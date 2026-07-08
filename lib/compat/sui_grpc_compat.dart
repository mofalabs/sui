import 'dart:convert';
import 'dart:typed_data';

import '../builder/transaction.dart';
import '../builder/transaction_builder_client.dart';
import '../client/network.dart';
import '../client/sui_models.dart';
import '../cryptography/intent.dart';
import '../cryptography/keypair.dart';
import '../cryptography/signature.dart';
import '../grpc/grpc_builder_adapter.dart';
import '../grpc/grpc_core_client.dart';
import '../grpc/grpc_transaction_executor.dart';
import '../grpc/proto/sui/rpc/v2/state_service.pbenum.dart';
import '../grpc/sui_grpc_client.dart';
import '../graphql/sui_graphql_client.dart';
import '../models/dev_inspect_results.dart';
import '../models/dynamic_field.dart';
import '../sui_account.dart';
import '../types/coins.dart';
import '../types/framework.dart';
import '../types/normalized.dart';
import '../types/objects.dart';
import '../types/transactions.dart';
import '../types/validator.dart';

/// Drop-in-ish replacement for the legacy JSON-RPC `SuiClient`, backed by the
/// new gRPC-web transport (and GraphQL for filtered queries). Exposes the same
/// method names and legacy model return types the app already consumes, so
/// callers migrate by swapping the client construction only.
///
/// This is the migration bridge: it keeps existing wallet business logic intact
/// while moving the wire protocol off the deprecated JSON-RPC endpoints.
class SuiGrpcCompat {
  SuiGrpcCompat(this.network, {this.account})
      : grpc = SuiGrpcClient(network: network),
        graphql = SuiGraphQLClient.forNetwork(network);

  final SuiNetwork network;
  final SuiAccount? account;
  final SuiGrpcClient grpc;
  final SuiGraphQLClient graphql;

  /// Transaction-builder client backing `Transaction.build()` (object / moveCall
  /// resolution over gRPC).
  TransactionBuilderClient get builderClient =>
      GrpcBuilderAdapter(grpc.core as GrpcCoreClient);

  // --- Chain / gas ---

  Future<String> getChainIdentifier() => grpc.getChainIdentifier();

  /// Protocol config is not needed by the gRPC build path (offline limits are
  /// used); returns null so `BuildOptions(protocolConfig: ...)` falls back.
  Future<dynamic> getProtocolConfig() async => null;

  /// Execute an already-signed transaction (dApp flow): serializes the
  /// signature (flag ‖ sig ‖ pubkey) and submits over gRPC.
  Future<SuiExecuteTransactionResponse> executeTransaction({
    required Uint8List txnBytes,
    required SignatureScheme signatureScheme,
    required Uint8List signature,
    required PublicKey pubkey,
    dynamic options,
    dynamic requestType,
  }) async {
    final serialized = <int>[pubkey.flag(), ...signature, ...pubkey.toRawBytes()];
    final executed = await grpc
        .executeTransaction(txnBytes, [Uint8List.fromList(serialized)]);
    return SuiExecuteTransactionResponse.fromJson({
      'digest': executed.digest,
      'confirmedLocalExecution': executed.effects.status.success,
      'errors': executed.effects.status.success
          ? null
          : [executed.effects.status.error.description],
    });
  }

  Future<BigInt> getReferenceGasPrice() async =>
      BigInt.from((await grpc.getReferenceGasPrice()).toInt());

  // --- Balances ---

  Future<CoinBalance> getBalance(String owner,
      {String coinType = '0x2::sui::SUI'}) async {
    final b = await grpc.getBalance(owner, coinType: coinType);
    return CoinBalance(b.coinType, 0, BigInt.from(b.balance.toInt()), BigInt.zero);
  }

  Future<List<CoinBalance>> getAllBalance(String owner) async {
    final resp = await grpc.listBalances(owner);
    return resp.balances
        .map((b) => CoinBalance(
            b.coinType, 0, BigInt.from(b.balance.toInt()), BigInt.zero))
        .toList();
  }

  // --- Coins ---

  Future<PaginatedCoins> getCoins(String owner,
      {String coinType = '0x2::sui::SUI', String? cursor, int? limit}) async {
    final page = await grpc.listCoins(owner,
        coinType: coinType,
        cursor: cursor == null ? null : base64Decode(cursor),
        limit: limit);
    final coins = page.coins
        .map((c) => CoinStruct(
              c.coinType,
              c.coinObjectId,
              c.version.toInt(),
              c.digest,
              c.balance.toString(),
              '',
            ))
        .toList();
    return PaginatedCoins(coins, page.cursor, page.hasNextPage);
  }

