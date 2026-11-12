import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fixnum/fixnum.dart';

import '../builder/transaction.dart';
import '../client/core_client.dart';
import '../client/mvr_client.dart';
import '../client/network.dart';
import '../client/sui_models.dart';
import '../client/ledger_query.dart';
import 'proto/sui/rpc/v2/event.pb.dart' as event_pb;
import 'proto/sui/rpc/v2/protocol_config.pb.dart';
import 'transport/grpc_web_transport.dart';
import '../cryptography/intent.dart';
import '../sui_account.dart';
import '../cryptography/keypair.dart';
import 'grpc_core_client.dart';
import 'grpc_transaction_executor.dart';
import 'proto/sui/rpc/v2/checkpoint.pb.dart';
import 'proto/sui/rpc/v2/epoch.pb.dart';
import 'proto/sui/rpc/v2/move_package.pb.dart';
import 'proto/sui/rpc/v2/name_service.pb.dart';
import 'proto/sui/rpc/v2/executed_transaction.pb.dart';
import 'proto/sui/rpc/v2/ledger_service.pb.dart';
import 'proto/sui/rpc/v2/object.pb.dart' as pb;
import 'proto/sui/rpc/v2/state_service.pb.dart';
import 'proto/sui/rpc/v2/subscription_service.pb.dart';
import 'proto/sui/rpc/v2/system_state.pb.dart';
import 'proto/sui/rpc/v2/transaction_execution_service.pb.dart';

/// gRPC-web client for Sui full nodes (`sui.rpc.v2`).
///
/// Thin transport-specific facade that delegates to a [CoreClient]
/// ([GrpcCoreClient]); mirrors the official TS SDK's `SuiGrpcClient` where
/// most methods forward to `this.core`.
class SuiGrpcClient {
  /// [endpoint] overrides the gRPC-web base URL (a custom / self-hosted full
  /// node); when null the public endpoint for [network] is used. [network]
  /// still selects the MVR endpoint.
  SuiGrpcClient({
    required this.network,
    Dio? dio,
    String? endpoint,
    Map<String, String> headers = const {},
    GrpcWebTransport? transport,
  }) : core = GrpcCoreClient(
         network: network,
         dio: dio,
         endpoint: endpoint,
         headers: headers,
         transport: transport,
       ),
       mvr = MvrClient.forNetwork(network, dio: dio);

  final SuiNetwork network;

  /// Transport-agnostic core API. Prefer this for portable code.
  final CoreClient core;

  /// Move Registry resolver (`@org/app` → package id / type tag). Null on
  /// networks without a public MVR endpoint (devnet/localnet).
  final MvrClient? mvr;

  GrpcCoreClient get _grpc => core as GrpcCoreClient;

  Future<GetServiceInfoResponse> getServiceInfo({CancelToken? cancelToken}) =>
      core.getServiceInfo(cancelToken: cancelToken);

  Future<String> resolveType(String type, {CancelToken? cancelToken}) =>
      core.resolveType(type, cancelToken: cancelToken);

  Future<String> resolvePackage(String package, {CancelToken? cancelToken}) =>
      core.resolvePackage(package, cancelToken: cancelToken);

  Future<ProtocolConfig> getProtocolConfig({CancelToken? cancelToken}) =>
      core.getProtocolConfig(cancelToken: cancelToken);
  Future<String?> defaultNameServiceName(
    String address, {
    CancelToken? cancelToken,
  }) => core.defaultNameServiceName(address, cancelToken: cancelToken);

