import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

/// Smoke test against MAINNET — the network the mofa wallet uses by default.
void main() {
  final client = SuiGrpcCompat(SuiNetwork.mainnet);
  const addr =
      '0x0000000000000000000000000000000000000000000000000000000000000005';

  test('mainnet chain id + gas price', () async {
    print('chainId=${await client.getChainIdentifier()}');
    print('gasPrice=${await client.getReferenceGasPrice()}');
  });

  test('mainnet balance / coins', () async {
    final b = await client.getBalance(addr);
    print('balance=${b.totalBalance} ${b.coinType}');
    final coins = await client.getCoins(addr);
    print('coins=${coins.data.length}');
  });

  test('mainnet coin metadata', () async {
    final m = await client.getCoinMetadata('0x2::sui::SUI');
    print('metadata=${m?.symbol}/${m?.decimals}');
    expect(m?.symbol, equalsIgnoringCase('SUI'));
  });

  test('mainnet validators (GraphQL)', () async {
    final state = await client.getLatestSuiSystemState();
    print('validators=${state.activeValidators.length}');
    expect(state.activeValidators, isNotEmpty);
  });
}
