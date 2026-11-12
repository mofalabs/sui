import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';
import 'package:sui/utils/proto_int.dart';
import 'package:sui/utils/hex.dart';

// These tests intentionally avoid dart:io so the same checks run in Chrome.
void main() {
  test('ML-DSA-65 signs and verifies on every supported platform', () async {
    final key = Mldsa65Keypair.fromSeed(Uint8List.fromList(List.filled(32, 2)));
    expect(
      key.getPublicKey().toSuiAddress(),
      '0xa44576e02f83a9e1bddac6fd742a77931d1689d9a61122eb3125dee425f6dd36',
    );
    final message = Uint8List.fromList([1, 2, 3]);
    final signed = key.signPersonalMessage(message);
    expect(
      await isValidPersonalMessageSignature(message, signed.signature),
      isTrue,
    );
    expect(
      await isValidPersonalMessageSignature(Uint8List(1), signed.signature),
      isFalse,
    );
  });

  test('PoW Argon2d matches the official vector on native and web', () async {
    final challenge = FaucetChallenge.fromJson({
      "chainId": "8wWZfv1HjQxjB5ncmC9CQqqRqUMBiEZXnc5FhS9zRe1v",
      "checkpointSeq": "1713342",
      "checkpointDigest": "GzBdc9tbUe3s2PK1iVJcyQBj5TvdX7bJiAHWbhBDYiYb",
      "randomBytes":
          "mJ4ZqDXQasy17GTiGfp0/OYAGCR+7reLM5+Gb39YtoAIaPuh1wj+z5J7po+eSze3",
      "faucetAddress":
          "0x949cd75a2485cc18b8258634ffd9b849a687e2e2a0b4c2444a21f007fc79adc4",
      "recipient":
          "0x1111111111111111111111111111111111111111111111111111111111111111",
      "version": 1,
      "domain": "sui-faucet-pow/1",
      "algorithm": "argon2d",
      "argon2Version": 19,
      "salt": "sui-faucet-pow-1",
      "memorySize": 8192,
      "iterations": 1,
      "parallelism": 1,
      "hashLength": 32,
      "difficulty": "2",
      "threshold": "9223372036854775808",
      "amountMist": "1000000000",
      "windowSeconds": 600,
    });
    expect(
      Hex.encode(await challenge.hashProof(BigInt.zero)),
      '31f6ec0e9169705f6105219eebbbc77420f1d9273d407db5df17b4d090afb92d',
    );
  });

  test(
    'protobuf uint64 conversions preserve values above JS integer precision',
    () {
      for (final value in [
        BigInt.zero,
        (BigInt.one << 53) + BigInt.one,
        (BigInt.one << 63) + BigInt.one,
        (BigInt.one << 64) - BigInt.one,
      ]) {
        expect(uint64ToBigInt(bigIntToUint64(value)), value);
      }
    },
  );
}
