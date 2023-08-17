
import 'dart:convert';
import 'dart:typed_data';

import 'package:bip32/bip32.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/mnemonics.dart';
import 'package:sui/cryptography/secp256.dart';
import 'package:sui/cryptography/secp256_publickey.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/utils/sha.dart';

const DEFAULT_SECP256R1_DERIVATION_PATH = "m/74'/784'/0'/0/0";

/// An Secp256r1 Keypair used for signing transactions.
class Secp256r1Keypair with Keypair {
  static final Secp256 secp256r1 = Secp256.fromSecp256r1();
  late Secp256KeypairData _keypair;

  /// Create a new keypair instance.
  /// Generate random keypair if no [Secp256r1Keypair] is provided.
  Secp256r1Keypair([Secp256KeypairData? keypair]) {
    if (keypair != null) {
      if (keypair.secretKey.length != 32) {
        throw ArgumentError('Invalid private key.');
      }
      _keypair = keypair;
    } else { 
     Uint8List secretKey = secp256r1.generatePrivateKeyBytes();
     Uint8List publicKey = secp256r1.getPublicKeyFromPrivateKeyBytes(secretKey);
      _keypair = Secp256KeypairData(publicKey, secretKey);
    }
  }

  /// Get the key scheme of the keypair Secp256r1
  @override
  SignatureScheme getKeyScheme() {
    return SignatureScheme.Secp256r1;
  }

  int getKeySchemeFalg() {
    return SIGNATURE_SCHEME_TO_FLAG.schemeToFlag(getKeyScheme());
  }

  /// Create a keypair from a raw secret key byte array.
  ///
  /// Throw error if the provided secret key is invalid and validation is not skipped.
  static Secp256r1Keypair fromSecretKey(
    Uint8List secretKey,
    { bool? skipValidation }
  ) {
    Uint8List publicKey = secp256r1.getPublicKeyFromPrivateKeyBytes(secretKey, false);
    if (skipValidation == null || !skipValidation) {
      final signData = utf8.encode('sui validation');
      final msgHash = sha256(signData);
      final signature = secp256r1.sign(msgHash, secretKey);
      if (!secp256r1.verifySignature(msgHash, signature, publicKey)) {
        throw ArgumentError('Invalid private key.');
      }
    }
    return Secp256r1Keypair(Secp256KeypairData(publicKey, secretKey));
  }

  /// Generate a keypair from a 32 byte [seed].
  static Secp256r1Keypair fromSeed(Uint8List seed) {
    final publicKey = secp256r1.getPublicKeyFromPrivateKeyBytes(seed, true);
    return Secp256r1Keypair(Secp256KeypairData(publicKey, seed));
  }

  /// Generate a keypair from [mnemonics] string.
  static Secp256r1Keypair fromMnemonics(String mnemonics,
      {int accountIndex = 0, int addressIndex = 0, int changeIndex = 0}) {
    String path = "m/74'/784'/$accountIndex'/$changeIndex/$addressIndex";
    return Secp256r1Keypair.deriveKeypair(path, mnemonics);
  }

  @override
  Uint8List getSecretKey() {
    return _keypair.secretKey;
  }

  Uint8List publicKeyBytes([bool isCompressed = true]) {
    return secp256r1.getPublicKeyFromPrivateKeyBytes(_keypair.secretKey, isCompressed);
  }

  @override
  PublicKey getPublicKey() {
    return Secp256PublicKey.fromBytes(publicKeyBytes(), getKeySchemeFalg());
  }

  @override
  Uint8List signData(Uint8List data) {
    final msgHash = sha256(data);
    final signatureData = secp256r1.sign(msgHash, _keypair.secretKey);
    return signatureData.toBytes();
  }

  /// Derive Secp256r1 keypair from mnemonics and path. The mnemonics must be normalized
  /// and validated against the english wordlist.
  ///
  /// If path is none, it will default to m/74'/784'/0'/0/0, otherwise the path must
  /// be compliant to BIP-32 in form m/74'/784'/{account_index}'/{change_index}/{address_index}.
  static Secp256r1Keypair deriveKeypair(String path, String mnemonics) {
    if (!isValidBIP32Path(path)) {
      throw ArgumentError('Invalid derivation path');
    }
    final key = BIP32.fromSeed(mnemonicToSeed(mnemonics)).derivePath(path);
    return Secp256r1Keypair(Secp256KeypairData(key.publicKey, key.privateKey!));
  }

  @override
  bool verify(Uint8List data, Uint8List signature, Uint8List publicKey) {
    final msgHash = sha256(data);
    return secp256r1.verifySignature(msgHash, SignatureData.fromBytes(signature), publicKey);
  }
  
  @override
  bool verifySerialized(Uint8List message, String signature, Uint8List publicKey) {
    final parsed = parseSerializedSignature(signature);
    if (parsed.signatureScheme != SignatureScheme.Secp256r1) {
      throw ArgumentError('Invalid signature scheme');
    }

    if (base64Encode(publicKey) != parsed.pubKey.toBase64()) {
      throw ArgumentError('Signature does not match public key');
    }

    return verify(message, parsed.signature, publicKey);
  }
}
