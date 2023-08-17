
import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/api.dart' show KeyParameter;
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/src/utils.dart' as utils;

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