
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/src/utils.dart' as utils;

enum SignatureScheme {
  ED25519,
  Secp256k1,
  Secp256r1
}

abstract class SIGNATURE_SCHEME_TO_FLAG {
  static const int ED25519 = 0x00;
  static const int Secp256k1 = 0x01;
  static const int Secp256r1 = 0x02;

  static int schemeToFlag(SignatureScheme scheme) {
    switch (scheme) {
      case SignatureScheme.ED25519:
        return ED25519;
      case SignatureScheme.Secp256k1:
        return Secp256k1;
      case SignatureScheme.Secp256r1:
        return Secp256r1;
      default:
        throw ArgumentError("Undefined Signature Scheme $scheme");
    }
  }
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