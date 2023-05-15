
import 'package:sui/cryptography/publickey.dart';
import 'package:sui/models/checkpoint.dart';
import 'package:sui/models/loaded_child_objects.dart';
import 'package:sui/models/paged.dart';
import 'package:sui/models/sui_event.dart';
import 'package:sui/models/validators_apys.dart';
import 'package:sui/rpc/client.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/types/coins.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/normalized.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';
import 'package:sui/types/validator.dart';
import 'package:sui/types/version.dart';

class JsonRpcProvider {

  late int versionCacheTimoutInSeconds;
  late String endpoint;
  late JsonRpcClient client;

  JsonRpcProvider(
    this.endpoint,
    {this.versionCacheTimoutInSeconds = 600}
  ): super() {
    client = JsonRpcClient(endpoint);
  }

  Future<Checkpoint> getCheckpoint(String id) async {
    final resp = await client.request('sui_getCheckpoint', [id]);
    return Checkpoint.fromJson(resp);
  }

  Future<Paged<List<Checkpoint>>> getCheckpoints({
    String? cursor,
    String? limit,
    bool descendingOrder = false
  }) async {
    final resp = await client.request('sui_getCheckpoints', [cursor, limit, descendingOrder]);
    final result = Paged<List<Checkpoint>>.fromJson(resp, (json) {
      return (json as List).map((e) => Checkpoint.fromJson(e)).toList();
    });
    return result;
  }

  Future<BigInt> getLatestCheckpointSequenceNumber() async {
    final resp = await client.request('sui_getLatestCheckpointSequenceNumber', []);
    return BigInt.parse(resp);
  }

  Future<LoadedChildObjects> getLoadedChildObjects(String txDigest) async {
    final resp = await client.request('sui_getLoadedChildObjects', [txDigest]);
    return LoadedChildObjects.fromJson(resp);
  }

  Future<RpcApiVersion> getRpcApiVersion() async {
    final resp = await client.request(
      'rpc.discover',
      [],
    );
    final rpcApiVersion = RpcApiVersion.parseVersion(resp['info']['version']);
    return rpcApiVersion;
  }

  Future<PaginatedCoins> getCoins(String owner, {
    String coinType = "0x2::sui::SUI",
    ObjectId? cursor,
    int? limit
  }) async {
    final resp = await client.request(
        'suix_getCoins',
        [owner, coinType, cursor, limit]
    );
    return PaginatedCoins.fromJson(resp);
  }

  Future<PaginatedCoins> getAllCoins(String owner,
      { ObjectId? cursor, int? limit}) async {
    final resp = await client.request(
        'suix_getAllCoins',
        [owner, cursor, limit]
    );
    return PaginatedCoins.fromJson(resp);
  }

  Future<CoinBalance> getBalance(String owner,
      {String coinType = "0x2::sui::SUI"}) async {
    final resp = await client.request('suix_getBalance', [owner, coinType]);
    return CoinBalance.fromJson(resp);
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
    final resp = await client.request(
      'suix_getAllBalances',
      [owner]
    );
    List<CoinBalance> list = [];
    for (var coin in resp) {
      list.add(CoinBalance.fromJson(coin));
    }
    return list;
  }

  Future<CoinMetadataStruct> getCoinMetadata(String coinType) async {
    final resp = await client.request(
        'suix_getCoinMetadata',
        [coinType]
    );
    return CoinMetadataStruct.fromJson(resp);
  }

  Future<CoinSupply> getTotalSupply(String coinType) async {
    final resp = await client.request(
        'suix_getTotalSupply',
        [coinType]
    );
    return CoinSupply.fromJson(resp);
  }

  Future<dynamic> getMoveFunctionArgTypes({
    required String packageId,
    required String moduleName,
    required String functionName
  }) async {
    final resp = await client.request(
      'sui_getMoveFunctionArgTypes',
      [packageId, moduleName, functionName]
    );
    return resp;
  }

  Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(
    String packageId,
    String moduleName,
    String functionName
  ) async {
    final resp = await client.request(
      'sui_getNormalizedMoveFunction',
      [packageId, moduleName, functionName]
    );
    return SuiMoveNormalizedFunction.fromJson(resp);
  }

