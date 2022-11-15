
import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/publickey.dart';
import 'package:sui/rpc/client.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/events.dart';
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

  // Future<SuiMoveFunctionArgTypes> getMoveFunctionArgTypes(
  //   String packageId,
  //   String moduleName,
  //   String functionName
  // ) async {
  //   try {
  //     return await client.requestWithType(
  //       'sui_getMoveFunctionArgTypes',
  //       [packageId, moduleName, functionName],
  //       isSuiMoveFunctionArgTypes,
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error fetching Move function arg types with package object ID: $packageId, module name: $moduleName, function name: $functionName'
  //     );
  //   }
  // }

  // Future<SuiMoveNormalizedModules> getNormalizedMoveModulesByPackage(
  //   String packageId
  // ) async {
  //   // TODO: Add caching since package object does not change
  //   try {
  //     return await this.client.requestWithType(
  //       'sui_getNormalizedMoveModulesByPackage',
  //       [packageId],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error fetching package: ${err} for package ${packageId}'
  //     );
  //   }
  // }

  // Future<SuiMoveNormalizedModule> getNormalizedMoveModule(
  //   String packageId,
  //   String moduleName
  // ) async {
  //   // TODO: Add caching since package object does not change
  //   try {
  //     return await this.client.requestWithType(
  //       'sui_getNormalizedMoveModule',
  //       [packageId, moduleName],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw  ArgumentError(
  //       'Error fetching module: ${err} for package ${packageId}, module ${moduleName}}'
  //     );
  //   }
  // }

  // Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(
  //   String packageId,
  //   String moduleName,
  //   String functionName
  // ) async {
  //   // TODO: Add caching since package object does not change
  //   try {
  //     return await client.requestWithType(
  //       'sui_getNormalizedMoveFunction',
  //       [packageId, moduleName, functionName],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArguemntError(
  //       'Error fetching function: ${err} for package ${packageId}, module ${moduleName} and function ${functionName}}'
  //     );
  //   }
  // }

  // Future<SuiMoveNormalizedStruct> getNormalizedMoveStruct(
  //   String packageId,
  //   String moduleName,
  //   String structName
  // ) async {
  //   try {
  //     return await this.client.requestWithType(
  //       'sui_getNormalizedMoveStruct',
  //       [packageId, moduleName, structName],
  //       isSuiMoveNormalizedStruct,
  //       this.skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error fetching struct: ${err} for package ${packageId}, module ${moduleName} and struct ${structName}}'
  //     );
  //   }
  // }

  /// Objects
  Future<List<SuiObjectInfo>> getObjectsOwnedByAddress(String address) async {
    try {
      final resp = await client.request(
        'sui_getObjectsOwnedByAddress',
        [address]
      );
      final objectsInfo = (resp as List).map((obj) => SuiObjectInfo.fromJson(obj)).toList();
      return objectsInfo;
    } catch (err) {
      throw ArgumentError(
        'Error fetching owned object: $err for address $address'
      );
    }
  }

  Future<List<SuiObjectInfo>> getGasObjectsOwnedByAddress(String address) async {
    final objects = await getObjectsOwnedByAddress(address);
    final result = (objects as List)
      .where((obj) => obj['type'] == '0x2::coin::Coin<0x2::sui::SUI>')
      .map((obj) => SuiObjectInfo.fromJson(obj));
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

  // Future<List<GetObjectDataResponse>> getCoinBalancesOwnedByAddress(
  //   String address,
  //   String? typeArg
  // ) async {
  //   final objects = await this.getObjectsOwnedByAddress(address);
  //   final coinIds = objects
  //     .filter(
  //       (SuiObjectInfo obj) =>
  //         Coin.isCoin(obj) &&
  //         (typeArg == null || typeArg == Coin.getCoinTypeArg(obj))
  //     )
  //     .map((c) => c.objectId);

  //   return await this.getObjectBatch(coinIds);
  // }

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

  // async getObjectsOwnedByObject(objectId: string): Promise<SuiObjectInfo[]> {
  //   try {
  //     return await this.client.requestWithType(
  //       'sui_getObjectsOwnedByObject',
  //       [objectId],
  //       isGetOwnedObjectsResponse,
  //       this.skipDataValidation
  //     );
  //   } catch (err) {
  //     throw new Error(
  //       `Error fetching owned object: ${err} for objectId ${objectId}`
  //     );
  //   }
  // }

  Future<GetObjectDataResponse> getObject(String objectId) async {
    try {
      final data = await client.request(
        'sui_getObject',
        [objectId]
      );
      return GetObjectDataResponse.fromJson(data);
    } catch (err) {
      throw ArgumentError('Error fetching object info: $err for id $objectId');
    }
  }

  // async getObjectRef(objectId: string): Promise<SuiObjectRef | undefined> {
  //   const resp = await this.getObject(objectId);
  //   return getObjectReference(resp);
  // }

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
  Future<List<String>> getTransactions(
    String address,
    {TransactionDigest? cursor,
    int? limit,
    bool descendingOrder = true}
  ) async {
    final query = { 'ToAddress': address };
    try {
      final filterFromAddress = await client.request(
        'sui_getTransactions',
        [{ 'FromAddress': address }, cursor, limit, descendingOrder]
      );
      final filterToAddress = await client.request(
        'sui_getTransactions',
        [{ 'ToAddress': address }, cursor, limit, descendingOrder]
      );
      
      final txIds = <String>{};
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

  // Future<GetTxnDigestsResponse> getTransactionsForObject(
  //   String objectID: string,
  //   Ordering ordering = 'Descending'
  // ) async {
  //   final requests = [
  //     {
  //       method: 'sui_getTransactions',
  //       args: [{ InputObject: objectID }, null, null, ordering],
  //     },
  //     {
  //       method: 'sui_getTransactions',
  //       args: [{ MutatedObject: objectID }, null, null, ordering],
  //     },
  //   ];

  //   try {
  //     final results = await client.batchRequestWithType(
  //       requests,
  //       isPaginatedTransactionDigests,
  //       this.skipDataValidation
  //     );
  //     return [...results[0].data, ...results[1].data];
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error getting transactions for object: ${err} for id ${objectID}'
  //     );
  //   }
  // }

  // Future<GetTxnDigestsResponse> getTransactionsForAddress(
  //   String addressID,
  //   Ordering ordering = 'Descending'
  // ) async {
  //   final requests = [
  //     {
  //       method: 'sui_getTransactions',
  //       args: [{ ToAddress: addressID }, null, null, ordering],
  //     },
  //     {
  //       method: 'sui_getTransactions',
  //       args: [{ FromAddress: addressID }, null, null, ordering],
  //     },
  //   ];
  //   try {
  //     final results = await client.batchRequestWithType(
  //       requests,
  //       isPaginatedTransactionDigests,
  //       this.skipDataValidation
  //     );
  //     return [...results[0].data, ...results[1].data];
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error getting transactions for address: ${err} for id ${addressID}'
  //     );
  //   }
  // }

  Future<SuiTransactionResponse> getTransactionWithEffects(
    TransactionDigest digest
  ) async {
    try {
      final data = await client.request(
        'sui_getTransaction',
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
      'method': 'sui_getTransaction',
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

  Future<SuiExecuteTransactionResponse> executeTransactionWithRequestType(
    String txnBytes,
    SignatureScheme signatureScheme,
    String signature,
    String pubkey,
   [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForEffectsCert]
  ) async {
    final resp = await client.request(
      'sui_executeTransaction',
      [txnBytes, signatureScheme.name, signature, pubkey, requestType.name],
      skipDataValidation
    );
    return resp;
  }

  // Future<int> getTotalTransactionNumber() async {
  //   try {
  //     final resp = await client.requestWithType(
  //       'sui_getTotalTransactionNumber',
  //       [],
  //       skipDataValidation
  //     );
  //     return resp;
  //   } catch (err) {
  //     throw ArgumentError('Error fetching total transaction number: ${err}');
  //   }
  // }

  // Future<GetTxnDigestsResponse> getTransactionDigestsInRange(
  //   int start,
  //   int end
  // ) async {
  //   try {
  //     return await client.requestWithType(
  //       'sui_getTransactionsInRange',
  //       [start, end],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error fetching transaction digests in range: ${err} for range ${start}-${end}'
  //     );
  //   }
  // }

  // // Events

  // Future<SuiEvents> getEventsByTransaction(
  //   TransactionDigest digest,
  //   int count
  // ) async {
  //   try {
  //     return await client.requestWithType(
  //       'sui_getEventsByTransaction',
  //       [digest, count],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error getting events by transaction: ${digest}, with error: ${err}'
  //     );
  //   }
  // }

  // Future<SuiEvents> getEventsByModule(
  //   String package_,
  //   String module,
  //   int count,
  //   int startTime,
  //   int endTime
  // ) async {
  //   try {
  //     return await client.requestWithType(
  //       'sui_getEventsByModule',
  //       [package_, module, count, startTime, endTime],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw  ArgumentError(
  //       'Error getting events by transaction module: ${package_}::${module}, with error: ${err}'
  //     );
  //   }
  // }

  // Future<SuiEvents> getEventsByMoveEventStructName(
  //   String moveEventStructName,
  //   int count,
  //   int startTime,
  //   int endTime
  // ) async {
  //   try {
  //     return await client.requestWithType(
  //       'sui_getEventsByMoveEventStructName',
  //       [moveEventStructName, count, startTime, endTime],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error getting events by move event struct name: ${moveEventStructName}, with error: ${err}'
  //     );
  //   }
  // }

  // Future<SuiEvents> getEventsBySender(
  //   SuiAddress sender,
  //   int count,
  //   int startTime,
  //   int endTime
  // ) async {
  //   try {
  //     return await this.client.requestWithType(
  //       'sui_getEventsBySender',
  //       [sender, count, startTime, endTime],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error getting events by sender: ${sender}, with error: ${err}'
  //     );
  //   }
  // }

  // Future<SuiEvents> getEventsByRecipient(
  //   ObjectOwner recipient,
  //   int count,
  //   int startTime,
  //   int endTime
  // ) async {
  //   try {
  //     return await client.requestWithType(
  //       'sui_getEventsByRecipient',
  //       [recipient, count, startTime, endTime],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error getting events by receipient: ${recipient}, with error: ${err}'
  //     );
  //   }
  // }

  // Future<SuiEvents> getEventsByObject(
  //   ObjectId object,
  //   int count,
  //   int startTime,
  //   int endTime
  // ) async {
  //   try {
  //     return await this.client.requestWithType(
  //       'sui_getEventsByObject',
  //       [object, count, startTime, endTime],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error getting events by object: ${object}, with error: ${err}'
  //     );
  //   }
  // }

  // Future<SuiEvents> getEventsByTimeRange(
  //   int count,
  //   int startTime,
  //   int endTime
  // ) async {
  //   try {
  //     return await client.requestWithType(
  //       'sui_getEventsByTimeRange',
  //       [count, startTime, endTime],
  //       skipDataValidation
  //     );
  //   } catch (err) {
  //     throw ArgumentError(
  //       'Error getting events by time range: ${startTime} thru ${endTime}, with error: ${err}'
  //     );
  //   }
  // }

  @override
  Future<SuiObjectRef?> getObjectRef(String objectId) {
    // TODO: implement getObjectRef
    throw UnimplementedError();
  }

  @override
  Future<List<GetObjectDataResponse>> selectCoinSetWithCombinedBalanceGreaterThanOrEqual(String address, BigInt amount, String typeArg, List<ObjectId> exclude) {
    // TODO: implement selectCoinSetWithCombinedBalanceGreaterThanOrEqual
    throw UnimplementedError();
  }

  @override
  Future<SubscriptionId> subscribeEvent(filter, Function(SuiEventEnvelope event) onMessage) {
    // TODO: implement subscribeEvent
    throw UnimplementedError();
  }

  @override
  Future<bool> unsubscribeEvent(SubscriptionId id) {
    // TODO: implement unsubscribeEvent
    throw UnimplementedError();
  }

  @override
  Future<List<GetObjectDataResponse>> getCoinBalancesOwnedByAddress(String address, String? typeArg) {
    // TODO: implement getCoinBalancesOwnedByAddress
    throw UnimplementedError();
  }

  @override
  CoinDenominationInfoResponse getCoinDenominationInfo(String coinType) {
    // TODO: implement getCoinDenominationInfo
    throw UnimplementedError();
  }

  @override
  Future<SuiEvents> getEventsByModule(ObjectId packageId, String module, int count, int startTime, int endTime) {
    // TODO: implement getEventsByModule
    throw UnimplementedError();
  }

  @override
  Future<SuiEvents> getEventsByMoveEventStructName(String moveEventStructName, int count, int startTime, int endTime) {
    // TODO: implement getEventsByMoveEventStructName
    throw UnimplementedError();
  }

  @override
  Future<SuiEvents> getEventsByObject(ObjectId object, int count, int startTime, int endTime) {
    // TODO: implement getEventsByObject
    throw UnimplementedError();
  }

  @override
  Future<SuiEvents> getEventsByRecipient(recipient, int count, int startTime, int endTime) {
    // TODO: implement getEventsByRecipient
    throw UnimplementedError();
  }

  @override
  Future<SuiEvents> getEventsBySender(SuiAddress sender, int count, int startTime, int endTime) {
    // TODO: implement getEventsBySender
    throw UnimplementedError();
  }

  @override
  Future<SuiEvents> getEventsByTimeRange(int count, int startTime, int endTime) {
    // TODO: implement getEventsByTimeRange
    throw UnimplementedError();
  }

  @override
  Future<SuiEvents> getEventsByTransaction(TransactionDigest digest, int count) {
    // TODO: implement getEventsByTransaction
    throw UnimplementedError();
  }

  @override
  Future<SuiMoveFunctionArgTypes> getMoveFunctionArgTypes(String objectId, String moduleName, String functionName) {
    // TODO: implement getMoveFunctionArgTypes
    throw UnimplementedError();
  }

  @override
  Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(String objectId, String moduleName, String functionName) {
    // TODO: implement getNormalizedMoveFunction
    throw UnimplementedError();
  }

  @override
  Future<SuiMoveNormalizedModule> getNormalizedMoveModule(String objectId, String moduleName) {
    // TODO: implement getNormalizedMoveModule
    throw UnimplementedError();
  }

  @override
  Future getNormalizedMoveModulesByPackage(String objectId) {
    // TODO: implement getNormalizedMoveModulesByPackage
    throw UnimplementedError();
  }

  @override
  Future<SuiMoveNormalizedStruct> getNormalizedMoveStruct(String objectId, String moduleName, String structName) {
    // TODO: implement getNormalizedMoveStruct
    throw UnimplementedError();
  }

  @override
  Future<int> getTotalTransactionNumber() {
    // TODO: implement getTotalTransactionNumber
    throw UnimplementedError();
  }

  @override
  Future<List<TransactionDigest>> getTransactionDigestsInRange(int start, int end) {
    // TODO: implement getTransactionDigestsInRange
    throw UnimplementedError();
  }

  @override
  List<GetObjectDataResponse> selectCoinsWithBalanceGreaterThanOrEqual(String address, BigInt amount, String typeArg, List<ObjectId> exclude) {
    // TODO: implement selectCoinsWithBalanceGreaterThanOrEqual
    throw UnimplementedError();
  }

  // async subscribeEvent(
  //   filter: SuiEventFilter,
  //   onMessage: (event: SuiEventEnvelope) => void
  // ): Promise<SubscriptionId> {
  //   return this.wsClient.subscribeEvent(filter, onMessage);
  // }

  // async unsubscribeEvent(id: SubscriptionId): Promise<boolean> {
  //   return this.wsClient.unsubscribeEvent(id);
  // }
}
