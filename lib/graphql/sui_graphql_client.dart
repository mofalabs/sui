import 'package:dio/dio.dart';

import '../client/network.dart';
import 'graphql_transport.dart';

/// GraphQL client for Sui GraphQL RPC (the secondary transport).
///
/// Use for query patterns full nodes cannot serve over gRPC (filtered
/// transaction/event queries, staking, validator APYs). Mysten operates public
/// endpoints at `graphql.<network>.sui.io`; see [graphqlEndpoint].
class SuiGraphQLClient {
  SuiGraphQLClient({required String endpoint, Dio? dio})
      : transport = GraphQLTransport(endpoint, dio: dio);

  /// Construct against the public GraphQL endpoint for [network].
  SuiGraphQLClient.forNetwork(SuiNetwork network, {Dio? dio})
      : transport = GraphQLTransport(graphqlEndpoint(network), dio: dio);

  final GraphQLTransport transport;

  /// Chain identifier (digest of the genesis checkpoint).
  Future<String> getChainIdentifier() async {
    final data = await transport.query('{ chainIdentifier }');
    return data['chainIdentifier'] as String;
  }

  /// Query transactions that affected [address] — both sent and received.
  ///
  /// Uses the `affectedAddress` filter so an account's activity is complete;
  /// `sentAddress` would only return transactions the account signed, dropping
  /// every incoming transfer. Each node carries the timestamp, status, and the
  /// per-owner balance deltas; pass [options] with `showObjectChanges: true` to
  /// also fetch object changes and surface NFT / owned-object transfers (which
  /// produce no balance change).
  Future<SenderTransactionPage> queryTransactionsByAddress(
    String address, {
    int first = 20,
    String? after,
    TransactionHistoryOptions options = const TransactionHistoryOptions(),
  }) async {
    final data = await transport.query(
      _historyQuery('affectedAddress', options),
      variables: {
        'addr': address,
        'first': first,
        if (after != null) 'after': after,
      },
    );
    return _parseTransactionsPage(data);
  }

  /// Query transactions the account *sent* (signed), via the `sentAddress`
  /// filter — the sender-only primitive. For a complete wallet history that
  /// also includes incoming transfers, use [queryTransactionsByAddress].
  Future<SenderTransactionPage> queryTransactionsBySender(
    String sender, {
    int first = 20,
    String? after,
    TransactionHistoryOptions options = const TransactionHistoryOptions(),
  }) async {
    final data = await transport.query(
      _historyQuery('sentAddress', options),
      variables: {
        'addr': sender,
        'first': first,
        if (after != null) 'after': after,
      },
    );
    return _parseTransactionsPage(data);
  }

  /// Builds the `transactions` history query for the given [filterField]
  /// (`affectedAddress` or `sentAddress`), selecting only the per-tx detail
  /// blocks that [options] asks for so callers never over-fetch.
  String _historyQuery(String filterField, TransactionHistoryOptions options) {
    final balanceChanges = options.showBalanceChanges
        ? 'balanceChanges { nodes { amount coinType { repr } owner { address } } }'
        : '';
    final objectChanges = options.showObjectChanges
        ? 'objectChanges { nodes { address idCreated idDeleted '
            'inputState { owner { __typename ... on AddressOwner { address { address } } } } '
            'outputState { owner { __typename ... on AddressOwner { address { address } } } '
            'asMoveObject { contents { type { repr } } } } } }'
        : '';
    // Sui's `transactions` connection is ordered oldest-first, so page from the
    // END (`last`/`before`) to get the most recent transactions — `first` would
    // return the account's oldest history (e.g. its 2023 txs). The pageInfo
    // fields are aliased so the shared parser keeps reading hasNextPage /
    // endCursor (here meaning "has an older page" / "cursor to older").
    return '''
      query (\$addr: SuiAddress!, \$first: Int!, \$after: String) {
        transactions(
          last: \$first
          before: \$after
          filter: { $filterField: \$addr }
        ) {
          pageInfo { hasNextPage: hasPreviousPage endCursor: startCursor }
          nodes {
            digest
            effects { timestamp status $balanceChanges $objectChanges }
          }
        }
      }
    ''';
  }

  /// Parses a `transactions` GraphQL page into a [SenderTransactionPage].
  /// Shared by [queryTransactionsByAddress] and [queryTransactionsBySender].
  SenderTransactionPage _parseTransactionsPage(Map<String, dynamic> data) {
    final tx = data['transactions'] as Map<String, dynamic>;
    final txs = (tx['nodes'] as List)
        .map((n) => SenderTransaction._fromNode(n as Map<String, dynamic>))
        .toList();
    final pageInfo = tx['pageInfo'] as Map<String, dynamic>;
    return SenderTransactionPage(
      transactions: txs,
      hasNextPage: pageInfo['hasNextPage'] as bool,
      endCursor: pageInfo['endCursor'] as String?,
    );
  }

