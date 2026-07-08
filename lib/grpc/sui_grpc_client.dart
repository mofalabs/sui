import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fixnum/fixnum.dart';

import '../builder/transaction.dart';
import '../client/core_client.dart';
import '../client/mvr_client.dart';
import '../client/network.dart';
import '../client/sui_models.dart';
import '../cryptography/intent.dart';
import '../sui_account.dart';
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
  SuiGrpcClient({required this.network, Dio? dio})
      : core = GrpcCoreClient(network: network, dio: dio),
        mvr = MvrClient.forNetwork(network, dio: dio);

  final SuiNetwork network;

  /// Transport-agnostic core API. Prefer this for portable code.
  final CoreClient core;

  /// Move Registry resolver (`@org/app` → package id / type tag). Null on
  /// networks without a public MVR endpoint (devnet/localnet).
  final MvrClient? mvr;

  GrpcCoreClient get _grpc => core as GrpcCoreClient;

  /// Prepare (gas price/payment/budget), sign and execute [tx] in one call.
  Future<ExecutedTransaction> signAndExecuteTransaction(
    SuiAccount signer,
    Transaction tx, {
    BigInt? gasBudget,
    List<String>? readMask,
  }) =>
      _grpc.signAndExecuteTransaction(signer, tx,
          gasBudget: gasBudget, readMask: readMask);

  /// Prepare [tx] and return built TransactionData BCS bytes (ready to sign).
  Future<Uint8List> prepareTransaction(
    Transaction tx, {
    required String sender,
    BigInt? gasBudget,
  }) =>
      _grpc.prepareTransaction(tx, sender: sender, gasBudget: gasBudget);

  Future<pb.Object> getObject(String objectId, {List<String>? readMask}) =>
      core.getObject(objectId, readMask: readMask);

  Future<List<GetObjectResult>> getObjects(List<String> objectIds,
          {List<String>? readMask}) =>
      core.getObjects(objectIds, readMask: readMask);

  Future<Balance> getBalance(String owner,
          {String coinType = '0x2::sui::SUI'}) =>
      core.getBalance(owner, coinType: coinType);

  Future<ListBalancesResponse> listBalances(String owner,
          {int? pageSize, Uint8List? pageToken}) =>
      core.listBalances(owner, pageSize: pageSize, pageToken: pageToken);

  Future<GetCoinInfoResponse> getCoinInfo(String coinType) =>
      core.getCoinInfo(coinType);

  Future<ListOwnedObjectsResponse> listOwnedObjects(String owner,
          {int? pageSize,
          Uint8List? pageToken,
          String? objectType,
          List<String>? readMask}) =>
      core.listOwnedObjects(owner,
          pageSize: pageSize,
          pageToken: pageToken,
          objectType: objectType,
          readMask: readMask);

  Future<ExecutedTransaction> getTransaction(String digest,
          {List<String>? readMask}) =>
      core.getTransaction(digest, readMask: readMask);

  Future<Epoch> getEpoch({int? epoch, List<String>? readMask}) =>
      core.getEpoch(epoch: epoch, readMask: readMask);

  Future<ListDynamicFieldsResponse> listDynamicFields(String parentId,
          {int? pageSize, Uint8List? pageToken}) =>
      core.listDynamicFields(parentId,
          pageSize: pageSize, pageToken: pageToken);

  Future<ExecutedTransaction> executeTransaction(
          Uint8List transactionBcs, List<Uint8List> signatures,
          {List<String>? readMask}) =>
      core.executeTransaction(transactionBcs, signatures, readMask: readMask);

  Future<SimulateTransactionResponse> simulateTransaction(
          Uint8List transactionBcs,
          {List<String>? readMask,
          bool doGasSelection = true,
          bool checksEnabled = true}) =>
      core.simulateTransaction(transactionBcs,
          readMask: readMask,
          doGasSelection: doGasSelection,
          checksEnabled: checksEnabled);

  Future<String> getChainIdentifier() => core.getChainIdentifier();

  Future<Int64> getReferenceGasPrice() => core.getReferenceGasPrice();

  Future<Package> getPackage(String packageId) => core.getPackage(packageId);

  Future<FunctionDescriptor> getFunction(
          String packageId, String moduleName, String functionName) =>
      core.getFunction(packageId, moduleName, functionName);

  Future<Checkpoint> getCheckpoint(
          {int? sequenceNumber, String? digest, List<String>? readMask}) =>
      core.getCheckpoint(
          sequenceNumber: sequenceNumber, digest: digest, readMask: readMask);

  Future<NameRecord> lookupName(String name) => core.lookupName(name);

  Future<NameRecord> reverseLookupName(String address) =>
      core.reverseLookupName(address);

  Future<String?> resolveNameServiceAddress(String name) =>
      core.resolveNameServiceAddress(name);

  Future<SuiCoinPage> listCoins(String owner,
          {String coinType = '0x2::sui::SUI',
          Uint8List? cursor,
          int? limit}) =>
      core.listCoins(owner, coinType: coinType, cursor: cursor, limit: limit);

  Future<SystemState> getCurrentSystemState() => core.getCurrentSystemState();

  Future<SignatureVerification> verifySignature(
          Uint8List message, Uint8List signature,
          {required IntentScope intentScope, String? address}) =>
      core.verifySignature(message, signature,
          intentScope: intentScope, address: address);

  Future<ExecutedTransaction> waitForTransaction(String digest,
          {Duration timeout = const Duration(seconds: 60),
          Duration pollInterval = const Duration(milliseconds: 500),
          List<String>? readMask}) =>
      core.waitForTransaction(digest,
          timeout: timeout, pollInterval: pollInterval, readMask: readMask);

  Future<pb.Object> getDynamicFieldObject(
          String parentId, String nameType, Uint8List nameBcs,
          {List<String>? readMask}) =>
      core.getDynamicFieldObject(parentId, nameType, nameBcs,
          readMask: readMask);

  Future<pb.Object> getDynamicObjectField(
          String parentId, String nameType, Uint8List nameBcs,
          {List<String>? readMask}) =>
      core.getDynamicObjectField(parentId, nameType, nameBcs,
          readMask: readMask);

  /// Subscribe to executed checkpoints (server-streaming gRPC-web).
  Stream<SubscribeCheckpointsResponse> subscribeCheckpoints(
          {List<String>? readMask}) =>
      (core as GrpcCoreClient).subscribeCheckpoints(readMask: readMask);

  // --- Normalized (transport-neutral) convenience wrappers ---

  /// [getBalance] as a transport-neutral [SuiBalance].
  Future<SuiBalance> balanceOf(String owner,
          {String coinType = '0x2::sui::SUI'}) async =>
      SuiBalance.fromProto(await core.getBalance(owner, coinType: coinType));

  /// [getObject] as a transport-neutral [SuiObjectInfo].
  Future<SuiObjectInfo> objectInfo(String objectId,
          {List<String>? readMask}) async =>
      SuiObjectInfo.fromProto(
          await core.getObject(objectId, readMask: readMask));

  /// [signAndExecuteTransaction] returning a transport-neutral result.
  Future<SuiExecutionResult> signAndExecute(
    SuiAccount signer,
    Transaction tx, {
    BigInt? gasBudget,
  }) async =>
      SuiExecutionResult.fromProto(
          await signAndExecuteTransaction(signer, tx, gasBudget: gasBudget));
}
