Sui Dart SDK
-

Requirements
-

- sdk: ">=2.15.1 <3.0.0"
- flutter: ">=1.17.0"

Installation
-

```
sui:
    git:
      url: https://github.com/0xmove/sui.git
      ref: main
```

Usage
-

#### pay sui with ed25519

```dart
const gas_budget = 10000;
final recipientAccount = SuiAccount.ed25519Account();
final recipient = recipientAccount.getAddress();

final mnemonics = SuiAccount.generateMnemonic();
final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
final client = SuiClient(Constants.devnetAPI, account: account);
var coins = await client.getGasObjectsOwnedByAddress(account.getAddress());
if (coins.isEmpty) {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSui(account.getAddress());
    assert(resp.transferredGasObjects.isNotEmpty);
    coins = await client.getGasObjectsOwnedByAddress(account.getAddress());
}

final inputObjectIds = [coins.first.objectId];
final txn = PaySuiTransaction(
    inputObjectIds, 
    [recipient],
    [1000],
    gas_budget
);

// estimate gas cost
txn.gasBudget = await client.getGasCostEstimation(txn);

final waitForLocalExecutionTx = await client.paySui(txn);
```

#### pay sui with secp256k1

```dart
const gas_budget = 10000;
final recipientAccount = SuiAccount.secp256k1Account();
final recipient = recipientAccount.getAddress();

final mnemonics = SuiAccount.generateMnemonic();
final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.Secp256k1);
final client = SuiClient(Constants.devnetAPI, account: account);
var coins = await client.getGasObjectsOwnedByAddress(account.getAddress());
if (coins.isEmpty) {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSui(account.getAddress());
    assert(resp.transferredGasObjects.isNotEmpty);
    coins = await client.getGasObjectsOwnedByAddress(account.getAddress());
}

final inputObjectIds = [coins.first.objectId];
final txn = PaySuiTransaction(
    inputObjectIds, 
    [recipient],
    [1000],
    gas_budget
);

// estimate gas cost
txn.gasBudget = await client.getGasCostEstimation(txn);

final waitForLocalExecutionTx = await client.paySui(txn);
```
