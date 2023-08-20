
import 'dart:typed_data';

import 'package:sui/builder/transaction_block.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/types/common.dart';

class SuiClient extends SignerWithProvider {
  late final SuiAccount? _account;

  SuiClient(
    String endpoint,
    {SuiAccount? account}
  ): super(endpoint) {
    _account = account;
  }
  
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

  signAndExecuteTransactionBlock(
    Keypair signer,
    TransactionBlock transactionBlock,
    {
      Map<String, dynamic>? options
    }
  ) async {
    final transactionBytes = await transactionBlock.build(options);
    final signWithBytes = signer.signTransactionBlock(transactionBytes);
    final resp = await this.provider.executeTransactionBlock(signWithBytes.bytes, [signWithBytes.signature]);
    print(resp);
  }


}