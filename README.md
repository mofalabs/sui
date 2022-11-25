## Sui Dart SDK

```dart
const gas_budget = 10000;
final recipientAccount = SuiAccount.ed25519Account();
final recipient = recipientAccount.getAddress();
```

```dart
// transfer sui with ed25519
final account = SuiAccount.ed25519Account();
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
    [recipient],
    [1000],
    gas_budget
);

// update with estimate gas cost
txn.gasBudget = await client.getGasCostEstimation(txn);

final waitForLocalExecutionTx = await client.paySui(txn);
```

```dart
// pay sui with secp256k1
final account = SuiAccount.secp256k1Account();
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
    [recipient],
    [1000],
    gas_budget
);

// update with estimate gas cost
txn.gasBudget = await client.getGasCostEstimation(txn);

final waitForLocalExecutionTx = await client.paySui(txn);
```