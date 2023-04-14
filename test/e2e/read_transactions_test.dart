import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/providers/json_rpc_provider.dart';
import 'package:sui/types/transactions.dart';

void main() {
  const address =
      '0x936accb491f0facaac668baaedcf4d0cfc6da1120b66f77fa6a43af718669973';
  late JsonRpcProvider provider;
  List<SuiTransactionBlockResponse> transactions = [];

  setUp(() async {
    provider = JsonRpcProvider(Constants.devnetAPI);
    var list = await provider
        .queryTransactionBlocks({'FromAddress': address}, limit: 10);
    transactions.addAll(list.data);
  });

  test('Get Total Transactions', () async {
    final numTransactions = await provider.getTotalTransactionBlocks();
    expect(numTransactions > BigInt.zero, true);
  });

  test('Get Transactions', () async {
    final digest = transactions[0].digest;
    final txn = await provider.getTransactionBlock(digest);
    expect(txn.digest == digest, true);
  });

  test('Multi Get Pay Transactions', () async {
    var options = SuiTransactionBlockResponseOptions(showBalanceChanges: true);
    List<SuiTransactionBlockResponse> ts =
        (await provider.queryTransactionBlocks(
      {'FromAddress': address},
      options: options,
      limit: 10,
    )).data;
    final digests = ts.map((t) => t.digest).toList();
    final txns =
        await provider.multiGetTransactionBlocks(digests, options: options);
    for (var txn in txns) {
      expect(txn.balanceChanges.isNotEmpty, true);
    }
    expect(txns.length == digests.length, true);
  });

  test('Query Transactions with opts', () async {
    final options = SuiTransactionBlockResponseOptions(
      showEvents: true,
      showEffects: true,
    );
    final resp = await provider.queryTransactionBlocks(
      {'FromAddress': address},
      options: options,
      limit: 1,
    );
    final digest = resp.data[0].digest;
    final resp2 = await provider.getTransactionBlock(
      digest,
      options,
    );
    expect(resp.data[0].effects?.status.status == resp2.effects?.status.status,
        true);
  });

  test('Get Transactions', () async {
    final resp = await provider.queryTransactionBlocks(
      {'FromAddress': address},
      limit: 10,
    );
    expect(resp.data.isNotEmpty, true);
  });

  test('Genesis exists', () async {
    final allTransactions = await provider.queryTransactionBlocks(
        {'FromAddress': address},
        limit: 1, descendingOrder: false);
    final resp = await provider.getTransactionBlock(
      allTransactions.data[0].digest,
      SuiTransactionBlockResponseOptions(showInput: true),
    );
    final txKind = getTransactionKind(resp)!;
    expect(txKind['kind'] != null, true);
  });
}
