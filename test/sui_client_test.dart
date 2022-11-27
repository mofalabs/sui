
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/cryptography/publickey.dart';
import 'package:sui/providers/json_rpc_provider.dart';
import 'package:sui/rpc/faucet_client.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/sui_client.dart';

void main() {

  const test_mnemonics =
  'result crisp session latin must fruit genuine question prevent start coconut brave speak student dismiss';

  const DEFAULT_RECIPIENT = '0x36096be6a0314052931babed39f53c0666a6b0df';

  const DEFAULT_GAS_BUDGET = 20000;

  final data = Base64DataBuffer.fromString('hello world');

  test('test secp256k1 account generate from mnemonics', () {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.Secp256k1);
    expect(account.getAddress() == '0xed17b3f435c03ff69c2cdc6d394932e68375f20f', true);
  });

  test('test ed25519 account generate from mnemonics', () {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.ED25519);
    expect(account.getAddress() == '0x1a4623343cd42be47d67314fce0ad042f3c82685', true);
  });

  test('test secp256k1 account generate', () {
    final account = SuiAccount.secp256k1Account();
    final signature = account.signData(data);
    bool success = account.verify(data, signature);
    expect(success, true);
  });

  test('test ed25519 account generate', () {
    final account = SuiAccount.ed25519Account();
    final signature = account.signData(data);
    bool success = account.verify(data, signature);
    expect(success, true);
  });

  test('test publish package', () async {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.Secp256k1);
    final client = SuiClient(account, Constants.devnetAPI);
    final bytecodes = ['oRzrCwYAAAAKAQAIAggMAxQuBEICBUQrB2+IAQj3ASgKnwIKDKkCkwENvAMEAAABAQECAQMABAgAAwYCAAENBAAABQABAAAHAgEAAAgDAQAACQQFAAAKBgEAAAsEBwABDgIIAAMPCQUAAhALAQEICAoCBggAAwABBwgBAQcIAAEGCAABBQMHCAADBwgBAQMBCAIBBggBAQgAAQkAB2NvdW50ZXIGb2JqZWN0CHRyYW5zZmVyCnR4X2NvbnRleHQHQ291bnRlcgxhc3NlcnRfdmFsdWUJVHhDb250ZXh0BmNyZWF0ZQlpbmNyZW1lbnQFb3duZXIJc2V0X3ZhbHVlBXZhbHVlAmlkA1VJRANuZXcGc2VuZGVyDHNoYXJlX29iamVjdAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAIAAgMMCAIJBQsDAAEEAAEJCwAQABQLASEDCAYAAAAAAAAAACcCAQEEAAEJCgARBgsALhEHBgAAAAAAAAAAEgA4AAICAQQAAQkKABAAFAYBAAAAAAAAABYLAA8AFQIDAQAAAQQLABABFAIEAQQAAREKABABFAsCLhEHIQMMCwABBgAAAAAAAAAAJwsBCwAPABUCBQEAAAEECwAQABQCAAIAAQA='];
    final txn = PublishTransaction(bytecodes, 10000);
    final waitForLocalExecutionTx = await client.publish(txn);
    final creates = waitForLocalExecutionTx.effectsCert!.effects.effects.events!;
    expect(creates.isNotEmpty, true);
    final publishMap = creates.firstWhere((e) => e['publish'] != null);
    final packageId = publishMap['publish']['packageId'].toString();
    expect(packageId.isNotEmpty, true);
  });

  test('test move contract call', () async {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.Secp256k1);
    final client = SuiClient(account, Constants.devnetAPI);
    final createSharedCounter = MoveCallTransaction(
      '0xa1a985ed4ce15503f36625c5996817337dc9e551', 
      'counter',
      'create',
      [],
      [],
      1000
    );
    final createCounterResp = await client.executeMoveCall(createSharedCounter);
    final shareObj = createCounterResp.effectsCert!.effects.effects.created![0];
    final shareObjId = shareObj.reference.objectId;

    final assertValueCall = MoveCallTransaction(
      '0xa1a985ed4ce15503f36625c5996817337dc9e551', 
      'counter',
      'assert_value',
      [],
      [shareObjId, 0],
      1000
    );
    var assertValueResp = await client.executeMoveCall(assertValueCall);
    var error = assertValueResp.effectsCert!.effects.effects.status.error;
    expect(error == null, true);

    final incrementValueCall = MoveCallTransaction(
      '0xa1a985ed4ce15503f36625c5996817337dc9e551', 
      'counter',
      'increment',
      [],
      [shareObjId],
      1000
    );
    final incrementValueResp = await client.executeMoveCall(incrementValueCall);
    error = incrementValueResp.effectsCert!.effects.effects.status.error;
    expect(error == null, true);
    
    assertValueResp = await client.executeMoveCall(assertValueCall);
    error = assertValueResp.effectsCert!.effects.effects.status.error;
    expect(error != null, true);
  });

  test('test pay sui with secp256k1', () async {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.Secp256k1);
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
      [DEFAULT_RECIPIENT],
      [1000],
      DEFAULT_GAS_BUDGET
    );

    final gasBudget = await client.getGasCostEstimation(txn);
    txn.gasBudget = gasBudget;

    final waitForLocalExecutionTx = await client.paySui(txn);
    expect(waitForLocalExecutionTx.effectsCert!.confirmedLocalExecution, true);
  });

  test('test pay sui with ed25519', () async {
    final account = SuiAccount.fromMnemonics(test_mnemonics, SignatureScheme.ED25519);
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
      [DEFAULT_RECIPIENT],
      [1000],
      DEFAULT_GAS_BUDGET
    );

    final gasBudget = await client.getGasCostEstimation(txn);
    txn.gasBudget = gasBudget;

    final waitForLocalExecutionTx = await client.paySui(txn);
    expect(waitForLocalExecutionTx.effectsCert!.confirmedLocalExecution, true);
  });

}