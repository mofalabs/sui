import 'package:flutter_test/flutter_test.dart';
import 'package:sui/client/network.dart';
import 'package:sui/grpc/sui_grpc_client.dart';

/// End-to-end POC: hits a real Sui testnet full node over gRPC-web.
/// Run with: flutter test test/grpc_web_poc_test.dart
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.testnet);

  test('getBalance (StateService) over gRPC-web', () async {
    // Sui framework address; balance may be zero but the call must succeed.
    const owner =
        '0x0000000000000000000000000000000000000000000000000000000000000005';
    final balance = await client.getBalance(owner);
    print('coinType=${balance.coinType} balance=${balance.balance} '
        'address=${balance.addressBalance} coin=${balance.coinBalance}');
    expect(balance.coinType, endsWith('::sui::SUI'));
    expect(balance.hasBalance(), isTrue);
  });

  test('getObject (LedgerService) over gRPC-web', () async {
    // 0x6 is the Clock shared object; always exists on every network.
    const clock =
        '0x0000000000000000000000000000000000000000000000000000000000000006';
    final object = await client.getObject(clock);
    print('objectId=${object.objectId} version=${object.version} '
        'type=${object.objectType} digest=${object.digest}');
    expect(object.objectId, endsWith('06'));
    expect(object.objectType, endsWith('::clock::Clock'));
  });
}
