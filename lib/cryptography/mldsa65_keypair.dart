import 'dart:math';
import 'dart:typed_data';

import 'package:pqcrypto/pqcrypto.dart' show MlDsa, DilithiumParams;

import 'helper.dart';
import 'keypair.dart';
import 'mldsa65_publickey.dart';
import 'signature.dart';

/// Cross-platform ML-DSA-65 signer. Exported private keys contain only the
/// 32-byte FIPS 204 seed; expanded signing keys remain private to this object.
class Mldsa65Keypair with Keypair {
  factory Mldsa65Keypair() {
    final random = Random.secure();
    return Mldsa65Keypair.fromSeed(
      Uint8List.fromList(List.generate(32, (_) => random.nextInt(256))),
    );
  }

  Mldsa65Keypair.fromSeed(Uint8List seed) : _seed = Uint8List.fromList(seed) {
    if (_seed.length != 32) {
      throw ArgumentError.value(
        seed.length,
        'seed.length',
        'Expected 32 bytes',
      );
    }
    final (publicKey, secretKey) = MlDsa.generateKeyPairSeeded(
      DilithiumParams.mlDsa65,
      _seed,
    );
    _publicKey = Mldsa65PublicKey(publicKey);
    _secretKey = secretKey;
  }

  factory Mldsa65Keypair.fromSecretKey(Uint8List seed) =>
      Mldsa65Keypair.fromSeed(seed);

  factory Mldsa65Keypair.fromSuiPrivateKey(String value) {
    final (scheme, seed) = decodeSuiPrivateKey(value);
    if (scheme != SignatureScheme.MLDSA65) {
      throw ArgumentError('Expected an MLDSA65 private key');
    }
    return Mldsa65Keypair.fromSeed(seed);
  }

  final Uint8List _seed;
  late final Uint8List _secretKey;
  late final Mldsa65PublicKey _publicKey;

  @override
  Mldsa65PublicKey getPublicKey() => _publicKey;
  @override
  Uint8List getSecretKey() => Uint8List.fromList(_seed);
  @override
  SignatureScheme getKeyScheme() => SignatureScheme.MLDSA65;
  @override
  Uint8List signData(Uint8List data) =>
      MlDsa.sign(_secretKey, data, DilithiumParams.mlDsa65);
  @override
  bool verify(Uint8List data, Uint8List signature, Uint8List publicKey) =>
      Mldsa65PublicKey(publicKey).verify(data, signature);
  @override
  bool verifySerialized(
    Uint8List message,
    String signature,
    Uint8List publicKey,
  ) {
    final parsed = parseSerializedSignature(signature);
    return parsed.signatureScheme == getKeyScheme() &&
        bytesEqual(parsed.pubKey!.toRawBytes(), publicKey) &&
        verify(message, parsed.signature, publicKey);
  }
}
