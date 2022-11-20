
import 'dart:typed_data';

import 'package:sui/cryptography/ed25519_keypair.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/publickey.dart';
import 'package:sui/cryptography/secp256k1_keypair.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/types/common.dart';

class SuiClient extends SignerWithProvider {
  late final SuiAccount _account;

  SuiClient(
    SuiAccount account,
    String endpoint
  ): super(endpoint) {
    _account = account;
  }

  @override
  SuiAddress getAddress() {
    return _account.getAddress();
  }

  @override
  SignaturePubkeyPair signData(Base64DataBuffer data) {
    return _account.signData(data);
  }

}