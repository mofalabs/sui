import 'package:flutter_test/flutter_test.dart';
import 'package:sui/client/network.dart';
import 'package:sui/grpc/sui_grpc_client.dart';
import 'package:sui/grpc/transport/grpc_web_transport.dart';

/// Extra read-method coverage: MovePackageService, LedgerService.GetCheckpoint,
/// NameService. All over gRPC-web on testnet.
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.testnet);

  test('getPackage 0x2 (sui framework)', () async {
    final pkg = await client.getPackage('0x2');
    print('package modules=${pkg.modules.length}');
    expect(pkg.modules, isNotEmpty);
  });

  test('getFunction 0x2::coin::value', () async {
    final fn = await client.getFunction('0x2', 'coin', 'value');
    print(
        'function=${fn.name} visibility=${fn.visibility} params=${fn.parameters.length}');
    expect(fn.name, equals('value'));
  });

  test('getCheckpoint by sequence number', () async {
    final latest = await client.core.getServiceInfo();
    final seq = latest.checkpointHeight.toInt();
    final cp = await client.getCheckpoint(sequenceNumber: seq);
    print('checkpoint seq=${cp.sequenceNumber} digest=${cp.digest}');
    expect(cp.sequenceNumber.toInt(), equals(seq));
  });

  test('reverseLookupName returns NOT_FOUND for an address without a name',
      () async {
    // Most addresses have no default SuiNS record; the node replies NOT_FOUND.
    const addr =
        '0x0000000000000000000000000000000000000000000000000000000000000005';
    await expectLater(
      client.reverseLookupName(addr),
      throwsA(isA<GrpcWebException>().having((e) => e.status, 'status', 5)),
    );
  });
}
