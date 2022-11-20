
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/cryptography/publickey.dart';
import 'package:sui/providers/json_rpc_provider.dart';
import 'package:sui/rpc/faucet_client.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/sui_client.dart';

void main() {

  const test_mnemonics =
  'result crisp session latin must fruit genuine question prevent start coconut brave speak student dismiss';

  const DEFAULT_RECIPIENT = '0x36096be6a0314052931babed39f53c0666a6b0df';

  const DEFAULT_GAS_BUDGET = 20000;

  final data = Base64DataBuffer.fromString('hello world');

  test('test secp256k1 account generate from mnemonics', () {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.Secp256k1);
    expect(account.getAddress() == '0xed17b3f435c03ff69c2cdc6d394932e68375f20f', true);
  });

  test('test ed25519 account generate from mnemonics', () {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.ED25519);
    expect(account.getAddress() == '0x1a4623343cd42be47d67314fce0ad042f3c82685', true);
  });

  test('test secp256k1 account generate', () {
    final account = SuiAccount.secp256k1Account();
    final signature = account.signData(data);
    bool success = account.verify(data, signature);
    expect(success, true);
  });

  test('test ed25519 account generate', () {
    final account = SuiAccount.ed25519Account();
    final signature = account.signData(data);
    bool success = account.verify(data, signature);
    expect(success, true);
  });

  test('test pay sui with secp256k1', () async {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.Secp256k1);
    final client = SuiClient(account, Constants.devnetAPI);
    final coins = await client.getGasObjectsOwnedByAddress(account.getAddress());
    if (coins.isEmpty) {
      final faucet = FaucetClient(Constants.faucetDevAPI);
      final resp = await faucet.requestSui(account.getAddress());
      assert(resp.transferredGasObjects.isNotEmpty);
    }

    final inputObjectIds = coins.take(2).map((x) => x.objectId).toList();
    final txn = PaySuiTransaction(
      inputObjectIds,
      [DEFAULT_RECIPIENT],
      [1000],
      DEFAULT_GAS_BUDGET
    );

    final gasBudget = await client.getGasCostEstimation(txn);
    txn.gasBudget = gasBudget;

    final waitForLocalExecutionTx = await client.paySui(txn);
    expect(waitForLocalExecutionTx.effectsCert!.confirmedLocalExecution, true);
  });

  test('test pay sui with ed25519', () async {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.ED25519);
    final client = SuiClient(account, Constants.devnetAPI);
    final coins = await client.getGasObjectsOwnedByAddress(account.getAddress());
    if (coins.isEmpty) {
      final faucet = FaucetClient(Constants.faucetDevAPI);
      final resp = await faucet.requestSui(account.getAddress());
      assert(resp.transferredGasObjects.isNotEmpty);
    }

    final inputObjectIds = coins.take(2).map((x) => x.objectId).toList();
    final txn = PaySuiTransaction(
      inputObjectIds, 
      [DEFAULT_RECIPIENT],
      [1000],
      DEFAULT_GAS_BUDGET
    );

    final gasBudget = await client.getGasCostEstimation(txn);
    txn.gasBudget = gasBudget;

    final waitForLocalExecutionTx = await client.paySui(txn);
    expect(waitForLocalExecutionTx.effectsCert!.confirmedLocalExecution, true);
  });

}