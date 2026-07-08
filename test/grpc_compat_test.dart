import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

/// Verifies the SuiGrpcCompat migration bridge end-to-end against a real
/// testnet full node + GraphQL endpoint, returning legacy model types over the
/// new gRPC-web transport. Mirrors how the mofa wallet consumes the client.
///
/// Run with: flutter test test/grpc_compat_test.dart
void main() {
  final client = SuiGrpcCompat(SuiNetwork.testnet);

  // A framework address that holds SUI + objects on testnet.
  const addr =
      '0x0000000000000000000000000000000000000000000000000000000000000005';
  const clock =
      '0x0000000000000000000000000000000000000000000000000000000000000006';

  test('getChainIdentifier / getReferenceGasPrice', () async {
    expect(await client.getChainIdentifier(), isNotEmpty);
    expect(await client.getReferenceGasPrice(), greaterThan(BigInt.zero));
  });

  test('getBalance / getAllBalance -> CoinBalance', () async {
    final b = await client.getBalance(addr);
    print('balance coinType=${b.coinType} total=${b.totalBalance}');
    expect(b.coinType, endsWith('::sui::SUI'));
    final all = await client.getAllBalance(addr);
    expect(all, isNotEmpty);
  });

  test('getCoins -> PaginatedCoins', () async {
    final coins = await client.getCoins(addr);
    print('coins=${coins.data.length}');
    expect(coins.data, isNotEmpty);
    expect(coins.data.first.coinObjectId, isNotEmpty);
    expect(int.tryParse(coins.data.first.balance), isNotNull);
  });

  test('getCoinMetadata -> CoinMetadataStruct', () async {
    final m = await client.getCoinMetadata('0x2::sui::SUI');
    print('metadata symbol=${m?.symbol} decimals=${m?.decimals}');
    expect(m?.symbol, equalsIgnoringCase('SUI'));
    expect(m?.decimals, 9);
  });

  test('getObject / multiGetObjects -> SuiObjectResponse', () async {
    final o = await client.getObject(clock,
        options: SuiObjectDataOptions(showType: true, showOwner: true));
    print('object type=${o.data?.type} owner=${o.data?.owner}');
    expect(o.data?.type, endsWith('::clock::Clock'));
    final multi = await client.multiGetObjects([clock]);
    expect(multi, hasLength(1));
  });

  test('getOwnedObjects with client-side filter', () async {
    // Exclude Coin objects (MatchNone) — exercises the filter matcher.
    final page = await client.getOwnedObjects(addr,
        limit: 10,
        options: SuiObjectDataOptions(showType: true),
        filter: {
          'MatchNone': [
            {'StructType': '0x2::coin::Coin'}
          ]
        });
    print('owned (non-coin)=${page.data.length}');
    expect(page.data, isA<List>());
    for (final r in page.data) {
      expect(r.data?.type?.startsWith('0x2::coin::Coin'), isNot(true));
    }
  });

  test('getLatestSuiSystemState + getValidatorsApy', () async {
    final state = await client.getLatestSuiSystemState();
    print('validators=${state.activeValidators.length}');
    expect(state.activeValidators, isNotEmpty);
    expect(state.activeValidators.first.suiAddress, isNotNull);
    final apy = await client.getValidatorsApy();
    expect(apy.apys, isNotEmpty);
  });

  test('getTransactions -> digests', () async {
    final (txs, cursor, _) = await client.getTransactions(
      '0x0000000000000000000000000000000000000000000000000000000000000000',
      limit: 3,
    );
    print('txs=${txs.length}');
    expect(txs, isNotEmpty);
    expect(txs.first.digest, isNotEmpty);
  });

  test('getObject on a non-existent id -> notExists (no throw)', () async {
    // Regression: a missing object must return {error: notExists} like the
    // legacy JSON-RPC SuiClient, not throw — wallets rely on this to tell an
    // account address (no object) apart from an object address.
    const missing =
        '0x9f1a2b3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a';
    final r = await client.getObject(missing);
    expect(r.data, isNull);
    expect(r.error, isNotNull);
  });
}
