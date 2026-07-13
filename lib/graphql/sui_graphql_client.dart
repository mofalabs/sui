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

  /// Query transaction digests filtered by sender address.
  ///
  /// Returns the page of digests and the end cursor. Full result hydration is
  /// left to callers via the gRPC `getTransaction` once digests are known.
  Future<SenderTransactionPage> queryTransactionsBySender(
    String sender, {
    int first = 20,
    String? after,
  }) async {
    // Fetch enough per transaction to render a wallet activity row: timestamp,
    // status, and the balance deltas (amount / coin / owner).
    const q = r'''
      query ($sender: SuiAddress!, $first: Int!, $after: String) {
        transactions(
          first: $first
          after: $after
          filter: { sentAddress: $sender }
        ) {
          pageInfo { hasNextPage endCursor }
          nodes {
            digest
            effects {
              timestamp
              status
              balanceChanges {
                nodes { amount coinType { repr } owner { address } }
              }
            }
          }
        }
      }
    ''';
    final data = await transport.query(q, variables: {
      'sender': sender,
      'first': first,
      if (after != null) 'after': after,
    });
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

class SenderTransaction {
  SenderTransaction({
    required this.digest,
    required this.timestampMs,
    required this.success,
    required this.balanceChanges,
  });

  final String digest;

  /// Execution timestamp in epoch milliseconds (null if unavailable).
  final int? timestampMs;
  final bool success;
  final List<TxBalanceChange> balanceChanges;

  factory SenderTransaction._fromNode(Map<String, dynamic> n) {
    final ef = n['effects'] as Map<String, dynamic>?;
    final ts = ef?['timestamp'] as String?;
    final bcNodes =
        ((ef?['balanceChanges'] as Map?)?['nodes'] as List?) ?? const [];
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
  });

  final String? name;
  final String? suiAddress;
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
