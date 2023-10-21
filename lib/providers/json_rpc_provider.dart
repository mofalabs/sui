
import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/models/checkpoint.dart';
import 'package:sui/models/dev_inspect_results.dart';
import 'package:sui/models/dynamic_field.dart';
import 'package:sui/models/loaded_child_objects.dart';
import 'package:sui/models/object_read.dart';
import 'package:sui/models/paged.dart';
import 'package:sui/models/sui_event.dart';
import 'package:sui/rpc/client.dart';
import 'package:sui/types/coins.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/event_filter.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/normalized.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';
import 'package:sui/types/validator.dart';
import 'package:sui/types/version.dart';

mixin JsonRpcProvider {

  JsonRpcClient get client;

  Future<DevInspectResults> devInspectTransaction(
    String sender,
    Uint8List txBytes, {
      BigInt? gasPrice,
      String? epoch
    }
  ) async {
    final txBase64 = base64Encode(txBytes);

    final result = await client.request('sui_devInspectTransactionBlock', 
      [
        sender,
        txBase64,
        gasPrice?.toInt(),
        epoch
      ]
    );
    return DevInspectResults.fromJson(result);
  }

  Future<String> getChainIdentifier() async {
    final result = await client.request('sui_getChainIdentifier', []);
    return result;
  }

  Future<Checkpoint> getCheckpoint(String id) async {
    final result = await client.request('sui_getCheckpoint', [id]);
    return Checkpoint.fromJson(result);
  }

  Future<Paged<List<Checkpoint>>> getCheckpoints({
    String? cursor,
    int? limit,
    bool descendingOrder = false
  }) async {
    final result = await client.request('sui_getCheckpoints', [cursor, limit, descendingOrder]);
    final checkPoints = Paged<List<Checkpoint>>.fromJson(result, (json) {
      return (json as List).map((e) => Checkpoint.fromJson(e)).toList();
    });
    return checkPoints;
  }

  Future<BigInt> getLatestCheckpointSequenceNumber() async {
    final result = await client.request('sui_getLatestCheckpointSequenceNumber', []);
    return BigInt.parse(result);
  }

  Future<LoadedChildObjects> getLoadedChildObjects(String txDigest) async {
    final result = await client.request('sui_getLoadedChildObjects', [txDigest]);
    return LoadedChildObjects.fromJson(result);
  }

  Future<RpcApiVersion> getRpcApiVersion() async {
    final result = await client.request(
      'rpc.discover',
      [],
    );
    final rpcApiVersion = RpcApiVersion.parseVersion(result['info']['version']);
    return rpcApiVersion;
  }

  Future<PaginatedCoins> getCoins(String owner, {
    String? coinType,
    String? cursor,
    int? limit
  }) async {
    coinType ??= SUI_TYPE_ARG;
    final result = await client.request(
        'suix_getCoins',
        [owner, coinType, cursor, limit]
    );
    return PaginatedCoins.fromJson(result);
  }

  Future<PaginatedCoins> getAllCoins(String owner,
      { String? cursor, int? limit}) async {
    final result = await client.request(
        'suix_getAllCoins',
        [owner, cursor, limit]
    );
    return PaginatedCoins.fromJson(result);
  }

  Future<CoinBalance> getBalance(String owner,
      {String coinType = "0x2::sui::SUI"}) async {
    final result = await client.request('suix_getBalance', [owner, coinType]);
    return CoinBalance.fromJson(result);
  }

  Future<List<CoinBalance>> getBalanceBatch(List<String> owner,
      {String coinType = "0x2::sui::SUI"}) async {
    final requests = owner.map((d) => ({
      'method': 'suix_getBalance',
      'args': [d, coinType],
    }));

    var result = await client.batchRequest(requests);
    List<CoinBalance> coins = [];
    for(var coin in result) {
      coins.add(CoinBalance.fromJson(coin));
    }
    return coins;
  }

  Future<List<CoinBalance>> getAllBalance(String owner) async {
    final result = await client.request(
      'suix_getAllBalances',
      [owner]
    );
    List<CoinBalance> list = [];
    for (var coin in result) {
      list.add(CoinBalance.fromJson(coin));
    }
    return list;
  }

  Future<CoinMetadataStruct> getCoinMetadata(String coinType) async {
    final result = await client.request(
        'suix_getCoinMetadata',
        [coinType]
    );
    return CoinMetadataStruct.fromJson(result);
  }

  Future<CoinSupply> getTotalSupply(String coinType) async {
    final result = await client.request(
        'suix_getTotalSupply',
        [coinType]
    );
    return CoinSupply.fromJson(result);
  }

  Future<List<dynamic>> getMoveFunctionArgTypes({
    required String packageId,
    required String moduleName,
    required String functionName
  }) async {
    final result = await client.request(
      'sui_getMoveFunctionArgTypes',
      [packageId, moduleName, functionName]
    );
    return List<dynamic>.from(result);
  }

  Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(
    String packageId,
    String moduleName,
    String functionName
  ) async {
    final result = await client.request(
      'sui_getNormalizedMoveFunction',
      [packageId, moduleName, functionName]
    );
    return SuiMoveNormalizedFunction.fromJson(result);
  }

  Future<SuiMoveNormalizedModule> getNormalizedMoveModule(
    String packageId,
    String moduleName
  ) async {
    final result = await client.request(
      'sui_getNormalizedMoveModule',
      [packageId, moduleName]
    );
    return SuiMoveNormalizedModule.fromJson(result);
  }

  Future<SuiMoveNormalizedModules> getNormalizedMoveModulesByPackage(
    String packageId
  ) async {
    var result = await client.request(
      'sui_getNormalizedMoveModulesByPackage',
      [packageId]
    );
    SuiMoveNormalizedModules modules = <String, SuiMoveNormalizedModule>{};
    if(result is Map) {
      for(var key in result.keys){
        modules[key] = SuiMoveNormalizedModule.fromJson(result[key]);
      }
    }
    return modules;
  }

  Future<SuiMoveNormalizedStruct> getNormalizedMoveStruct(
    String packageId,
    String moduleName,
    String structName
  ) async {
    final result = await client.request(
      'sui_getNormalizedMoveStruct',
      [packageId, moduleName, structName]
    );
    return SuiMoveNormalizedStruct.fromJson(result);
  }

  /// Objects
  
  Future<PaginatedObjectsResponse> getOwnedObjects(
    String address, {
    SuiObjectDataOptions? options,
    int limit = 50,
    String? cursor,
    Map? filter,
  }) async {
    options ??= SuiObjectDataOptions();
    final result = await client.request('suix_getOwnedObjects', [
      address,
      {"filter": filter, "options": options.toJson()},
      cursor,
      limit,
    ]);
    return PaginatedObjectsResponse.fromJson(result);
  }

  Future<List<SuiObject>> getGasObjectsOwnedByAddress(String address) async {
    final objects = await getOwnedObjects(address, options: SuiObjectDataOptions(showType: true));
    final result = objects
      .data
      .where((x) => Coin.isSUI(x))
      .map((y) => y.data!);
    return result.toList();
  }

  Future<List<SuiObjectResponse>> getCoinBalancesOwnedByAddress(
    String address,
    {String? typeArg}
  ) async {
    final objects = await getOwnedObjects(address);
    final coinIds = objects
      .data
      .where((x) => Coin.isCoin(x)
                && (typeArg == null || typeArg == Coin.getCoinTypeArg(x)))
      .map((y) => y.data!.objectId);

    final result = await getObjectBatch(coinIds.toList());
    return result;
  }

  Future<List<SuiObject>> getObjectsOwnedByObject(String objectId) async {
    final data = await client.request(
      'sui_getObjectsOwnedByObject',
      [objectId]
    );
    return (data as List).map((e) => SuiObject.fromJson(e)).toList();
  }

  Future<SuiObjectResponse> getObject(String objectId,
      {SuiObjectDataOptions? options}) async {
    final data = await client.request('sui_getObject', [objectId, options?.toJson()]);
    return SuiObjectResponse.fromJson(data);
  }

	Future<ObjectRead> tryGetPastObject(
    String id, 
    int version, {
      SuiObjectDataOptions? options
    }
  ) async {
		final data = await client.request(
			'sui_tryGetPastObject',
			[id, version, options?.toJson()]
		);
    return ObjectRead.fromJson(data);
	}

  Future<List<SuiObjectResponse>> multiGetObjects(List<String> objectIds,
      {SuiObjectDataOptions? options}) async {
    final data =
        await client.request('sui_multiGetObjects', [objectIds, options?.toJson()]);
    List<SuiObjectResponse> list = [];
    for(var response in data){
      list.add(SuiObjectResponse.fromJson(response));
    }
    return list;
  }

  Future<PaginatedTransactionResponse> queryTransactionBlocks(
      Map filter,
      {SuiTransactionBlockResponseOptions? options,
      int? limit,
      String? cursor,
      bool descendingOrder = true}) async {
    final data = await client.request('suix_queryTransactionBlocks', [
      {
        "filter": filter,
        "options": options?.toJson()
      },
      cursor,
      limit,
      descendingOrder
    ]);
    return PaginatedTransactionResponse.fromJson(data);
  }

  Future<SuiTransactionBlockResponse> getTransactionBlock(
      TransactionDigest digest,
      {SuiTransactionBlockResponseOptions? options}) async {
    final data = await client
        .request('sui_getTransactionBlock', [digest, options?.toJson()]);
    return SuiTransactionBlockResponse.fromJson(data);
  }

  Future<List<SuiTransactionBlockResponse>> multiGetTransactionBlocks(
      List<TransactionDigest> digests,
      {SuiTransactionBlockResponseOptions? options}) async {
    final data = await client.request(
        'sui_multiGetTransactionBlocks', [digests, options?.toJson()]);
    List<SuiTransactionBlockResponse> list = [];
    for (var response in data) {
      list.add(SuiTransactionBlockResponse.fromJson(response));
    }
    return list;
  }

  Future<SuiTransactionBlockResponse> executeTransactionBlock(
    String transactionBlockBase64,
    List<String> signature, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForEffectsCert,
  }) async {
    final data = await client.request('sui_executeTransactionBlock', [
      transactionBlockBase64,
      signature,
      options?.toJson(),
      requestType.name,
    ]);
    return SuiTransactionBlockResponse.fromJson(data);
  }

  Future<BigInt> getTotalTransactionBlocks() async {
    final data = await client.request('sui_getTotalTransactionBlocks', []);
    return BigInt.parse(data);
  }

  Future<BigInt> getReferenceGasPrice() async {
    final data = await client.request('suix_getReferenceGasPrice', []);
    return BigInt.parse(data);
  }

  Future<SuiSystemStateSummary> getLatestSuiSystemState() async {
    final data = await client.request('suix_getLatestSuiSystemState', []);
    return SuiSystemStateSummary.fromJson(data);
  }

  Future<ValidatorsApy> getValidatorsApy() async {
    final data = await client.request('suix_getValidatorsApy', []);
    return ValidatorsApy.fromJson(data);
  }

  // Future<ValidatorsApys> getValidatorsApy() async {
  //   final result = await client.request('suix_getValidatorsApy');
  //   return ValidatorsApys.fromJson(result);
  // }

  Future<List<DelegatedStake>> getStakes(SuiAddress address) async {
    final data = await client.request('suix_getStakes', [address]);
    List<DelegatedStake> delegatedStakes = [];
    for(var value in data){
      delegatedStakes.add(DelegatedStake.fromJson(value));
    }
    return delegatedStakes;
  }

  Future<List<DelegatedStake>> getStakesByIds(List<ObjectId> stakedSuiIds) async {
    final data = await client.request('suix_getStakesByIds', [stakedSuiIds]);
    List<DelegatedStake> delegatedStakes = [];
    for(var value in data){
      delegatedStakes.add(DelegatedStake.fromJson(value));
    }
    return delegatedStakes;
  }

  Future<CommitteeInfo> getCommitteeInfo([String? epoch]) async {
    final data = await client.request('suix_getCommitteeInfo', [epoch]);
    return CommitteeInfo.fromJson(data);
  }

  Future<SuiObjectRef?> getObjectRef(String objectId) async {
    final data = await getObject(objectId);
    return getObjectReference(data);
  }

  Future<List<SuiObjectResponse>> getObjectBatch(List<String> objectIds) async {
    final requests = objectIds.map((id) => ({
      'method': 'sui_getObject',
      'args': [id],
    }));
    final dataList = await client.batchRequest(requests);

    final result = (dataList as List)
      .map((data) => SuiObjectResponse.fromJson(data))
      .toList();
    return result;
  }

  /// Query Transactions
  Future<(List<SuiTransactionBlockResponse> data, String?, String?)> getTransactions(
    String address, {
    SuiTransactionBlockResponseOptions? options,
    TransactionDigest? filterFromCursor,
    TransactionDigest? filterToCursor,
    int? limit,
    bool descendingOrder = true,
  }) async {
    final filterFromAddressQuery = queryTransactionBlocks(
        {'FromAddress': address},
        options: options,
        cursor: filterFromCursor,
        limit: limit,
        descendingOrder: descendingOrder);
    final filterToAddressQuery = queryTransactionBlocks(
        {'ToAddress': address},
        options: options,
        cursor: filterToCursor,
        limit: limit,
        descendingOrder: descendingOrder);

    final result = await Future.wait([filterFromAddressQuery, filterToAddressQuery]);

    final fromResult = result[0];
    final toResult = result[1];
    final txs = fromResult.data;
    final nextFromCursor = fromResult.hasNextPage ? fromResult.nextCursor : null;
    final nextToCursor = toResult.hasNextPage ? toResult.nextCursor : null;
    final digests = txs.isNotEmpty ? txs.map((e) => e.digest).toList() : [];
    if (digests.isEmpty) {
      return (toResult.data, nextFromCursor, nextToCursor);
    }

    for (var item in toResult.data) {
      if (digests.contains(item.digest)) {
        continue;
      }

      txs.add(item);
    }
    return (txs, nextFromCursor, nextToCursor);
  }


  Future<List<SuiTransactionBlockResponse>> getTransactionBlockBatch(
    List<TransactionDigest> digests,
  [SuiTransactionBlockResponseOptions? options]
  ) async {
    final requests = digests.map((d) => ({
      'method': 'sui_getTransactionBlock',
      'args': [d, options?.toJson()],
    }));
    final result = await client.batchRequest(requests) as List;
    if (result.isEmpty) return <SuiTransactionBlockResponse>[];
    final resp = result.map((e) => SuiTransactionBlockResponse.fromJson(e));
    return resp.toList();
  }

  Future<SuiExecuteTransactionResponse> executeTransaction({
    required Uint8List txnBytes,
    required SignatureScheme signatureScheme,
    required Uint8List signature,
    required PublicKey pubkey,
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForEffectsCert,
  }) async {
    final serializedSig = <int>[];
    serializedSig.add(SIGNATURE_SCHEME_TO_FLAG.schemeToFlag(signatureScheme));
    serializedSig.addAll(signature);
    serializedSig.addAll(pubkey.toBytes());
    final result = await executeTransactionBlock(
      base64Encode(txnBytes),
      [base64Encode(serializedSig)],
      options: options ?? SuiTransactionBlockResponseOptions(
        showInput: true,
        showEffects: true,
        showEvents: true,
        showObjectChanges: true,
        showBalanceChanges: true,
      ),
      requestType: requestType,
    );
    return result;
  }

  /// Events
  
  Future<List<SuiEvent>> getEvents(String txDigest) async {
    final result = await client.request('sui_getEvents', [txDigest]);
    final events = (result as List).map((e) => SuiEvent.fromJson(e)).toList();
    return events;
  }

  Future<Paged<List<SuiEvent>>> queryEvents(
    Map query,
    {String? cursor,
    int? limit,
    bool descendingOrder = false}
  ) async {
    final result = await client.request(
      'suix_queryEvents',
      [
        query,
        cursor,
        limit,
        descendingOrder
      ]
    );

    final events = Paged<List<SuiEvent>>.fromJson(result, (json) {
      return (json as List).map((e) => SuiEvent.fromJson(e)).toList();
    });
    return events;
  }

  Future<Paged<List<SuiEvent>>> queryEventsByFilter(
    EventFilter filter,
    {String? cursor,
    int? limit,
    bool descendingOrder = false}
  ) async {
    return await queryEvents(
      filter.toJson(), 
      cursor: cursor, 
      limit: limit, 
      descendingOrder: descendingOrder
    );
  }

  Future<Paged<List<SuiEvent>>> queryTransactionEvents(
    TransactionDigest digest,
    {String? cursor,
    int limit = 1,
    bool descendingOrder = true}
  ) async {
    final query = { "Transaction": digest };
    final result = await queryEvents(
      query, 
      limit: limit, 
      descendingOrder: descendingOrder, 
      cursor: cursor
    );
    return result;
  }

  Future<DryRunTransactionBlockResponse> dryRunTransactionBlock(String txBytes) async {
    final result = await client.request(
      'sui_dryRunTransactionBlock',
      [txBytes],
    );
    return DryRunTransactionBlockResponse.fromJson(result);
  }

  Future<SuiObjectResponse> getDynamicFieldObject(
    String parentObjectId, 
    String nameType, 
    String nameValue
  ) async {
    final params = {"type": nameType, "value": nameValue};
    final data = await client.request('suix_getDynamicFieldObject', [parentObjectId, params]);
    return SuiObjectResponse.fromJson(data);
  }

  Future<DynamicFieldPage> getDynamicFields(
    String parentId, {
    String? cursor,
    int? limit,
  }) async {
    final result = await client.request(
      'suix_getDynamicFields',
      [parentId, cursor, limit],
    );
    return DynamicFieldPage.fromJson(result);
  }

  Future<dynamic> getCurrentEpoch() async {
    return await client.request('suix_getCurrentEpoch');
  }

  Future<String?> resolveNameServiceAddress(String name) async {
    return await client.request(
      'suix_resolveNameServiceAddress',
      [name]
    );
  }

  Future<Paged<List<String>>?> resolveNameServiceNames(
    String address, {
    String? cursor,
    int? limit
  }) async {
    final result = await client.request(
      'suix_resolveNameServiceNames',
      [address, cursor, limit]
    );
    final names = Paged<List<String>>.fromJson(result, (json) {
      return List<String>.from(json as List);
    });
    return names;
  }

	Future<dynamic> getProtocolConfig([String? version]) async {
		return await client.request(
			'sui_getProtocolConfig',
			[version]
		);
	}

}
