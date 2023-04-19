
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:sui/cryptography/publickey.dart';
import 'package:sui/rpc/client.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/types/coins.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/events.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/normalized.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';
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

  Future<RpcApiVersion> getRpcApiVersion() async {
    final resp = await client.request(
      'rpc.discover',
      [],
    );
    final rpcApiVersion = RpcApiVersion.parseVersion(resp['info']['version']);
    return rpcApiVersion;
  }

  /// Get all Coin<`coin_type`> objects owned by an address.
  Future<PaginatedCoins> getCoins(String owner,
      { String coinType = "0x2::sui::SUI", ObjectId? cursor, int? limit,}) async {
    try {
      final resp = await client.request(
          'suix_getCoins',
          [owner, coinType, cursor, limit]
      );
      return PaginatedCoins.fromJson(resp);
    } catch (err) {
      throw ArgumentError(
        'Error getting coin for coin type $coinType for owner $owner: $err',
      );
    }
  }

  /// Get all Coin objects owned by an address.
  Future<PaginatedCoins> getAllCoins(String owner,
      { ObjectId? cursor, int? limit,}) async {
    try {
      final resp = await client.request(
          'suix_getAllCoins',
          [owner, cursor, limit]
      );
      return PaginatedCoins.fromJson(resp);
    } catch (err) {
      throw ArgumentError(
        'Error getting all coins for owner $owner: $err',
      );
    }
  }

  /// Get the total coin balance for one coin type, owned by the address owner.
  Future<CoinBalance> getBalance(String owner,
      {String coinType = "0x2::sui::SUI"}) async {
    try {
      final resp = await client.request('suix_getBalance', [owner, coinType]);
      return CoinBalance.fromJson(resp);
    } catch (err) {
      throw ArgumentError(
        'Error getting balance for coin type $coinType for owner $owner: $err',
      );
    }
  }

  Future<List<CoinBalance>> getBalanceBatch(List<String> owner,
      {String coinType = "0x2::sui::SUI"}) async {
    final requests = owner.map((d) => ({
      'method': 'suix_getBalance',
      'args': [d, coinType],
    }));
    try {
      var result = await client.batchRequest(requests);
      List<CoinBalance> coins = [];
      for(var coin in result) {
        coins.add(CoinBalance.fromJson(coin));
      }
      return coins;
    } catch (err) {
      final list = owner.join(', ').substring(0, -2);
      throw ArgumentError(
          'Error getting transaction effects: $err for digests [$list]');
    }
  }

  /// Get the total coin balance for all coin type, owned by the address owner.
  Future<List<CoinBalance>> getAllBalance(String owner) async {
    try {
      final resp = await client.request(
        'suix_getAllBalances',
        [owner]
      );
      List<CoinBalance> list = [];
      for (var coin in resp) {
        list.add(CoinBalance.fromJson(coin));
      }
      return list;
    } catch (err) {
      throw ArgumentError(
       'Error getting all balances for owner $owner: $err'
      );
    }
  }


  /// Fetch CoinMetadata for a given coin type
  Future<CoinMetadataStruct> getCoinMetadata(String coinType) async {
    try {
      final resp = await client.request(
          'suix_getCoinMetadata',
          [coinType]
      );
      return CoinMetadataStruct.fromJson(resp);
    } catch (err) {
      throw ArgumentError(
        'Error getting coinMetadata for coinType $coinType: $err',
      );
    }
  }

  Future<CoinSupply> getTotalSupply(String coinType) async {
    try {
      final resp = await client.request(
          'suix_getTotalSupply',
          [coinType]
      );
      return CoinSupply.fromJson(resp);
    } catch (err) {
      throw ArgumentError(
        'Error getTotalSupply for coinType $coinType: $err',
      );
    }
  }

  Future<SuiMoveFunctionArgTypes> getMoveFunctionArgTypes(
    String packageId,
    String moduleName,
    String functionName
  ) async {
    try {
      final resp = await client.request(
        'sui_getMoveFunctionArgTypes',
        [packageId, moduleName, functionName]
      );
      return resp;
    } catch (err) {
      throw ArgumentError(
        'Error fetching Move function arg types with package object ID: $packageId, module name: $moduleName, function name: $functionName'
      );
    }
  }

  Future<SuiMoveNormalizedModules> getNormalizedMoveModulesByPackage(
    String packageId
  ) async {
    try {
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
    } catch (err) {
      throw ArgumentError(
        'Error fetching package: $err for package $packageId'
      );
    }
  }

  Future<SuiMoveNormalizedModule> getNormalizedMoveModule(
    String packageId,
    String moduleName
  ) async {
    try {
      final resp = await client.request(
        'sui_getNormalizedMoveModule',
        [packageId, moduleName]
      );
      return SuiMoveNormalizedModule.fromJson(resp);
    } catch (err) {
      throw  ArgumentError(
        'Error fetching module: $err for package $packageId, module $moduleName'
      );
    }
  }

  Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(
    String packageId,
    String moduleName,
    String functionName
  ) async {
    try {
      final resp = await client.request(
        'sui_getNormalizedMoveFunction',
        [packageId, moduleName, functionName]
      );
      return SuiMoveNormalizedFunction.fromJson(resp);
    } catch (err) {
      throw ArgumentError(
        'Error fetching function: $err for package $packageId, module $moduleName and function $functionName'
      );
    }
  }

  Future<SuiMoveNormalizedStruct> getNormalizedMoveStruct(
    String packageId,
    String moduleName,
    String structName
  ) async {
    try {
      final resp = await client.request(
        'sui_getNormalizedMoveStruct',
        [packageId, moduleName, structName]
      );
      return SuiMoveNormalizedStruct.fromJson(resp);
    } catch (err) {
      throw ArgumentError(
        'Error fetching struct: $err for package $packageId, module $moduleName and struct $structName'
      );
    }
  }

  /// Objects
  Future<List<SuiObjectInfo>> getOwnedObjects(String address) async {
    try {
      final resp = await client.request('suix_getOwnedObjects', [
        address,
        {
          "options": {
            "showType": true,
            "showContent": true,
            "showBcs": true,
            "showOwner": true,
            "showPreviousTransaction": true,
            "showStorageRebate": true,
            "showDisplay": true
          }
        },
      ]);
      final objectsInfo = (resp['data'] as List).map((obj) {
        return SuiObjectInfo.fromJson(obj['data']);
      }).toList();
      return objectsInfo;
    } catch (err) {
      throw ArgumentError(
        'Error fetching owned object: $err for address $address'
      );
    }
  }

  Future<List<SuiObjectInfo>> getGasObjectsOwnedByAddress(String address) async {
    final objects = await getOwnedObjects(address);
    final result = objects
      .where((obj) => Coin.isSUI(ObjectData(objectInfo: obj)));
    return result.toList();
  }

  // CoinDenominationInfoResponse getCoinDenominationInfo(String coinType) {
  //   final coinTypeArr = coinType.split('::');
  //   final packageId = coinTypeArr[0];
  //   final module = coinTypeArr[1];
  //   final symbol = coinTypeArr[2];

  //   if (
  //     normalizeSuiAddress(packageId) != normalizeSuiAddress('0x2') ||
  //     module != 'sui' ||
  //     symbol != 'SUI'
  //   ) {
  //     throw ArgumentError(
  //       'only SUI coin is supported in getCoinDenominationInfo for now.'
  //     );
  //   }

  //   return CoinDenominationInfoResponse(
  //     coinType, 'MIST', 9
  //   );
  // }

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

  // Future<GetObjectDataResponse> selectCoinsWithBalanceGreaterThanOrEqual(
  //   String address,
  //   BigInt amount,
  //   {String typeArg = SUI_TYPE_ARG,
  //   List<ObjectId> exclude = []}
  // ) async {
  //   final coins = await this.getCoinBalancesOwnedByAddress(address, typeArg);
  //   return (await Coin.selectCoinsWithBalanceGreaterThanOrEqual(
  //     coins,
  //     amount,
  //     exclude
  //   )) as List<GetObjectDataResponse>;
  // }

  // async selectCoinSetWithCombinedBalanceGreaterThanOrEqual(
  //   address: string,
  //   amount: bigint,
  //   typeArg: string = SUI_TYPE_ARG,
  //   exclude: ObjectId[] = []
  // ): Promise<GetObjectDataResponse[]> {
  //   const coins = await this.getCoinBalancesOwnedByAddress(address, typeArg);
  //   return (await Coin.selectCoinSetWithCombinedBalanceGreaterThanOrEqual(
  //     coins,
  //     amount,
  //     exclude
  //   )) as GetObjectDataResponse[];
  // }

  Future<List<SuiObjectInfo>> getObjectsOwnedByObject(String objectId) async {
    try {
      final data = await client.request(
        'sui_getObjectsOwnedByObject',
        [objectId]
      );
      return (data as List).map((e) => SuiObjectInfo.fromJson(e)).toList();
    } catch (err) {
      throw ArgumentError(
        'Error fetching owned object: $err for objectId $objectId'
      );
    }
  }

  Future<SuiObjectResponse> getObject(String objectId,
      {SuiObjectDataOptions? options}) async {
    try {
      final data = await client.request('sui_getObject', [objectId, options]);
      return SuiObjectResponse.fromJson(data);
    } catch (err) {
      throw ArgumentError('Error fetching object info: $err for id $objectId');
    }
  }

  Future<List<SuiObjectResponse>> multiGetObjects(List<String> objectIds,
      {SuiObjectDataOptions? options}) async {
    try {
      final data =
          await client.request('sui_multiGetObjects', [objectIds, options]);
      List<SuiObjectResponse> list = [];
      for(var response in data){
        list.add(SuiObjectResponse.fromJson(response));
      }
      return list;
    } catch (err) {
      throw ArgumentError('Error fetching objects info: $err for id $objectIds');
    }
  }

  /*
   {
      MoveFunction: {
        package: ObjectId;
        module: string | null;
        function: string | null;
      };
    }
  | { InputObject: ObjectId }
  | { ChangedObject: ObjectId }
  | { FromAddress: SuiAddress }
  | { ToAddress: SuiAddress }
   */
  Future<PaginatedTransactionResponse> queryTransactionBlocks(
      Map filter,
      {SuiTransactionBlockResponseOptions? options,
      int limit = 100,
      String? cursor,
      bool descendingOrder = true}) async {
    try {
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
    } catch (err) {
      throw ArgumentError(
          'Error fetching queryTransactionBlocks info: $err for filter $filter');
    }
  }

  Future<SuiTransactionBlockResponse> getTransactionBlock(
      TransactionDigest digest,
      [SuiTransactionBlockResponseOptions? options]) async {
    try {
      final data = await client
          .request('sui_getTransactionBlock', [digest, options?.toJson()]);
      return SuiTransactionBlockResponse.fromJson(data);
    } catch (err) {
      throw ArgumentError(
          'Error fetching getTransactionBlock info: $err for digest $digest');
    }
  }

  Future<List<SuiTransactionBlockResponse>> multiGetTransactionBlocks(
      List<TransactionDigest> digests,
      {SuiTransactionBlockResponseOptions? options}) async {
    try {
      final data = await client.request(
          'sui_multiGetTransactionBlocks', [digests, options?.toJson()]);
      List<SuiTransactionBlockResponse> list = [];
      for (var response in data) {
        list.add(SuiTransactionBlockResponse.fromJson(response));
      }
      return list;
    } catch (err) {
      throw ArgumentError(
          'Error fetching multiGetTransactionBlocks info: $err for digests $digests');
    }
  }


  /// transactionBlock is base64 string
  Future<SuiTransactionBlockResponse> executeTransactionBlock(
    String transactionBlock,
    List<String> signature, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForEffectsCert,
  }) async {
    try {
      final data = await client.request('sui_executeTransactionBlock', [
        transactionBlock,
        signature,
        options?.toJson(),
        requestType.name,
      ]);
      return SuiTransactionBlockResponse.fromJson(data);
    } catch (err) {
      throw ArgumentError(
          'Error fetching executeTransactionBlock info: $err for transactionBlock $transactionBlock');
    }
  }

  /// Get total number of transactions
  Future<BigInt> getTotalTransactionBlocks() async {
    try {
      final data = await client.request('sui_getTotalTransactionBlocks', []);
      return BigInt.parse(data);
    } catch (err) {
      throw ArgumentError(
          'Error fetching getTotalTransactionBlocks info: $err');
    }
  }

  /// Getting the reference gas price for the network
  Future<BigInt> getReferenceGasPrice() async {
    try {
      final data = await client.request('suix_getReferenceGasPrice', []);
      return BigInt.parse(data);
    } catch (err) {
      throw ArgumentError(
          'Error fetching getTotalTransactionBlocks info: $err');
    }
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
    try {
      final dataList = await client.batchRequest(requests);

      final result = (dataList as List)
        .map((data) => SuiObjectResponse.fromJson(data))
        .toList();
      return result;
    } catch (err) {
      throw ArgumentError('Error fetching object info: $err for id $objectIds');
    }
  }

  /// Query Transactions Hash
  Future<List<SuiTransactionBlockResponse>> getTransactions(
    String address,
    {TransactionDigest? cursor,
    int? limit,
    bool descendingOrder = true}
  ) async {
    final query = { 'ToAddress': address };
    try {
      final filterFromAddress = await queryTransactionBlocks(
          {'FromAddress': address},
          cursor: cursor,
          limit: limit ?? 100,
          descendingOrder: descendingOrder);
      final filterToAddress = await queryTransactionBlocks(
          {'ToAddress': address},
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
    } catch (err) {
      throw ArgumentError(
        'Error getting transactions for query: $err for query $query'
      );
    }
  }


  Future<List<SuiTransactionBlockResponse>> getTransactionBlockBatch(
    List<TransactionDigest> digests,
  [SuiTransactionBlockResponseOptions? options]
  ) async {
    final requests = digests.map((d) => ({
      'method': 'sui_getTransactionBlock',
      'args': [d, options?.toJson()],
    }));
    try {
      return await client.batchRequest(requests);
    } catch (err) {
      final list = digests.join(', ').substring(0, -2);
      throw ArgumentError(
        'Error getting transaction effects: $err for digests [$list]'
      );
    }
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

  Future<PaginatedEvents> getEvents(
    TransactionDigest digest,
    {int limit = 1,
    bool descendingOrder = true,
    String? cursor}
  ) async {
    try {
      final result = await client.request(
        'sui_getEvents',
        [
          { "Transaction": digest },
          cursor,
          limit,
          descendingOrder
        ]
      );

      return PaginatedEvents.fromJson(result);

    } catch (err) {
      throw ArgumentError(
        'Error getting events by transaction: $digest, with error: $err'
      );
    }
  }


  Future<DryRunTransactionBlockResponse> dryRunTransaction(String txBytes) async {
    try {
      final resp = await client.request(
        'sui_dryRunTransactionBlock',
        [txBytes],
      );
      return DryRunTransactionBlockResponse.fromJson(resp);
    } catch (err) {
      throw ArgumentError('Error dry running transaction with request type: $err');
    }
  }
}
