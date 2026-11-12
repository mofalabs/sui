import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/epoch.pb.dart' as pb;
import 'package:sui/grpc/proto/sui/rpc/v2/ledger_service.pb.dart';

import '../support/grpc_fixture_transport.dart';

const _chain = '11111111111111111111111111111111';

Transaction _withEmptyGas() => Transaction()
  ..setSender(normalizeSuiAddress('0xabc'))
  ..setGasPrice(BigInt.one)
  ..setGasBudget(BigInt.from(100))
  ..setGasPayment([]);

void main() {
  final roundTrips = <String, Transaction Function(Transaction)>{
    'original': (tx) => tx,
    'copy constructor': Transaction.new,
    'modern JSON': (tx) => Transaction.from(tx.toJson()),
    // ignore: deprecated_member_use_from_same_package
    'legacy JSON': (tx) => Transaction.from(tx.serialize()),
  };

  for (final entry in roundTrips.entries) {
    test(
      '${entry.key} preserves unset expiration for address-balance gas resolution',
      () async {
        final methods = <String>[];
        final client = GrpcCoreClient(
          network: SuiNetwork.localnet,
          transport: GrpcFixtureTransport(
            onUnary: (method, _) {
              methods.add(method);
              return switch (method) {
                'GetEpoch' => GetEpochResponse(
                  epoch: pb.Epoch(epoch: Int64(10)),
                ).writeToBuffer(),
                'GetServiceInfo' => GetServiceInfoResponse(
                  chainId: _chain,
                ).writeToBuffer(),
                _ => throw StateError('Unexpected RPC: $method'),
              };
            },
          ),
        );
        final tx = entry.value(_withEmptyGas());
        expect(tx.getData().expiration, isNull);
        final built = await tx.build(
          BuildOptions(client: GrpcBuilderAdapter(client)),
        );
        final expiration = Transaction.fromBytes(built).getData().expiration!;
        expect(
          expiration.validDuring,
          containsPair('minEpoch', BigInt.from(10)),
        );
        expect(
          expiration.validDuring,
          containsPair('maxEpoch', BigInt.from(11)),
        );
        expect(expiration.validDuring, containsPair('chain', _chain));
        expect(methods, ['GetEpoch', 'GetServiceInfo']);
      },
    );

    test(
      '${entry.key} preserves explicitly disabled expiration without RPCs',
      () async {
        final source = _withEmptyGas()..setExpiration(null);
        final tx = entry.value(source);
        expect(tx.getData().expiration!.toJson(), {'None': true});
        final client = GrpcCoreClient(
          network: SuiNetwork.localnet,
          transport: GrpcFixtureTransport(
            onUnary: (method, _) =>
                throw StateError('Explicit None must not trigger $method'),
          ),
        );
        final built = await tx.build(
          BuildOptions(client: GrpcBuilderAdapter(client)),
        );
        expect(Transaction.fromBytes(built).getData().expiration!.toJson(), {
          'None': true,
        });
      },
    );
  }
}
