Sui Dart SDK
-

[![Pub](https://img.shields.io/badge/pub-v0.0.4-blue)](https://pub.dev/packages/sui)

Installation
-

```
dependencies:
  sui: ^0.0.4
```

Usage
-

#### pay sui with ed25519

```dart
const gas_budget = 2000000;
final recipientAccount = SuiAccount.ed25519Account();
final recipient = recipientAccount.getAddress();

final mnemonics = SuiAccount.generateMnemonic();
final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
final client = SuiClient(Constants.devnetAPI, account: account);
var coins = await client.getCoins(account.getAddress());
if (coins.data.isEmpty) {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSuiFromFaucetV0(account.getAddress());
    assert(resp.transferredGasObjects.isNotEmpty);
    coins = await client.getGasObjectsOwnedByAddress(account.getAddress());
}

final inputObjectIds = [coins.data.first.coinObjectId];
final txn = PaySuiTransaction(
    inputObjectIds, 
    [recipient],
    [1000],
    gas_budget
);

txn.gasBudget = await client.getGasCostEstimation(txn);

final waitForLocalExecutionTx = await client.paySui(txn);
print(waitForLocalExecutionTx.digest);
```

#### pay sui with secp256k1

```dart
const gas_budget = 2000000;
final recipientAccount = SuiAccount.secp256k1Account();
final recipient = recipientAccount.getAddress();

final mnemonics = SuiAccount.generateMnemonic();
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
    gas_budget
);

txn.gasBudget = await client.getGasCostEstimation(txn);

final waitForLocalExecutionTx = await client.paySui(txn);
print(waitForLocalExecutionTx.digest);
```

#### pay sui with secp256r1

```dart
const gasBudget = 10000000;
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
print(waitForLocalExecutionTx.digest);
```

#### Programmable Transaction Blocks

```dart
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
    tx.setGasPayment([SuiObjectRef(gasCoin.digest, gasCoin.coinObjectId, gasCoin.version)]);
    tx.setGasBudget(BigInt.from(2000000));

    final coin = tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(1000)]));
    tx.add(Transactions.transferObjects([coin], tx.pureAddress(recipient)));

    final waitForLocalExecutionTx = await client.signAndExecuteTransactionBlock(account, tx);
    debugPrint(waitForLocalExecutionTx.digest);
});
```