  Future<CoinMetadataStruct?> getCoinMetadata(String coinType) async {
    final info = await grpc.getCoinInfo(coinType);
    if (!info.hasMetadata()) return null;
    final m = info.metadata;
    return CoinMetadataStruct(
      m.decimals,
      m.name,
      m.symbol,
      m.description,
      m.iconUrl,
      '',
    );
  }

  // --- Objects ---

  Future<SuiObjectResponse> getObject(String objectId,
      {SuiObjectDataOptions? options}) async {
    try {
      final o = await grpc.getObject(objectId, readMask: _objectMask(options));
      return SuiObjectResponse.fromJson({'data': _objectToJson(o)});
    } catch (e) {
      // A missing object is a normal result in JSON-RPC ({error: notExists}),
      // not an exception. gRPC throws NOT_FOUND, so translate it back; only
      // swallow the not-found case and let real errors propagate.
      if (e.toString().toLowerCase().contains('not found')) {
        return SuiObjectResponse.fromJson({
          'error': {'code': 'notExists', 'object_id': objectId}
        });
      }
      rethrow;
    }
  }

  Future<List<SuiObjectResponse>> multiGetObjects(List<String> objectIds,
      {SuiObjectDataOptions? options}) async {
    final results =
        await grpc.getObjects(objectIds, readMask: _objectMask(options));
    return results.map((r) {
      if (r.hasError()) {
        return SuiObjectResponse.fromJson({
          'error': {'code': 'notExists', 'object_id': null}
        });
      }
      return SuiObjectResponse.fromJson({'data': _objectToJson(r.object)});
    }).toList();
  }

  // --- Transactions (write) ---

  /// Build + sign + execute [tx] using the new auto-gas path. Returns a legacy
  /// [SuiTransactionBlockResponse] (digest + effects status).
  Future<SuiTransactionBlockResponse> signAndExecuteTransactionBlock(
    SuiAccount signer,
    Transaction tx, {
    dynamic options,
    dynamic responseOptions,
    dynamic requestType,
  }) async {
    final executed = await grpc.signAndExecuteTransaction(signer, tx);
    return SuiTransactionBlockResponse.fromJson({
      'digest': executed.digest,
      'effects': _effectsJson(executed),
      'errors': executed.effects.status.success
          ? null
          : [executed.effects.status.error.description],
    });
  }

  /// Estimate a gas budget for [tx] by simulating it (no signing needed).
  Future<BigInt> estimateGas(Transaction tx, String sender) async {
    tx.setSenderIfNotSet(sender);
    final gasPrice = await grpc.getReferenceGasPrice();
    tx.setGasPrice(BigInt.from(gasPrice.toInt()));
    final coin = await _firstGasCoin(sender);
    if (coin != null) tx.setGasPayment([coin]);
    final bal = await grpc.getBalance(sender);
    tx.setGasBudget(BigInt.from(bal.balance.toInt()));
    final data = await tx.build(BuildOptions(limits: <String, dynamic>{}));
    final sim = await grpc.simulateTransaction(Uint8List.fromList(data));
    final g = sim.transaction.effects.gasUsed;
    final budget = BigInt.from(g.computationCost.toInt()) +
        BigInt.from(g.storageCost.toInt()) -
        BigInt.from(g.storageRebate.toInt());
    final floor = BigInt.from(g.computationCost.toInt()) +
        BigInt.from(1000) * BigInt.from(gasPrice.toInt());
    return budget > floor ? budget : floor;
  }

  Future<SuiObjectRef?> _firstGasCoin(String owner) async {
    final owned = await grpc.listOwnedObjects(owner,
        objectType: '0x2::coin::Coin<0x2::sui::SUI>',
        readMask: const ['object_id', 'version', 'digest'],
        pageSize: 1);
    if (owned.objects.isEmpty) return null;
    final o = owned.objects.first;
    return SuiObjectRef(o.digest, o.objectId, o.version.toInt());
  }

  /// Verify a signed message/transaction (used by dApp flows).
  Future<bool> verifySignature(
    Uint8List message,
    Uint8List signature, {
    required IntentScope intentScope,
    String? address,
  }) async =>
      (await grpc.verifySignature(message, signature,
              intentScope: intentScope, address: address))
          .isValid;

  // --- Owned objects (client-side filtering; gRPC has no MatchAny/MatchNone) ---

