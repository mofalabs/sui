import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

import 'utils/setup.dart';

void main() {
  const address =
      '0x936accb491f0facaac668baaedcf4d0cfc6da1120b66f77fa6a43af718669973';
  late SuiClient client;
  late TestToolbox toolbox;
  List<SuiTransactionBlockResponse> transactions = [];

  setUp(() async {
    toolbox = await setup();
    client = SuiClient(SuiUrls.devnet);
    var list = await client
        .queryTransactionBlocks({'FromAddress': address}, limit: 10);
    transactions.addAll(list.data);
  });

  test('Get Total Transactions', () async {
    final numTransactions = await client.getTotalTransactionBlocks();
    expect(numTransactions > BigInt.zero, true);
  });

  group('waitForTransaction', () {
		Future<SuiExecuteTransactionResponse> setupTransaction() {
			final tx = Transaction();
			final coin = tx.splitCoins(tx.gas, [tx.pureInt(1)]);
			tx.transferObjects([coin], tx.pureAddress(toolbox.address()));
			return toolbox.client.signAndExecuteTransactionBlock(
				SuiAccount(toolbox.keypair),
				tx
			);
		}

		test('can wait for transactions with WaitForEffectsCert', () async {
			final result = await setupTransaction();

			// Should succeed using wait
			final waited = await toolbox.client.waitForTransaction(result.digest);
			expect(waited.digest, result.digest);
		});

		test('abort signal doesnt throw after transaction is received', () async {
			final result = await setupTransaction();

			final waited = await toolbox.client.waitForTransaction(result.digest);
			final secondWait = await toolbox.client.waitForTransaction(result.digest, timeout: 2000);
			// wait for timeout to expire incase it causes an unhandled rejection
			await Future.delayed(const Duration(milliseconds: 2100));
			expect(waited.digest, result.digest);
			expect(secondWait.digest, result.digest);
		});
	});

  test('Get Transactions', () async {
    final digest = transactions[0].digest;
    final txn = await client.getTransactionBlock(digest);
    expect(txn.digest == digest, true);
  });

  test('Multi Get Pay Transactions', () async {
    var options = SuiTransactionBlockResponseOptions(showBalanceChanges: true);
    List<SuiTransactionBlockResponse> ts = (await client.queryTransactionBlocks(
      {'FromAddress': address},
      options: options,
      limit: 10,
    ))
        .data;
    final digests = ts.map((t) => t.digest).toList();
    final txns =
        await client.multiGetTransactionBlocks(digests, options: options);
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
    final resp = await client.queryTransactionBlocks(
      {'FromAddress': address},
      options: options,
      limit: 1,
    );
    final digest = resp.data[0].digest;
    final resp2 = await client.getTransactionBlock(
      digest,
      options: options,
    );
    expect(resp.data[0].effects?.status.status == resp2.effects?.status.status,
        true);
  });

  test('Get Transactions', () async {
    final resp = await client.queryTransactionBlocks(
      {'FromAddress': address},
      limit: 10,
    );
    expect(resp.data.isNotEmpty, true);
  });

  test('Genesis exists', () async {
    final allTransactions = await client.queryTransactionBlocks(
        {'FromAddress': address},
        limit: 1, descendingOrder: false);
    final resp = await client.getTransactionBlock(
      allTransactions.data[0].digest,
      options: SuiTransactionBlockResponseOptions(showInput: true),
    );
    final txKind = getTransactionKind(resp)!;
    expect(txKind['kind'] != null, true);
  });
}
