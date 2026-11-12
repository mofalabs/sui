import 'dart:async';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:dio/dio.dart';

import '../cryptography/intent.dart';

import '../grpc/proto/sui/rpc/v2/checkpoint.pb.dart';
import '../grpc/proto/sui/rpc/v2/epoch.pb.dart';
import '../grpc/proto/sui/rpc/v2/executed_transaction.pb.dart';
import '../grpc/proto/sui/rpc/v2/ledger_service.pb.dart';
import '../grpc/proto/sui/rpc/v2/move_package.pb.dart';
import '../grpc/proto/sui/rpc/v2/name_service.pb.dart';
import '../grpc/proto/sui/rpc/v2/object.pb.dart';
import '../grpc/proto/sui/rpc/v2/state_service.pb.dart';
import '../grpc/proto/sui/rpc/v2/system_state.pb.dart';
import '../grpc/proto/sui/rpc/v2/transaction_execution_service.pb.dart';
import '../utils/dynamic_fields.dart';
import 'network.dart';
import 'sui_models.dart';
import 'errors.dart';
import 'ledger_query.dart';
import '../grpc/proto/sui/rpc/v2/event.pb.dart' as event_pb;
import '../grpc/proto/sui/rpc/v2/subscription_service.pb.dart';
import '../grpc/proto/sui/rpc/v2/protocol_config.pb.dart';

/// Transport-agnostic core API, mirroring the official TypeScript SDK's
/// `CoreClient` (`client/core.ts`).
///
/// Concrete transports (gRPC-web now, GraphQL later) implement the abstract
/// primitives; shared derived methods live here so they are written once.
///
/// NOTE (migration decision): for now these methods return the `sui.rpc.v2`
/// protobuf message types directly. A later `compat/` layer will map them to
/// the SDK's legacy model classes to soften breaking changes. Normalizing into
/// transport-neutral Dart models is deferred to keep momentum.
abstract class CoreClient {
  CoreClient({required this.network});