  Future<PaginatedObjectsResponse> getOwnedObjects(
    String address, {
    int? limit,
    String? cursor,
    SuiObjectDataOptions? options,
    Map? filter,
  }) async {
    final target = limit ?? 50;
    final mask = _objectMask(options);
    // gRPC has no MatchAny/MatchNone/Package/MoveModule filter, so we filter
    // client-side. When filtering, keep paging until we've collected `target`
    // matches (or run out) — otherwise a page full of excluded objects would
    // hide items on later pages. All matches from every fetched page are
    // returned and the cursor points past them, so there are no gaps/overlaps.
    final pageSize = filter == null ? target : 50;
    final matched = <SuiObjectResponse>[];
    var token = cursor == null ? null : base64Decode(cursor);
    var nextCursor = '';
    var hasNext = false;
    var guard = 0;
    do {
      guard++;
      final resp = await grpc.listOwnedObjects(address,
          pageSize: pageSize, pageToken: token, readMask: mask);
      for (final o in resp.objects) {
        final r = SuiObjectResponse.fromJson({'data': _objectToJson(o)});
        if (filter == null || _matchesFilter(r.data?.type ?? '', filter)) {
          matched.add(r);
        }
      }
      hasNext = resp.nextPageToken.isNotEmpty;
      nextCursor = hasNext ? base64Encode(resp.nextPageToken) : '';
      token = hasNext ? Uint8List.fromList(resp.nextPageToken) : null;
    } while (filter != null && hasNext && matched.length < target && guard < 20);
    return PaginatedObjectsResponse(matched, nextCursor, hasNext);
  }

  /// Legacy alias returning the same page.
  Future<PaginatedObjectsResponse> getOwnedObjectList(String address,
          {int? limit, String? cursor, SuiObjectDataOptions? options}) =>
      getOwnedObjects(address, limit: limit, cursor: cursor, options: options);

  bool _matchesFilter(String type, dynamic filter) {
    if (filter is! Map) return true;
    if (filter.containsKey('MatchAny')) {
      return (filter['MatchAny'] as List).any((f) => _matchesFilter(type, f));
    }
    if (filter.containsKey('MatchNone')) {
      return !(filter['MatchNone'] as List).any((f) => _matchesFilter(type, f));
    }
    if (filter.containsKey('MatchAll')) {
      return (filter['MatchAll'] as List).every((f) => _matchesFilter(type, f));
    }
    if (filter.containsKey('StructType')) {
      final t = filter['StructType'] as String;
      return type == t || type.startsWith('$t<') || type.startsWith('$t ');
    }
    if (filter.containsKey('Package')) {
      return type.startsWith('${filter['Package']}::');
    }
    if (filter.containsKey('MoveModule')) {
      final m = filter['MoveModule'] as Map;
      return type.startsWith('${m['package']}::${m['module']}::');
    }
    return true;
  }

  // --- Dynamic fields ---

  Future<DynamicFieldPage> getDynamicFields(String parentId,
      {String? cursor, int? limit}) async {
    final resp = await grpc.listDynamicFields(
      parentId,
      pageSize: limit,
      pageToken: cursor == null ? null : base64Decode(cursor),
    );
    final data = resp.dynamicFields.map((f) {
      final isObject = f.kind == DynamicField_DynamicFieldKind.OBJECT;
      return DynamicFieldInfo.fromJson({
        'name': {
          'type': f.hasName() ? f.name.name : '',
          // JSON-RPC decoded the value to JSON; gRPC gives BCS. For dynamic
          // OBJECT fields the child id is the useful value.
          'value': isObject ? {'id': f.childId} : base64Encode(f.name.value),
        },
        'bcsName': f.hasName() ? base64Encode(f.name.value) : '',
        'type': isObject ? 'DynamicObject' : 'DynamicField',
        'objectType': f.valueType,
        'objectId': f.fieldId,
        'version': 0,
        'digest': '',
      });
    }).toList();
    return DynamicFieldPage(
      data: data,
      nextCursor: resp.nextPageToken.isNotEmpty
          ? base64Encode(resp.nextPageToken)
          : null,
      hasNextPage: resp.nextPageToken.isNotEmpty,
    );
  }

  // --- Move ---

  Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(
          String package, String module, String function) =>
      GrpcBuilderAdapter(grpc.core as GrpcCoreClient)
          .getNormalizedMoveFunction(package, module, function);

  // --- Name service ---

  Future<String?> resolveNameServiceAddress(String name) =>
      grpc.resolveNameServiceAddress(name);

  Future<_NamePage?> resolveNameServiceNames(String address) async {
    try {
      final rec = await grpc.reverseLookupName(address);
      return _NamePage([if (rec.name.isNotEmpty) rec.name]);
    } catch (_) {
      return _NamePage(const []);
    }
  }