  /// Query transaction digests that affected a given object (its history).
  Future<TransactionDigestPage> queryTransactionsByObject(
    String objectId, {
    int first = 20,
    String? after,
  }) async {
    const q = r'''
      query ($obj: SuiAddress!, $first: Int!, $after: String) {
        transactions(
          first: $first
          after: $after
          filter: { affectedObject: $obj }
        ) {
          pageInfo { hasNextPage endCursor }
          nodes { digest }
        }
      }
    ''';
    final data = await transport.query(q, variables: {
      'obj': objectId,
      'first': first,
      if (after != null) 'after': after,
    });
    final tx = data['transactions'] as Map<String, dynamic>;
    final nodes = (tx['nodes'] as List)
        .map((n) => (n as Map<String, dynamic>)['digest'] as String)
        .toList();
    final pageInfo = tx['pageInfo'] as Map<String, dynamic>;
    return TransactionDigestPage(
      digests: nodes,
      hasNextPage: pageInfo['hasNextPage'] as bool,
      endCursor: pageInfo['endCursor'] as String?,
    );
  }

  /// Summary of an epoch (defaults to the current epoch).
  Future<EpochSummary> getEpochSummary({int? epochId}) async {
    const q = r'''
      query ($id: UInt53) {
        epoch(epochId: $id) {
          epochId
          referenceGasPrice
          totalTransactions
          startTimestamp
          endTimestamp
        }
      }
    ''';
    final data = await transport.query(q, variables: {
      if (epochId != null) 'id': epochId,
    });
    final e = data['epoch'] as Map<String, dynamic>;
    return EpochSummary(
      epochId: (e['epochId'] as num).toInt(),
      referenceGasPrice: BigInt.parse(e['referenceGasPrice'].toString()),
      totalTransactions: (e['totalTransactions'] as num?)?.toInt(),
      startTimestamp: e['startTimestamp'] as String?,
      endTimestamp: e['endTimestamp'] as String?,
    );
  }

  /// Active validators for the current (or given) epoch, parsed from each
  /// validator's on-chain `0x3::validator::Validator` contents.
  ///
  /// Note: annualized APY is not a stored field — it must be derived from each
  /// staking pool's exchange-rate history (a separate traversal). The raw
  /// `stakingPoolSuiBalance` / `poolTokenBalance` needed for that are exposed.
  Future<List<ValidatorInfo>> getActiveValidators({
    int? epochId,
    int first = 50,
    String? after,
  }) async {
    // The endpoint caps page size at 50; paginate internally to gather all.
    const q = r'''
      query ($id: UInt53, $first: Int!, $after: String) {
        epoch(epochId: $id) {
          validatorSet {
            activeValidators(first: $first, after: $after) {
              pageInfo { hasNextPage endCursor }
              nodes { contents { json } }
            }
          }
        }
      }
    ''';
    final pageSize = first > 50 ? 50 : first;
    final out = <ValidatorInfo>[];
    String? cursor = after;
    while (true) {
      final data = await transport.query(q, variables: {
        if (epochId != null) 'id': epochId,
        'first': pageSize,
        if (cursor != null) 'after': cursor,
      });
      final vs = (((data['epoch'] as Map)['validatorSet']
          as Map)['activeValidators'] as Map);
      out.addAll((vs['nodes'] as List).map((n) => ValidatorInfo._fromJson(
          (n as Map<String, dynamic>)['contents']['json']
              as Map<String, dynamic>)));
      final pageInfo = vs['pageInfo'] as Map<String, dynamic>;
      if (pageInfo['hasNextPage'] != true) break;
      cursor = pageInfo['endCursor'] as String?;
      if (cursor == null) break;
    }
    return out;
  }

  /// Staked SUI objects owned by [owner] (`0x3::staking_pool::StakedSui`).
  Future<List<StakedSuiInfo>> getStakes(
    String owner, {
    int first = 50,
    String? after,
  }) async {
    const q = r'''
      query ($owner: SuiAddress!, $first: Int!, $after: String) {
        address(address: $owner) {
          objects(
            first: $first
            after: $after
            filter: { type: "0x3::staking_pool::StakedSui" }
          ) {
            pageInfo { hasNextPage endCursor }
            nodes { address contents { json } }
          }
        }
      }
    ''';
    final data = await transport.query(q, variables: {
      'owner': owner,
      'first': first,
      if (after != null) 'after': after,
    });
    final address = data['address'];
    if (address == null) return const [];
    final nodes = ((address as Map)['objects'] as Map)['nodes'] as List;
    return nodes
        .map((n) => StakedSuiInfo._fromNode(n as Map<String, dynamic>))
        .toList();
  }

