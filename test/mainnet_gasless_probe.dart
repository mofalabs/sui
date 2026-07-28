import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

/// Probes Sui mainnet gasless-stablecoin support. Run:
/// flutter test test/mainnet_gasless_probe.dart
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.mainnet);
  final compat = SuiGrpcCompat(SuiNetwork.mainnet);
  const usdc =
      '0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC';

  Future<void> probeFn(String module, String fn) async {
    try {
      final f = await client.getFunction('0x2', module, fn);
      print('  FOUND   0x2::$module::$fn  (params=${f.parameters.length})');
    } catch (e) {
      print('  MISSING 0x2::$module::$fn  -> ${e.toString().split('\n').first}');
    }
  }

  test('gasless functions present on mainnet?', () async {
    print('--- function probe (mainnet) ---');
    await probeFn('balance', 'send_funds');
    await probeFn('balance', 'redeem_funds');
    await probeFn('coin', 'send_funds');
    await probeFn('coin', 'redeem_funds');
  });

  test('getBalance returns addressBalance on mainnet?', () async {
    // Any address works to confirm the field is populated (0 is valid).
    for (final addr in [
      '0x0000000000000000000000000000000000000000000000000000000000000006',
    ]) {
      final b = await client.core.getBalance(addr, coinType: usdc);
      print('  addr=${addr.substring(0, 8)} total=${b.balance} '
          'addressBalance=${b.addressBalance} coinBalance=${b.coinBalance}');
    }
  });

  test('dump the resolved PTB for a coin-object USDC holder', () async {
    // 0x06 holds USDC entirely as coin objects (addressBalance=0), so this
    // exercises Path 2. Build kind-only to resolve the intent without gas, then
    // print the commands to locate the InvalidResultArity.
    const sender =
        '0x0000000000000000000000000000000000000000000000000000000000000006';
    final tx = Transaction();
    final bal = tx.balance(usdc, BigInt.from(10000), useGasCoin: false);
    tx.moveCall('0x2::balance::send_funds',
        typeArguments: [usdc], arguments: [bal, tx.pureAddress(sender)]);
    tx.setSender(sender);
    await tx.build(BuildOptions(
        client: compat.builderClient,
        onlyTransactionKind: true,
        limits: <String, dynamic>{}));
    final cmds = tx.getData().commands ?? [];
    for (var i = 0; i < cmds.length; i++) {
      final c = cmds[i] as Map;
      final kind = c.keys.firstWhere((k) => k != '\$kind', orElse: () => '?');
      print('  cmd[$i] $kind -> ${c[kind]}');
    }
  });

  test('full build+simulate a send_funds tx (mainnet) — node accepts now?',
      () async {
    const sender =
        '0x0000000000000000000000000000000000000000000000000000000000000006';
    try {
      final tx = Transaction();
      final bal = tx.balance(usdc, BigInt.from(10000), useGasCoin: false);
      tx.moveCall('0x2::balance::send_funds',
          typeArguments: [usdc], arguments: [bal, tx.pureAddress(sender)]);
      tx.setSender(sender);
      await tx.build(BuildOptions(
          client: compat.builderClient, limits: <String, dynamic>{}));
      print('  BUILD OK, resolved budget=${tx.getData().gasData.budget}');
    } catch (e) {
      print('  BUILD ERROR -> ${e.toString().split('\n').first}');
    }
  });
}
