import 'package:flutter_test/flutter_test.dart';
import 'package:sui/client/network.dart';
import 'package:sui/graphql/sui_graphql_client.dart';

/// LIVE integration tests against Mysten's public GraphQL endpoint
/// (`graphql.testnet.sui.io`). These cover the query patterns full nodes cannot
/// serve over gRPC (filtered transaction/event queries).
///
/// Run with: flutter test test/graphql_live_test.dart
void main() {
  final client = SuiGraphQLClient.forNetwork(SuiNetwork.testnet);

  test('getChainIdentifier matches testnet', () async {
    final id = await client.getChainIdentifier();
    print('chainIdentifier=$id');
    // testnet genesis digest (also returned by gRPC getServiceInfo).
    expect(id, '69WiPg3DAQiwdxfncX6wYQ2siKwAe6L9BZthQea3JNMD');
  });

  test('queryTransactionsByAddress returns a page of digests', () async {
    // 0x0...0 (the "0x0" address) has transactions on testnet (system txs).
    final page = await client.queryTransactionsByAddress(
      '0x0000000000000000000000000000000000000000000000000000000000000000',
      first: 3,
    );
    print('tx digests=${page.digests.length} hasNextPage=${page.hasNextPage}');
    expect(page.digests, isNotEmpty);
    for (final d in page.digests) {
      expect(d, isNotEmpty);
    }
  });

  test('queryEventsByModule returns events for an active module', () async {
    // Which modules have recent events depends on live testnet activity, so
    // discover one from the unfiltered event stream first, then verify the
    // module filter path returns its events.
    final recent = await client.transport.query(r'''
      query {
        events(first: 20) {
          nodes { transactionModule { name package { address } } }
        }
      }
    ''');
    final nodes =
        ((recent['events'] as Map)['nodes'] as List).cast<Map<String, dynamic>>();
    expect(nodes, isNotEmpty);
    final module = nodes.first['transactionModule'] as Map<String, dynamic>;
    final packageId = module['package']['address'] as String;
    final moduleName = module['name'] as String;

    final events =
        await client.queryEventsByModule(packageId, moduleName, first: 3);
    print('events=${events.length} for $packageId::$moduleName');
    expect(events, isNotEmpty);
    final first = events.first;
    expect(first['transactionModule'], isNotNull);
    expect(first['contents'], isNotNull);
  });

  test('queryTransactionsByObject returns object history', () async {
    // 0x6 (Clock) is touched by many transactions.
    final page = await client.queryTransactionsByObject(
      '0x0000000000000000000000000000000000000000000000000000000000000006',
      first: 3,
    );
    print('object tx digests=${page.digests.length}');
    expect(page.digests, isNotEmpty);
  });

  test('getEpochSummary returns current epoch', () async {
    final e = await client.getEpochSummary();
    print('epochId=${e.epochId} rgp=${e.referenceGasPrice} '
        'totalTx=${e.totalTransactions}');
    expect(e.epochId, greaterThan(0));
    expect(e.referenceGasPrice, greaterThan(BigInt.zero));
  });

  test('getActiveValidators returns validators with stake/voting power',
      () async {
    final vs = await client.getActiveValidators(first: 5);
    print('validators=${vs.length} first="${vs.first.name}" '
        'votingPower=${vs.first.votingPower} '
        'poolSui=${vs.first.stakingPoolSuiBalance}');
    expect(vs, isNotEmpty);
    expect(vs.first.suiAddress, isNotNull);
    expect(vs.first.votingPower, greaterThan(0));
    expect(vs.first.stakingPoolSuiBalance, greaterThan(BigInt.zero));
  });

  test('getStakes returns a (possibly empty) list without error', () async {
    // 0x5 holds no StakedSui; the query must still succeed and parse.
    final stakes = await client.getStakes(
      '0x0000000000000000000000000000000000000000000000000000000000000005',
    );
    print('stakes=${stakes.length}');
    expect(stakes, isA<List>());
  });
}
