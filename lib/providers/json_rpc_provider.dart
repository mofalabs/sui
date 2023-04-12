
import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/publickey.dart';
import 'package:sui/rpc/client.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/types/coins.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/events.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';
import 'package:sui/types/version.dart';

class JsonRpcProvider {

  late bool skipDataValidation;
  late int versionCacheTimoutInSeconds;
  late String endpoint;
  late JsonRpcClient client;

  JsonRpcProvider(
    this.endpoint,
    {this.skipDataValidation = true,
    this.versionCacheTimoutInSeconds = 600}
  ): super() {
    client = JsonRpcClient(endpoint);
  }

  Future<RpcApiVersion> getRpcApiVersion() async {
    final resp = await client.request(
      'rpc.discover',
      [],
      skipDataValidation
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
        'Error getting oinMetadata for coinType $coinType: $err',
      );
    }
  }

  Future<dynamic> getMoveFunctionArgTypes(
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

  Future<dynamic> getNormalizedMoveModulesByPackage(
    String packageId
  ) async {
    try {
      return await client.request(
        'sui_getNormalizedMoveModulesByPackage',
        [packageId]
      );
    } catch (err) {
      throw ArgumentError(
        'Error fetching package: $err for package $packageId'
      );
    }
  }

  Future<dynamic> getNormalizedMoveModule(
    String packageId,
    String moduleName
  ) async {
    try {
      final resp = await client.request(
        'sui_getNormalizedMoveModule',
        [packageId, moduleName]
      );
      return resp;
    } catch (err) {
      throw  ArgumentError(
        'Error fetching module: $err for package $packageId, module $moduleName'
      );
    }
  }

  Future<dynamic> getNormalizedMoveFunction(
    String packageId,
    String moduleName,
    String functionName
  ) async {
    try {
      final resp = await client.request(
        'sui_getNormalizedMoveFunction',
        [packageId, moduleName, functionName]
      );
      return resp;
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
  Future<List<SuiObjectInfo>> getObjectsOwnedByAddress(String address) async {
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
    final objects = await getObjectsOwnedByAddress(address);
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

  Future<List<GetObjectDataResponse>> getCoinBalancesOwnedByAddress(
    String address,
    {String? typeArg}
  ) async {
    final objects = await getObjectsOwnedByAddress(address);
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

  Future<GetObjectDataResponse> getObject(String objectId) async {
    try {
      final data = await client.request('sui_getObject', [
        objectId,
        {
          "showType": true,
          "showOwner": true,
          "showPreviousTransaction": true,
          "showDisplay": true,
          "showContent": true,
          "showBcs": true,
          "showStorageRebate": true
        }
      ]);
      return GetObjectDataResponse.fromJson(data);
    } catch (err) {
      throw ArgumentError('Error fetching object info: $err for id $objectId');
    }
  }

  Future<GetObjectDataResponse> getRawObject(String objectId) async {
    try {
      final data = await client.request(
        'suix_getRawObject',
        [objectId]
      );
      return GetObjectDataResponse.fromJson(data);
    } catch (err) {
      throw ArgumentError('Error fetching object info: $err for id $objectId');
    }
  }

  Future<SuiObjectRef?> getObjectRef(String objectId) async {
    final data = await getObject(objectId);
    return getObjectReference(data);
  }

  Future<List<GetObjectDataResponse>> getObjectBatch(List<String> objectIds) async {
    final requests = objectIds.map((id) => ({
      'method': 'sui_getObject',
      'args': [id],
    }));
    try {
      final dataList = await client.batchRequest(
        requests,
        skipDataValidation
      );

      final result = (dataList as List)
        .map((data) => GetObjectDataResponse.fromJson(data))
        .toList();
      return result;
    } catch (err) {
      throw ArgumentError('Error fetching object info: $err for id $objectIds');
    }
  }

  /// Query Transactions Hash
  Future<List<dynamic>> getTransactions(
    String address,
    {TransactionDigest? cursor,
    int? limit,
    bool descendingOrder = true}
  ) async {
    final query = { 'ToAddress': address };
    try {
      final filterFromAddress =
          await client.request('suix_queryTransactionBlocks', [
        {
          "filter": {'FromAddress': address}
        },
        cursor,
        limit,
        descendingOrder
      ]);
      final filterToAddress =
          await client.request('suix_queryTransactionBlocks', [
        {
          "filter": {'ToAddress': address}
        },
        cursor,
        limit,
        descendingOrder
      ]);

      final txIds = <dynamic>{};
      if (filterFromAddress != null && filterFromAddress['data'] is Iterable) {
        for (var item in filterFromAddress['data']) {
          txIds.add(item);
        }
      }

      if (filterToAddress != null && filterToAddress['data'] is Iterable) {
        for (var item in filterToAddress['data']) {
          txIds.add(item);
        }
      }
      return txIds.toList();
    } catch (err) {
      throw ArgumentError(
        'Error getting transactions for query: $err for query $query'
      );
    }
  }

  Future<List<String>> getTransactionsForObject(
    String objectID,
    {bool descendingOrder = true}
  ) async {
    final requests = [
      {
        'method': 'suix_getTransactions',
        'args': [{ 'InputObject': objectID }, null, null, descendingOrder],
      },
      {
        'method': 'suix_getTransactions',
        'args': [{ 'MutatedObject': objectID }, null, null, descendingOrder],
      },
    ];

    try {
      final results = await client.batchRequest(
        requests
      );
      return [...results[0]['data'], ...results[1]['data']];
    } catch (err) {
      throw ArgumentError(
        'Error getting transactions for object: $err for id $objectID'
      );
    }
  }

  Future<SuiTransactionResponse> getTransactionWithEffects(
    TransactionDigest digest
  ) async {
    try {
      final data = await client.request(
        'sui_getTransactionBlock',
        [digest],
        skipDataValidation
      );
      final result = SuiTransactionResponse.fromJson(data);
      return result;
    } catch (err) {
      throw ArgumentError(
        'Error getting transaction with effects: $err for digest $digest'
      );
    }
  }

  Future<List<dynamic>> getTransactionWithEffectsBatch(
    List<TransactionDigest> digests
  ) async {
    final requests = digests.map((d) => ({
      'method': 'sui_getTransactionBlock',
      'args': [d],
    }));
    try {
      return await client.batchRequest(
        requests,
        skipDataValidation
      );
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
    PublicKey pubkey,
   [ExecuteTransaction requestType = ExecuteTransaction.WaitForEffectsCert]
  ) async {
    final serializedSig = <int>[];
    serializedSig.add(SIGNATURE_SCHEME_TO_FLAG.schemeToFlag(signatureScheme));
    serializedSig.addAll(signature.getData());
    serializedSig.addAll(pubkey.toBytes());
    var params = [
      txnBytes.toBase64(),
      [Base64DataBuffer(serializedSig).toBase64()],
      {
        "showInput": true,
        "showRawInput": true,
        "showEffects": true,
        "showEvents": true,
        "showObjectChanges": true,
        "showBalanceChanges": true,
        "skipDataValidation": skipDataValidation
      },
      requestType.name
    ];
    final result = await client.request(
        'sui_executeTransactionBlock',
        params,
        skipDataValidation
    );
    return SuiExecuteTransactionResponse.fromJson(result);
  }

  Future<int> getTotalTransactionNumber() async {
    try {
      final resp = await client.request(
        'suix_getTotalTransactionNumber',
        []
      );
      return resp;
    } catch (err) {
      throw ArgumentError('Error fetching total transaction number: ${err}');
    }
  }

  Future<List<String>> getTransactionDigestsInRange(
    int start,
    int end
  ) async {
    try {
      final data = await client.request(
        'suix_getTransactionsInRange',
        [start, end]
      );
      return (data as List).cast<String>();
    } catch (err) {
      throw ArgumentError(
        'Error fetching transaction digests in range: $err for range $start-$end'
      );
    }
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
        'suix_getEvents',
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
