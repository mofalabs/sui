
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/api.dart' show KeyParameter;
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/src/utils.dart' as utils;
import 'package:sui/cryptography/signature.dart';
import 'package:sui/sui.dart';
import 'package:sui/utils/bech32/bech32.dart';

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
    seeds.add(seedSource.nextInt(256));
  }
  secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
  return secureRandom;
}

const PRIVATE_KEY_SIZE = 32;
const SUI_PRIVATE_KEY_PREFIX = 'suiprivkey';

/// This returns an ParsedKeypair object based by validating the
/// 33-byte Bech32 encoded string starting with `suiprivkey`, and
/// parse out the signature scheme and the private key in bytes.
(SignatureScheme, Uint8List) decodeSuiPrivateKey(String value) {
  final result = bech32.decode(value);
	if (result.hrp != SUI_PRIVATE_KEY_PREFIX) {
		throw ArgumentError('Invalid private key prefix');
	}
	final extendedSecretKey = bech32.fromWords(result.data);
	final signatureScheme = SIGNATURE_SCHEME_TO_FLAG.flagToScheme(extendedSecretKey[0]);
	final secretKey = Uint8List.fromList(extendedSecretKey.sublist(1));
	return (signatureScheme, secretKey);
}

/// This returns a Bech32 encoded string starting with `suiprivkey`,
/// encoding 33-byte `flag || bytes` for the given the 32-byte private
/// key and its signature scheme.
String encodeSuiPrivateKey(Uint8List bytes, SignatureScheme scheme) {
	if (bytes.length != PRIVATE_KEY_SIZE) {
		throw ArgumentError('Invalid bytes length');
	}
	final flag = SIGNATURE_SCHEME_TO_FLAG.schemeToFlag(scheme);
	final privKeyBytes = Uint8List(bytes.length + 1);
	privKeyBytes.setAll(0, [flag]);
	privKeyBytes.setAll(1, bytes);
	return bech32.encode(Bech32(SUI_PRIVATE_KEY_PREFIX, bech32.toWords(privKeyBytes)));
}