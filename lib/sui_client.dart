import 'dart:typed_data';

import 'package:sui/builder/transaction.dart';
import 'package:sui/builder/transaction_builder_client.dart';
import 'package:sui/models/dev_inspect_results.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/transactions.dart';

/// Legacy JSON-RPC client for a Sui full node.
///
/// JSON-RPC is being decommissioned (fully off on 2026-07-31). New code should
/// use [SuiGrpcClient] (gRPC-web) and [SuiGraphQLClient] (GraphQL) instead; this
/// class is kept for backward compatibility during the migration.
///
/// Signs with the optional [account]; call [setSigner] to attach one later.
class SuiClient extends SignerWithProvider implements TransactionBuilderClient {
  late SuiAccount? _account;

  /// Creates a client for the JSON-RPC [endpoint], optionally with a signing
  /// [account]. See [SuiUrls] for the well-known network endpoints.
  SuiClient(String endpoint, {SuiAccount? account, super.options})
      : super(endpoint: endpoint) {
    _account = account;
  }

  /// The signing account, or null if none has been set.
  SuiAccount? get account => _account;

  @override
  void setSigner(SuiAccount signer) {
    _account = signer;
  }

  @override
  SuiAddress getAddress() {
    if (_account == null) {
      throw ArgumentError("Please call setSigner method first", "signer");
    }
    return _account!.getAddress();
  }

  @override
  SignaturePubkeyPair signData(Uint8List data) {
    if (_account == null) {
      throw ArgumentError("Please call setSigner method first", "signer");
    }
    return _account!.signData(data);
  }

  /// Builds, signs (with [signer]) and executes [transaction], returning the
  /// full transaction-block response. Pass [responseOptions] to control which
  /// effects/changes are returned.
  Future<SuiTransactionBlockResponse> signAndExecuteTransactionBlock(
      SuiAccount signer, Transaction transaction,
      {BuildOptions? options,
      SuiTransactionBlockResponseOptions? responseOptions,
      @Deprecated('requestType will be ignored by JSON RPC in the future')
      ExecuteTransaction requestType =
          ExecuteTransaction.WaitForEffectsCert}) async {
    options ??= BuildOptions(client: this);
    options.client ??= this;
    transaction.setSenderIfNotSet(signer.getAddress());
    final transactionBytes = await transaction.build(options);
    final signWithBytes = signer.keyPair.signTransactionBlock(transactionBytes);
    return await executeTransactionBlock(
        signWithBytes.bytes, [signWithBytes.signature],
        options: responseOptions,
        // ignore: deprecated_member_use_from_same_package
        requestType: requestType);
  }

  /// Simulates [transaction] from [sender] without submitting it, returning the
  /// execution effects and any return values. Useful for gas estimation and
  /// read-only Move calls.
  Future<DevInspectResults> devInspectTransactionBlock(
      String sender, Transaction transaction,
      {BigInt? gasPrice, String? epoch}) async {
    transaction.setSenderIfNotSet(sender);
    final txBytes = await transaction
        .build(BuildOptions(client: this, onlyTransactionKind: true));
    final result = await devInspectTransaction(sender, txBytes,
        gasPrice: gasPrice, epoch: epoch);
    return result;
  }
}
