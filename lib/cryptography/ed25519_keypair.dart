
import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/ed25519_publickey.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/mnemonics.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed25519;
import 'package:sui/cryptography/signature.dart';
import 'package:sui/utils/ed25519_hd_key.dart' as ed25519HDKey;

const DEFAULT_ED25519_DERIVATION_PATH = "m/44'/784'/0'/0'/0'";


class Ed25519Keypair with Keypair {

  late ed25519.KeyPair _signingKeypair;

  /// Create a new Ed25519 keypair instance.
  /// Generate random keypair if no [Ed25519Keypair] is provided.
  Ed25519Keypair([Uint8List? secretKey]) {
    if (secretKey != null) {
      final privateKey = ed25519.PrivateKey(secretKey);
      final publicKey = ed25519.PublicKey(privateKey.bytes.sublist(32));
      _signingKeypair = ed25519.KeyPair(privateKey, publicKey);
    } else {
      _signingKeypair = ed25519.generateKey();
    }
  }

  @override
  SignatureScheme getKeyScheme() {
    return SignatureScheme.ED25519;
  }

  @override
  Uint8List getSecretKey() {
    return ed25519.seed(_signingKeypair.privateKey);
  }

  Uint8List publicKeyBytes() {
    return Uint8List.fromList(_signingKeypair.publicKey.bytes);
  }

  ed25519.KeyPair keyPair() {
    return _signingKeypair;
  }

  /// Create a Ed25519 keypair from a raw secret key byte array.
  ///
  /// throws error if the provided secret key is invalid and validation is not skipped.
  factory Ed25519Keypair.fromSecretKey(
    Uint8List secretKey,
    { bool skipValidation = true }
  ) {
    if (secretKey.length == 32) {
      return Ed25519Keypair.fromSeed(secretKey);
    }
    if (secretKey.length != 64) throw ArgumentError("Wrong secretKey size. Expected 64 bytes, got ${secretKey.length}.");

    final privateKey = ed25519.PrivateKey(secretKey);
    final publicKey = ed25519.public(privateKey);

    if (!skipValidation) {
      final msg =  Uint8List.fromList(utf8.encode('sui validation'));
      final signature = ed25519.sign(privateKey,msg);
      if (!ed25519.verify(publicKey, msg, signature)) {
        throw ArgumentError('provided secretKey is invalid');
      }
    }
    return Ed25519Keypair(secretKey);
  }

  /// Generate a Ed25519 keypair from a 32 byte seed.
  factory Ed25519Keypair.fromSeed(Uint8List seed) {
    if (seed.length != 32) throw ArgumentError("Wrong secretKey size. Expected 32 bytes, got ${seed.length}.");

    final privateKey = ed25519.newKeyFromSeed(seed);
    return Ed25519Keypair(Uint8List.fromList(privateKey.bytes));
  }

  /// Generate a keypair from [mnemonics] string.
  static Ed25519Keypair fromMnemonics(String mnemonics,
      {int accountIndex = 0, int addressIndex = 0, int changeIndex = 0}) {
    String path = "m/44'/784'/$accountIndex'/$changeIndex'/$addressIndex'";
    return deriveKeypair(path, mnemonics);
  }

  /// The public key for this Ed25519 keypair
  @override
  Ed25519PublicKey getPublicKey() {
    return Ed25519PublicKey.fromBytes(_signingKeypair.publicKey.bytes);
  }

  /// Return the signature for the provided data using Ed25519.
  @override
  Uint8List signData(Uint8List data) {
    Uint8List signature = ed25519.sign(_signingKeypair.privateKey, data);
    return signature;
  }

  /// Derive Ed25519 keypair from mnemonics and path. The mnemonics must be normalized
  /// and validated against the english wordlist.
  ///
  /// If path is none, it will default to m/44'/784'/0'/0'/0', otherwise the path must
  /// be compliant to SLIP-0010 in form m/44'/784'/{account_index}'/{change_index}'/{address_index}'.
  static Ed25519Keypair deriveKeypair(String path, String mnemonics) {

    if (!isValidHardenedPath(path)) {
      throw ArgumentError('Invalid derivation path');
    }

    final normalizeMnemonics = mnemonics
      .trim()
      .split(r"\s+")
      .map((part) => part.toLowerCase())
      .join(" ");

    if(!isValidMnemonics(mnemonics)) {
      throw ArgumentError('Invalid mnemonics');
    }

    final key = ed25519HDKey.derivePath(path, mnemonicToSeedHex(normalizeMnemonics)).key!;    
    final pubkey = ed25519HDKey.getPublicKey(key, false);
    
    final fullPrivateKey = Uint8List(64);
    fullPrivateKey.setAll(0, key);
    fullPrivateKey.setAll(32, pubkey);

    return Ed25519Keypair(Uint8List.fromList(fullPrivateKey));
  }

  @override
  bool verify(Uint8List data,Uint8List signature, Uint8List publicKey) {
    return ed25519.verify(ed25519.PublicKey(publicKey), data, signature);
  }
  
  @override
  bool verifySerialized(Uint8List message, String signature, Uint8List publicKey) {
    final parsed = parseSerializedSignature(signature);
    if (parsed.signatureScheme != SignatureScheme.ED25519) {
      throw ArgumentError('Invalid signature scheme');
    }

    if (base64Encode(publicKey) != parsed.pubKey.toBase64()) {
      throw ArgumentError('Signature does not match public key');
    }

    return verify(message, parsed.signature, publicKey);
  }

}