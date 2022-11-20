## Sui Dart SDK

```dart
// transfer sui with ed25519
final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.ED25519);
final client = SuiClient(account, Constants.devnetAPI);
final coins = await client.getGasObjectsOwnedByAddress(account.getAddress());
assert(coins.isNotEmpty, 'empty gas coin');

final inputObjectIds = coins.take(2).map((x) => x.objectId).toList();
final txn = PaySuiTransaction(
    inputObjectIds, 
    [DEFAULT_RECIPIENT],
    [1000],
    DEFAULT_GAS_BUDGET
);

// update with estimate gas cost
txn.gasBudget = await client.getGasCostEstimation(txn);

final waitForLocalExecutionTx = await client.paySui(txn);
```

```dart
// pay sui with secp256k1
final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.Secp256k1);
final client = SuiClient(account, Constants.devnetAPI);
final coins = await client.getGasObjectsOwnedByAddress(account.getAddress());
assert(coins.isNotEmpty, 'empty gas coin');

final inputObjectIds = coins.take(2).map((x) => x.objectId).toList();
final txn = PaySuiTransaction(
    inputObjectIds,
    [DEFAULT_RECIPIENT],
    [1000],
    DEFAULT_GAS_BUDGET
);

// update with estimate gas cost
txn.gasBudget = await client.getGasCostEstimation(txn);

final waitForLocalExecutionTx = await client.paySui(txn);
```