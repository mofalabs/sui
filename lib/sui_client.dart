
import 'dart:typed_data';

import 'package:sui/builder/transaction.dart';
import 'package:sui/models/dev_inspect_results.dart';
import 'package:sui/rpc/client.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/transactions.dart';

class SuiClient extends SignerWithProvider {
  late SuiAccount? _account;

  SuiClient(
    String endpoint, {
    SuiAccount? account,
    RequestOptions? options
  }): super(
    endpoint: endpoint,
    options: options
  ) {
    _account = account;
  }

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

  Future<SuiTransactionBlockResponse> signAndExecuteTransactionBlock(
    SuiAccount signer,
    Transaction transaction,
    {
      BuildOptions? options,
      SuiTransactionBlockResponseOptions? responseOptions,
      @Deprecated('requestType will be ignored by JSON RPC in the future')
      ExecuteTransaction requestType = ExecuteTransaction.WaitForEffectsCert
    }
  ) async {
    options ??= BuildOptions(client: this);
    options.client ??= this;
    transaction.setSenderIfNotSet(signer.getAddress());
    final transactionBytes = await transaction.build(options);
    final signWithBytes = signer.keyPair.signTransactionBlock(transactionBytes);
    return await executeTransactionBlock(
      signWithBytes.bytes, 
      [signWithBytes.signature],
      options: responseOptions,
      requestType: requestType
    );
  }

  Future<DevInspectResults> devInspectTransactionBlock(
    String sender,
    Transaction transaction, {
      BigInt? gasPrice,
      String? epoch
    }
  ) async {
    transaction.setSenderIfNotSet(sender);
    final txBytes = await transaction.build(
      BuildOptions(client: this, onlyTransactionKind: true)
    );
    final result = await devInspectTransaction(
      sender,
      txBytes,
      gasPrice: gasPrice,
      epoch: epoch
    );
    return result;
  }


}