  // --- System state / validators / stakes (GraphQL) ---

  Future<SuiSystemStateSummary> getLatestSuiSystemState() async {
    final vals = await graphql.getActiveValidators(first: 200);
    final epoch = await graphql.getEpochSummary();
    return SuiSystemStateSummary.fromJson({
      'activeValidators': [for (final v in vals) _validatorJson(v)],
      'epoch': epoch.epochId.toString(),
      'protocolVersion': '0',
      'systemStateVersion': '0',
      'storageFundTotalObjectStorageRebates': '0',
      'storageFundNonRefundableBalance': '0',
      'referenceGasPrice': epoch.referenceGasPrice.toString(),
      'safeMode': false,
      'safeModeStorageRewards': '0',
      'safeModeComputationRewards': '0',
      'safeModeStorageRebates': '0',
      'safeModeNonRefundableStorageFee': '0',
      'epochStartTimestampMs': '0',
      'epochDurationMs': '0',
      'stakeSubsidyStartEpoch': '0',
      'maxValidatorCount': '0',
      'minValidatorJoiningStake': '0',
      'validatorLowStakeThreshold': '0',
      'validatorVeryLowStakeThreshold': '0',
      'validatorLowStakeGracePeriod': '0',
      'stakeSubsidyBalance': '0',
      'stakeSubsidyDistributionCounter': '0',
      'stakeSubsidyCurrentDistributionAmount': '0',
      'stakeSubsidyPeriodLength': '0',
      'stakeSubsidyDecreaseRate': 0,
      'totalStake': '0',
      'pendingActiveValidatorsId': '',
      'pendingActiveValidatorsSize': '0',
      'pendingRemovals': [],
      'stakingPoolMappingsId': '',
      'stakingPoolMappingsSize': '0',
      'inactivePoolsId': '',
      'inactivePoolsSize': '0',
      'validatorCandidatesId': '',
      'validatorCandidatesSize': '0',
      'atRiskValidators': [],
      'validatorReportRecords': [],
    });
  }

  Map<String, dynamic> _validatorJson(ValidatorInfo v) => {
        'suiAddress': v.suiAddress ?? '',
        'protocolPubkeyBytes': '',
        'networkPubkeyBytes': '',
        'workerPubkeyBytes': '',
        'proofOfPossessionBytes': '',
        'name': v.name ?? '',
        'description': '',
        'imageUrl': '',
        'projectUrl': '',
        'netAddress': '',
        'p2pAddress': '',
        'primaryAddress': '',
        'workerAddress': '',
        'votingPower': v.votingPower.toString(),
        'operationCapId': '',
        'gasPrice': '0',
        'commissionRate': v.commissionRate.toString(),
        'nextEpochStake': v.nextEpochStake.toString(),
        'nextEpochGasPrice': '0',
        'nextEpochCommissionRate': v.commissionRate.toString(),
        'stakingPoolId': '',
        'stakingPoolSuiBalance': v.stakingPoolSuiBalance.toString(),
        'rewardsPool': '0',
        'poolTokenBalance': v.poolTokenBalance.toString(),
        'pendingStake': '0',
        'pendingTotalSuiWithdraw': '0',
        'pendingPoolTokenWithdraw': '0',
        'exchangeRatesId': '',
        'exchangeRatesSize': '0',
      };

  /// Annualized APY is not available from the public GraphQL schema (it needs
  /// exchange-rate history). Returns 0 for each validator so the UI still lists
  /// them; ordering falls back to stake.
  Future<ValidatorsApy> getValidatorsApy() async {
    final vals = await graphql.getActiveValidators(first: 200);
    return ValidatorsApy.fromJson({
      'epoch': '0',
      'apys': [for (final v in vals) {'address': v.suiAddress, 'apy': 0.0}],
    });
  }

  Future<List<DelegatedStake>> getStakes(String address) async {
    final stakes = await graphql.getStakes(address);
    // Group by pool into the legacy DelegatedStake shape.
    final byPool = <String, List<StakedSuiInfo>>{};
    for (final s in stakes) {
      byPool.putIfAbsent(s.poolId ?? '', () => []).add(s);
    }
    return byPool.entries
        .map((e) => DelegatedStake.fromJson({
              'stakingPool': e.key,
              'validatorAddress': '',
              'stakes': [
                for (final s in e.value)
                  {
                    'stakedSuiId': s.stakedSuiId,
                    'stakeRequestEpoch': (s.stakeActivationEpoch ?? 0).toString(),
                    'stakeActiveEpoch': (s.stakeActivationEpoch ?? 0).toString(),
                    'principal': s.principal.toString(),
                    'status': 'Active',
                  }
              ],
            }))
        .toList();
  }

