import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

/// Verifies the custom gRPC-web `endpoint` override (0.4.1): a client typed for
/// one network but pointed at another network's full node actually talks to the
/// override, not the network's default endpoint.
///
/// Run with: flutter test test/grpc_custom_endpoint_test.dart
void main() {
  const testnetEndpoint = 'https://fullnode.testnet.sui.io:443';

  test('SuiGrpcClient endpoint override routes reads to the custom node',
      () async {
    // Stable per-network chain identifiers via the standard endpoints.
    final mainnetId =
        await SuiGrpcClient(network: SuiNetwork.mainnet).getChainIdentifier();
    final testnetId =
        await SuiGrpcClient(network: SuiNetwork.testnet).getChainIdentifier();
    expect(mainnetId, isNotEmpty);
    expect(testnetId, isNotEmpty);
    expect(mainnetId, isNot(testnetId));

    // A mainnet-typed client overridden to the testnet endpoint must report the
    // testnet chain id — proving the call goes to `endpoint`, not the default.
    final overridden = await SuiGrpcClient(
      network: SuiNetwork.mainnet,
      endpoint: testnetEndpoint,
    ).getChainIdentifier();
    expect(overridden, testnetId);
    expect(overridden, isNot(mainnetId));
  });

  test('SuiGrpcCompat forwards the endpoint override to gRPC', () async {
    final testnetId =
        await SuiGrpcClient(network: SuiNetwork.testnet).getChainIdentifier();
    final compat =
        SuiGrpcCompat(SuiNetwork.mainnet, endpoint: testnetEndpoint);
    expect(await compat.getChainIdentifier(), testnetId);
  });
}
