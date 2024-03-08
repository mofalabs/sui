import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/ed25519_keypair.dart';
import 'package:sui/cryptography/secp256k1_keypair.dart';
import 'package:sui/cryptography/secp256r1_keypair.dart';
import 'package:sui/signers/raw_signer.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui_urls.dart';

void main() {
  const validSecp256k1SecretKey = [
    59,
    148,
    11,
    85,
    134,
    130,
    61,
    253,
    2,
    174,
    59,
    70,
    27,
    180,
    51,
    107,
    94,
    203,
    174,
    253,
    102,
    39,
    170,
    146,
    46,
    252,
    4,
    143,
    236,
    12,
    136,
    28,
  ];

  // Corresponding to the secret key above.
  const validSecp256k1PublicKey = [
    2,
    29,
    21,
    35,
    7,
    198,
    183,
    43,
    14,
    208,
    65,
    139,
    14,
    112,
    205,
    128,
    231,
    245,
    41,
    91,
    141,
    134,
    245,
    114,
    45,
    63,
    82,
    19,
    251,
    210,
    57,
    79,
    54,
  ];

  const validEd25519SecretKey =
      'mdqVWeFekT7pqy5T49+tV12jO0m+ESW7ki4zSU9JiCgbL0kJbj5dvQ/PqcDAzZLZqzshVEs01d1KZdmLh4uZIg==';

  const defaultRecipient =
      '0x8113a0a7b6247da6c6535b51a10b439cc5d9899bdb2c52d5fa66d81ed4ac7fb7';
  const defaultRecipient2 =
      '0x79088c4883a33769473f548e738ec96bfa00cefbed34b4be0970dacda7135de4';
  const defaultGasBudget = 10000000;

  late Secp256k1Keypair secp256k1Keypair;
  late Secp256r1Keypair secp256r1Keypair;
  late Ed25519Keypair ed25519Keypair;

  setUp(() {
    final secretKey = Uint8List.fromList(validSecp256k1SecretKey);
    final pubKey = Uint8List.fromList(validSecp256k1PublicKey);
    secp256k1Keypair = Secp256k1Keypair.fromSecretKey(secretKey);
    secp256r1Keypair = Secp256r1Keypair.fromSecretKey(secretKey);

    ed25519Keypair =
        Ed25519Keypair.fromSecretKey(base64Decode(validEd25519SecretKey));
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
    final signer = RawSigner(ed25519Keypair, endpoint: SuiUrls.devnet);
    final coins = await signer.getCoins(signer.getAddress());
    final txn = TransferSuiTransaction(
        coins.data[0].coinObjectId, defaultGasBudget, defaultRecipient, 100);
    final resp = await signer.transferSui(txn);
    expect(resp.digest.isNotEmpty, true);
  });

  test('transfer sui with secp256k1 keypair', () async {
    final signer = RawSigner(secp256k1Keypair, endpoint: SuiUrls.devnet);
    final coins = await signer.getCoins(signer.getAddress());
    final txn = TransferSuiTransaction(
        coins.data[0].coinObjectId, defaultGasBudget, defaultRecipient, 100);
    final resp = await signer.transferSui(txn);
    expect(resp.digest.isNotEmpty, true);
  });

  test('transfer sui with secp256r1 keypair', () async {
    final signer = RawSigner(secp256r1Keypair, endpoint: SuiUrls.devnet);
    final coins = await signer.getCoins(signer.getAddress());
    final txn = TransferSuiTransaction(
        coins.data[0].coinObjectId, defaultGasBudget, defaultRecipient, 100);
    final resp = await signer.transferSui(txn);
    expect(resp.digest.isNotEmpty, true);
  });

  test('pay with secp256k1 keypair', () async {
    final signer = RawSigner(secp256k1Keypair, endpoint: SuiUrls.devnet);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds =
        coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PayTransaction(inputObjectIds, [defaultRecipient], [1000],
        defaultGasBudget, coins.data[2].coinObjectId);

    final waitForLocalExecutionTx = await signer.pay(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });

  test('pay with secp256r1 keypair', () async {
    final signer = RawSigner(secp256r1Keypair, endpoint: SuiUrls.devnet);
    print(signer.getAddress());
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds =
        coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PayTransaction(inputObjectIds, [defaultRecipient], [1000],
        defaultGasBudget, coins.data[2].coinObjectId);

    final waitForLocalExecutionTx = await signer.pay(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });

  test('pay sui with secp256k1 keypair', () async {
    final signer = RawSigner(secp256k1Keypair, endpoint: SuiUrls.devnet);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds =
        coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PaySuiTransaction(inputObjectIds,
        [defaultRecipient, defaultRecipient2], [1000, 1000], defaultGasBudget);

    final waitForLocalExecutionTx = await signer.paySui(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });

  test('pay all sui with secp256k1 keypair', () async {
    final signer = RawSigner(secp256k1Keypair, endpoint: SuiUrls.devnet);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds =
        coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PayAllSuiTransaction(
        inputObjectIds, defaultRecipient2, defaultGasBudget);

    final waitForLocalExecutionTx = await signer.payAllSui(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });

  test('pay all sui with secp256r1 keypair', () async {
    final signer = RawSigner(secp256r1Keypair, endpoint: SuiUrls.devnet);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds =
        coins.data.take(2).map((x) => x.coinObjectId).toList();
    final txn = PayAllSuiTransaction(
        inputObjectIds, defaultRecipient2, defaultGasBudget);

    final waitForLocalExecutionTx = await signer.payAllSui(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });

  test('test getGasCostEstimation', () async {
    final signer = RawSigner(ed25519Keypair, endpoint: SuiUrls.devnet);
    final coins = await signer.getCoins(signer.getAddress());
    final inputObjectIds =
        coins.data.take(2).map((x) => x.coinObjectId).toList();

    var txn = PaySuiTransaction(
        inputObjectIds, [defaultRecipient], [1000], defaultGasBudget);

    final gasBudget = await signer.getGasCostEstimation(txn);
    txn.gasBudget = gasBudget;

    final waitForLocalExecutionTx = await signer.paySui(txn);
    expect(waitForLocalExecutionTx.confirmedLocalExecution, true);
  });
}
