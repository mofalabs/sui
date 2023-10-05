
import 'dart:typed_data';

import 'package:sui/cryptography/ed25519_keypair.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/secp256k1_keypair.dart';
import 'package:sui/cryptography/secp256r1_keypair.dart';
import 'package:sui/cryptography/mnemonics.dart' as mnemonic;
import 'package:sui/cryptography/signature.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/types/common.dart';
import 'package:sui/utils/hex.dart';

class SuiAccount {
  late final Keypair _keypair;

  Keypair get keyPair => _keypair;

  SuiAccount(Keypair keypair) {
    _keypair = keypair;
  }

  factory SuiAccount.secp256k1Account() {
    return SuiAccount(Secp256k1Keypair());
  }

  factory SuiAccount.secp256r1Account() {
    return SuiAccount(Secp256r1Keypair());
  }

  factory SuiAccount.ed25519Account() {
    return SuiAccount(Ed25519Keypair());
  }

  factory SuiAccount.fromMnemonics(String mnemonics, SignatureScheme scheme,
      {int accountIndex = 0, int addressIndex = 0, int changeIndex = 0}) {
    SuiAccount account;
    switch (scheme) {
      case SignatureScheme.Secp256k1:
        account = SuiAccount(Secp256k1Keypair.fromMnemonics(
          mnemonics,
          accountIndex: accountIndex,
          addressIndex: addressIndex,
          changeIndex: changeIndex,
        ));
        break;
      case SignatureScheme.Secp256r1:
        account = SuiAccount(Secp256r1Keypair.fromMnemonics(
          mnemonics,
          accountIndex: accountIndex,
          addressIndex: addressIndex,
          changeIndex: changeIndex,
        ));
        break;
      case SignatureScheme.ED25519:
        account = SuiAccount(Ed25519Keypair.fromMnemonics(
          mnemonics,
          accountIndex: accountIndex,
          addressIndex: addressIndex,
          changeIndex: changeIndex,
        ));
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
      case SignatureScheme.Secp256r1:
        account = SuiAccount(
            Secp256r1Keypair.fromSecretKey(Hex.decode(privateKeyHex)));
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

  static bool isValidAddress(String address) {
    return RegExp(r"^0x[A-Fa-f0-9]{64}$").hasMatch(address);
  }

  static bool isValidSuiNS(String name) {
    if (name.endsWith('-.sui')) return false;
    if (name.contains('--')) return false;
    return RegExp(r"^[a-z0-9][a-z0-9-]{2,62}.sui$").hasMatch(name);
  }

  Uint8List getSecretKey() {
    return _keypair.getSecretKey();
  }

  String privateKeyHex() {
    return Hex.encode(getSecretKey());
  }

  Uint8List getPublicKey() {
    return _keypair.getPublicKey().toBytes();
  }

  SuiAddress getAddress() {
    return _keypair.getPublicKey().toSuiAddress();
  }

  SignaturePubkeyPair signData(Uint8List data) {
    return SignaturePubkeyPair(
      _keypair.getKeyScheme(),
      _keypair.signData(data),
      pubKey: _keypair.getPublicKey()
    );
  }

  bool verify(Uint8List data, SignaturePubkeyPair signature) {
    bool success = _keypair.verify(data, signature.signature, signature.pubKey.toBytes());
    return success;
  }
}