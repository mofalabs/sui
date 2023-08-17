

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/secp256.dart';
import 'package:sui/cryptography/secp256k1_keypair.dart';
import 'package:sui/utils/sha.dart';


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

  const TEST_MNEMONIC =
    'result crisp session latin must fruit genuine question prevent start coconut brave speak student dismiss';

  group('secp256k1-keypair', () {

    test('new keypair', () {
      final keypair = Secp256k1Keypair();
      expect(keypair.publicKeyBytes().length == 33, true);
    });

    test('create keypair from secret key', () {
      final secretKey = Uint8List.fromList(VALID_SECP256K1_SECRET_KEY);
      final pubKey = Uint8List.fromList(VALID_SECP256K1_PUBLIC_KEY);
      final pubKeyBase64 = base64Encode(pubKey);
      final keypair = Secp256k1Keypair.fromSecretKey(secretKey);
      expect(base64Encode(keypair.publicKeyBytes()) == base64Encode(Uint8List.fromList(pubKey)), true);
      expect(keypair.getPublicKey().toBase64() == pubKeyBase64, true);
    });

    test('creating keypair from invalid secret key throws error', () {
      var secretKey = Uint8List.fromList(INVALID_SECP256K1_SECRET_KEY);
      final secretKeyBase64 = base64Encode(secretKey);
      secretKey = base64Decode(secretKeyBase64);
      expect(() {
        Secp256k1Keypair.fromSecretKey(secretKey);
      }, throwsArgumentError);
    });

    test('generate keypair from random seed', () {
      final keypair = Secp256k1Keypair.fromSeed(
        Uint8List.fromList(List<int>.filled(32, 8))
      );
      expect(keypair.getPublicKey().toBase64() == 'A/mR+UTR4ZVKf8i5v2Lg148BX0wHdi1QXiDmxFJgo2Yb', true);
    });

    test('signature of data is valid', () async {
      final keypair = Secp256k1Keypair();
      final signData = Uint8List.fromList(utf8.encode('hello world'));

      final msgHash = sha256(signData);
      final sig = keypair.signData(signData);
      final signature = SignatureData.fromBytes(sig);
      int recId = Secp256k1Keypair.secp256k1.recoveryId(signature, msgHash, keypair.publicKeyBytes(false));
      final publicKey = Secp256k1Keypair.secp256k1.ecRecover(recId, msgHash, signature);

      expect(base64Encode(publicKey) == base64Encode(keypair.publicKeyBytes(false)), true);
    });

    test('invalid mnemonics to derive secp256k1 keypair', () {
      expect(() {
        Secp256k1Keypair.deriveKeypair(DEFAULT_SECP256K1_DERIVATION_PATH, 'aaa');
      }, throwsArgumentError);
    });

    test('derive secp256k1 keypair from path and mnemonics', () {
      final keypair = Secp256k1Keypair.deriveKeypair(
        DEFAULT_SECP256K1_DERIVATION_PATH,
        TEST_MNEMONIC
      );
      
      expect(keypair.getPublicKey().toBase64() == 
        'A+NxdDVYKrM9LjFdIem8ThlQCh/EyM3HOhU2WJF3SxMf', 
        true);
      expect(keypair.getPublicKey().toSuiAddress() ==
        '0x7ec1b6df34a4018c377109851af1cf70db6687dd4a880a51f9119af86d855643',
        true
      );
    });

    test('incorrect purpose node for secp256k1 derivation path', () {
      expect(() {
        Secp256k1Keypair.deriveKeypair("m/44'/784'/0'/0'/0'", TEST_MNEMONIC);
      }, throwsArgumentError);
    });

    test('incorrect hardened path for secp256k1 key derivation', () {
      expect(() {
        Secp256k1Keypair.deriveKeypair("m/54'/784'/0'/0'/0'", TEST_MNEMONIC);
      }, throwsArgumentError);
    });

    test('signs PersonalMessages', () {
      final keypair = Secp256k1Keypair();
      final message = Uint8List.fromList(utf8.encode('hello world'));

      final signatureWithBytes = (keypair.signPersonalMessage(message));

      expect(keypair.verifyPersonalMessage(message, signatureWithBytes.signature), true);
      expect(keypair.verifyPersonalMessage(message, signatureWithBytes.signature), true);
    });

  });

}
