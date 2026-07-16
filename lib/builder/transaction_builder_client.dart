import '../types/coins.dart';
import '../types/normalized.dart';
import '../types/objects.dart';
import '../types/transactions.dart';
import 'transaction_block_data.dart';

/// Result of one-shot server-side gas resolution: the gas payment the server
/// selected and the budget it computed (and echoed gas price).
class ResolvedGasData {
  ResolvedGasData({
    required this.budget,
    required this.payment,
    this.price,
  });

  final BigInt budget;
  final List<SuiObjectRef> payment;
  final BigInt? price;
}

/// Narrow interface of the data-provider capabilities the transaction
/// [Transaction] builder needs during `build()`:
///  - object reference resolution (`multiGetObjects`)
///  - Move function signature lookup (`getNormalizedMoveFunction`)
///  - gas price / gas coin selection / budget dry-run
///
/// Both the legacy JSON-RPC `SuiClient` and the new gRPC-backed adapter
/// implement this, so the builder is transport-agnostic.
abstract class TransactionBuilderClient {
  Future<List<SuiObjectResponse>> multiGetObjects(
    List<String> objectIds, {
    SuiObjectDataOptions? options,
  });

  Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(
    String package,
    String moduleName,
    String functionName,
  );

  Future<BigInt> getReferenceGasPrice();

  Future<PaginatedCoins> getCoins(
    String owner, {
    String? coinType,
    String? cursor,
    int? limit,
  });

  Future<dynamic> getProtocolConfig([String? version]);

  Future<DryRunTransactionBlockResponse> dryRunTransaction<T>(
    T tx, {
    String? signerAddress,
  });

  /// One-shot server-side gas resolution for a fully input-resolved
  /// transaction: the server selects the gas coin and computes the budget
  /// (gRPC `simulate` with `doGasSelection`). Returns null when the transport
  /// does not support it (e.g. JSON-RPC); the builder then falls back to local
  /// coin selection + a budget dry-run.
  Future<ResolvedGasData?> resolveGasData(
    TransactionBlockDataBuilder data,
  ) async =>
      null;
}
