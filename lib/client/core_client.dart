import 'dart:async';
import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';

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

  // --- Abstract primitives (one per transport) ---

  Future<GetServiceInfoResponse> getServiceInfo();

  Future<List<GetObjectResult>> getObjects(
    List<String> objectIds, {
    List<String>? readMask,
  });

  Future<Balance> getBalance(String owner, {String coinType});

  Future<ListBalancesResponse> listBalances(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
  });

  Future<GetCoinInfoResponse> getCoinInfo(String coinType);

  Future<ListOwnedObjectsResponse> listOwnedObjects(
    String owner, {
    int? pageSize,
    Uint8List? pageToken,
    String? objectType,
    List<String>? readMask,
  });

  Future<ExecutedTransaction> getTransaction(
    String digest, {
    List<String>? readMask,
  });

  Future<Epoch> getEpoch({int? epoch, List<String>? readMask});

  Future<ListDynamicFieldsResponse> listDynamicFields(
    String parentId, {
    int? pageSize,
    Uint8List? pageToken,
    List<String>? readMask,
  });

  Future<ExecutedTransaction> executeTransaction(
    Uint8List transactionBcs,
    List<Uint8List> signatures, {
    List<String>? readMask,
  });

  Future<SimulateTransactionResponse> simulateTransaction(
    Uint8List transactionBcs, {
    List<String>? readMask,
    bool doGasSelection,
    bool checksEnabled,
  });

  Future<Package> getPackage(String packageId);

  Future<FunctionDescriptor> getFunction(
    String packageId,
    String moduleName,
    String functionName,
  );

  Future<Checkpoint> getCheckpoint(
      {int? sequenceNumber, String? digest, List<String>? readMask});

  /// List `Coin<coinType>` objects owned by [owner] (with per-coin balance).
  Future<SuiCoinPage> listCoins(
    String owner, {
    String coinType,
    Uint8List? cursor,
    int? limit,
  });

  /// Snapshot of the on-chain system state (`0x3::sui_system::SystemState`).
  Future<SystemState> getCurrentSystemState();

  /// Verify a user signature (Ed25519 / secp / multisig / zkLogin) over
  /// [message] under the given [intentScope]. [signature] is the serialized
  /// signature bytes.
  Future<SignatureVerification> verifySignature(
    Uint8List message,
    Uint8List signature, {
    required IntentScope intentScope,
    String? address,
  });

  /// Resolve a SuiNS name (`@name` or `name.sui`) to its record.
  Future<NameRecord> lookupName(String name);

  /// Reverse-resolve an address to its default SuiNS record.
  Future<NameRecord> reverseLookupName(String address);

  // --- Optional Move Registry (MVR) resolution hooks ---
  // Default to pass-through; gRPC overrides these to call the MVR service so
  // `@org/app` package names and `@org/app::mod::T` types can be used directly.

  /// Resolve MVR names inside a type string (pass-through by default).
  Future<String> resolveType(String type) async => type;

  /// Resolve an MVR package name to its address (pass-through by default).
  Future<String> resolvePackage(String package) async => package;

  // --- Shared derived methods ---

  /// Resolve a SuiNS name to its target address (null if unset).
  Future<String?> resolveNameServiceAddress(String name) async {
    final record = await lookupName(name);
    return record.hasTargetAddress() ? record.targetAddress : null;
  }

  /// Fetch a single object; throws if the node returns an error for it.
  Future<Object> getObject(String objectId, {List<String>? readMask}) async {
    final results = await getObjects([objectId], readMask: readMask);
    final result = results.single;
    if (result.hasError()) {
      throw StateError('getObject($objectId) failed: ${result.error.message}');
    }
    return result.object;
  }

  /// Chain identifier = digest of the genesis checkpoint.
  Future<String> getChainIdentifier() async => (await getServiceInfo()).chainId;

  /// Current reference gas price (from the current epoch).
  Future<Int64> getReferenceGasPrice() async =>
      (await getEpoch(readMask: ['reference_gas_price'])).referenceGasPrice;

  /// Poll [getTransaction] until [digest] is available or [timeout] elapses.
  Future<ExecutedTransaction> waitForTransaction(
    String digest, {
    Duration timeout = const Duration(seconds: 60),
    Duration pollInterval = const Duration(milliseconds: 500),
    List<String>? readMask,
  }) async {
    final deadline = DateTime.now().add(timeout);
    while (true) {
      try {
        final tx = await getTransaction(digest, readMask: readMask);
        if (tx.digest.isNotEmpty) return tx;
      } catch (_) {
        // not yet available; keep polling
      }
      if (DateTime.now().isAfter(deadline)) {
        throw TimeoutException(
            'waitForTransaction($digest) timed out', timeout);
      }
      await Future.delayed(pollInterval);
    }
  }

  /// Fetch the dynamic field object on [parentId] identified by field name type
  /// [nameType] and BCS-encoded name value [nameBcs].
  Future<Object> getDynamicFieldObject(
    String parentId,
    String nameType,
    Uint8List nameBcs, {
    List<String>? readMask,
  }) async {
    final resolvedType = await resolveType(nameType);
    final fieldId = deriveDynamicFieldID(parentId, resolvedType, nameBcs);
    return getObject(fieldId, readMask: readMask);
  }

  /// Fetch the child object of a dynamic OBJECT field on [parentId].
  Future<Object> getDynamicObjectField(
    String parentId,
    String nameType,
    Uint8List nameBcs, {
    List<String>? readMask,
  }) async {
    final resolvedType = await resolveType(nameType);
    final wrapperType = '0x2::dynamic_object_field::Wrapper<$resolvedType>';
    final wrapperId = deriveDynamicFieldID(parentId, wrapperType, nameBcs);
    final field = await getObject(wrapperId, readMask: const [
      'object_id',
      'version',
      'digest',
      'object_type',
      'contents',
    ]);
    // Field<Wrapper<Name>, ID> content = [parent(32)][name bcs][childId(32)].
    final content = Uint8List.fromList(field.contents.value);
    final start = 32 + nameBcs.length;
    final childBytes = content.sublist(start, start + 32);
    final childId = '0x${_hex(childBytes)}';
    return getObject(childId, readMask: readMask);
  }

  static String _hex(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