  Future<SuiMoveNormalizedModule> getNormalizedMoveModule(
    String packageId,
    String moduleName
  ) async {
    final resp = await client.request(
      'sui_getNormalizedMoveModule',
      [packageId, moduleName]
    );
    return SuiMoveNormalizedModule.fromJson(resp);
  }

  Future<SuiMoveNormalizedModules> getNormalizedMoveModulesByPackage(
    String packageId
  ) async {
    var resp = await client.request(
      'sui_getNormalizedMoveModulesByPackage',
      [packageId]
    );
    SuiMoveNormalizedModules modules = <String, SuiMoveNormalizedModule>{};
    if(resp is Map) {
      for(var key in resp.keys){
        modules[key] = SuiMoveNormalizedModule.fromJson(resp[key]);
      }
    }
    return modules;
  }

  Future<SuiMoveNormalizedStruct> getNormalizedMoveStruct(
    String packageId,
    String moduleName,
    String structName
  ) async {
    final resp = await client.request(
      'sui_getNormalizedMoveStruct',
      [packageId, moduleName, structName]
    );
    return SuiMoveNormalizedStruct.fromJson(resp);
  }

  /// Objects
  
  Future<PaginatedObjectsResponse> getOwnedObjectList(
      String address, {
        SuiObjectDataOptions? options,
        int limit = 50,
    String? cursor,
    Map? filter,
  }) async {
    options ??= SuiObjectDataOptions(
      showDisplay: true,
      showType: true,
      showBcs: true,
      showOwner: true,
      showPreviousTransaction: true,
      showStorageRebate: true,
    );
    final resp = await client.request('suix_getOwnedObjects', [
      address,
      {"filter": filter, "options": options.toJson()},
      cursor,
      limit,
    ]);
    return PaginatedObjectsResponse.fromJson(resp);
  }

  Future<List<SuiObjectInfo>> getOwnedObjects(String address, {
    Map<String,dynamic>? filter,
    Map<String,dynamic>? options,
    bool showAllOptions = false
  }) async {
    final params = <String, dynamic>{};
    params["filter"] = filter;
    final opconf =  {
      "showType": true,
      "showContent": true,
      "showBcs": true,
      "showOwner": true,
      "showPreviousTransaction": true,
      "showStorageRebate": true,
      "showDisplay": true
    };
    params["options"] = showAllOptions ? opconf : options;

    final resp = await client.request('suix_getOwnedObjects', [
      address,
      params
    ]);
    final objectsInfo = (resp['data'] as List).map((obj) {
      return SuiObjectInfo.fromJson(obj['data']);
    }).toList();
    return objectsInfo;
  }

  Future<List<SuiObjectInfo>> getGasObjectsOwnedByAddress(String address) async {
    final objects = await getOwnedObjects(address);
    final result = objects
      .where((obj) => Coin.isSUI(ObjectData(objectInfo: obj)));
    return result.toList();
  }

  Future<List<SuiObjectResponse>> getCoinBalancesOwnedByAddress(
    String address,
    {String? typeArg}
  ) async {
    final objects = await getOwnedObjects(address);
    final coinIds = objects
      .where((x) => Coin.isCoin(ObjectData(objectInfo: x))
                && (typeArg == null || typeArg == Coin.getCoinTypeArg(ObjectData(objectInfo: x))))
      .map((y) => y.objectId);

    final result = await getObjectBatch(coinIds.toList());
    return result;
  }

  Future<List<SuiObjectInfo>> getObjectsOwnedByObject(String objectId) async {
    final data = await client.request(
      'sui_getObjectsOwnedByObject',
      [objectId]
    );
    return (data as List).map((e) => SuiObjectInfo.fromJson(e)).toList();
  }

