import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction.dart';
import 'package:sui/client/network.dart';
import 'package:sui/grpc/sui_grpc_client.dart';

/// MVR (Move Registry) wiring: `Transaction.resolveNames` rewrites `@org/app`
/// package names and MVR-named type args in moveCall commands, and the core
/// client's resolveType/resolvePackage hooks route through MVR.
void main() {
  test('Transaction.resolveNames rewrites moveCall package + type args',
      () async {
    final tx = Transaction();
    tx.moveCall(
      '@org/app::counter::increment',
      typeArguments: ['@org/app::counter::Counter', '0x2::sui::SUI'],
    );

    final requestedPackages = <String>[];
    final requestedTypes = <String>[];
    await tx.resolveNames(
      resolvePackage: (p) async {
        requestedPackages.add(p);
        return p == '@org/app' ? '0xPKG' : p;
      },
      resolveType: (t) async {
        requestedTypes.add(t);
        return t.replaceAll('@org/app', '0xPKG');
      },
    );

    // Only the MVR-named entries are sent to the resolvers.
    expect(requestedPackages, ['@org/app']);
    expect(requestedTypes, ['@org/app::counter::Counter']); // 0x2::sui::SUI skipped

    final mc = tx
        .getData()
        .commands!
        .firstWhere((c) => c['MoveCall'] != null)['MoveCall'] as Map;
    expect(mc['package'], '0xPKG');
    expect(mc['typeArguments'][0], '0xPKG::counter::Counter');
    expect(mc['typeArguments'][1], '0x2::sui::SUI'); // unchanged
  });

  test('resolveNames is a no-op without MVR names', () async {
    final tx = Transaction();
    tx.moveCall('0x2::clock::timestamp_ms');
    var called = false;
    await tx.resolveNames(
      resolvePackage: (p) async {
        called = true;
        return p;
      },
      resolveType: (t) async {
        called = true;
        return t;
      },
    );
    expect(called, isFalse);
  });

  test('core.resolvePackage routes through MVR (mainnet) + passthrough',
      () async {
    final mainnet = SuiGrpcClient(network: SuiNetwork.mainnet);
    // passthrough for non-MVR input
    expect(await mainnet.core.resolvePackage('0x2'), '0x2');
    expect(await mainnet.core.resolveType('0x2::sui::SUI'), '0x2::sui::SUI');
    // real MVR resolution
    final pkg = await mainnet.core.resolvePackage('@mvr/core');
    print('@mvr/core -> $pkg');
    expect(pkg, startsWith('0x'));
    expect(pkg.length, greaterThan(60));
  });
}
