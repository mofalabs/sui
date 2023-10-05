import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction_block.dart';
import 'package:sui/builder/transactions.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui.dart';

void main() {
  const mnemonics = "describe beyond repair shuffle pluck during still prefer gravity film green master";

  test('test connecting to sui network', () async {
    /// connect to devnet
    final devnetClient = SuiClient(Constants.devnetAPI);

    /// connect to  testnet
    final testnetClient = SuiClient(Constants.testnetAPI);

    /// connect to  mainnet
    final mainnetClient = SuiClient(Constants.mainnetAPI);
  });

  test('test Getting coins from the faucet v0', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    await faucet.requestSuiFromFaucetV0('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');
  });

  test('test Getting coins from the faucet v1', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    await faucet.requestSuiFromFaucetV1('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');
  });

  test('test create sui account and import from private key', () {
    final ed25519 = SuiAccount.ed25519Account();
    final secp256k1 = SuiAccount.secp256k1Account();
    final secp256r1 = SuiAccount.secp256r1Account();

    final ed25519Import = SuiAccount.fromPrivateKey(
      ed25519.privateKeyHex(), 
      SignatureScheme.ED25519
    );
    expect(ed25519.getAddress(), ed25519Import.getAddress());

    final sepc256k1Import = SuiAccount.fromPrivateKey(
      secp256k1.privateKeyHex(), 
      SignatureScheme.Secp256k1
    );
    expect(secp256k1.getAddress(), sepc256k1Import.getAddress());

    final sepc256r1Import = SuiAccount.fromPrivateKey(
      secp256r1.privateKeyHex(), 
      SignatureScheme.Secp256r1
    );
    expect(secp256r1.getAddress(), sepc256r1Import.getAddress());

  });

  test('test create sui from mnemonic', () {
    final mnemonics = SuiAccount.generateMnemonic();
    final ed25519 = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
    final secp256k1 = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.Secp256k1);
    final secp256r1 = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.Secp256r1);
  });

  test('test ed25519 transfer sui', () async {
    const gasBudget = 2000000;
    final recipientAccount = SuiAccount.ed25519Account();
    final recipient = recipientAccount.getAddress();

    final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
    final client = SuiClient(Constants.devnetAPI, account: account);
    var coins = await client.getCoins(account.getAddress());
    if (coins.data.isEmpty) {
        final faucet = FaucetClient(Constants.faucetDevAPI);
        final resp = await faucet.requestSuiFromFaucetV0(account.getAddress());
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
        final resp = await faucet.requestSuiFromFaucetV0(account.getAddress());
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
      final resp = await faucet.requestSuiFromFaucetV0(account.getAddress());
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

test('test programmable transaction blocks', () async {
    final recipientAccount = SuiAccount.ed25519Account();
    final recipient = recipientAccount.getAddress();

    final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
    final client = SuiClient(Constants.devnetAPI, account: account);
    var coins = await client.getCoins(account.getAddress());
    if (coins.data.isEmpty) {
        final faucet = FaucetClient(Constants.faucetDevAPI);
        final resp = await faucet.requestSuiFromFaucetV0(account.getAddress());
        assert(resp.transferredGasObjects.isNotEmpty);
    }

    final gasCoin = coins.data.first;

    final tx = TransactionBlock();
    tx.setGasPayment([gasCoin]);
    tx.setGasBudget(BigInt.from(2000000));

    final coin = tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(1000)]));
    tx.add(Transactions.transferObjects([coin], tx.pureAddress(recipient)));

    final waitForLocalExecutionTx = await client.signAndExecuteTransactionBlock(account, tx);
    debugPrint(waitForLocalExecutionTx.digest);
  });
}
