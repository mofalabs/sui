import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/secp256_publickey.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/sui.dart';
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
    {
      "rawPublicKey": "AwTC3jVFRxXc3RJIFgoQcv486QdqwYa8vBp4bgSq0gsI",
      "suiPublicKey": "AQMEwt41RUcV3N0SSBYKEHL+POkHasGGvLwaeG4EqtILCA==",
      "suiAddress": "0xcdce00b4326fb908fdac83c35bcfbda323bfcc0618b47c66ccafbdced850efaa"
    },
    {
      "rawPublicKey": "A1F2CtldIGolO92Pm9yuxWXs5E07aX+6ZEHAnSuKOhii",
      "suiPublicKey": "AQNRdgrZXSBqJTvdj5vcrsVl7ORNO2l/umRBwJ0rijoYog==",
      "suiAddress": "0xb588e58ed8967b6a6f9dbce76386283d374cf7389fb164189551257e32b023b2"
    },
    {
      "rawPublicKey": "Ak5rsa5Od4T6YFN/V3VIhZ/azMMYPkUilKQwc+RiaId+",
      "suiPublicKey": "AQJOa7GuTneE+mBTf1d1SIWf2szDGD5FIpSkMHPkYmiHfg==",
      "suiAddress": "0x694dd74af1e82b968822a82fb5e315f6d20e8697d5d03c0b15e0178c1a1fcfa0"
    },
    {
      "rawPublicKey": "A4XbJ3fLvV/8ONsnLHAW1nORKsoCYsHaXv9FK1beMtvY",
      "suiPublicKey": "AQOF2yd3y71f/DjbJyxwFtZzkSrKAmLB2l7/RStW3jLb2A==",
      "suiAddress": "0x78acc6ca0003457737d755ade25a6f3a144e5e44ed6f8e6af4982c5cc75e55e7"
    }
  ];

  group('Secp256k1PublicKey', () {
    test('invalid', () {
      expect(() {
        Secp256PublicKey.fromBytes(INVALID_SECP256K1_PUBLIC_KEY, SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
      }, throwsArgumentError);

      expect(() {
        final invalidPubKeyBase64 = base64Encode(INVALID_SECP256K1_PUBLIC_KEY);
        Secp256PublicKey.fromString(invalidPubKeyBase64, SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
      }, throwsArgumentError);

      expect(() {
        final wrongEncode = Hex.encode(VALID_SECP256K1_PUBLIC_KEY);
        Secp256PublicKey.fromString(wrongEncode, SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
      }, throwsFormatException);

      expect(() {
        Secp256PublicKey.fromString('12345', SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
      }, throwsFormatException);

    });

    test('toBase64', () {
      final pubKeyBase64 = base64Encode(VALID_SECP256K1_PUBLIC_KEY);
      final key = Secp256PublicKey.fromString(pubKeyBase64, SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
      expect(key.toBase64() == pubKeyBase64, true);
      expect(key.toString() == pubKeyBase64, true);
    });

    test('toBuffer', () {
      final pubKeyBase64 = base64Encode(VALID_SECP256K1_PUBLIC_KEY);
      final key = Secp256PublicKey.fromString(pubKeyBase64, SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
      expect(key.toBytes().length == 33, true);
      expect(Secp256PublicKey.fromBytes(key.toBytes(), SIGNATURE_SCHEME_TO_FLAG.Secp256k1).equals(key), true);
    });

    SECP_TEST_CASES.forEach((data) {
      final rawPublicKey = data["rawPublicKey"]!;
      final suiPublicKey = data["suiPublicKey"]!;
      final suiAddress = data["suiAddress"]!;

      test('toSuiAddress from base64 public key $suiAddress}', () {
        final key = Secp256PublicKey.fromString(rawPublicKey, SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
        expect(key.toSuiAddress() == suiAddress, true);
      });


      test("toSuiPublicKey from base64 public key $suiAddress", () {
        final key = Secp256PublicKey.fromString(rawPublicKey, SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
        expect(key.toSuiPublicKey(), suiPublicKey);
      });

    });

  });

}
