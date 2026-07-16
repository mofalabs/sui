import 'dart:convert';
import 'dart:typed_data';

import '../builder/transaction.dart';
import '../sui_account.dart';
import 'grpc_builder_adapter.dart';
import 'grpc_core_client.dart';
import 'proto/sui/rpc/v2/executed_transaction.pb.dart';

/// Builds, signs and executes a [Transaction] over gRPC without a legacy
/// JSON-RPC client. Gas (price, coin selection, budget) is resolved by
/// `Transaction.build` — server-side via `simulate` with `doGasSelection`.
extension GrpcTransactionExecutor on GrpcCoreClient {
  /// Prepare [tx] (sender, gas price/payment/budget) and return the built
  /// TransactionData BCS bytes, ready to sign.
  Future<Uint8List> prepareTransaction(
    Transaction tx, {
    required String sender,
    BigInt? gasBudget,
  }) async {
    // The adapter lets the builder resolve object references and moveCall
    // signatures over gRPC; offline limits avoid a protocol-config fetch.
    final buildOptions = BuildOptions(
      client: GrpcBuilderAdapter(this),
      limits: <String, dynamic>{},
    );

    // Resolve any Move Registry (`@org/app`) names in moveCall targets/types.
    await tx.resolveNames(
      resolvePackage: resolvePackage,
      resolveType: resolveType,
    );

    tx.setSenderIfNotSet(sender);
    if (gasBudget != null) {
      tx.setGasBudget(gasBudget);
    }

    // Gas is resolved inside build() (see Transaction._prepare).
    return tx.build(buildOptions);
  }

  /// Prepare, sign and execute [tx] in one call.
  Future<ExecutedTransaction> signAndExecuteTransaction(
    SuiAccount signer,
    Transaction tx, {
    BigInt? gasBudget,
    List<String>? readMask,
  }) async {
    final bytes = await prepareTransaction(
      tx,
      sender: signer.getAddress(),
      gasBudget: gasBudget,
    );
    final signed = signer.keyPair.signTransactionBlock(bytes);
    return executeTransaction(
      bytes,
      [Uint8List.fromList(base64Decode(signed.signature))],
      readMask: readMask,
    );
  }
}
