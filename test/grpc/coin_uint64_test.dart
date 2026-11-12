import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/object.pb.dart' as pb;
import 'package:sui/grpc/proto/sui/rpc/v2/state_service.pb.dart';
import 'package:sui/utils/proto_int.dart';

import '../support/grpc_fixture_transport.dart';

void main() {
  test(
    'coin balances and versions retain the full unsigned u64 range',
    () async {
      final values = [
        (BigInt.one << 53) + BigInt.one,
        (BigInt.one << 63) + BigInt.one,
        (BigInt.one << 64) - BigInt.one,
      ];
      final core = GrpcCoreClient(
        network: SuiNetwork.localnet,
        transport: GrpcFixtureTransport(
          onUnary: (_, __) => ListOwnedObjectsResponse(
            objects: [
              for (var i = 0; i < values.length; i++)
                pb.Object(
                  objectId: '0x${i + 1}',
                  balance: bigIntToUint64(values[i]),
                  version: bigIntToUint64(values[i]),
                ),
            ],
          ).writeToBuffer(),
        ),
      );
      final page = await core.listCoins('0x1');
      expect(page.coins.map((coin) => coin.balance), values);
      expect(page.coins.map((coin) => coin.version), values);
    },
  );
}
