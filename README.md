Sui Dart SDK
-

[![Pub](https://img.shields.io/badge/pub-v0.1.3-blue)](https://pub.dev/packages/sui)


Installation
-

```
dependencies:
  sui: ^0.1.3
```

Demo
-

https://sui-dart.pages.dev/

Usage
-

### Connecting to Sui Network

```dart
/// connect to devnet
final devnetClient = SuiClient(Constants.devnetAPI);

/// connect to testnet
final testnetClient = SuiClient(Constants.testnetAPI);

/// connect to mainnet
final mainnetClient = SuiClient(Constants.mainnetAPI);
```

### Getting coins from the faucet

#### Faucet V0
```dart
final faucet = FaucetClient(Constants.faucetDevAPI);
await faucet.requestSuiFromFaucetV0('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');
```

#### Faucet V1
```dart
final faucet = FaucetClient(Constants.faucetDevAPI);
await faucet.requestSuiFromFaucetV1('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');
```

### Sui Account

#### Create account with private key

```dart
/// Ed25519 account
final ed25519 = SuiAccount.ed25519Account();
final ed25519Import = SuiAccount.fromPrivateKey(ed25519.privateKeyHex(), SignatureScheme.ED25519);

/// Secp256k1 account
final secp256k1 = SuiAccount.secp256k1Account();
final sepc256k1Import = SuiAccount.fromPrivateKey(secp256k1.privateKeyHex(), SignatureScheme.Secp256k1);

/// Secp256r1 account
final secp256r1 = SuiAccount.secp256r1Account();
final sepc256r1Import = SuiAccount.fromPrivateKey(secp256r1.privateKeyHex(), SignatureScheme.Secp256r1);
```

#### Create account with mnemonic

```dart
/// create mnemonics
final mnemonics = SuiAccount.generateMnemonic();

/// Ed25519 account
final ed25519 = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);

/// Secp256k1 account
final secp256k1 = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.Secp256k1);

/// Secp256r1 account
final secp256r1 = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.Secp256r1);
```

### Writing APIs

#### Transfer Object

```dart
final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
final client = SuiClient(Constants.devnetAPI);

final tx = TransactionBlock();
tx.setGasBudget(BigInt.from(20000000));
tx.transferObjects(
    [tx.objectId('0x2619f581cb1864d07c89453a69611202669fdc4784fb59b9cb4278ec60756011')], 
    tx.pureAddress(account.getAddress())
);

final result = await client.signAndExecuteTransactionBlock(account, tx);
print(result.digest);
```

#### Split and Transfer Coins

```dart
final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
final client = SuiClient(Constants.devnetAPI);

final tx = TransactionBlock();
tx.setGasBudget(BigInt.from(20000000));
final coin = tx.splitCoins(tx.gas, [tx.pureInt(1000)]);
tx.transferObjects(
    [coin],
    tx.pureAddress(account.getAddress())
);

final result = await client.signAndExecuteTransactionBlock(account, tx);
print(result.digest);
```

#### Merge Coins

```dart
final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
final client = SuiClient(Constants.devnetAPI);

final tx = TransactionBlock();
tx.setGasBudget(BigInt.from(20000000));
tx.mergeCoins(tx.objectId('0x922ec73939b3288f6da39ebefb0cb88c6c54817441254d448bd2491ac4dd0cbd'), 
    [tx.objectId('0x8dafc96dec7f8d635e052a6da9a4153e37bc4d59ed44c45006e4e9d17d07f80d')]
);

final result = await client.signAndExecuteTransactionBlock(account, tx);
print(result.digest);
```

#### Move Call

```dart
final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
final client = SuiClient(Constants.devnetAPI);

const packageObjectId = '0x...';
final tx = TransactionBlock();
tx.setGasBudget(BigInt.from(20000000));
tx.moveCall('$packageObjectId::nft::mint', arguments: [tx.pureString('Example NFT')]);

final result = await client.signAndExecuteTransactionBlock(account, tx);
print(result.digest);
```

#### Publish Modules

```dart
final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
final client = SuiClient(Constants.devnetAPI);

const moduels = <String>[];
const dependencies = <String>[];
final tx = TransactionBlock();
tx.setGasBudget(BigInt.from(20000000));
final upgradeCap = tx.publish(moduels, dependencies);
tx.transferObjects([upgradeCap], account.getAddress());

final result = await client.signAndExecuteTransactionBlock(account, tx);
print(result.digest);
```

### Reading APIs

#### Get Owned Objects

```dart
final client = SuiClient(Constants.devnetAPI);

final objects = await client.getOwnedObjects('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');
```

#### Get Objects

```dart
final client = SuiClient(Constants.devnetAPI);

final obj = await client.getObject('0x0d49dbda185cd0941b71315edb594276731f21b2232d8713f319b02c462a2da7',
    options: SuiObjectDataOptions(showContent: true)
);

final objs = await client.multiGetObjects([
    '0x0d49dbda185cd0941b71315edb594276731f21b2232d8713f319b02c462a2da7',
    '0x922ec73939b3288f6da39ebefb0cb88c6c54817441254d448bd2491ac4dd0cbd'
], options: SuiObjectDataOptions(showType: true));
```

#### Get Transaction

```dart
final client = SuiClient(Constants.devnetAPI);

final txn = await client.getTransactionBlock('6oH779AUs2WpwW77xCVGbYqK1FYVamRqHjV6A5wCV8Qj',
    options: SuiTransactionBlockResponseOptions(showEffects: true)
);

final txns = await client.multiGetTransactionBlocks([
    '9znMGToLRRa8yZvjCUfj1FJmq4gpb8QwpibFAUffuto1',
    '4CEFMajEtM62MthwY1xR3Bcddoh2h5wc7jeKEy7WWsbv'
], options: SuiTransactionBlockResponseOptions(showInput: true, showEffects: true));
```

#### Get Checkpoints

```dart
final client = SuiClient(Constants.devnetAPI);

final checkpoint = await client.getCheckpoint('338000');

final checkpoints = await client.getCheckpoints(descendingOrder: true);
```

#### Get Coins

```dart
final client = SuiClient(Constants.devnetAPI);

final coins = await client.getCoins(
    '0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2',
    coinType: '0x2::sui::SUI');

final allCoins = await client.getAllCoins('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');

final suiBalance = await client.getBalance('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');
```

### Events APIs

#### Querying events

```dart
final client = SuiClient(Constants.devnetAPI);

final events = await client.queryEvents(
    {"Sender": "0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2"}, 
    limit: 2
);

/// Or with EventFilter

final events = await client.queryEventsByFilter(
    EventFilter(sender: "0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2"), 
    limit: 2
);
```

#### WebsocketClient subscribeEvent

```dart
final client = WebsocketClient(Constants.websocketAPI);

final subscription = client.subscribeEvent({"Sender": "0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2"})
.listen((event) {
    debugPrint(event);
}, onError: (e) {
    debugPrint(e.toString());
});
```