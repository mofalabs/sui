import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/providers/json_rpc_provider.dart';

void main() {

  const address = '0x936accb491f0facaac668baaedcf4d0cfc6da1120b66f77fa6a43af718669973';

  late JsonRpcProvider provider;

  setUp(() {
    provider = JsonRpcProvider(Constants.devnetAPI);
  });

  test('test getRpcApiVersion', () async {
    final resp = await provider.getRpcApiVersion();
    expect(resp.major >= 0, true);
    expect(resp.minor >= 15, true);
    expect(resp.patch >= 0, true);
  });

  test('test getTransactions', () async {
    final resp = await provider.getTransactions(address);
    expect(resp.isNotEmpty, true);
  });

  test('test getTransactionWithEffects', () async {
    final txns = await provider.getTransactions(address);
    expect(txns.isNotEmpty, true);
    final resp = await provider.getTransactionBlock(txns[0].digest);
    expect(txns[0].digest == resp.digest, true);
  });

  test('test getTransactionWithEffectsBatch', () async {
    final txs = await provider.getTransactions(address);
    List<String> txDigests= [];
    for (var element in txs) {
      txDigests.add(element.digest);
    }
    final resp = await provider.getTransactionBlockBatch(txDigests);
    expect(txs.length == resp.length, true);
  });

  test('test getOwnedObjects', () async {
    final resp = await provider.getOwnedObjects(address);
    expect(resp.isNotEmpty, true);
  });

  test('test getObject by objectId', () async {
    final objectsID = await provider.getOwnedObjects(address);
    final objectId = objectsID[0].objectId;
    final resp = await provider.getObject(objectId);
    expect(resp.data?.objectId == objectId, true);
  });

  test('test getObjectRef by objectId', () async {
    final objectsID = await provider.getOwnedObjects(address);
    final objectId = objectsID[0].objectId;
    final resp = await provider.getObjectRef(objectId);
    expect(resp?.objectId == objectId, true);
  });

  test('test getObjectBatch', () async {
    final objectsID = await provider.getOwnedObjects(address);
    final ids = objectsID.map((obj) => obj.objectId).toList();
    final resp = await provider.getObjectBatch(ids);
    expect(resp.length == ids.length, true);
  });

  test('test getTotalTransactionBlocks', () async {
    final txNum = await provider.getTotalTransactionBlocks();
    expect(txNum > BigInt.zero, true);
  });

  test('test getCoinBalancesOwnedByAddress', () async {
    final result = await provider.getCoinBalancesOwnedByAddress(address);
    expect(result.isNotEmpty, true);
  });

  test('test getObjectsOwnedByObject', () async {
    final objectsID = await provider.getOwnedObjects(address);
    final objectId = objectsID[0].objectId;
    final result = await provider.getObject(objectId);
    expect(result.data?.objectId == objectId, true);
  });

  test('test getEventsByTransaction', () async {
    const txn = '6oQhbs5miNLuMgun1ZK4ybvx1r7aXx5UdywLqNw36qZd';
    final result = await provider.getEvents(txn);
    expect(result.data.isNotEmpty, true);
    expect(result.data.first.txDigest == txn, true);
  });

}