  /// Query events emitted by a Move module, e.g. package `0x2`, module `coin`.
  ///
  /// Returns the raw event nodes (`transactionModule`, `sender`, `contents`).
  Future<List<Map<String, dynamic>>> queryEventsByModule(
    String packageId,
    String module, {
    int first = 20,
    String? after,
  }) async {
    const q = r'''
      query ($module: String!, $first: Int!, $after: String) {
        events(
          first: $first
          after: $after
          filter: { module: $module }
        ) {
          pageInfo { hasNextPage endCursor }
          nodes {
            transactionModule { name }
            sender { address }
            contents { type { repr } json }
          }
        }
      }
    ''';
    final data = await transport.query(q, variables: {
      'module': '$packageId::$module',
      'first': first,
      if (after != null) 'after': after,
    });
    final events = data['events'] as Map<String, dynamic>;
    return (events['nodes'] as List).cast<Map<String, dynamic>>();
  }
}

class TransactionDigestPage {
  TransactionDigestPage({
    required this.digests,
    required this.hasNextPage,
    required this.endCursor,
  });

  final List<String> digests;
  final bool hasNextPage;
  final String? endCursor;
}

/// A page of a sender's transactions with the fields wallets show per row.
class SenderTransactionPage {
  SenderTransactionPage({
    required this.transactions,
    required this.hasNextPage,
    this.endCursor,
  });

  final List<SenderTransaction> transactions;
  final bool hasNextPage;
  final String? endCursor;

  /// The digests of the transactions in this page.
  List<String> get digests => [for (final tx in transactions) tx.digest];
}

/// Selects which per-transaction details a history query fetches. Mirrors the
/// SDK's `SuiTransactionBlockResponseOptions` convention. Object changes are
/// off by default because they can be large; enable them to surface NFT /
/// owned-object transfers, which produce no balance change.
class TransactionHistoryOptions {
  const TransactionHistoryOptions({
    this.showBalanceChanges = true,
    this.showObjectChanges = false,
  });

  final bool showBalanceChanges;
  final bool showObjectChanges;
}

class SenderTransaction {
  SenderTransaction({
    required this.digest,
    required this.timestampMs,
    required this.success,
    required this.balanceChanges,
    this.objectChanges = const [],
  });

  final String digest;

  /// Execution timestamp in epoch milliseconds (null if unavailable).
  final int? timestampMs;
  final bool success;
  final List<TxBalanceChange> balanceChanges;

  /// Populated only when the query requested object changes (see
  /// [TransactionHistoryOptions.showObjectChanges]).
  final List<TxObjectChange> objectChanges;

  factory SenderTransaction._fromNode(Map<String, dynamic> n) {
    final ef = n['effects'] as Map<String, dynamic>?;
    final ts = ef?['timestamp'] as String?;
    final bcNodes =
        ((ef?['balanceChanges'] as Map?)?['nodes'] as List?) ?? const [];
    final ocNodes =
        ((ef?['objectChanges'] as Map?)?['nodes'] as List?) ?? const [];
    return SenderTransaction(
      digest: n['digest'] as String,
      timestampMs:
          ts != null ? DateTime.parse(ts).millisecondsSinceEpoch : null,
      success: (ef?['status'] as String?) == 'SUCCESS',
      balanceChanges: [
        for (final b in bcNodes)
          TxBalanceChange(
            ownerAddress: ((b as Map)['owner'] as Map?)?['address'] as String?,
            amount: b['amount']?.toString() ?? '0',
            coinType: ((b['coinType'] as Map?)?['repr'] as String?) ?? '',
          )
      ],
      objectChanges: [
        for (final o in ocNodes) TxObjectChange._fromNode(o as Map),
      ],
    );
  }
}

class TxBalanceChange {
  TxBalanceChange({
    required this.ownerAddress,
    required this.amount,
    required this.coinType,
  });

  final String? ownerAddress;
  final String amount;
  final String coinType;
}

/// An object's ownership/state change within a transaction — enough to surface
/// NFT (and other owned-object) transfers, which leave no balance change.
class TxObjectChange {
  TxObjectChange({
    required this.objectId,
    required this.type,
    required this.kind,
    this.fromAddress,
    this.toAddress,
  });

  final String objectId;

  /// Move type of the object (e.g. `0x…::nft::Nft`), empty if unavailable.
  final String type;

  /// `created`, `deleted`, or `mutated`.
  final String kind;

  /// Address owner before / after — null when the object isn't address-owned,
  /// or was created (no `from`) / deleted (no `to`).
  final String? fromAddress;
  final String? toAddress;

