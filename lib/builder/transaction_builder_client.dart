import '../types/coins.dart';
import '../types/normalized.dart';
import '../types/objects.dart';
import '../types/transactions.dart';

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
}
