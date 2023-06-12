import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/secp256r1_publickey.dart';
import 'package:sui/utils/hex.dart';

void main() {

  const VALID_SECP256R1_SECRET_KEY = [
    66, 37, 141, 205, 161, 76, 241, 17, 198, 2, 184, 151, 27, 140, 200, 67, 233,
    30, 70, 202, 144, 81, 81, 192, 39, 68, 166, 176, 23, 230, 147, 22,
  ];

  // Corresponding to the secret key above.
  const VALID_SECP256R1_PUBLIC_KEY = [
    2, 39, 50, 43, 58, 137, 26, 10, 40, 13, 107, 193, 251, 44, 187, 35, 210, 143,
    84, 144, 111, 214, 64, 127, 95, 116, 31, 109, 239, 87, 98, 96, 154,
  ];

  // Invalid private key with incorrect length
  final INVALID_SECP256K1_SECRET_KEY = Uint8List.fromList(List<int>.filled(31, 1));

  // Invalid public key with incorrect length
  final INVALID_SECP256R1_PUBLIC_KEY = Uint8List.fromList(List<int>.filled(32, 1));

  final SECP_TEST_CASES = [
    [
      'A8Ju2r5X3EZ3aYuZzH+Ofs6cd1j2WOwY7lhoJQenulBl',
      '0xafd0f5a4f41c5770c201879518740b83743164ed2445016fbba9ae98e04af8a5',
    ],
  ];

  group('Secp256r1PublicKey', () {
    test('invalid', () {
      expect(() {
        Secp256r1PublicKey.fromBytes(INVALID_SECP256R1_PUBLIC_KEY);
      }, throwsArgumentError);

      expect(() {
        final invalidPubKeyBase64 = base64Encode(INVALID_SECP256R1_PUBLIC_KEY);
        Secp256r1PublicKey.fromString(invalidPubKeyBase64);
      }, throwsArgumentError);

      expect(() {
        final wrongEncode = Hex.encode(VALID_SECP256R1_PUBLIC_KEY);
        Secp256r1PublicKey.fromString(wrongEncode);
      }, throwsFormatException);

      expect(() {
        Secp256r1PublicKey.fromString('12345');
      }, throwsFormatException);

    });

    test('toBase64', () {
      final pubKeyBase64 = base64Encode(VALID_SECP256R1_PUBLIC_KEY);
      final key = Secp256r1PublicKey.fromString(pubKeyBase64);
      expect(key.toBase64() == pubKeyBase64, true);
      expect(key.toString() == pubKeyBase64, true);
    });

    test('toBuffer', () {
      final pubKeyBase64 = base64Encode(VALID_SECP256R1_PUBLIC_KEY);
      final key = Secp256r1PublicKey.fromString(pubKeyBase64);
      expect(key.toBytes().length == 33, true);
      expect(Secp256r1PublicKey.fromBytes(key.toBytes()).equals(key), true);
    });

    SECP_TEST_CASES.forEach((data) {
      test('toSuiAddress from base64 public key ${data[1]}}', () {
        final key = Secp256r1PublicKey.fromString(data[0]);
        expect(key.toSuiAddress() == data[1], true);
      });
    });

  });

}
