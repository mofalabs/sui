
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/providers/json_rpc_provider.dart';

void main() {

  const address = '0x8b97863daa9e05bc41adad8f909fc14ca9370780';

  late JsonRpcProvider provider;

  setUp(() {
    provider = JsonRpcProvider(Constants.devnetAPI);
  });

  test('test getRpcApiVersion', () async {
    final resp = await provider.getRpcApiVersion();
    expect(resp.major >= 0, true);
    expect(resp.minor >= 15, true);
    expect(resp.patch >= 2, true);
  });

  test('test getTransactions', () async {
    final resp = await provider.getTransactions(address);
    expect(resp.isNotEmpty, true);
  });

  test('test getTransactionWithEffects', () async {
    final txns = await provider.getTransactions(address);
    expect(txns.isNotEmpty, true);
    final resp = await provider.getTransactionWithEffects(txns[0]);
    expect(resp.certificate.transactionDigest == txns[0], true);
  });

  test('test getTransactionWithEffectsBatch', () async {
    final txs = await provider.getTransactions(address);
    final resp = await provider.getTransactionWithEffectsBatch(txs);
    expect(txs.length == resp.length, true);
  });

  test('test getObjectsOwnedByAddress', () async {
    final resp = await provider.getObjectsOwnedByAddress(address);
    expect(resp.isNotEmpty, true);
  });

  test('test getObject by objectId', () async {
    final objectsID = await provider.getObjectsOwnedByAddress(address);
    final objectId = objectsID[0].objectId;
    final resp = await provider.getObject(objectId);
    expect(resp.details.data.fields.id.id == objectId, true);
  });

  test('test getObjectBatch', () async {
    final objectsID = await provider.getObjectsOwnedByAddress(address);
    final ids = objectsID.map((obj) => obj.objectId).toList();
    final resp = await provider.getObjectBatch(ids);
    expect(resp.length == ids.length, true);
  });

}