import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/cryptography/publickey.dart';
import 'package:sui/rpc/faucet_client.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';

import 'package:sui/sui_account.dart';
import 'package:sui/sui_client.dart';

void main() {
  const mnemonics = "describe beyond repair shuffle pluck during still prefer gravity film green master";

  test('test ed25519 transfer sui', () async {
    const gasBudget = 200000;
    final recipientAccount = SuiAccount.ed25519Account();
    final recipient = recipientAccount.getAddress();

    // transfer sui with ed25519
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

    // update with estimate gas cost
    txn.gasBudget = await client.getGasCostEstimation(txn);

    final waitForLocalExecutionTx = await client.paySui(txn);
    debugPrint(waitForLocalExecutionTx.digest);
  });

  test('test secp256k1 transfer sui', () async {
    const gasBudget = 10000;
    final recipientAccount = SuiAccount.secp256k1Account();
    final recipient = recipientAccount.getAddress();

    // transfer sui with secp256k1
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

    // update with estimate gas cost
    txn.gasBudget = await client.getGasCostEstimation(txn);

    final waitForLocalExecutionTx = await client.paySui(txn);
    debugPrint(waitForLocalExecutionTx.digest);
  });
}
