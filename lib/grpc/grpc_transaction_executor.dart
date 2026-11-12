import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import '../cryptography/keypair.dart';
import '../cryptography/intent.dart';

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
    CancelToken? cancelToken,
  }) async {
    if (cancelToken?.isCancelled ?? false) throw cancelToken!.cancelError!;
    // The adapter lets the builder resolve object references and moveCall
    // signatures over gRPC; offline limits avoid a protocol-config fetch.
    final buildOptions = BuildOptions(
      client: GrpcBuilderAdapter(this, cancelToken: cancelToken),
      limits: <String, dynamic>{},
    );

    tx.setSenderIfNotSet(sender);
    if (gasBudget != null) {
      tx.setGasBudget(gasBudget);
    }

    // Gas is resolved inside build() (see Transaction._prepare).
    final bytes = await tx.build(buildOptions);
    if (cancelToken?.isCancelled ?? false) throw cancelToken!.cancelError!;
    return bytes;
  }

  /// Prepare, sign and execute [tx] in one call.
  Future<ExecutedTransaction> signAndExecuteTransaction(
    SuiAccount signer,
    Transaction tx, {
    BigInt? gasBudget,
    CancelToken? cancelToken,
    List<String>? readMask,
  }) => signAndExecuteWithSigner(
    signer.keyPair,
    tx,
    gasBudget: gasBudget,
    readMask: readMask,
    cancelToken: cancelToken,
  );

  /// Supports local keypairs, passkeys and zkLogin proof signers.
  Future<ExecutedTransaction> signAndExecuteWithSigner(
    Signer signer,
    Transaction tx, {
    BigInt? gasBudget,
    List<String>? readMask,
    CancelToken? cancelToken,
  }) async {
    final bytes = await prepareTransaction(
      tx,
      sender: signer.getPublicKey().toSuiAddress(),
      gasBudget: gasBudget,
      cancelToken: cancelToken,
    );
    if (cancelToken?.isCancelled ?? false) throw cancelToken!.cancelError!;
    final signed = await signer.signWithIntent(
      bytes,
      IntentScope.transactionData,
    );
    if (cancelToken?.isCancelled ?? false) throw cancelToken!.cancelError!;
    return executeTransaction(
      bytes,
      [Uint8List.fromList(base64Decode(signed.signature))],
      readMask: readMask,
      cancelToken: cancelToken,
    );
  }
}
