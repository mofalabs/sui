import '../grpc/proto/sui/rpc/v2/executed_transaction.pb.dart';
import '../grpc/proto/sui/rpc/v2/transaction_execution_service.pb.dart';
import '../utils/proto_int.dart';
import '../grpc/proto/sui/rpc/v2/object.pb.dart' as pb;
import '../grpc/proto/sui/rpc/v2/owner.pb.dart';
import '../grpc/proto/sui/rpc/v2/state_service.pb.dart';

/// Transport-neutral Dart models for the most common results, so callers don't
/// depend on `sui.rpc.v2` protobuf types directly. These map from the gRPC
/// messages today; a GraphQL transport can populate the same shapes later.

enum SuiOwnerKind { address, object, shared, immutable, unknown }

class SuiOwner {
  SuiOwner({required this.kind, this.address, this.initialSharedVersion});

  final SuiOwnerKind kind;
  final String? address;
  final int? initialSharedVersion;

  factory SuiOwner.fromProto(Owner o) => switch (o.kind) {
    Owner_OwnerKind.ADDRESS || Owner_OwnerKind.CONSENSUS_ADDRESS => SuiOwner(
      kind: SuiOwnerKind.address,
      address: o.address,
    ),
    Owner_OwnerKind.OBJECT => SuiOwner(
      kind: SuiOwnerKind.object,
      address: o.address,
    ),
    Owner_OwnerKind.SHARED => SuiOwner(
      kind: SuiOwnerKind.shared,
      initialSharedVersion: o.version.toInt(),
    ),
    Owner_OwnerKind.IMMUTABLE => SuiOwner(kind: SuiOwnerKind.immutable),
    _ => SuiOwner(kind: SuiOwnerKind.unknown),
  };
}

class SuiBalance {
  SuiBalance({
    required this.coinType,
    required this.totalBalance,
    required this.addressBalance,
    required this.coinBalance,
  });

  final String coinType;
  final BigInt totalBalance;
  final BigInt addressBalance;
  final BigInt coinBalance;

  factory SuiBalance.fromProto(Balance b) => SuiBalance(
    coinType: b.coinType,
    totalBalance: uint64ToBigInt(b.balance),
    addressBalance: uint64ToBigInt(b.addressBalance),
    coinBalance: uint64ToBigInt(b.coinBalance),
  );
}

class SuiObjectInfo {
  SuiObjectInfo({
    required this.objectId,
    required this.version,
    required this.digest,
    required this.type,
    required this.owner,
  });

  final String objectId;
  final BigInt version;
  final String digest;
  final String? type;
  final SuiOwner? owner;

  factory SuiObjectInfo.fromProto(pb.Object o) => SuiObjectInfo(
    objectId: o.objectId,
    version: uint64ToBigInt(o.version),
    digest: o.digest,
    type: o.hasObjectType() ? o.objectType : null,
    owner: o.hasOwner() ? SuiOwner.fromProto(o.owner) : null,
  );
}

class SignatureVerification {
  SignatureVerification({required this.isValid, required this.reason});

  final bool isValid;
  final String? reason;
}

class SuiCoin {
  SuiCoin({
    required this.coinType,
    required this.coinObjectId,
    required this.version,
    required this.digest,
    required this.balance,
  });

  final String coinType;
  final String coinObjectId;
  final BigInt version;
  final String digest;
  final BigInt balance;
}

class SuiCoinPage {
  SuiCoinPage({
    required this.coins,
    required this.hasNextPage,
    required this.cursor,
  });

  final List<SuiCoin> coins;
  final bool hasNextPage;

  /// Base64 page token to pass as `cursor` for the next page.
  final String? cursor;
}

class SuiGasCost {
  SuiGasCost({
    required this.computationCost,
    required this.storageCost,
    required this.storageRebate,
  });

  final BigInt computationCost;
  final BigInt storageCost;
  final BigInt storageRebate;

  /// Net gas charged = computation + storage - rebate.
  BigInt get net => computationCost + storageCost - storageRebate;
}

class SuiExecutionResult {
  SuiExecutionResult({
    required this.digest,
    required this.success,
    required this.error,
    required this.gas,
    this.checkpoint,
    this.timestamp,
    this.gasObjectId,
  });

  final String digest;
  final bool success;
  final String? error;
  final SuiGasCost gas;
  final BigInt? checkpoint;
  final DateTime? timestamp;

  /// Null for transactions that paid gas from address balance or used no gas.
  final String? gasObjectId;

  factory SuiExecutionResult.fromProto(ExecutedTransaction tx) {
    final status = tx.effects.status;
    final g = tx.effects.gasUsed;
    return SuiExecutionResult(
      digest: tx.digest,
      checkpoint: tx.hasCheckpoint() ? uint64ToBigInt(tx.checkpoint) : null,
      timestamp: tx.hasTimestamp()
          ? DateTime.fromMillisecondsSinceEpoch(
              tx.timestamp.seconds.toInt() * 1000 +
                  tx.timestamp.nanos ~/ 1000000,
              isUtc: true,
            )
          : null,
      gasObjectId: tx.effects.hasGasObject()
          ? tx.effects.gasObject.objectId
          : null,
      success: status.success,
      error: status.hasError() ? status.error.description : null,
      gas: SuiGasCost(
        computationCost: uint64ToBigInt(g.computationCost),
        storageCost: uint64ToBigInt(g.storageCost),
        storageRebate: uint64ToBigInt(g.storageRebate),
      ),
    );
  }
}

/// Sentinel used when a node simulates with a synthetic gas coin.
const mockedGasObjectId =
    '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';

extension SuiSimulationMetadata on SimulateTransactionResponse {
  bool get gasPaymentMocked =>
      transaction.effects.hasGasObject() &&
      transaction.effects.gasObject.objectId.toLowerCase() == mockedGasObjectId;
}
