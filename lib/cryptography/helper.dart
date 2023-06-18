
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/api.dart' show KeyParameter;
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/src/utils.dart' as utils;
import 'package:sui/cryptography/ed25519_publickey.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/secp256_publickey.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/signer_with_provider.dart';

enum SignatureScheme {
  ED25519,
  Secp256k1,
  Secp256r1,
  MultiSig,
}

abstract class SIGNATURE_SCHEME_TO_FLAG {
  static const int ED25519 = 0x00;
  static const int Secp256k1 = 0x01;
  static const int Secp256r1 = 0x02;
  static const int MultiSig = 0x03;

  static int schemeToFlag(SignatureScheme scheme) {
    switch (scheme) {
      case SignatureScheme.ED25519:
        return ED25519;
      case SignatureScheme.Secp256k1:
        return Secp256k1;
      case SignatureScheme.Secp256r1:
        return Secp256r1;
      case SignatureScheme.MultiSig:
        return MultiSig;
      default:
        throw ArgumentError("Undefined Signature Scheme $scheme");
    }
  }

  static SignatureScheme flagToScheme(int flag) {
    switch (flag) {
      case ED25519:
        return SignatureScheme.ED25519;
      case Secp256k1:
        return SignatureScheme.Secp256k1;
      case Secp256r1:
        return SignatureScheme.Secp256r1;
      case MultiSig:
        return SignatureScheme.MultiSig;
      default:
        throw ArgumentError("Undefined Signature Flag $flag");
    }
  }
}

String toSerializedSignature(
  SignatureScheme signatureScheme,
  Uint8List signature,
  PublicKey pubKey,
) {
  final serializedSignature = Uint8List(
    1 + signature.length + pubKey.toBytes().length,
  );
  serializedSignature.setAll(0, [SIGNATURE_SCHEME_TO_FLAG.schemeToFlag(signatureScheme)]);
  serializedSignature.setAll(1, signature);
  serializedSignature.setAll(1 + signature.length, pubKey.toBytes());
  return base64Encode(serializedSignature);
}

SignaturePubkeyPair fromSerializedSignature(
  String serializedSignature,
) {
  final bytes = base64Decode(serializedSignature);
  final signatureScheme = SIGNATURE_SCHEME_TO_FLAG.flagToScheme(bytes[0]);
  if (signatureScheme == SignatureScheme.MultiSig) {
    throw ArgumentError('MultiSig is not supported');
  }

  PublicKey getPublicKey(SignatureScheme scheme, Uint8List bytes) {
    switch (scheme) {
      case SignatureScheme.ED25519:
        return Ed25519PublicKey.fromBytes(bytes);
      case SignatureScheme.Secp256k1:
        return Secp256PublicKey.fromBytes(bytes, SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
      case SignatureScheme.Secp256r1:
        return Secp256PublicKey.fromBytes(bytes, SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
      default:
        throw ArgumentError("Undefined Scheme: $scheme");
    }
  }

  int getPublicKeySize(SignatureScheme scheme) {
    switch (scheme) {
      case SignatureScheme.ED25519:
        return 32;
      case SignatureScheme.Secp256k1:
      case SignatureScheme.Secp256r1:
        return 33;
      default:
        throw ArgumentError("Undefined Public Key Scheme: $scheme");
    }
  }

  final publicKeySize = getPublicKeySize(signatureScheme);
  final signature = bytes.sublist(1, bytes.length - publicKeySize);
  final pubkeyBytes = bytes.sublist(1 + signature.length);
  final pubKey = getPublicKey(signatureScheme, pubkeyBytes);

  return SignaturePubkeyPair(signatureScheme, Base64DataBuffer(signature), pubKey);
}

Uint8List encodeBigInt(BigInt? number) => utils.encodeBigInt(number);

Uint8List encodeBigIntAsUnsigned(BigInt number) => utils.encodeBigIntAsUnsigned(number);

BigInt decodeBigIntToUnsigned(List<int> magnitude) => utils.decodeBigIntWithSign(1, magnitude);

Uint8List padLeftUint8List(Uint8List data, [int len = 32]) {
  assert(data.length <= len);
  if (data.length == len) return data;

  return Uint8List(len)..setRange(len - data.length, len, data);
}

FortunaRandom getRandom() {
  final secureRandom = FortunaRandom();
  final seedSource = Random.secure();
  final seeds = <int>[];
  for (int i = 0; i < 32; i++) {
    seeds.add(seedSource.nextInt(255));
  }
  secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
  return secureRandom;
}