  Future<SuiObjectResponse> getObject(String objectId,
      {SuiObjectDataOptions? options}) async {
    final data = await client.request('sui_getObject', [objectId, options?.toJson()]);
    return SuiObjectResponse.fromJson(data);
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
      int limit = 100,
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
      [SuiTransactionBlockResponseOptions? options]) async {
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
  //   final resp = await client.request('suix_getValidatorsApy');
  //   return ValidatorsApys.fromJson(resp);
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

  /// Query Transactions Hash
  Future<List<SuiTransactionBlockResponse>> getTransactions(
    String address, {
    SuiTransactionBlockResponseOptions? options,
    TransactionDigest? cursor,
    int? limit,
    bool descendingOrder = true,
  }) async {
    final filterFromAddress = await queryTransactionBlocks(
        {'FromAddress': address},
        options: options,
        cursor: cursor,
        limit: limit ?? 100,
        descendingOrder: descendingOrder);
    final filterToAddress = await queryTransactionBlocks(
        {'ToAddress': address},
        options: options,
        cursor: cursor,
        limit: limit ?? 100,
        descendingOrder: descendingOrder);

    final txIds = <SuiTransactionBlockResponse>{};
    for (var item in filterFromAddress.data) {
      txIds.add(item);
    }

    for (var item in filterToAddress.data) {
      txIds.add(item);
    }
    return txIds.toList();
  }


  Future<List<SuiTransactionBlockResponse>> getTransactionBlockBatch(
    List<TransactionDigest> digests,
  [SuiTransactionBlockResponseOptions? options]
  ) async {
    final requests = digests.map((d) => ({
      'method': 'sui_getTransactionBlock',
      'args': [d, options?.toJson()],
    }));
    final resp = await client.batchRequest(requests) as List;
    if (resp.isEmpty) return <SuiTransactionBlockResponse>[];
    final result = resp.map((e) => SuiTransactionBlockResponse.fromJson(e));
    return result.toList();
  }

  Future<SuiExecuteTransactionResponse> executeTransaction(
    Base64DataBuffer txnBytes,
    SignatureScheme signatureScheme,
    Base64DataBuffer signature,
    PublicKey pubkey, [
    ExecuteTransaction requestType = ExecuteTransaction.WaitForEffectsCert,
  ]) async {
    final serializedSig = <int>[];
    serializedSig.add(SIGNATURE_SCHEME_TO_FLAG.schemeToFlag(signatureScheme));
    serializedSig.addAll(signature.getData());
    serializedSig.addAll(pubkey.toBytes());
    final result = await executeTransactionBlock(
      txnBytes.toBase64(),
      [Base64DataBuffer(serializedSig).toBase64()],
      options: SuiTransactionBlockResponseOptions(
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
    final resp = await client.request('sui_getEvents', [txDigest]);
    final result = (resp as List).map((e) => SuiEvent.fromJson(e)).toList();
    return result;
  }

  Future<Paged<List<SuiEvent>>> queryEvents(
    dynamic query,
    {String? cursor,
    int? limit,
    bool descendingOrder = false}
  ) async {
    final resp = await client.request(
      'suix_queryEvents',
      [
        query,
        cursor,
        limit,
        descendingOrder
      ]
    );

    final result = Paged<List<SuiEvent>>.fromJson(resp, (json) {
      return (json as List).map((e) => SuiEvent.fromJson(e)).toList();
    });
    return result;
  }

  Future<Paged<List<SuiEvent>>> queryTransactionEvents(
    TransactionDigest digest,
    {String? cursor,
    int limit = 1,
    bool descendingOrder = true}
  ) async {
    final query = { "Transaction": digest };
    final resp = await queryEvents(
      query, 
      limit: limit, 
      descendingOrder: descendingOrder, 
      cursor: cursor
    );
    return resp;
  }

  Future<DryRunTransactionBlockResponse> dryRunTransaction(String txBytes) async {
    final resp = await client.request(
      'sui_dryRunTransactionBlock',
      [txBytes],
    );
    return DryRunTransactionBlockResponse.fromJson(resp);
  }

  Future<dynamic> getCurrentEpoch() async {
    return await client.request('suix_getCurrentEpoch');
  }
}