  // --- Transaction history (GraphQL) ---

  Future<(List<SuiTransactionBlockResponse>, String?, String?)> getTransactions(
    String address, {
    dynamic options,
    int? limit,
    String? filterFromCursor,
    String? filterToCursor,
  }) async {
    final page = await graphql.queryTransactionsBySender(address,
        first: limit ?? 20, after: filterFromCursor);
    final txs = page.digests
        .map((d) => SuiTransactionBlockResponse.fromJson({'digest': d}))
        .toList();
    return (txs, page.endCursor, null);
  }

  // --- Simulate / inspect / execute (write) ---

  Future<DevInspectResults> devInspectTransactionBlock(
      String sender, Transaction tx) async {
    final data = await tx.build(BuildOptions(limits: <String, dynamic>{}));
    final sim = await grpc.simulateTransaction(Uint8List.fromList(data));
    return DevInspectResults.fromJson({'effects': _effectsJson(sim.transaction)});
  }

  Future<DryRunTransactionBlockResponse> dryRunTransactionBlock(
      String txBytes) async {
    final sim = await grpc.simulateTransaction(base64Decode(txBytes));
    return DryRunTransactionBlockResponse.fromJson(
        {'effects': _effectsJson(sim.transaction)});
  }

  /// Sign and execute already-built transaction [data] bytes.
  Future<SuiExecuteTransactionResponse> signAndExecuteTransaction(
      Uint8List data) async {
    final signed = account!.keyPair.signTransactionBlock(data);
    final executed = await grpc.executeTransaction(
        data, [Uint8List.fromList(base64Decode(signed.signature))]);
    return SuiExecuteTransactionResponse.fromJson({
      'digest': executed.digest,
      'confirmedLocalExecution': executed.effects.status.success,
      'errors': executed.effects.status.success
          ? null
          : [executed.effects.status.error.description],
    });
  }

  Map<String, dynamic> _effectsJson(dynamic executed) {
    final st = executed.effects.status;
    final g = executed.effects.gasUsed;
    const zero =
        '0x0000000000000000000000000000000000000000000000000000000000000000';
    return {
      'messageVersion': 'v1',
      'status': {
        'status': st.success ? 'success' : 'failure',
        if (!st.success) 'error': st.error.description,
      },
      'gasUsed': {
        'computationCost': g.computationCost.toInt().toString(),
        'storageCost': g.storageCost.toInt().toString(),
        'storageRebate': g.storageRebate.toInt().toString(),
        'nonRefundableStorageFee': '0',
      },
      'transactionDigest': executed.digest,
      'gasObject': {
        'owner': {'AddressOwner': zero},
        'reference': {
          'objectId': zero,
          'version': 0,
          'digest': '11111111111111111111111111111111',
        }
      },
    };
  }

  // --- helpers ---

  List<String> _objectMask(SuiObjectDataOptions? o) {
    final paths = <String>['object_id', 'version', 'digest'];
    if (o == null) {
      paths.addAll(['object_type', 'owner', 'contents']);
      return paths;
    }
    if (o.showType) paths.add('object_type');
    if (o.showOwner) paths.add('owner');
    if (o.showContent || o.showBcs) paths.add('contents');
    if (o.showPreviousTransaction) paths.add('previous_transaction');
    if (o.showDisplay) paths.add('display');
    return paths;
  }

  Map<String, dynamic> _objectToJson(dynamic o) => {
        'objectId': o.objectId,
        'digest': o.digest,
        'version': o.version.toString(),
        'type': o.hasObjectType() ? o.objectType : null,
        'owner': _ownerJson(o),
      };

  dynamic _ownerJson(dynamic o) {
    if (!o.hasOwner()) return null;
    final owner = SuiOwner.fromProto(o.owner);
    switch (owner.kind) {
      case SuiOwnerKind.address:
        return {'AddressOwner': owner.address};
      case SuiOwnerKind.object:
        return {'ObjectOwner': owner.address};
      case SuiOwnerKind.shared:
        return {
          'Shared': {'initial_shared_version': owner.initialSharedVersion}
        };
      case SuiOwnerKind.immutable:
        return 'Immutable';
      case SuiOwnerKind.unknown:
        return null;
    }
  }
}

/// Minimal page wrapper matching the legacy `resolveNameServiceNames` return
/// shape (`.data.firstOrNull`).
class _NamePage {
  _NamePage(this.data);
  final List<String> data;
}
