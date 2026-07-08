import 'package:flutter_test/flutter_test.dart';
import 'package:sui/client/network.dart';
import 'package:sui/grpc/sui_grpc_client.dart';

/// LIVE test of server-streaming gRPC-web: subscribe to executed checkpoints
/// from a testnet full node and read the first one. Replaces the deprecated
/// JSON-RPC WebSocket subscriptions.
///
/// Run with: flutter test test/grpc_subscribe_test.dart
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.testnet);

  test('subscribeCheckpoints yields a checkpoint', () async {
    final stream = client.subscribeCheckpoints(
      readMask: const ['sequence_number', 'digest'],
    );

    final first = await stream
        .map((r) => r.checkpoint)
        .firstWhere((_) => true)
        .timeout(const Duration(seconds: 40));

    print('checkpoint seq=${first.sequenceNumber} digest=${first.digest}');
    expect(first.sequenceNumber.toInt(), greaterThan(0));
    expect(first.digest, isNotEmpty);
  }, timeout: const Timeout(Duration(seconds: 60)));
}
