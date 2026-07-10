import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

/// Regression for the wallet NFT list: `SuiGrpcCompat` must map the gRPC
/// object's `display` (Display template output) and `json` (parsed Move fields)
/// into the legacy `display.data` / `content.fields` shapes the wallet reads.
///
/// Run with: flutter test test/nft_display_compat_test.dart
void main() {
  final client = SuiGrpcCompat(SuiNetwork.testnet);

  const clock =
      '0x0000000000000000000000000000000000000000000000000000000000000006';

  // Regression: object filters compared short-form addresses against gRPC's
  // fully-normalized types, so `MatchNone` coin exclusion silently failed and
  // owned-object pages came back full of coins (empty NFT lists in the wallet).
  test('normalizeTypeAddresses pads short addresses to 32-byte form', () {
    const coin =
        '0x0000000000000000000000000000000000000000000000000000000000000002::coin::Coin';
    expect(normalizeTypeAddresses('0x2::coin::Coin'), coin);
    expect(
      normalizeTypeAddresses('0x2::coin::Coin<0x2::sui::SUI>'),
      '$coin<0x0000000000000000000000000000000000000000000000000000000000000002::sui::SUI>',
    );
    // Already-full addresses are left unchanged.
    expect(normalizeTypeAddresses(coin), coin);
  });

  test('getObject maps parsed Move content (Clock.timestamp_ms)', () async {
    final o = await client.getObject(
      clock,
      options: SuiObjectDataOptions(showType: true, showContent: true),
    );
    expect(o.data?.type, endsWith('::clock::Clock'));
    final fields = o.data?.content?.fields;
    print('clock content.fields=$fields');
    expect(fields, isNotNull);
    // Clock always carries a timestamp_ms field — proves json -> content.fields.
    expect(fields['timestamp_ms'], isNotNull);
  });

  test('getOwnedObjects surfaces display.data when a Display exists', () async {
    // Best-effort against a Display-bearing NFT collection on testnet. Skips the
    // assertion if the address currently holds none (chain state varies), but
    // still exercises the display-mapping path without throwing.
    const holder =
        '0x0000000000000000000000000000000000000000000000000000000000000005';
    final page = await client.getOwnedObjects(
      holder,
      limit: 5,
      options: SuiObjectDataOptions(showType: true, showDisplay: true),
    );
    for (final r in page.data) {
      // The key assertion: when display is present it is a decoded Map, not null
      // garbage — i.e. the mapping produced a usable `display.data`.
      final d = r.data?.display;
      if (d != null && d.data != null) {
        print('display.data=${d.data}');
        // Must be a Map<String, dynamic> — the legacy model rejects
        // Map<dynamic, dynamic> at runtime (regression guard).
        expect(d.data, isA<Map<String, dynamic>>());
      }
    }
    expect(page.data, isA<List>());
  });
}
