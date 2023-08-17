import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/sui.dart';
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
    {
      "rawPublicKey": "A8Ju2r5X3EZ3aYuZzH+Ofs6cd1j2WOwY7lhoJQenulBl",
      "suiPublicKey": "AgPCbtq+V9xGd2mLmcx/jn7OnHdY9ljsGO5YaCUHp7pQZQ==",
      "suiAddress": "0xafd0f5a4f41c5770c201879518740b83743164ed2445016fbba9ae98e04af8a5"
    }
  ];

  group('Secp256r1PublicKey', () {
    test('invalid', () {
      expect(() {
        Secp256PublicKey.fromBytes(INVALID_SECP256R1_PUBLIC_KEY, SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
      }, throwsArgumentError);

      expect(() {
        final invalidPubKeyBase64 = base64Encode(INVALID_SECP256R1_PUBLIC_KEY);
        Secp256PublicKey.fromString(invalidPubKeyBase64, SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
      }, throwsArgumentError);

      expect(() {
        final wrongEncode = Hex.encode(VALID_SECP256R1_PUBLIC_KEY);
        Secp256PublicKey.fromString(wrongEncode, SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
      }, throwsFormatException);

      expect(() {
        Secp256PublicKey.fromString('12345', SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
      }, throwsFormatException);

    });

    test('toBase64', () {
      final pubKeyBase64 = base64Encode(VALID_SECP256R1_PUBLIC_KEY);
      final key = Secp256PublicKey.fromString(pubKeyBase64, SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
      expect(key.toBase64() == pubKeyBase64, true);
      expect(key.toString() == pubKeyBase64, true);
    });

    test('toBuffer', () {
      final pubKeyBase64 = base64Encode(VALID_SECP256R1_PUBLIC_KEY);
      final key = Secp256PublicKey.fromString(pubKeyBase64, SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
      expect(key.toBytes().length == 33, true);
      expect(Secp256PublicKey.fromBytes(key.toBytes(), SIGNATURE_SCHEME_TO_FLAG.Secp256r1).equals(key), true);
    });

    SECP_TEST_CASES.forEach((data) {
      final rawPublicKey = data["rawPublicKey"]!;
      final suiPublicKey = data["suiPublicKey"]!;
      final suiAddress = data["suiAddress"]!;

      test('toSuiAddress from base64 public key $suiAddress}', () {
        final key = Secp256PublicKey.fromString(rawPublicKey, SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
        expect(key.toSuiAddress() == suiAddress, true);
      });

      test("toSuiPublicKey from base64 public key $suiAddress", () {
        final key = Secp256PublicKey.fromString(rawPublicKey, SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
        expect(key.toSuiPublicKey(), suiPublicKey);
      });
    });

  });

}
