import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/secp256.dart';
import 'package:sui/cryptography/secp256r1_keypair.dart';
import 'package:sui/utils/sha.dart';

void main() {
  const VALID_SECP256R1_SECRET_KEY = [
    66, 37, 141, 205, 161, 76, 241, 17, 198, 2, 184, 151, 27, 140, 200, 67, 233,
    30, 70, 202, 144, 81, 81, 192, 39, 68, 166, 176, 23, 230, 147, 22,
  ];

  /// Corresponding to the secret key above.
  const VALID_SECP256R1_PUBLIC_KEY = [
    2, 39, 50, 43, 58, 137, 26, 10, 40, 13, 107, 193, 251, 44, 187, 35, 210, 143,
    84, 144, 111, 214, 64, 127, 95, 116, 31, 109, 239, 87, 98, 96, 154,
  ];

  /// Invalid private key with incorrect length
  final INVALID_SECP256R1_SECRET_KEY = Uint8List.fromList(List<int>.filled(31, 1));

  /// Invalid public key with incorrect length
  final INVALID_SECP256R1_PUBLIC_KEY = Uint8List.fromList(List<int>.filled(32, 1));

  /// Test case generated against rust keytool cli. See https://github.com/MystenLabs/sui/blob/edd2cd31e0b05d336b1b03b6e79a67d8dd00d06b/crates/sui/src/unit_tests/keytool_tests.rs#L165
  final TEST_CASES = [
    [
      'act wing dilemma glory episode region allow mad tourist humble muffin oblige',
      'AiWmZXUcFpUF75H082F2RVJAABS5kcrvb8o09IPH9yUw',
      '0x4a822457f1970468d38dae8e63fb60eefdaa497d74d781f581ea2d137ec36f3a',
      'AgLL1StURWGAemn/8rFn3FsRDVfO/Ssf+bbFaugGBtd70w==',
    ],
    [
      'flag rebel cabbage captain minimum purpose long already valley horn enrich salt',
      'AjaB6aLp4fQabx4NglfGz2Bf01TGKArV80NEOnqDwqNN',
      '0xcd43ecb9dd32249ff5748f5e4d51855b01c9b1b8bbe7f8638bb8ab4cb463b920',
      'AgM2aZKpmTrKs8HuyvOZQ2TCQ0s7ql5Agf4giTcu6FtPHA==',
    ],
    [
      'area renew bar language pudding trial small host remind supreme cabbage era',
      'AtSIEzVpJv+bJH3XptEq63vsuK+te1KRSY7JsiuJfcdK',
      '0x0d9047b7e7b698cc09c955ea97b0c68c2be7fb3aebeb59edcc84b1fb87e0f28e',
      'AgJ0BrsxGK2gI3pl7m6L67IXusKo99w4tMDDZCwXhnUm/Q==',
    ],
  ];

  const TEST_MNEMONIC =
      'open genre century trouble allow pioneer love task chat salt drive income';

  group('secp256r1-keypair', () {
    test('new keypair', () {
      final keypair = Secp256r1Keypair();
      expect(keypair.publicKeyBytes().length == 33, true);
    });

    test('create keypair from secret key', () {
      final secretKey = Uint8List.fromList(VALID_SECP256R1_SECRET_KEY);
      final pubKey = Uint8List.fromList(VALID_SECP256R1_PUBLIC_KEY);
      final pubKeyBase64 = base64Encode(pubKey);
      final keypair = Secp256r1Keypair.fromSecretKey(secretKey);
      expect(
          base64Encode(keypair.publicKeyBytes()) ==
              base64Encode(Uint8List.fromList(pubKey)),
          true);
      expect(keypair.getPublicKey().toBase64() == pubKeyBase64, true);
    });

    test('creating keypair from invalid secret key throws error', () {
      var secretKey = Uint8List.fromList(INVALID_SECP256R1_SECRET_KEY);
      final secretKeyBase64 = base64Encode(secretKey);
      secretKey = base64Decode(secretKeyBase64);
      expect(() {
        Secp256r1Keypair.fromSecretKey(secretKey);
      }, throwsArgumentError);
    });

    test('generate keypair from random seed', () {
      final keypair = Secp256r1Keypair.fromSeed(
          Uint8List.fromList(List<int>.filled(32, 8)));
      expect(
          keypair.getPublicKey().toBase64() ==
              'AzrasV1mJWvxXNcWA1s/BBRE5RL+0d1k1Lp1WX0g42bx',
          true);
    });

    test('signature of data is valid', () async {
      final keypair = Secp256r1Keypair();
      final signData = Uint8List.fromList(utf8.encode('hello world'));

      final msgHash = sha256(signData);
      final sig = keypair.signData(signData);
      final signature = SignatureData.fromBytes(sig);
      int recId = Secp256r1Keypair.secp256r1.recoveryId(signature, msgHash, keypair.publicKeyBytes(false));
      final publicKey = Secp256r1Keypair.secp256r1.ecRecover(recId, msgHash, signature);

      expect(base64Encode(publicKey) == base64Encode(keypair.publicKeyBytes(false)), true);
    });

    test('invalid mnemonics to derive secp256r1 keypair', () {
      expect(() {
        Secp256r1Keypair.deriveKeypair(
            DEFAULT_SECP256R1_DERIVATION_PATH, 'aaa');
      }, throwsArgumentError);
    });

    test('derive secp256r1 keypair from path and mnemonics', () {
      final keypair = Secp256r1Keypair.deriveKeypair(
          DEFAULT_SECP256R1_DERIVATION_PATH, TEST_MNEMONIC);
      expect(
          keypair.getPublicKey().toBase64() ==
              'A1s+wioS1h2S+kFEhyB/E16/8nxK6iFzdvc7lrlP9fsM',
          true);
      expect(
          keypair.getPublicKey().toSuiAddress() ==
              '0xd135b77e2c949a104142969b2ab7f1866a1fc6882e045c0377b7f13b45320691',
          true);
    });

    test('incorrect purpose node for secp256r1 derivation path', () {
      expect(() {
        Secp256r1Keypair.deriveKeypair("m/74'/784'/0'/0'/0'", TEST_MNEMONIC);
      }, throwsArgumentError);
    });

    test('signs PersonalMessages', () {
      final keypair = Secp256r1Keypair();
      final message = Uint8List.fromList(utf8.encode('hello world'));

      final signatureWithBytes = (keypair.signPersonalMessage(message));

      expect(keypair.verifyPersonalMessage(message, signatureWithBytes.signature), true);
      expect(keypair.verifyPersonalMessage(message, signatureWithBytes.signature), true);
    });
  });
}
