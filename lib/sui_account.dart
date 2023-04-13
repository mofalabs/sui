
import 'dart:typed_data';

import 'package:sui/cryptography/ed25519_keypair.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/publickey.dart';
import 'package:sui/cryptography/secp256k1_keypair.dart';
import 'package:sui/cryptography/mnemonics.dart' as mnemonic;
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/types/common.dart';
import 'package:sui/utils/hex.dart';

class SuiAccount {
  late final Keypair _keypair;

  SuiAccount(Keypair keypair) {
    _keypair = keypair;
  }

  factory SuiAccount.secp256k1Account() {
    return SuiAccount(Secp256k1Keypair());
  }

  factory SuiAccount.ed25519Account() {
    return SuiAccount(Ed25519Keypair());
  }

  factory SuiAccount.fromMnemonics(String mnemonics, SignatureScheme scheme) {
    SuiAccount account;
    switch(scheme) {
      case SignatureScheme.Secp256k1:
        account = SuiAccount(Secp256k1Keypair.fromMnemonics(mnemonics));
        break;
      case SignatureScheme.ED25519:
        account = SuiAccount(Ed25519Keypair.fromMnemonics(mnemonics));
        break;
      default:
        throw ArgumentError('Undefined SignatureScheme $scheme');
    }
    return account;
  }

  factory SuiAccount.fromPrivateKey(String privateKey, SignatureScheme scheme) {
    final privateKeyHex = Hex.trimHex(Hex.prefixHex(privateKey));
    if (privateKeyHex.length != 64 && privateKeyHex.length != 128) {
      throw ArgumentError("Invalid private key length ${privateKeyHex.length}");
    }
    SuiAccount account;
    switch (scheme) {
      case SignatureScheme.Secp256k1:
        account = SuiAccount(
            Secp256k1Keypair.fromSecretKey(Hex.decode(privateKeyHex)));
        break;
      case SignatureScheme.ED25519:
        account =
            SuiAccount(Ed25519Keypair.fromSecretKey(Hex.decode(privateKeyHex)));
        break;
      default:
        throw ArgumentError('Undefined SignatureScheme $scheme');
    }
    return account;
  }

  static String generateMnemonic({int strength = 128 }) {
    return mnemonic.generateMnemonic(strength: strength);
  }

  static bool isValidMnemonics(String mnemonics) {
    return mnemonic.isValidMnemonics(mnemonics);
  }

  Uint8List getSecretKey() {
    return _keypair.getSecretKey();
  }

  Uint8List getPublicKey() {
    return _keypair.getPublicKey().toBytes();
  }

  SuiAddress getAddress() {
    return _keypair.getPublicKey().toSuiAddress();
  }

  SignaturePubkeyPair signData(Base64DataBuffer data) {
    return SignaturePubkeyPair(
      _keypair.getKeyScheme(),
      _keypair.signData(data),
      _keypair.getPublicKey()
    );
  }

  bool verify(Base64DataBuffer data, SignaturePubkeyPair signature) {
    bool success = _keypair.verify(data, signature.signature, signature.pubKey.toBytes());
    return success;
  }

}