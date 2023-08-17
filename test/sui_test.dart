import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui.dart';

void main() {
  const mnemonics = "describe beyond repair shuffle pluck during still prefer gravity film green master";

  test('test ed25519 transfer sui', () async {
    const gasBudget = 2000000;
    final recipientAccount = SuiAccount.ed25519Account();
    final recipient = recipientAccount.getAddress();

    final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
    final client = SuiClient(Constants.devnetAPI, account: account);
    var coins = await client.getCoins(account.getAddress());
    if (coins.data.isEmpty) {
        final faucet = FaucetClient(Constants.faucetDevAPI);
        final resp = await faucet.requestSui(account.getAddress());
        assert(resp.transferredGasObjects.isNotEmpty);
        coins = await client.getCoins(account.getAddress());
    }

    final inputObjectIds = [coins.data.first.coinObjectId];
    final txn = PaySuiTransaction(
        inputObjectIds, 
        [recipient],
        [1000],
        gasBudget
    );

    txn.gasBudget = await client.getGasCostEstimation(txn);

    final waitForLocalExecutionTx = await client.paySui(txn);
    debugPrint(waitForLocalExecutionTx.digest);
  });

  test('test secp256k1 transfer sui', () async {
    const gasBudget = 2000000;
    final recipientAccount = SuiAccount.secp256k1Account();
    final recipient = recipientAccount.getAddress();

    final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.Secp256k1);
    final client = SuiClient(Constants.devnetAPI, account: account);
    var coins = await client.getCoins(account.getAddress());
    if (coins.data.isEmpty) {
        final faucet = FaucetClient(Constants.faucetDevAPI);
        final resp = await faucet.requestSui(account.getAddress());
        assert(resp.transferredGasObjects.isNotEmpty);
        coins = await client.getCoins(account.getAddress());
    }

    final inputObjectIds = [coins.data.first.coinObjectId];
    final txn = PaySuiTransaction(
        inputObjectIds, 
        [recipient],
        [1000],
        gasBudget
    );

    txn.gasBudget = await client.getGasCostEstimation(txn);

    final waitForLocalExecutionTx = await client.paySui(txn);
    debugPrint(waitForLocalExecutionTx.digest);
  });

  test('test secp256r1 transfer sui', () async {
    const gasBudget = 2000000;
    final recipientAccount = SuiAccount.secp256r1Account();
    final recipient = recipientAccount.getAddress();

    final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.Secp256r1);
    final client = SuiClient(Constants.devnetAPI, account: account);
    var coins = await client.getCoins(account.getAddress());
    if (coins.data.isEmpty) {
      final faucet = FaucetClient(Constants.faucetDevAPI);
      final resp = await faucet.requestSui(account.getAddress());
      assert(resp.transferredGasObjects.isNotEmpty);
      coins = await client.getCoins(account.getAddress());
    }

    final inputObjectIds = [coins.data.first.coinObjectId];
    final txn = PaySuiTransaction(
        inputObjectIds,
        [recipient],
        [1000],
        gasBudget
    );

    txn.gasBudget = await client.getGasCostEstimation(txn);

    final waitForLocalExecutionTx = await client.paySui(txn);
    debugPrint(waitForLocalExecutionTx.digest);
  });
}
