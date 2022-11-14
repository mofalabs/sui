import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/secp256k1_publickey.dart';
import 'package:sui/utils/hex.dart';

void main() {

  const VALID_SECP256K1_SECRET_KEY = [
    59, 148, 11, 85, 134, 130, 61, 253, 2, 174, 59, 70, 27, 180, 51, 107, 94, 203,
    174, 253, 102, 39, 170, 146, 46, 252, 4, 143, 236, 12, 136, 28,
  ];

  // Corresponding to the secret key above.
  const VALID_SECP256K1_PUBLIC_KEY = [
    2, 29, 21, 35, 7, 198, 183, 43, 14, 208, 65, 139, 14, 112, 205, 128, 231, 245,
    41, 91, 141, 134, 245, 114, 45, 63, 82, 19, 251, 210, 57, 79, 54,
  ];

  // Invalid private key with incorrect length
  final INVALID_SECP256K1_SECRET_KEY = Uint8List.fromList(List<int>.filled(31, 1));

  // Invalid public key with incorrect length
  final INVALID_SECP256K1_PUBLIC_KEY = Uint8List.fromList(List<int>.filled(32, 1));

  final SECP_TEST_CASES = [
    [
      'AwTC3jVFRxXc3RJIFgoQcv486QdqwYa8vBp4bgSq0gsI',
      '0x35057079b5dfc60d650768e2f4f92318f4ea5a77'
    ],
    [
      'A1F2CtldIGolO92Pm9yuxWXs5E07aX+6ZEHAnSuKOhii',
      '0x0187cf4234ff80862d5a1665d840df400fef29a0'
    ],
    [
      'Ak5rsa5Od4T6YFN/V3VIhZ/azMMYPkUilKQwc+RiaId+',
      '0x70eaff6b7973c57842c2272f00aa19af9f20dc1b'
    ],
    [
      'A4XbJ3fLvV/8ONsnLHAW1nORKsoCYsHaXv9FK1beMtvY',
      '0xdeb28f733d9f59910cb210d56a46614f9dd28360'
    ],
  ];

  group('Secp256k1PublicKey', () {
    test('invalid', () {
      expect(() {
        Secp256k1PublicKey.fromBytes(INVALID_SECP256K1_PUBLIC_KEY);
      }, throwsArgumentError);

      expect(() {
        final invalidPubKeyBase64 = base64Encode(INVALID_SECP256K1_PUBLIC_KEY);
        Secp256k1PublicKey.fromString(invalidPubKeyBase64);
      }, throwsArgumentError);

      expect(() {
        final wrongEncode = Hex.encode(VALID_SECP256K1_PUBLIC_KEY);
        Secp256k1PublicKey.fromString(wrongEncode);
      }, throwsFormatException);

      expect(() {
        Secp256k1PublicKey.fromString('12345');
      }, throwsFormatException);

    });

    test('toBase64', () {
      final pubKeyBase64 = base64Encode(VALID_SECP256K1_PUBLIC_KEY);
      final key = Secp256k1PublicKey.fromString(pubKeyBase64);
      expect(key.toBase64() == pubKeyBase64, true);
      expect(key.toString() == pubKeyBase64, true);
    });

    test('toBuffer', () {
      final pubKeyBase64 = base64Encode(VALID_SECP256K1_PUBLIC_KEY);
      final key = Secp256k1PublicKey.fromString(pubKeyBase64);
      expect(key.toBytes().length == 33, true);
      expect(Secp256k1PublicKey.fromBytes(key.toBytes()).equals(key), true);
    });

    SECP_TEST_CASES.forEach((data) {
      test('toSuiAddress from base64 public key ${data[1]}}', () {
        final key = Secp256k1PublicKey.fromString(data[0]);
        expect(key.toSuiAddress() == data[1], true);
      });
    });

  });

}