  Future<LedgerPage<ExecutedTransaction>> listTransactions({
    GrpcTransactionFilter? filter,
    int limit = 50,
    String? after,
    String? before,
    bool descending = true,
    BigInt? startCheckpoint,
    BigInt? endCheckpoint,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => _grpc.listTransactions(
    filter: filter,
    limit: limit,
    after: after,
    before: before,
    descending: descending,
    startCheckpoint: startCheckpoint,
    endCheckpoint: endCheckpoint,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Future<LedgerPage<event_pb.Event>> listEvents({
    GrpcEventFilter? filter,
    int limit = 50,
    String? after,
    String? before,
    bool descending = true,
    BigInt? startCheckpoint,
    BigInt? endCheckpoint,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => _grpc.listEvents(
    filter: filter,
    limit: limit,
    after: after,
    before: before,
    descending: descending,
    startCheckpoint: startCheckpoint,
    endCheckpoint: endCheckpoint,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Stream<SubscribeTransactionsResponse> subscribeTransactions({
    GrpcTransactionFilter? filter,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => _grpc.subscribeTransactions(
    filter: filter,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Stream<SubscribeEventsResponse> subscribeEvents({
    GrpcEventFilter? filter,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => _grpc.subscribeEvents(
    filter: filter,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  /// Prepare (gas price/payment/budget), sign and execute [tx] in one call.
  Future<ExecutedTransaction> signAndExecuteTransaction(
    SuiAccount signer,
    Transaction tx, {
    BigInt? gasBudget,
    CancelToken? cancelToken,
    List<String>? readMask,
  }) => _grpc.signAndExecuteTransaction(
    signer,
    tx,
    gasBudget: gasBudget,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Future<ExecutedTransaction> signAndExecuteWithSigner(
    Signer signer,
    Transaction tx, {
    BigInt? gasBudget,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => _grpc.signAndExecuteWithSigner(
    signer,
    tx,
    gasBudget: gasBudget,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  /// Prepare [tx] and return built TransactionData BCS bytes (ready to sign).
  Future<Uint8List> prepareTransaction(
    Transaction tx, {
    required String sender,
    BigInt? gasBudget,
    CancelToken? cancelToken,
  }) => _grpc.prepareTransaction(
    tx,
    sender: sender,
    gasBudget: gasBudget,
    cancelToken: cancelToken,
  );

  Future<pb.Object> getObject(
    String objectId, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => core.getObject(objectId, readMask: readMask, cancelToken: cancelToken);

  Future<List<GetObjectResult>> getObjects(
    List<String> objectIds, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) =>
      core.getObjects(objectIds, readMask: readMask, cancelToken: cancelToken);

  Future<Balance> getBalance(
    String owner, {
    String coinType = '0x2::sui::SUI',
    CancelToken? cancelToken,
  }) => core.getBalance(owner, coinType: coinType, cancelToken: cancelToken);

  Future<ListBalancesResponse> listBalances(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
    CancelToken? cancelToken,
  }) => core.listBalances(
    owner,
    pageSize: pageSize,
    pageToken: pageToken,
    cancelToken: cancelToken,
  );

  Future<GetCoinInfoResponse> getCoinInfo(
    String coinType, {
    CancelToken? cancelToken,
  }) => core.getCoinInfo(coinType, cancelToken: cancelToken);

  Future<ListOwnedObjectsResponse> listOwnedObjects(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
    String? objectType,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => core.listOwnedObjects(
    owner,
    pageSize: pageSize,
    pageToken: pageToken,
    objectType: objectType,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Future<ExecutedTransaction> getTransaction(
    String digest, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) =>
      core.getTransaction(digest, readMask: readMask, cancelToken: cancelToken);

  Future<Epoch> getEpoch({
    int? epoch,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) =>
      core.getEpoch(epoch: epoch, readMask: readMask, cancelToken: cancelToken);

  Future<ListDynamicFieldsResponse> listDynamicFields(
    String parentId, {
    int? pageSize,
    Uint8List? pageToken,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => core.listDynamicFields(
    parentId,
    pageSize: pageSize,
    pageToken: pageToken,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Future<ExecutedTransaction> executeTransaction(
    Uint8List transactionBcs,
    List<Uint8List> signatures, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => core.executeTransaction(
    transactionBcs,
    signatures,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Future<SimulateTransactionResponse> simulateTransaction(
    Uint8List transactionBcs, {
    List<String>? readMask,
    bool doGasSelection = true,
    bool checksEnabled = true,
    CancelToken? cancelToken,
  }) => core.simulateTransaction(
    transactionBcs,
    readMask: readMask,
    doGasSelection: doGasSelection,
    checksEnabled: checksEnabled,
    cancelToken: cancelToken,
  );

  Future<String> getChainIdentifier({CancelToken? cancelToken}) =>
      core.getChainIdentifier(cancelToken: cancelToken);

  Future<Int64> getReferenceGasPrice({CancelToken? cancelToken}) =>
      core.getReferenceGasPrice(cancelToken: cancelToken);

  Future<Package> getPackage(
    String packageId, {
    BigInt? version,
    BigInt? atCheckpoint,
    CancelToken? cancelToken,
  }) => core.getPackage(
    packageId,
    version: version,
    atCheckpoint: atCheckpoint,
    cancelToken: cancelToken,
  );

  Future<FunctionDescriptor> getFunction(
    String packageId,
    String moduleName,
    String functionName, {
    CancelToken? cancelToken,
  }) => core.getFunction(
    packageId,
    moduleName,
    functionName,
    cancelToken: cancelToken,
  );

  Future<Checkpoint> getCheckpoint({
    int? sequenceNumber,
    String? digest,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => core.getCheckpoint(
    sequenceNumber: sequenceNumber,
    digest: digest,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Future<NameRecord> lookupName(String name, {CancelToken? cancelToken}) =>
      core.lookupName(name, cancelToken: cancelToken);

  Future<NameRecord> reverseLookupName(
    String address, {
    CancelToken? cancelToken,
  }) => core.reverseLookupName(address, cancelToken: cancelToken);

  Future<String?> resolveNameServiceAddress(
    String name, {
    CancelToken? cancelToken,
  }) => core.resolveNameServiceAddress(name, cancelToken: cancelToken);

  Future<SuiCoinPage> listCoins(
    String owner, {
    String coinType = '0x2::sui::SUI',
    Uint8List? cursor,
    int? limit,
    CancelToken? cancelToken,
  }) => core.listCoins(
    owner,
    coinType: coinType,
    cursor: cursor,
    limit: limit,
    cancelToken: cancelToken,
  );

  Future<SystemState> getCurrentSystemState({CancelToken? cancelToken}) =>
      core.getCurrentSystemState(cancelToken: cancelToken);

  Future<SignatureVerification> verifySignature(
    Uint8List message,
    Uint8List signature, {
    required IntentScope intentScope,
    String? address,
    CancelToken? cancelToken,
  }) => core.verifySignature(
    message,
    signature,
    intentScope: intentScope,
    address: address,
    cancelToken: cancelToken,
  );

  Future<ExecutedTransaction> waitForTransaction(
    String digest, {
    Duration timeout = const Duration(seconds: 60),
    Duration pollInterval = const Duration(milliseconds: 500),
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => core.waitForTransaction(
    digest,
    timeout: timeout,
    pollInterval: pollInterval,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Future<pb.Object> getDynamicFieldObject(
    String parentId,
    String nameType,
    Uint8List nameBcs, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => core.getDynamicFieldObject(
    parentId,
    nameType,
    nameBcs,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  Future<pb.Object> getDynamicObjectField(
    String parentId,
    String nameType,
    Uint8List nameBcs, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => core.getDynamicObjectField(
    parentId,
    nameType,
    nameBcs,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  /// Subscribe to executed checkpoints (server-streaming gRPC-web).
  Stream<SubscribeCheckpointsResponse> subscribeCheckpoints({
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => (core as GrpcCoreClient).subscribeCheckpoints(
    readMask: readMask,
    cancelToken: cancelToken,
  );

  // --- Normalized (transport-neutral) convenience wrappers ---

  /// [getBalance] as a transport-neutral [SuiBalance].
  Future<SuiBalance> balanceOf(
    String owner, {
    String coinType = '0x2::sui::SUI',
    CancelToken? cancelToken,
  }) async => SuiBalance.fromProto(
    await core.getBalance(owner, coinType: coinType, cancelToken: cancelToken),
  );

  /// [getObject] as a transport-neutral [SuiObjectInfo].
  Future<SuiObjectInfo> objectInfo(
    String objectId, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async => SuiObjectInfo.fromProto(
    await core.getObject(
      objectId,
      readMask: readMask,
      cancelToken: cancelToken,
    ),
  );

  /// [signAndExecuteTransaction] returning a transport-neutral result.
  Future<SuiExecutionResult> signAndExecute(
    SuiAccount signer,
    Transaction tx, {
    BigInt? gasBudget,
    CancelToken? cancelToken,
  }) async => SuiExecutionResult.fromProto(
    await signAndExecuteTransaction(
      signer,
      tx,
      gasBudget: gasBudget,
      cancelToken: cancelToken,
    ),
  );
}