  /// Reads the address out of an `AddressOwner` owner shape
  /// (`{ __typename, address: { address } }`); null for other owner kinds.
  static String? _ownerAddress(Map? owner) =>
      ((owner?['address'] as Map?)?['address']) as String?;

  factory TxObjectChange._fromNode(Map o) {
    final created = o['idCreated'] == true;
    final deleted = o['idDeleted'] == true;
    final contents =
        ((o['outputState'] as Map?)?['asMoveObject'] as Map?)?['contents']
            as Map?;
    final typeRepr = (contents?['type'] as Map?)?['repr'] as String?;
    return TxObjectChange(
      objectId: o['address'] as String? ?? '',
      type: typeRepr ?? '',
      kind: created ? 'created' : (deleted ? 'deleted' : 'mutated'),
      fromAddress: _ownerAddress((o['inputState'] as Map?)?['owner'] as Map?),
      toAddress: _ownerAddress((o['outputState'] as Map?)?['owner'] as Map?),
    );
  }

  Map<String, dynamic> toJson() => {
        'objectId': objectId,
        'type': type,
        'kind': kind,
        'from': fromAddress,
        'to': toAddress,
      };
}

class ValidatorInfo {
  ValidatorInfo({
    required this.name,
    required this.suiAddress,
    required this.votingPower,
    required this.commissionRate,
    required this.nextEpochStake,
    required this.stakingPoolSuiBalance,
    required this.poolTokenBalance,
    required this.stakingPoolId,
    required this.activationEpoch,
    this.imageUrl,
    this.projectUrl,
    this.description,
  });

  final String? name;
  final String? suiAddress;

  /// Display metadata from the validator's on-chain `ValidatorMetadata`
  /// (`image_url` / `project_url` / `description`). Surfaced so the wallet can
  /// render validator logos on the staking screen.
  final String? imageUrl;
  final String? projectUrl;
  final String? description;
  final int votingPower;
  final int commissionRate;
  final BigInt nextEpochStake;
  final BigInt stakingPoolSuiBalance;
  final BigInt poolTokenBalance;

  /// Staking pool object id — the value `StakedSui.pool_id` references, used to
  /// link a stake back to its validator.
  final String? stakingPoolId;

  /// Epoch the staking pool was activated; the basis for APY estimation.
  final int activationEpoch;

  static BigInt _big(dynamic v) =>
      v == null ? BigInt.zero : BigInt.parse(v.toString());

  factory ValidatorInfo._fromJson(Map<String, dynamic> j) {
    final md = (j['metadata'] as Map?) ?? const {};
    final sp = (j['staking_pool'] as Map?) ?? const {};
    return ValidatorInfo(
      name: md['name'] as String?,
      suiAddress: md['sui_address'] as String?,
      imageUrl: md['image_url'] as String?,
      projectUrl: md['project_url'] as String?,
      description: md['description'] as String?,
      votingPower: int.tryParse('${j['voting_power']}') ?? 0,
      commissionRate: int.tryParse('${j['commission_rate']}') ?? 0,
      nextEpochStake: _big(j['next_epoch_stake']),
      stakingPoolSuiBalance: _big(sp['sui_balance']),
      poolTokenBalance: _big(sp['pool_token_balance']),
      stakingPoolId: sp['id']?.toString(),
      activationEpoch: int.tryParse('${sp['activation_epoch']}') ?? 0,
    );
  }
}

class StakedSuiInfo {
  StakedSuiInfo({
    required this.stakedSuiId,
    required this.poolId,
    required this.principal,
    required this.stakeActivationEpoch,
  });

  final String stakedSuiId;
  final String? poolId;
  final BigInt principal;
  final int? stakeActivationEpoch;

  factory StakedSuiInfo._fromNode(Map<String, dynamic> node) {
    final j = (node['contents']?['json'] as Map?) ?? const {};
    // `principal` is a Balance<SUI> serialized either as a scalar or {value}.
    final rawPrincipal = j['principal'];
    final principal = rawPrincipal is Map
        ? BigInt.parse('${rawPrincipal['value'] ?? 0}')
        : BigInt.parse('${rawPrincipal ?? 0}');
    return StakedSuiInfo(
      stakedSuiId: node['address'] as String,
      poolId: j['pool_id'] as String?,
      principal: principal,
      stakeActivationEpoch: j['stake_activation_epoch'] == null
          ? null
          : int.tryParse('${j['stake_activation_epoch']}'),
    );
  }
}

class EpochSummary {
  EpochSummary({
    required this.epochId,
    required this.referenceGasPrice,
    required this.totalTransactions,
    required this.startTimestamp,
    required this.endTimestamp,
  });

  final int epochId;
  final BigInt referenceGasPrice;
  final int? totalTransactions;
  final String? startTimestamp;
  final String? endTimestamp;
}
