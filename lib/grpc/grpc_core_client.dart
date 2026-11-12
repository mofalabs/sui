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
import '../client/ledger_query.dart';
import '../client/errors.dart';
import '../utils/proto_int.dart';
import 'proto/sui/rpc/v2/event.pb.dart' as event_pb;
import 'proto/sui/rpc/v2/query_options.pb.dart';
import 'proto/sui/rpc/v2/protocol_config.pb.dart';
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
  GrpcCoreClient({
    required super.network,
    Dio? dio,
    String? endpoint,
    Map<String, String> headers = const {},
    GrpcWebTransport? transport,
  }) : _t =
           transport ??
           GrpcWebTransport(
             endpoint ?? grpcWebEndpoint(network),
             dio: dio,
             headers: headers,
           ),
       _mvr = MvrClient.forNetwork(network, dio: dio);

  final GrpcWebTransport _t;
  final MvrClient? _mvr;

  @override
  Future<String> resolveType(String type, {CancelToken? cancelToken}) async {
    final mvr = _mvr;
    return mvr == null
        ? type
        : await mvr.resolveType(type, cancelToken: cancelToken);
  }

  @override
  Future<String> resolvePackage(
    String package, {
    CancelToken? cancelToken,
  }) async {
    final mvr = _mvr;
    return mvr == null
        ? package
        : await mvr.resolvePackage(package, cancelToken: cancelToken);
  }

  static const _ledger = 'sui.rpc.v2.LedgerService';
  static const _state = 'sui.rpc.v2.StateService';
  static const _exec = 'sui.rpc.v2.TransactionExecutionService';
  static const _movePackage = 'sui.rpc.v2.MovePackageService';
  static const _name = 'sui.rpc.v2.NameService';
  static const _subscription = 'sui.rpc.v2.SubscriptionService';
  static const _sigVerify = 'sui.rpc.v2.SignatureVerificationService';

  Future<Uint8List> _call(
    String service,
    String method,
    List<int> request, {
    CancelToken? cancelToken,
  }) => _t.unary(
    service,
    method,
    Uint8List.fromList(request),
    cancelToken: cancelToken,
  );

  FieldMask? _mask(List<String>? paths) =>
      paths == null ? null : FieldMask(paths: paths);

  @override
  Future<GetServiceInfoResponse> getServiceInfo({
    CancelToken? cancelToken,
  }) async {
    final bytes = await _call(
      _ledger,
      'GetServiceInfo',
      GetServiceInfoRequest().writeToBuffer(),
      cancelToken: cancelToken,
    );
    return GetServiceInfoResponse.fromBuffer(bytes);
  }

  @override
  Future<ProtocolConfig> getProtocolConfig({CancelToken? cancelToken}) async =>
      (await getEpoch(
        readMask: const ['protocol_config'],
        cancelToken: cancelToken,
      )).protocolConfig;

  @override
  Future<String?> defaultNameServiceName(
    String address, {
    CancelToken? cancelToken,
  }) async {
    try {
      final record = await reverseLookupName(address, cancelToken: cancelToken);
      return record.name.isEmpty ? null : record.name;
    } on GrpcWebException catch (error) {
      if (error.status == GrpcStatus.notFound) return null;
      rethrow;
    }
  }

  @override
  Future<String?> resolveNameServiceAddress(
    String name, {
    CancelToken? cancelToken,
  }) async {
    try {
      return await super.resolveNameServiceAddress(
        name,
        cancelToken: cancelToken,
      );
    } on GrpcWebException catch (error) {
      if (error.status == GrpcStatus.notFound) return null;
      rethrow;
    }
  }

  /// Query filtered transactions directly from the full node's retained ledger.
  @override
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
  }) async {
    _validateLimit(limit);
    final request = ListTransactionsRequest(
      filter: filter,
      options: _queryOptions(limit + 1, after, before, descending),
      startCheckpoint: startCheckpoint == null
          ? null
          : bigIntToUint64(startCheckpoint),
      endCheckpoint: endCheckpoint == null
          ? null
          : bigIntToUint64(endCheckpoint),
      readMask: _mask(
        readMask ??
            const [
              'digest',
              'effects',
              'checkpoint',
              'timestamp',
              'balance_changes',
            ],
      ),
    );
    final items = <ExecutedTransaction>[];
    Watermark? watermark;
    Watermark? lastItem;
    var lookahead = false;
    QueryEndReason? reason;
    await for (final bytes in _t.serverStream(
      _ledger,
      'ListTransactions',
      request.writeToBuffer(),
      cancelToken: cancelToken,
    )) {
      final frame = ListTransactionsResponse.fromBuffer(bytes);
      if (frame.hasWatermark()) watermark = frame.watermark;
      if (frame.hasTransaction()) {
        if (items.length < limit) {
          items.add(frame.transaction);
          lastItem = watermark;
        } else {
          lookahead = true;
        }
      }
      if (frame.hasEnd()) reason = frame.end.reason;
    }
    return _ledgerPage(
      items,
      lookahead ? lastItem : watermark,
      reason,
      lookahead: lookahead,
    );
  }

  @override
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
  }) async {
    _validateLimit(limit);
    final request = ListEventsRequest(
      filter: filter,
      options: _queryOptions(limit + 1, after, before, descending),
      startCheckpoint: startCheckpoint == null
          ? null
          : bigIntToUint64(startCheckpoint),
      endCheckpoint: endCheckpoint == null
          ? null
          : bigIntToUint64(endCheckpoint),
      readMask: _mask(readMask),
    );
    final items = <event_pb.Event>[];
    Watermark? watermark;
    Watermark? lastItem;
    var lookahead = false;
    QueryEndReason? reason;
    await for (final bytes in _t.serverStream(
      _ledger,
      'ListEvents',
      request.writeToBuffer(),
      cancelToken: cancelToken,
    )) {
      final frame = ListEventsResponse.fromBuffer(bytes);
      if (frame.hasWatermark()) watermark = frame.watermark;
      if (frame.hasEvent()) {
        if (items.length < limit) {
          items.add(frame.event);
          lastItem = watermark;
        } else {
          lookahead = true;
        }
      }
      if (frame.hasEnd()) reason = frame.end.reason;
    }
    return _ledgerPage(
      items,
      lookahead ? lastItem : watermark,
      reason,
      lookahead: lookahead,
    );
  }

  void _validateLimit(int limit) {
    if (limit <= 0 || limit >= 0xffffffff) {
      throw ArgumentError.value(limit, 'limit');
    }
  }

  QueryOptions _queryOptions(
    int limit,
    String? after,
    String? before,
    bool descending,
  ) {
    if (limit <= 0) {
      throw ArgumentError.value(limit, 'limit', 'Must be positive');
    }
    return QueryOptions(
      limit: limit,
      after: after == null ? null : base64Decode(after),
      before: before == null ? null : base64Decode(before),
      ordering: descending
          ? Ordering.ORDERING_DESCENDING
          : Ordering.ORDERING_ASCENDING,
    );
  }

  LedgerPage<T> _ledgerPage<T>(
    List<T> items,
    Watermark? watermark,
    QueryEndReason? reason, {
    required bool lookahead,
  }) {
    if (reason == null ||
        reason == QueryEndReason.QUERY_END_REASON_UNKNOWN ||
        watermark == null) {
      throw const FormatException(
        'Ledger scan ended without a terminal watermark',
      );
    }
    return LedgerPage(
      items: items,
      cursor: watermark.cursor.isEmpty ? null : base64Encode(watermark.cursor),
      checkpoint: watermark.hasCheckpoint()
          ? uint64ToBigInt(watermark.checkpoint)
          : null,
      hasNextPage:
          lookahead ||
          reason == QueryEndReason.QUERY_END_REASON_ITEM_LIMIT ||
          reason == QueryEndReason.QUERY_END_REASON_SCAN_LIMIT,
      endReason: reason,
    );
  }

  @override
  Stream<SubscribeTransactionsResponse> subscribeTransactions({
    GrpcTransactionFilter? filter,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => _t
      .serverStream(
        _subscription,
        'SubscribeTransactions',
        SubscribeTransactionsRequest(
          filter: filter,
          readMask: _mask(readMask),
        ).writeToBuffer(),
        cancelToken: cancelToken,
      )
      .map(SubscribeTransactionsResponse.fromBuffer);

  @override
  Stream<SubscribeEventsResponse> subscribeEvents({
    GrpcEventFilter? filter,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) => _t
      .serverStream(
        _subscription,
        'SubscribeEvents',
        SubscribeEventsRequest(
          filter: filter,
          readMask: _mask(readMask),
        ).writeToBuffer(),
        cancelToken: cancelToken,
      )
      .map(SubscribeEventsResponse.fromBuffer);

  @override
  Future<List<GetObjectResult>> getObjects(
    List<String> objectIds, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final req = BatchGetObjectsRequest(
      requests: objectIds.map((id) => GetObjectRequest(objectId: id)),
      readMask: _mask(
        readMask ??
            const [
              'object_id',
              'version',
              'digest',
              'owner',
              'object_type',
              'contents',
            ],
      ),
    );
    final bytes = await _call(
      _ledger,
      'BatchGetObjects',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return BatchGetObjectsResponse.fromBuffer(bytes).objects;
  }

  @override
  Future<Balance> getBalance(
    String owner, {
    String coinType = '0x2::sui::SUI',
    CancelToken? cancelToken,
  }) async {
    final req = GetBalanceRequest(
      owner: owner,
      coinType: await resolveType(coinType, cancelToken: cancelToken),
    );
    final bytes = await _call(
      _state,
      'GetBalance',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return GetBalanceResponse.fromBuffer(bytes).balance;
  }

  @override
  Future<ListBalancesResponse> listBalances(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
    CancelToken? cancelToken,
  }) async {
    final req = ListBalancesRequest(
      owner: owner,
      pageSize: pageSize,
      pageToken: pageToken,
    );
    final bytes = await _call(
      _state,
      'ListBalances',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return ListBalancesResponse.fromBuffer(bytes);
  }

  @override
  Future<GetCoinInfoResponse> getCoinInfo(
    String coinType, {
    CancelToken? cancelToken,
  }) async {
    final req = GetCoinInfoRequest(
      coinType: await resolveType(coinType, cancelToken: cancelToken),
    );
    final bytes = await _call(
      _state,
      'GetCoinInfo',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return GetCoinInfoResponse.fromBuffer(bytes);
  }

  @override
  Future<ListOwnedObjectsResponse> listOwnedObjects(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
    String? objectType,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final req = ListOwnedObjectsRequest(
      owner: owner,
      pageSize: pageSize,
      pageToken: pageToken,
      objectType: objectType == null
          ? null
          : await resolveType(objectType, cancelToken: cancelToken),
      readMask: _mask(readMask),
    );
    final bytes = await _call(
      _state,
      'ListOwnedObjects',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return ListOwnedObjectsResponse.fromBuffer(bytes);
  }

  @override
  Future<ExecutedTransaction> getTransaction(
    String digest, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final req = GetTransactionRequest(
      digest: digest,
      readMask: _mask(
        readMask ??
            const [
              'digest',
              'transaction',
              'effects',
              'events',
              'balance_changes',
              'checkpoint',
              'timestamp',
            ],
      ),
    );
    try {
      final bytes = await _call(
        _ledger,
        'GetTransaction',
        req.writeToBuffer(),
        cancelToken: cancelToken,
      );
      return GetTransactionResponse.fromBuffer(bytes).transaction;
    } on GrpcWebException catch (error) {
      if (error.status == GrpcStatus.notFound) {
        throw SuiTransactionException(digest, cause: error);
      }
      rethrow;
    }
  }

  @override
  Future<Epoch> getEpoch({
    int? epoch,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final req = GetEpochRequest(
      epoch: epoch == null ? null : Int64(epoch),
      readMask: _mask(readMask),
    );
    final bytes = await _call(
      _ledger,
      'GetEpoch',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return GetEpochResponse.fromBuffer(bytes).epoch;
  }

  @override
  Future<ListDynamicFieldsResponse> listDynamicFields(
    String parentId, {
    int? pageSize,
    Uint8List? pageToken,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final req = ListDynamicFieldsRequest(
      parent: parentId,
      pageSize: pageSize,
      pageToken: pageToken,
      readMask: _mask(
        readMask ??
            const ['kind', 'field_id', 'name', 'value_type', 'child_id'],
      ),
    );
    final bytes = await _call(
      _state,
      'ListDynamicFields',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return ListDynamicFieldsResponse.fromBuffer(bytes);
  }

  @override
  Future<ExecutedTransaction> executeTransaction(
    Uint8List transactionBcs,
    List<Uint8List> signatures, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final req = ExecuteTransactionRequest(
      transaction: Transaction(
        bcs: Bcs(name: 'TransactionData', value: transactionBcs),
      ),
      signatures: signatures.map(
        (s) => UserSignature(
          bcs: Bcs(name: 'UserSignature', value: s),
        ),
      ),
      readMask: _mask(
        readMask ?? const ['digest', 'effects', 'events', 'balance_changes'],
      ),
    );
    final bytes = await _call(
      _exec,
      'ExecuteTransaction',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return ExecuteTransactionResponse.fromBuffer(bytes).transaction;
  }

  @override
  Future<SimulateTransactionResponse> simulateTransaction(
    Uint8List transactionBcs, {
    List<String>? readMask,
    bool doGasSelection = true,
    bool checksEnabled = true,
    CancelToken? cancelToken,
  }) async {
    final req = SimulateTransactionRequest(
      transaction: Transaction(
        bcs: Bcs(name: 'TransactionData', value: transactionBcs),
      ),
      readMask: _mask(readMask),
      checks: checksEnabled
          ? SimulateTransactionRequest_TransactionChecks.ENABLED
          : SimulateTransactionRequest_TransactionChecks.DISABLED,
      doGasSelection: doGasSelection,
    );
    final bytes = await _call(
      _exec,
      'SimulateTransaction',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return SimulateTransactionResponse.fromBuffer(bytes);
  }

  /// Simulate a structured [Transaction] (as opposed to opaque BCS), so the
  /// gas payment/budget can be left unset for server-side gas selection.
  Future<SimulateTransactionResponse> simulateStructured(
    Transaction structuredTx, {
    List<String>? readMask,
    bool doGasSelection = true,
    bool checksEnabled = true,
    CancelToken? cancelToken,
  }) async {
    final req = SimulateTransactionRequest(
      transaction: structuredTx,
      readMask: _mask(readMask),
      checks: checksEnabled
          ? SimulateTransactionRequest_TransactionChecks.ENABLED
          : SimulateTransactionRequest_TransactionChecks.DISABLED,
      doGasSelection: doGasSelection,
    );
    final bytes = await _call(
      _exec,
      'SimulateTransaction',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return SimulateTransactionResponse.fromBuffer(bytes);
  }

  @override
  Future<Package> getPackage(
    String packageId, {
    BigInt? version,
    BigInt? atCheckpoint,
    CancelToken? cancelToken,
  }) async {
    if (version != null && atCheckpoint != null) {
      throw ArgumentError('Specify version or atCheckpoint');
    }
    final req = GetPackageRequest(
      packageId: await resolvePackage(packageId, cancelToken: cancelToken),
      version: version == null ? null : bigIntToUint64(version),
      atCheckpoint: atCheckpoint == null ? null : bigIntToUint64(atCheckpoint),
    );
    final bytes = await _call(
      _movePackage,
      'GetPackage',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return GetPackageResponse.fromBuffer(bytes).package;
  }

  @override
  Future<FunctionDescriptor> getFunction(
    String packageId,
    String moduleName,
    String functionName, {
    CancelToken? cancelToken,
  }) async {
    final req = GetFunctionRequest(
      packageId: await resolvePackage(packageId, cancelToken: cancelToken),
      moduleName: moduleName,
      name: functionName,
    );
    final bytes = await _call(
      _movePackage,
      'GetFunction',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return GetFunctionResponse.fromBuffer(bytes).function;
  }

  @override
  Future<Checkpoint> getCheckpoint({
    int? sequenceNumber,
    String? digest,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final req = GetCheckpointRequest(readMask: _mask(readMask));
    if (sequenceNumber != null) {
      req.sequenceNumber = Int64(sequenceNumber);
    } else if (digest != null) {
      req.digest = digest;
    }
    final bytes = await _call(
      _ledger,
      'GetCheckpoint',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return GetCheckpointResponse.fromBuffer(bytes).checkpoint;
  }

  @override
  Future<SuiCoinPage> listCoins(
    String owner, {
    String coinType = '0x2::sui::SUI',
    Uint8List? cursor,
    int? limit,
    CancelToken? cancelToken,
  }) async {
    final resolvedType = await resolveType(coinType, cancelToken: cancelToken);
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
    final bytes = await _call(
      _state,
      'ListOwnedObjects',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    final resp = ListOwnedObjectsResponse.fromBuffer(bytes);
    return SuiCoinPage(
      coins: resp.objects
          .map(
            (o) => SuiCoin(
              coinType: resolvedType,
              coinObjectId: o.objectId,
              version: uint64ToBigInt(o.version),
              digest: o.digest,
              balance: uint64ToBigInt(o.balance),
            ),
          )
          .toList(),
      hasNextPage: resp.nextPageToken.isNotEmpty,
      cursor: resp.nextPageToken.isNotEmpty
          ? base64Encode(resp.nextPageToken)
          : null,
    );
  }

  @override
  Future<SystemState> getCurrentSystemState({CancelToken? cancelToken}) async {
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
    final bytes = await _call(
      _ledger,
      'GetEpoch',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return GetEpochResponse.fromBuffer(bytes).epoch.systemState;
  }

  @override
  Future<SignatureVerification> verifySignature(
    Uint8List message,
    Uint8List signature, {
    required IntentScope intentScope,
    String? address,
    CancelToken? cancelToken,
  }) async {
    // PersonalMessage is verified over BCS vector<u8>; TransactionData is raw.
    final value = intentScope == IntentScope.personalMessage
        ? Uint8List.fromList(
            SuiBcs.VECTOR(SuiBcs.U8).serialize(message).toBytes(),
          )
        : message;
    final req = VerifySignatureRequest(
      message: Bcs(name: _intentName(intentScope), value: value),
      signature: UserSignature(
        bcs: Bcs(name: 'UserSignature', value: signature),
      ),
      address: address,
    );
    final bytes = await _call(
      _sigVerify,
      'VerifySignature',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
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
  Future<NameRecord> lookupName(String name, {CancelToken? cancelToken}) async {
    final req = LookupNameRequest(name: name);
    final bytes = await _call(
      _name,
      'LookupName',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return LookupNameResponse.fromBuffer(bytes).record;
  }

  @override
  Future<NameRecord> reverseLookupName(
    String address, {
    CancelToken? cancelToken,
  }) async {
    final req = ReverseLookupNameRequest(address: address);
    final bytes = await _call(
      _name,
      'ReverseLookupName',
      req.writeToBuffer(),
      cancelToken: cancelToken,
    );
    return ReverseLookupNameResponse.fromBuffer(bytes).record;
  }

  /// Subscribe to the stream of executed checkpoints (server-streaming).
  /// Replaces the deprecated JSON-RPC WebSocket subscriptions.
  Stream<SubscribeCheckpointsResponse> subscribeCheckpoints({
    List<String>? readMask,
    CancelToken? cancelToken,
  }) {
    final req = SubscribeCheckpointsRequest(
      readMask: _mask(readMask ?? const ['sequence_number', 'digest']),
    );
    return _t
        .serverStream(
          _subscription,
          'SubscribeCheckpoints',
          Uint8List.fromList(req.writeToBuffer()),
          cancelToken: cancelToken,
        )
        .map(SubscribeCheckpointsResponse.fromBuffer);
  }
}
