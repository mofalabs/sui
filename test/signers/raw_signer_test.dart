

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/cryptography/ed25519_keypair.dart';
import 'package:sui/cryptography/secp256k1_keypair.dart';
import 'package:sui/cryptography/secp256r1_keypair.dart';
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

  const DEFAULT_RECIPIENT = '0x8113a0a7b6247da6c6535b51a10b439cc5d9899bdb2c52d5fa66d81ed4ac7fb7';
  const DEFAULT_RECIPIENT_2 = '0x9fd5a804ed6b46d36949ff7434247f0fd594673973ece24aede6b86a7b5dae01';
  const DEFAULT_GAS_BUDGET = 10000000;

  late Secp256k1Keypair secp256k1Keypair;
  late Secp256r1Keypair secp256r1Keypair;
  late Ed25519Keypair ed25519Keypair;

  setUp(() {
    final secretKey = Uint8List.fromList(VALID_SECP256K1_SECRET_KEY);
    final pubKey = Uint8List.fromList(VALID_SECP256K1_PUBLIC_KEY);
    secp256k1Keypair = Secp256k1Keypair.fromSecretKey(secretKey);
    secp256r1Keypair = Secp256r1Keypair.fromSecretKey(secretKey);

    ed25519Keypair = Ed25519Keypair.fromSecretKey(
      base64Decode(VALID_Ed25519_SECRET_KEY)
    );
  });

  test('Ed25519 keypair signData', () {
    final keypair = Ed25519Keypair();
    final signData = Uint8List.fromList(utf8.encode('hello world'));
    final signer = RawSigner(keypair);
    final signature = signer.signData(signData);
    final isValid = signer.verify(signData, signature);
    expect(isValid, true);
  });

  test('Secp256k1 keypair signData', () {
    final keypair = Secp256k1Keypair();
    final signData = Uint8List.fromList(utf8.encode('hello world'));
    final signer = RawSigner(keypair);
    final signature = signer.signData(signData);
    final isValid = signer.verify(signData, signature);
    expect(isValid, true);
  });

  test('Secp256r1 keypair signData', () {
    final keypair = Secp256r1Keypair();
    final signData = Uint8List.fromList(utf8.encode('hello world'));
    final signer = RawSigner(keypair);
    final signature = signer.signData(signData);
    final isValid = signer.verify(signData, signature);
    expect(isValid, true);
  });

  test('transfer sui with ed25519 keypair', () async {
    final signer = RawSigner(ed25519Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.getCoins(signer.getAddress());
    final txn = TransferSuiTransaction(coins.data[0].coinObjectId, DEFAULT_GAS_BUDGET, DEFAULT_RECIPIENT, 100);
    final resp = await signer.transferSui(txn);
    expect(resp.digest.isNotEmpty, true);
  });

  test('transfer sui with secp256k1 keypair', () async {
    final signer = RawSigner(secp256k1Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.getCoins(signer.getAddress());
    final txn = TransferSuiTransaction(coins.data[0].coinObjectId, DEFAULT_GAS_BUDGET, DEFAULT_RECIPIENT, 100);
    final resp = await signer.transferSui(txn);
    expect(resp.digest.isNotEmpty, true);
  });

  test('transfer sui with secp256r1 keypair', () async {
    final signer = RawSigner(secp256r1Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.getCoins(signer.getAddress());
    final txn = TransferSuiTransaction(coins.data[0].coinObjectId, DEFAULT_GAS_BUDGET, DEFAULT_RECIPIENT, 100);
    final resp = await signer.transferSui(txn);
    expect(resp.digest.isNotEmpty, true);
  });

  test('pay with secp256k1 keypair', () async {
    final signer = RawSigner(secp256k1Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds = coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PayTransaction(
      inputObjectIds,
      [DEFAULT_RECIPIENT],
      [1000],
      DEFAULT_GAS_BUDGET,
      coins.data[2].coinObjectId
    );

    final waitForLocalExecutionTx = await signer.pay(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);

  });

  test('pay with secp256r1 keypair', () async {
    final signer = RawSigner(secp256r1Keypair, endpoint: Constants.devnetAPI);
    print(signer.getAddress());
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds = coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PayTransaction(
        inputObjectIds,
        [DEFAULT_RECIPIENT],
        [1000],
        DEFAULT_GAS_BUDGET,
        coins.data[2].coinObjectId
    );

    final waitForLocalExecutionTx = await signer.pay(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);

  });

  test('pay sui with secp256k1 keypair', () async {
    final signer = RawSigner(secp256k1Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds = coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PaySuiTransaction(
      inputObjectIds,
      [DEFAULT_RECIPIENT],
      [1000],
      DEFAULT_GAS_BUDGET
    );

    final waitForLocalExecutionTx = await signer.paySui(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });

  test('pay all sui with secp256k1 keypair', () async {
    final signer = RawSigner(secp256k1Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds = coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PayAllSuiTransaction(
      inputObjectIds,
      DEFAULT_RECIPIENT,
      DEFAULT_GAS_BUDGET
    );

    final waitForLocalExecutionTx = await signer.payAllSui(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });

  test('pay all sui with secp256r1 keypair', () async {
    final signer = RawSigner(secp256r1Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds = coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PayAllSuiTransaction(
        inputObjectIds,
        DEFAULT_RECIPIENT,
        DEFAULT_GAS_BUDGET
    );

    final waitForLocalExecutionTx = await signer.payAllSui(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });

  test('test getGasCostEstimation', () async {
    final signer = RawSigner(ed25519Keypair, endpoint: Constants.devnetAPI);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds = coins.data.take(2).map((x) => x.coinObjectId).toList();

    var txn = PaySuiTransaction(
      inputObjectIds,
      [DEFAULT_RECIPIENT],
      [1000],
      DEFAULT_GAS_BUDGET
    );

    final gasBudget = await signer.getGasCostEstimation(txn);
    txn.gasBudget = gasBudget;

    final waitForLocalExecutionTx = await signer.paySui(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });

}