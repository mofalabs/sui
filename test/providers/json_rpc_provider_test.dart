
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/providers/json_rpc_provider.dart';

void main() {

  const address = '0x8b97863daa9e05bc41adad8f909fc14ca9370780';

  test('test getRpcApiVersion', () async {
    final provider = JsonRpcProvider(Constants.devnetAPI);
    final resp = await provider.getRpcApiVersion();
    expect(resp.major == 0, true);
    expect(resp.minor == 14, true);
    expect(resp.patch == 2, true);
  });

  test('test getTransactions', () async {
    final provider = JsonRpcProvider(Constants.devnetAPI);
    final resp = await provider.getTransactions(address);
    print(resp);
  });

  test('test getTransactionWithEffects', () async {
    final provider = JsonRpcProvider(Constants.devnetAPI);
    final txns = await provider.getTransactions(address);
    expect(txns.length > 0, true);
    final resp = await provider.getTransactionWithEffects(txns[0]);
    expect(resp["certificate"]["transactionDigest"] == txns[0], true);
  });

  test('test getTransactionWithEffects', () async {
    final provider = JsonRpcProvider(Constants.devnetAPI);
    final txs = await provider.getTransactions(address);
    final resp = await provider.getTransactionWithEffectsBatch(txs.toList());
    expect(txs.length == resp.length, true);
  });

  test('test getObjectsOwnedByAddress', () async {
    final provider = JsonRpcProvider(Constants.devnetAPI);
    final resp = await provider.getObjectsOwnedByAddress(address);
    expect(resp.length >= 0, true);
  });

  test('test getObject by objectId', () async {
    final provider = JsonRpcProvider(Constants.devnetAPI);
    final objectsID = await provider.getObjectsOwnedByAddress(address);
    final objectId = objectsID[0]["objectId"];
    final resp = await provider.getObject(objectId);
    expect(resp['details']['data']['fields']['id']['id'] == objectId, true);
  });

  test('test getObjectBatch', () async {
    final provider = JsonRpcProvider(Constants.devnetAPI);
    final objectsID = await provider.getObjectsOwnedByAddress(address);
    final ids = <String>[];
    for (var item in objectsID) {
      ids.add(item["objectId"]);
    }
    final resp = await provider.getObjectBatch(ids);
    expect(resp.length == ids.length, true);
  });

}