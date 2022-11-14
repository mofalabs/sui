## Sui Dart SDK

```dart
/// transfer sui with ed25519
final keypair = Ed25519Keypair.fromMnemonics('mnemonics');
final signer = RawSigner(ed25519Keypair, endpoint: Constants.devnetAPI);
final coins = await signer.provider.getGasObjectsOwnedByAddress(signer.getAddress());
final txn = TransferSuiTransaction(coins[0].objectId, 100, 'receipt address', 100);
final resp = await signer.transferSuiWithRequestType(txn);
```

```dart
/// transfer sui with secp256k1
final keypair = Secp256k1Keypair.fromMnemonics('mnemonics');
final signer = RawSigner(secp256k1Keypair, endpoint: Constants.devnetAPI);
final coins = await signer.provider.getGasObjectsOwnedByAddress(signer.getAddress());
final txn = TransferSuiTransaction(coins[0].objectId, 100, 'receipt address', 100);
final resp = await signer.transferSuiWithRequestType(txn);
```