import 'dart:typed_data';

import '../builder/transaction.dart';
import '../grpc/proto/sui/rpc/v2/executed_transaction.pb.dart';
import '../grpc/proto/sui/rpc/v2/object.pb.dart' as pb;
import '../grpc/proto/sui/rpc/v2/state_service.pb.dart';
import '../grpc/proto/sui/rpc/v2/transaction_execution_service.pb.dart';
import '../grpc/sui_grpc_client.dart';
import '../sui_account.dart';

/// Source-compatibility bridge: exposes the legacy `JsonRpcProvider` /
/// `SuiClient` method NAMES on top of the new gRPC client so existing call
/// sites need minimal changes.
///
/// Return types are the new `sui.rpc.v2` protobuf messages (not the old
/// freezed models); this smooths method-name churn but is not a byte-for-byte
/// drop-in. Prefer the native [SuiGrpcClient] / `core` API for new code.
extension LegacyNames on SuiGrpcClient {
  /// Legacy alias of [signAndExecuteTransaction].
  Future<ExecutedTransaction> signAndExecuteTransactionBlock(
    SuiAccount signer,
    Transaction transaction, {
    BigInt? gasBudget,
  }) =>
      signAndExecuteTransaction(signer, transaction, gasBudget: gasBudget);

  /// Legacy alias of [getTransaction].
  Future<ExecutedTransaction> getTransactionBlock(String digest,
          {List<String>? readMask}) =>
      getTransaction(digest, readMask: readMask);

  /// Legacy alias of [listOwnedObjects].
  Future<ListOwnedObjectsResponse> getOwnedObjects(
    String address, {
    int? limit,
    Uint8List? cursor,
    String? objectType,
  }) =>
      listOwnedObjects(address,
          pageSize: limit, pageToken: cursor, objectType: objectType);

  /// Legacy alias of [getCoinInfo]-derived total supply.
  Future<GetCoinInfoResponse> getCoinMetadata(String coinType) =>
      getCoinInfo(coinType);

  /// Legacy alias of [getObjects] / [getObject].
  Future<pb.Object> multiGetObjectsSingle(String objectId,
          {List<String>? readMask}) =>
      getObject(objectId, readMask: readMask);

  /// Legacy alias of [simulateTransaction] (old `dryRunTransactionBlock`).
  Future<SimulateTransactionResponse> dryRunTransactionBlock(
          Uint8List transactionBcs) =>
      simulateTransaction(transactionBcs);

  /// Legacy alias: old `getReferenceGasPrice` returned a BigInt.
  Future<BigInt> getReferenceGasPriceBigInt() async =>
      BigInt.from((await getReferenceGasPrice()).toInt());
}
