import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/state_service.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/epoch.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/ledger_service.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/transaction_execution_service.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/executed_transaction.pb.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/effects.pb.dart' as pb;
import 'package:sui/grpc/proto/sui/rpc/v2/gas_cost_summary.pb.dart' as gas_pb;
import 'package:sui/utils/proto_int.dart';

import '../support/grpc_fixture_transport.dart';

class _Compat extends SuiGrpcCompat {
  _Compat(this.client) : super(SuiNetwork.localnet);
  final SuiGrpcClient client;
  @override
  SuiGrpcClient get grpc => client;
}

void main() {
  test(
    'wallet gas estimation preserves large unsigned costs and rebates',
    () async {
      final computation = (BigInt.one << 63) + BigInt.one;
      final compat = _Compat(
        SuiGrpcClient(
          network: SuiNetwork.localnet,
          transport: GrpcFixtureTransport(
            onUnary: (method, _) {
              expect(method, 'SimulateTransaction');
              return SimulateTransactionResponse(
                transaction: ExecutedTransaction(
                  effects: pb.TransactionEffects(
                    gasUsed: gas_pb.GasCostSummary(
                      computationCost: bigIntToUint64(computation),
                      storageCost: bigIntToUint64(BigInt.from(5000)),
                      storageRebate: bigIntToUint64(BigInt.from(1000)),
                    ),
                  ),
                ),
              ).writeToBuffer();
            },
          ),
        ),
      );
      final tx = Transaction()
        ..setSender('0x1')
        ..setGasPrice(BigInt.one)
        ..setGasBudget(BigInt.from(10000))
        ..setGasPayment([
          SuiObjectRef('11111111111111111111111111111111', '0x2', 1),
        ]);
      expect(
        await compat.estimateGas(tx, '0x1'),
        computation + BigInt.from(4000),
      );
    },
  );

  test(
    'wallet compatibility balances and gas price preserve unsigned u64',
    () async {
      final max = (BigInt.one << 64) - BigInt.one;
      final balance = Balance(
        coinType: '0x2::sui::SUI',
        balance: bigIntToUint64(max),
        addressBalance: bigIntToUint64(max),
      );
      final compat = _Compat(
        SuiGrpcClient(
          network: SuiNetwork.localnet,
          transport: GrpcFixtureTransport(
            onUnary: (method, _) {
              return switch (method) {
                'GetBalance' => GetBalanceResponse(
                  balance: balance,
                ).writeToBuffer(),
                'ListBalances' => ListBalancesResponse(
                  balances: [balance],
                ).writeToBuffer(),
                'GetEpoch' => GetEpochResponse(
                  epoch: Epoch(referenceGasPrice: bigIntToUint64(max)),
                ).writeToBuffer(),
                _ => throw StateError('Unexpected RPC: $method'),
              };
            },
          ),
        ),
      );
      expect((await compat.getBalance('0x1')).totalBalance, max);
      expect((await compat.getAllBalance('0x1')).single.totalBalance, max);
      expect(await compat.getAddressBalance('0x1'), max);
      expect(await compat.getReferenceGasPrice(), max);
    },
  );
}
