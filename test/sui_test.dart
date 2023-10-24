import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
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

  test('test transfer object', () async {
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
  });

  test('test split and transfer sui', () async {
    final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
    final client = SuiClient(Constants.devnetAPI);

    final tx = TransactionBlock();
    tx.setGasBudget(BigInt.from(20000000));
    final coin = tx.splitCoins(tx.gas, [tx.pureInt(200000)]);
    tx.transferObjects(
      [coin],
      tx.pureAddress(account.getAddress())
    );

    final result = await client.signAndExecuteTransactionBlock(account, tx);
    print(result.digest);
  });

  test('test merge coins', () async {
    final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
    final client = SuiClient(Constants.devnetAPI);

    final tx = TransactionBlock();
    tx.setGasBudget(BigInt.from(20000000));
    tx.mergeCoins(tx.objectId('0x922ec73939b3288f6da39ebefb0cb88c6c54817441254d448bd2491ac4dd0cbd'), 
      [tx.objectId('0x8dafc96dec7f8d635e052a6da9a4153e37bc4d59ed44c45006e4e9d17d07f80d')]
    );

    final result = await client.signAndExecuteTransactionBlock(account, tx);
    print(result.digest);
  });

  test('test move call', () async {
    final account = SuiAccount.fromMnemonics(mnemonics, SignatureScheme.ED25519);
    final client = SuiClient(Constants.devnetAPI);

    const packageObjectId = '0x...';
    final tx = TransactionBlock();
    tx.setGasBudget(BigInt.from(20000000));
    tx.moveCall('$packageObjectId::nft::mint', arguments: [tx.pureString('Example NFT')]);

    final result = await client.signAndExecuteTransactionBlock(account, tx);
    print(result.digest);
  });

  test('test publish modules', () async {
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
  });

  test('test get owned objects', () async {
    final client = SuiClient(Constants.devnetAPI);
    final objects = await client.getOwnedObjects('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');
  });

  test('test get objects', () async {
    final client = SuiClient(Constants.devnetAPI);

    final obj = await client.getObject('0x0d49dbda185cd0941b71315edb594276731f21b2232d8713f319b02c462a2da7',
      options: SuiObjectDataOptions(showContent: true)
    );

    final objs = await client.multiGetObjects([
      '0x0d49dbda185cd0941b71315edb594276731f21b2232d8713f319b02c462a2da7',
      '0x922ec73939b3288f6da39ebefb0cb88c6c54817441254d448bd2491ac4dd0cbd'
    ], options: SuiObjectDataOptions(showType: true));

  });

  test('test get transaction', () async {
    final client = SuiClient(Constants.devnetAPI);
    
    final txn = await client.getTransactionBlock('6oH779AUs2WpwW77xCVGbYqK1FYVamRqHjV6A5wCV8Qj',
      options: SuiTransactionBlockResponseOptions(showEffects: true)
    );

    final txns = await client.multiGetTransactionBlocks([
      '9znMGToLRRa8yZvjCUfj1FJmq4gpb8QwpibFAUffuto1',
      '4CEFMajEtM62MthwY1xR3Bcddoh2h5wc7jeKEy7WWsbv'
    ], options: SuiTransactionBlockResponseOptions(showInput: true, showEffects: true));

  });

  test('test get checkpoints', () async {
    final client = SuiClient(Constants.devnetAPI);
    
    final checkpoint = await client.getCheckpoint('338000');
    print(checkpoint.sequenceNumber);
    print(checkpoint.timestampMs);
    print(checkpoint.transactions.length);

    final checkpoints = await client.getCheckpoints(descendingOrder: true);
    for (var cp in checkpoints.data) {
      print(cp.sequenceNumber);
      print(cp.timestampMs);
      print(cp.transactions.length);
    }

  });

  test('test get coins', () async {
    final client = SuiClient(Constants.devnetAPI);
    
    final coins = await client.getCoins(
      '0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2',
      coinType: SUI_TYPE_ARG);

    final allCoins = await client.getAllCoins('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');

    final suiBalance = await client.getBalance('0xa2d8bb82df40770ac5bc8628d8070b041a13386fef17db27b32f3b0f316ae5a2');

  });

  test('test querying events', () async {
    final client = SuiClient(Constants.mainnetAPI);
    final events = await client.queryEvents({ "Sender": "0x02a212de6a9dfa3a69e22387acfbafbb1a9e591bd9d636e7895dcfc8de05f331" }, limit: 2);
    debugPrint(events.data.length.toString());

    final events2 = await client.queryEventsByFilter(
      EventFilter(sender: "0x02a212de6a9dfa3a69e22387acfbafbb1a9e591bd9d636e7895dcfc8de05f331"), 
      limit: 2
    );
    debugPrint(events2.data.length.toString());
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
    final suiBalance = await client.getBalance(account.getAddress());
    if (suiBalance.totalBalance == BigInt.zero) {
        final faucet = FaucetClient(Constants.faucetDevAPI);
        final resp = await faucet.requestSuiFromFaucetV0(account.getAddress());
        assert(resp.transferredGasObjects.isNotEmpty);
    }

    final tx = TransactionBlock();
    tx.setGasBudget(BigInt.from(2000000));

    final coin = tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(1000)]));
    tx.add(Transactions.transferObjects([coin], tx.pureAddress(recipient)));

    final waitForLocalExecutionTx = await client.signAndExecuteTransactionBlock(account, tx);
    debugPrint(waitForLocalExecutionTx.digest);
  });

}
