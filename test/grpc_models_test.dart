import 'package:flutter_test/flutter_test.dart';
import 'package:sui/client/network.dart';
import 'package:sui/client/sui_models.dart';
import 'package:sui/grpc/sui_grpc_client.dart';

/// Transport-neutral model wrappers over gRPC (testnet).
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.testnet);

  test('balanceOf returns a normalized SuiBalance', () async {
    final b = await client.balanceOf(
      '0x0000000000000000000000000000000000000000000000000000000000000005',
    );
    print('coinType=${b.coinType} total=${b.totalBalance}');
    expect(b.coinType, endsWith('::sui::SUI'));
    expect(b.totalBalance, greaterThanOrEqualTo(BigInt.zero));
  });

  test('objectInfo returns a normalized SuiObjectInfo (shared Clock)', () async {
    final o = await client.objectInfo(
      '0x0000000000000000000000000000000000000000000000000000000000000006',
    );
    print('id=${o.objectId} v=${o.version} type=${o.type} '
        'ownerKind=${o.owner?.kind} initShared=${o.owner?.initialSharedVersion}');
    expect(o.type, endsWith('::clock::Clock'));
    expect(o.version, greaterThan(BigInt.zero));
    // 0x6 is a shared object.
    expect(o.owner?.kind, SuiOwnerKind.shared);
    expect(o.owner?.initialSharedVersion, isNotNull);
  });
}
