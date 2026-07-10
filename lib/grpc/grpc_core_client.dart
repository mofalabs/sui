import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fixnum/fixnum.dart';

import '../bcs/sui_bcs.dart';
import '../client/core_client.dart';
import '../client/mvr_client.dart';
import '../cryptography/intent.dart';
import '../client/network.dart';
import '../client/sui_models.dart';
import 'proto/google/protobuf/field_mask.pb.dart';
import 'proto/sui/rpc/v2/bcs.pb.dart';
import 'proto/sui/rpc/v2/checkpoint.pb.dart';
import 'proto/sui/rpc/v2/epoch.pb.dart';
import 'proto/sui/rpc/v2/executed_transaction.pb.dart';
import 'proto/sui/rpc/v2/ledger_service.pb.dart';
import 'proto/sui/rpc/v2/move_package.pb.dart';
import 'proto/sui/rpc/v2/move_package_service.pb.dart';
import 'proto/sui/rpc/v2/name_service.pb.dart';
import 'proto/sui/rpc/v2/signature.pb.dart';
import 'proto/sui/rpc/v2/signature_verification_service.pb.dart';
import 'proto/sui/rpc/v2/state_service.pb.dart';
import 'proto/sui/rpc/v2/subscription_service.pb.dart';
import 'proto/sui/rpc/v2/system_state.pb.dart';
import 'proto/sui/rpc/v2/transaction.pb.dart';
import 'proto/sui/rpc/v2/transaction_execution_service.pb.dart';
import 'transport/grpc_web_transport.dart';

/// gRPC-web implementation of [CoreClient] over `sui.rpc.v2`.
class GrpcCoreClient extends CoreClient {
  /// [endpoint] overrides the gRPC-web base URL (e.g. a self-hosted or
  /// third-party full node); when null the public endpoint for [network] is
  /// used. [network] still selects the MVR endpoint regardless.
  GrpcCoreClient({required super.network, Dio? dio, String? endpoint})
      : _t = GrpcWebTransport(endpoint ?? grpcWebEndpoint(network), dio: dio),
        _mvr = MvrClient.forNetwork(network, dio: dio);

  final GrpcWebTransport _t;
  final MvrClient? _mvr;

  @override
  Future<String> resolveType(String type) async {
    final mvr = _mvr;
    return mvr == null ? type : await mvr.resolveType(type);
  }

  @override
  Future<String> resolvePackage(String package) async {
    final mvr = _mvr;
    return mvr == null ? package : await mvr.resolvePackage(package);
  }

  static const _ledger = 'sui.rpc.v2.LedgerService';
  static const _state = 'sui.rpc.v2.StateService';
  static const _exec = 'sui.rpc.v2.TransactionExecutionService';
  static const _movePackage = 'sui.rpc.v2.MovePackageService';
  static const _name = 'sui.rpc.v2.NameService';
  static const _subscription = 'sui.rpc.v2.SubscriptionService';
  static const _sigVerify = 'sui.rpc.v2.SignatureVerificationService';

  Future<Uint8List> _call(String service, String method, List<int> request) =>
      _t.unary(service, method, Uint8List.fromList(request));

  FieldMask? _mask(List<String>? paths) =>
      paths == null ? null : FieldMask(paths: paths);

  @override
  Future<GetServiceInfoResponse> getServiceInfo() async {
    final bytes = await _call(
        _ledger, 'GetServiceInfo', GetServiceInfoRequest().writeToBuffer());
    return GetServiceInfoResponse.fromBuffer(bytes);
  }

  @override
  Future<List<GetObjectResult>> getObjects(
    List<String> objectIds, {
    List<String>? readMask,
  }) async {
    final req = BatchGetObjectsRequest(
      requests: objectIds.map((id) => GetObjectRequest(objectId: id)),
      readMask: _mask(readMask ??
          const [
            'object_id',
            'version',
            'digest',
            'owner',
            'object_type',
            'contents'
          ]),
    );
    final bytes = await _call(_ledger, 'BatchGetObjects', req.writeToBuffer());
    return BatchGetObjectsResponse.fromBuffer(bytes).objects;
  }

  @override
  Future<Balance> getBalance(String owner,
      {String coinType = '0x2::sui::SUI'}) async {
    final req = GetBalanceRequest(owner: owner, coinType: coinType);
    final bytes = await _call(_state, 'GetBalance', req.writeToBuffer());
    return GetBalanceResponse.fromBuffer(bytes).balance;
  }

