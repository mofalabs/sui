

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/cryptography/ed25519_keypair.dart';
import 'package:sui/cryptography/secp256k1_keypair.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/raw_signer.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';

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

  const VALID_Ed25519_SECRET_KEY =
    'mdqVWeFekT7pqy5T49+tV12jO0m+ESW7ki4zSU9JiCgbL0kJbj5dvQ/PqcDAzZLZqzshVEs01d1KZdmLh4uZIg==';

  const DEFAULT_RECIPIENT = '0x36096be6a0314052931babed39f53c0666a6b0df';
  const DEFAULT_RECIPIENT_2 = '0x46096be6a0314052931babed39f53c0666a6b0da';
  const DEFAULT_GAS_BUDGET = 20000;

  late Secp256k1Keypair secp256k1Keypair;
  late Ed25519Keypair ed25519Keypair;

  setUp(() {
    final secretKey = Uint8List.fromList(VALID_SECP256K1_SECRET_KEY);
    final pubKey = Uint8List.fromList(VALID_SECP256K1_PUBLIC_KEY);
    final pubKeyBase64 = base64Encode(pubKey);
    secp256k1Keypair = Secp256k1Keypair.fromSecretKey(secretKey);

    ed25519Keypair = Ed25519Keypair.fromSecretKey(
      base64Decode(VALID_Ed25519_SECRET_KEY), 
      skipValidation: false
    );
  });

  test('Ed25519 keypair signData', () {
    final keypair = Ed25519Keypair();
    final signData = Base64DataBuffer(Uint8List.fromList(utf8.encode('hello world')));
    final signer = RawSigner(keypair);
    final signature = signer.signData(signData);
    final isValid = Ed25519Keypair.verify(signData, signature.signature.getData(), signature.pubKey.toBytes());
    expect(isValid, true);
    
  });

  test('Secp256k1 keypair signData', () {
    final keypair = Secp256k1Keypair();
    final signData = Base64DataBuffer(Uint8List.fromList(utf8.encode('hello world')));
    final signer = RawSigner(keypair);
    final signature = signer.signData(signData);
    final isValid = Secp256k1Keypair.verify(signData, signature.signature.getData(), signature.pubKey.toBytes());
    expect(isValid, true);
  });

  test('transfer sui with ed25519 keypair', () async {
    final signer = RawSigner(ed25519Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.provider.getGasObjectsOwnedByAddress(signer.getAddress());
    final txn = TransferSuiTransaction(coins[0].objectId, DEFAULT_GAS_BUDGET, DEFAULT_RECIPIENT, 100);
    final resp = await signer.transferSuiWithRequestType(txn);
    expect(resp['EffectsCert']['certificate']['transactionDigest'] != null, true);
  });

  test('transfer sui with secp256k1 keypair', () async {
    final signer = RawSigner(secp256k1Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.provider.getGasObjectsOwnedByAddress(signer.getAddress());
    final txn = TransferSuiTransaction(coins[0].objectId, DEFAULT_GAS_BUDGET, DEFAULT_RECIPIENT, 100);
    final resp = await signer.transferSuiWithRequestType(txn);
    expect(resp['EffectsCert']['certificate']['transactionDigest'] != null, true);
  });

}