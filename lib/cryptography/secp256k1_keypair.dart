
import 'dart:convert';
import 'dart:typed_data';

import 'package:bip32/bip32.dart';
import 'package:pointycastle/src/utils.dart' as utils;
import 'package:sui/cryptography/helper.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/mnemonics.dart';
import 'package:sui/cryptography/secp256.dart';
import 'package:sui/cryptography/secp256_publickey.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/utils/sha.dart';

const DEFAULT_SECP256K1_DERIVATION_PATH = "m/54'/784'/0'/0/0";

/// An Secp256k1 Keypair used for signing transactions.
class Secp256k1Keypair with Keypair {
  static final Secp256 secp256k1 = Secp256.fromSecp256k1();
  late Secp256KeypairData _keypair;

  /// Create a new keypair instance.
  /// Generate random keypair if no [Secp256k1Keypair] is provided.
  Secp256k1Keypair([Secp256KeypairData? keypair]) {
    if (keypair != null) {
      if (keypair.secretKey.length != 32) {
        throw ArgumentError('Invalid private key.');
      }
      _keypair = keypair;
    } else { 
     Uint8List secretKey = secp256k1.generatePrivateKeyBytes();
     Uint8List publicKey = secp256k1.getPublicKeyFromPrivateKeyBytes(secretKey);
      _keypair = Secp256KeypairData(publicKey, secretKey);
    }
  }

  /// Get the key scheme of the keypair Secp256k1
  @override
  SignatureScheme getKeyScheme() {
    return SignatureScheme.Secp256k1;
  }

  int getKeySchemeFalg() {
    return SIGNATURE_SCHEME_TO_FLAG.schemeToFlag(getKeyScheme());
  }

  /// Create a keypair from a raw secret key byte array.
  ///
  /// Throw error if the provided secret key is invalid and validation is not skipped.
  static Secp256k1Keypair fromSecretKey(
    Uint8List secretKey,
    { bool? skipValidation }
  ) {
    Uint8List publicKey = secp256k1.getPublicKeyFromPrivateKeyBytes(secretKey, false);
    if (skipValidation == null || !skipValidation) {
      final signData = utf8.encode('sui validation');
      final msgHash = sha256(signData);
      final signature = secp256k1.sign(msgHash, secretKey);
      if (!secp256k1.verifySignature(msgHash, signature, publicKey)) {
        throw ArgumentError('Invalid private key.');
      }
    }
    return Secp256k1Keypair(Secp256KeypairData(publicKey, secretKey));
  }

  /// Generate a keypair from a 32 byte [seed].
  static Secp256k1Keypair fromSeed(Uint8List seed) {
    final publicKey = secp256k1.getPublicKeyFromPrivateKeyBytes(seed, true);
    return Secp256k1Keypair(Secp256KeypairData(publicKey, seed));
  }

  /// Generate a keypair from [mnemonics] string.
  static Secp256k1Keypair fromMnemonics(String mnemonics,
      {int accountIndex = 0, int addressIndex = 0, int changeIndex = 0}) {
    String path = "m/54'/784'/$accountIndex'/$changeIndex/$addressIndex";
    return Secp256k1Keypair.deriveKeypair(path, mnemonics);
  }

  @override
  Uint8List getSecretKey() {
    return _keypair.secretKey;
  }

  Uint8List publicKeyBytes([bool isCompressed = true]) {
    return secp256k1.getPublicKeyFromPrivateKeyBytes(_keypair.secretKey, isCompressed);
  }

  @override
  PublicKey getPublicKey() {
    return Secp256PublicKey.fromBytes(publicKeyBytes(), getKeySchemeFalg());
  }

  @override
  Base64DataBuffer signData(Base64DataBuffer data) {
    final msgHash = sha256(data.getData());
    final signatureData = secp256k1.sign(msgHash, _keypair.secretKey);
    return Base64DataBuffer(signatureData.toBytes());
  }

  /// Derive Secp256k1 keypair from mnemonics and path. The mnemonics must be normalized
  /// and validated against the english wordlist.
  ///
  /// If path is none, it will default to m/54'/784'/0'/0/0, otherwise the path must
  /// be compliant to BIP-32 in form m/54'/784'/{account_index}'/{change_index}/{address_index}.
  static Secp256k1Keypair deriveKeypair(String path, String mnemonics) {
    if (!isValidBIP32Path(path)) {
      throw ArgumentError('Invalid derivation path');
    }
    final key = BIP32.fromSeed(mnemonicToSeed(mnemonics)).derivePath(path);
    return Secp256k1Keypair(Secp256KeypairData(key.publicKey, key.privateKey!));
  }

  @override
  bool verify(Base64DataBuffer data, Base64DataBuffer signature, Uint8List publicKey) {
    final msgHash = sha256(data.getData());
    return secp256k1.verifySignature(msgHash, SignatureData.fromBytes(signature.getData()), publicKey);
  }
}