  @override
  Future<ListBalancesResponse> listBalances(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
  }) async {
    final req = ListBalancesRequest(
      owner: owner,
      pageSize: pageSize,
      pageToken: pageToken,
    );
    final bytes = await _call(_state, 'ListBalances', req.writeToBuffer());
    return ListBalancesResponse.fromBuffer(bytes);
  }

  @override
  Future<GetCoinInfoResponse> getCoinInfo(String coinType) async {
    final req = GetCoinInfoRequest(coinType: coinType);
    final bytes = await _call(_state, 'GetCoinInfo', req.writeToBuffer());
    return GetCoinInfoResponse.fromBuffer(bytes);
  }

  @override
  Future<ListOwnedObjectsResponse> listOwnedObjects(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
    String? objectType,
    List<String>? readMask,
  }) async {
    final req = ListOwnedObjectsRequest(
      owner: owner,
      pageSize: pageSize,
      pageToken: pageToken,
      objectType: objectType,
      readMask: _mask(readMask),
    );
    final bytes = await _call(_state, 'ListOwnedObjects', req.writeToBuffer());
    return ListOwnedObjectsResponse.fromBuffer(bytes);
  }

  @override
  Future<ExecutedTransaction> getTransaction(
    String digest, {
    List<String>? readMask,
  }) async {
    final req = GetTransactionRequest(
      digest: digest,
      readMask: _mask(readMask ??
          const [
            'digest',
            'transaction',
            'effects',
            'events',
            'balance_changes'
          ]),
    );
    final bytes = await _call(_ledger, 'GetTransaction', req.writeToBuffer());
    return GetTransactionResponse.fromBuffer(bytes).transaction;
  }

  @override
  Future<Epoch> getEpoch({int? epoch, List<String>? readMask}) async {
    final req = GetEpochRequest(
      epoch: epoch == null ? null : Int64(epoch),
      readMask: _mask(readMask),
    );
    final bytes = await _call(_ledger, 'GetEpoch', req.writeToBuffer());
    return GetEpochResponse.fromBuffer(bytes).epoch;
  }

  @override
  Future<ListDynamicFieldsResponse> listDynamicFields(
    String parentId, {
    int? pageSize,
    Uint8List? pageToken,
    List<String>? readMask,
  }) async {
    final req = ListDynamicFieldsRequest(
      parent: parentId,
      pageSize: pageSize,
      pageToken: pageToken,
      readMask: _mask(readMask ??
          const ['kind', 'field_id', 'name', 'value_type', 'child_id']),
    );
    final bytes = await _call(_state, 'ListDynamicFields', req.writeToBuffer());
    return ListDynamicFieldsResponse.fromBuffer(bytes);
  }

  @override
  Future<ExecutedTransaction> executeTransaction(
    Uint8List transactionBcs,
    List<Uint8List> signatures, {
    List<String>? readMask,
  }) async {
    final req = ExecuteTransactionRequest(
      transaction:
          Transaction(bcs: Bcs(name: 'TransactionData', value: transactionBcs)),
      signatures: signatures
          .map((s) => UserSignature(bcs: Bcs(name: 'UserSignature', value: s))),
      readMask: _mask(
          readMask ?? const ['digest', 'effects', 'events', 'balance_changes']),
    );
    final bytes = await _call(_exec, 'ExecuteTransaction', req.writeToBuffer());
    return ExecuteTransactionResponse.fromBuffer(bytes).transaction;
  }

  @override
  Future<SimulateTransactionResponse> simulateTransaction(
    Uint8List transactionBcs, {
    List<String>? readMask,
    bool doGasSelection = true,
    bool checksEnabled = true,
  }) async {
    final req = SimulateTransactionRequest(
      transaction:
          Transaction(bcs: Bcs(name: 'TransactionData', value: transactionBcs)),
      readMask: _mask(readMask),
      checks: checksEnabled
          ? SimulateTransactionRequest_TransactionChecks.ENABLED
          : SimulateTransactionRequest_TransactionChecks.DISABLED,
      doGasSelection: doGasSelection,
    );
    final bytes =
        await _call(_exec, 'SimulateTransaction', req.writeToBuffer());
    return SimulateTransactionResponse.fromBuffer(bytes);
  }

  @override
  Future<Package> getPackage(String packageId) async {
    final req = GetPackageRequest(packageId: packageId);
    final bytes = await _call(_movePackage, 'GetPackage', req.writeToBuffer());
    return GetPackageResponse.fromBuffer(bytes).package;
  }

  @override
  Future<FunctionDescriptor> getFunction(
    String packageId,
    String moduleName,
    String functionName,
  ) async {
    final req = GetFunctionRequest(
      packageId: packageId,
      moduleName: moduleName,
      name: functionName,
    );
    final bytes = await _call(_movePackage, 'GetFunction', req.writeToBuffer());
    return GetFunctionResponse.fromBuffer(bytes).function;
  }

  @override
  Future<Checkpoint> getCheckpoint({
    int? sequenceNumber,
    String? digest,
    List<String>? readMask,
  }) async {
    final req = GetCheckpointRequest(readMask: _mask(readMask));
    if (sequenceNumber != null) {
      req.sequenceNumber = Int64(sequenceNumber);
    } else if (digest != null) {
      req.digest = digest;
    }
    final bytes = await _call(_ledger, 'GetCheckpoint', req.writeToBuffer());
    return GetCheckpointResponse.fromBuffer(bytes).checkpoint;
  }

  @override
  Future<SuiCoinPage> listCoins(
    String owner, {
    String coinType = '0x2::sui::SUI',
    Uint8List? cursor,
    int? limit,
  }) async {
    final resolvedType = await resolveType(coinType);
    final req = ListOwnedObjectsRequest(
      owner: owner,
      objectType: '0x2::coin::Coin<$resolvedType>',
      pageSize: limit,
      pageToken: cursor,
      readMask: _mask(const [
        'object_id',
        'version',
        'digest',
        'object_type',
        'balance',
      ]),
    );
    final bytes = await _call(_state, 'ListOwnedObjects', req.writeToBuffer());
    final resp = ListOwnedObjectsResponse.fromBuffer(bytes);
    return SuiCoinPage(
      coins: resp.objects
          .map((o) => SuiCoin(
                coinType: resolvedType,
                coinObjectId: o.objectId,
                version: BigInt.from(o.version.toInt()),
                digest: o.digest,
                balance: BigInt.from(o.balance.toInt()),
              ))
          .toList(),
      hasNextPage: resp.nextPageToken.isNotEmpty,
      cursor: resp.nextPageToken.isNotEmpty
          ? base64Encode(resp.nextPageToken)
          : null,
    );
  }

  @override
  Future<SystemState> getCurrentSystemState() async {
    final req = GetEpochRequest(
      readMask: _mask(const [
        'system_state.version',
        'system_state.epoch',
        'system_state.protocol_version',
        'system_state.reference_gas_price',
        'system_state.epoch_start_timestamp_ms',
        'system_state.safe_mode',
        'system_state.parameters',
        'system_state.storage_fund',
        'system_state.validators',
      ]),
    );
    final bytes = await _call(_ledger, 'GetEpoch', req.writeToBuffer());
    return GetEpochResponse.fromBuffer(bytes).epoch.systemState;
  }

  @override
  Future<SignatureVerification> verifySignature(
    Uint8List message,
    Uint8List signature, {
    required IntentScope intentScope,
    String? address,
  }) async {
    // PersonalMessage is verified over BCS vector<u8>; TransactionData is raw.
    final value = intentScope == IntentScope.personalMessage
        ? Uint8List.fromList(
            SuiBcs.VECTOR(SuiBcs.U8).serialize(message).toBytes())
        : message;
    final req = VerifySignatureRequest(
      message: Bcs(name: _intentName(intentScope), value: value),
      signature:
          UserSignature(bcs: Bcs(name: 'UserSignature', value: signature)),
      address: address,
    );
    final bytes =
        await _call(_sigVerify, 'VerifySignature', req.writeToBuffer());
    final resp = VerifySignatureResponse.fromBuffer(bytes);
    return SignatureVerification(
      isValid: resp.isValid,
      reason: resp.hasReason() ? resp.reason : null,
    );
  }

  /// Proto `Bcs.name` label expected for each intent scope.
  static String _intentName(IntentScope scope) => switch (scope) {
        IntentScope.transactionData => 'TransactionData',
        IntentScope.transactionEffects => 'TransactionEffects',
        IntentScope.checkpointSummary => 'CheckpointSummary',
        IntentScope.personalMessage => 'PersonalMessage',
      };

  @override
  Future<NameRecord> lookupName(String name) async {
    final req = LookupNameRequest(name: name);
    final bytes = await _call(_name, 'LookupName', req.writeToBuffer());
    return LookupNameResponse.fromBuffer(bytes).record;
  }

  @override
  Future<NameRecord> reverseLookupName(String address) async {
    final req = ReverseLookupNameRequest(address: address);
    final bytes = await _call(_name, 'ReverseLookupName', req.writeToBuffer());
    return ReverseLookupNameResponse.fromBuffer(bytes).record;
  }

  /// Subscribe to the stream of executed checkpoints (server-streaming).
  /// Replaces the deprecated JSON-RPC WebSocket subscriptions.
  Stream<SubscribeCheckpointsResponse> subscribeCheckpoints({
    List<String>? readMask,
  }) {
    final req = SubscribeCheckpointsRequest(
      readMask: _mask(readMask ?? const ['sequence_number', 'digest']),
    );
    return _t
        .serverStream(_subscription, 'SubscribeCheckpoints',
            Uint8List.fromList(req.writeToBuffer()))
        .map(SubscribeCheckpointsResponse.fromBuffer);
  }
}
