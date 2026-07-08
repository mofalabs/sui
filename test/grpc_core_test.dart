import 'package:flutter_test/flutter_test.dart';
import 'package:sui/client/network.dart';
import 'package:sui/grpc/sui_grpc_client.dart';

/// Phase-2 integration tests: CoreClient read methods over gRPC-web on testnet.
/// Run with: flutter test test/grpc_core_test.dart
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.testnet);

  const clock =
      '0x0000000000000000000000000000000000000000000000000000000000000006';
  const framework =
      '0x0000000000000000000000000000000000000000000000000000000000000005';

  test('getServiceInfo / getChainIdentifier', () async {
    final info = await client.core.getServiceInfo();
    print('chain=${info.chain} chainId=${info.chainId} epoch=${info.epoch} '
        'height=${info.checkpointHeight}');
    expect(info.chain, equals('testnet'));
    expect(await client.getChainIdentifier(), equals(info.chainId));
  });

  test('getReferenceGasPrice (via getEpoch)', () async {
    final rgp = await client.getReferenceGasPrice();
    print('referenceGasPrice=$rgp');
    expect(rgp.toInt(), greaterThan(0));
  });

  test('getObjects (batch) returns Clock', () async {
    final results = await client.getObjects([clock]);
    expect(results, hasLength(1));
    expect(results.single.hasObject(), isTrue);
    expect(results.single.object.objectType, endsWith('::clock::Clock'));
  });

  test('listBalances', () async {
    final resp = await client.listBalances(framework);
    print('balances=${resp.balances.length}');
    expect(resp.balances, isNotEmpty);
    expect(resp.balances.first.coinType, isNotEmpty);
  });

  test('getCoinInfo for SUI', () async {
    final info = await client.getCoinInfo('0x2::sui::SUI');
    print('metadata symbol=${info.metadata.symbol} decimals=${info.metadata.decimals}');
    expect(info.metadata.symbol, equalsIgnoringCase('SUI'));
  });

  test('listOwnedObjects', () async {
    final resp = await client.listOwnedObjects(framework, pageSize: 5);
    print('ownedObjects=${resp.objects.length} nextPage=${resp.nextPageToken.isNotEmpty}');
    // framework address may own 0 objects; call must still succeed.
    expect(resp.objects.length, greaterThanOrEqualTo(0));
  });
}