  final SuiNetwork network;

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
  });

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
  });

  Stream<SubscribeTransactionsResponse> subscribeTransactions({
    GrpcTransactionFilter? filter,
    List<String>? readMask,
    CancelToken? cancelToken,
  });

  Stream<SubscribeEventsResponse> subscribeEvents({
    GrpcEventFilter? filter,
    List<String>? readMask,
    CancelToken? cancelToken,
  });

  // --- Abstract primitives (one per transport) ---

  Future<GetServiceInfoResponse> getServiceInfo({CancelToken? cancelToken});

  Future<ProtocolConfig> getProtocolConfig({CancelToken? cancelToken}) async =>
      (await getEpoch(
        readMask: const ['protocol_config'],
        cancelToken: cancelToken,
      )).protocolConfig;

  Future<String?> defaultNameServiceName(
    String address, {
    CancelToken? cancelToken,
  }) async {
    final record = await reverseLookupName(address, cancelToken: cancelToken);
    return record.name.isEmpty ? null : record.name;
  }

  Future<List<GetObjectResult>> getObjects(
    List<String> objectIds, {
    List<String>? readMask,
    CancelToken? cancelToken,
  });

  Future<Balance> getBalance(
    String owner, {
    String coinType,
    CancelToken? cancelToken,
  });

  Future<ListBalancesResponse> listBalances(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
    CancelToken? cancelToken,
  });

  Future<GetCoinInfoResponse> getCoinInfo(
    String coinType, {
    CancelToken? cancelToken,
  });

  Future<ListOwnedObjectsResponse> listOwnedObjects(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
    String? objectType,
    List<String>? readMask,
    CancelToken? cancelToken,
  });

  Future<ExecutedTransaction> getTransaction(
    String digest, {
    List<String>? readMask,
    CancelToken? cancelToken,
  });

  Future<Epoch> getEpoch({
    int? epoch,
    List<String>? readMask,
    CancelToken? cancelToken,
  });

  Future<ListDynamicFieldsResponse> listDynamicFields(
    String parentId, {
    int? pageSize,
    Uint8List? pageToken,
    List<String>? readMask,
    CancelToken? cancelToken,
  });

  Future<ExecutedTransaction> executeTransaction(
    Uint8List transactionBcs,
    List<Uint8List> signatures, {
    List<String>? readMask,
    CancelToken? cancelToken,
  });

  Future<SimulateTransactionResponse> simulateTransaction(
    Uint8List transactionBcs, {
    List<String>? readMask,
    bool doGasSelection,
    bool checksEnabled,
    CancelToken? cancelToken,
  });

  Future<Package> getPackage(
    String packageId, {
    BigInt? version,
    BigInt? atCheckpoint,
    CancelToken? cancelToken,
  });

  Future<FunctionDescriptor> getFunction(
    String packageId,
    String moduleName,
    String functionName, {
    CancelToken? cancelToken,
  });

  Future<Checkpoint> getCheckpoint({
    int? sequenceNumber,
    String? digest,
    List<String>? readMask,
    CancelToken? cancelToken,
  });

  /// List `Coin<coinType>` objects owned by [owner] (with per-coin balance).
  Future<SuiCoinPage> listCoins(
    String owner, {
    String coinType,
    Uint8List? cursor,
    int? limit,
    CancelToken? cancelToken,
  });

  /// Snapshot of the on-chain system state (`0x3::sui_system::SystemState`).
  Future<SystemState> getCurrentSystemState({CancelToken? cancelToken});

  /// Verify a user signature (Ed25519 / secp / multisig / zkLogin) over
  /// [message] under the given [intentScope]. [signature] is the serialized
  /// signature bytes.
  Future<SignatureVerification> verifySignature(
    Uint8List message,
    Uint8List signature, {
    required IntentScope intentScope,
    String? address,
    CancelToken? cancelToken,
  });

  /// Resolve a SuiNS name (`@name` or `name.sui`) to its record.
  Future<NameRecord> lookupName(String name, {CancelToken? cancelToken});

  /// Reverse-resolve an address to its default SuiNS record.
  Future<NameRecord> reverseLookupName(
    String address, {
    CancelToken? cancelToken,
  });

  // --- Optional Move Registry (MVR) resolution hooks ---
  // Default to pass-through; gRPC overrides these to call the MVR service so
  // `@org/app` package names and `@org/app::mod::T` types can be used directly.

  /// Resolve MVR names inside a type string (pass-through by default).
  Future<String> resolveType(String type, {CancelToken? cancelToken}) async =>
      type;

  /// Resolve an MVR package name to its address (pass-through by default).
  Future<String> resolvePackage(
    String package, {
    CancelToken? cancelToken,
  }) async => package;

  // --- Shared derived methods ---

  /// Resolve a SuiNS name to its target address (null if unset).
  Future<String?> resolveNameServiceAddress(
    String name, {
    CancelToken? cancelToken,
  }) async {
    final record = await lookupName(name, cancelToken: cancelToken);
    return record.hasTargetAddress() ? record.targetAddress : null;
  }

  /// Fetch a single object; throws if the node returns an error for it.
  Future<Object> getObject(
    String objectId, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final results = await getObjects(
      [objectId],
      readMask: readMask,
      cancelToken: cancelToken,
    );
    final result = results.single;
    if (result.hasError()) {
      throw SuiObjectException(
        result.error.message,
        objectId: objectId,
        reason: result.error.code == 5
            ? ObjectErrorReason.notFound
            : ObjectErrorReason.unknown,
        code: result.error.code,
        cause: result.error,
      );
    }
    return result.object;
  }

  /// Chain identifier = digest of the genesis checkpoint.
  Future<String> getChainIdentifier({CancelToken? cancelToken}) async =>
      (await getServiceInfo(cancelToken: cancelToken)).chainId;

  /// Current reference gas price (from the current epoch).
  Future<Int64> getReferenceGasPrice({CancelToken? cancelToken}) async =>
      (await getEpoch(
        readMask: ['reference_gas_price'],
        cancelToken: cancelToken,
      )).referenceGasPrice;

  /// Poll [getTransaction] until [digest] is available or [timeout] elapses.
  Future<ExecutedTransaction> waitForTransaction(
    String digest, {
    Duration timeout = const Duration(seconds: 60),
    Duration pollInterval = const Duration(milliseconds: 500),
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    if (timeout <= Duration.zero || pollInterval <= Duration.zero) {
      throw ArgumentError('Timeout and poll interval must be positive');
    }
    final elapsed = Stopwatch()..start();
    while (true) {
      if (cancelToken?.isCancelled ?? false) throw cancelToken!.cancelError!;
      final remaining = timeout - elapsed.elapsed;
      if (remaining <= Duration.zero) {
        throw TimeoutException(
          'waitForTransaction($digest) timed out',
          timeout,
        );
      }
      try {
        final request = getTransaction(
          digest,
          readMask: readMask,
          cancelToken: cancelToken,
        ).timeout(remaining);
        final tx = cancelToken == null
            ? await request
            : await Future.any([
                request,
                cancelToken.whenCancel.then<ExecutedTransaction>(
                  (error) => throw error,
                ),
              ]);
        if (tx.digest.isNotEmpty) return tx;
      } on SuiTransactionException {
        // Only a missing transaction is retryable; preserve transport failures.
      }
      final delay = timeout - elapsed.elapsed;
      if (delay <= Duration.zero) {
        throw TimeoutException(
          'waitForTransaction($digest) timed out',
          timeout,
        );
      }
      await Future.any<void>([
        Future<void>.delayed(delay < pollInterval ? delay : pollInterval),
        if (cancelToken != null)
          cancelToken.whenCancel.then<void>((error) => throw error),
      ]);
    }
  }

  /// Fetch the dynamic field object on [parentId] identified by field name type
  /// [nameType] and BCS-encoded name value [nameBcs].
  Future<Object> getDynamicFieldObject(
    String parentId,
    String nameType,
    Uint8List nameBcs, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final resolvedType = await resolveType(nameType, cancelToken: cancelToken);
    final fieldId = deriveDynamicFieldID(parentId, resolvedType, nameBcs);
    return getObject(fieldId, readMask: readMask, cancelToken: cancelToken);
  }

  /// Fetch the child object of a dynamic OBJECT field on [parentId].
  Future<Object> getDynamicObjectField(
    String parentId,
    String nameType,
    Uint8List nameBcs, {
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final resolvedType = await resolveType(nameType, cancelToken: cancelToken);
    final wrapperType = '0x2::dynamic_object_field::Wrapper<$resolvedType>';
    final wrapperId = deriveDynamicFieldID(parentId, wrapperType, nameBcs);
    final field = await getObject(
      wrapperId,
      readMask: const [
        'object_id',
        'version',
        'digest',
        'object_type',
        'contents',
      ],
      cancelToken: cancelToken,
    );
    // Field<Wrapper<Name>, ID> content = [parent(32)][name bcs][childId(32)].
    final content = Uint8List.fromList(field.contents.value);
    final start = 32 + nameBcs.length;
    final childBytes = content.sublist(start, start + 32);
    final childId = '0x${_hex(childBytes)}';
    return getObject(childId, readMask: readMask, cancelToken: cancelToken);
  }

  static String _hex(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
