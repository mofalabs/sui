
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
    expect(resp.patch >= 0, true);
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
    expect(resp.details.data.fields?.id.id == objectId, true);
  });

  test('test getRawObject by objectId', () async {
    final objectsID = await provider.getObjectsOwnedByAddress(address);
    final objectId = objectsID[0].objectId;
    final resp = await provider.getRawObject(objectId);
    expect(resp.details.data.bcsBytes!.isNotEmpty, true);
  });

  test('test getObjectRef by objectId', () async {
    final objectsID = await provider.getObjectsOwnedByAddress(address);
    final objectId = objectsID[0].objectId;
    final resp = await provider.getObjectRef(objectId);
    expect(resp?.digest.isNotEmpty ?? false, true);
  });

  test('test getObjectBatch', () async {
    final objectsID = await provider.getObjectsOwnedByAddress(address);
    final ids = objectsID.map((obj) => obj.objectId).toList();
    final resp = await provider.getObjectBatch(ids);
    expect(resp.length == ids.length, true);
  });

  test('test getTotalTransactionNumber', () async {
    final txNum = await provider.getTotalTransactionNumber();
    expect(txNum > 0, true);
  });

  test('test getTotalTransactionNumber', () async {
    int start = 1;
    int end = 10;
    final txns = await provider.getTransactionDigestsInRange(1, 10);
    expect(txns.length == end - start, true);
  });

  test('test getTransactionsForObject', () async {
    final objectsID = await provider.getObjectsOwnedByAddress(address);
    final objectId = objectsID[0].objectId;
    final txns = await provider.getTransactionsForObject(objectId);
    expect(txns.isNotEmpty, true);
  });

  test('test getCoinBalancesOwnedByAddress', () async {
    final result = await provider.getCoinBalancesOwnedByAddress(address);
    expect(result.isNotEmpty, true);
  });

  test('test getObjectsOwnedByObject', () async {
    final objectsID = await provider.getObjectsOwnedByAddress(address);
    final objectId = objectsID[0].objectId;
    final result = await provider.getObjectsOwnedByObject(objectId);
    expect(result.length >= 0, true);
  });

  test('test getEventsByTransaction', () async {
    const txn = 'AWsJPVBcugYHB1qwa7hKhDQ89oImX5lOxphXHphlud8=';
    final result = await provider.getEvents(txn);
    expect(result.data.isNotEmpty, true);
    expect(result.data.first.txDigest == txn, true);
  });

}