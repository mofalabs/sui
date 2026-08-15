import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction.dart';
import 'package:sui/sui.dart';

/// Regression coverage for estimateGas / devInspectTransactionBlock on
/// transactions that cannot build offline (shared-object inputs need their
/// initial version resolved over gRPC). Before the fix, `tx.build` ran with no
/// client and threw "No provider passed to Transaction#build".
///
/// Simulation needs no signatures, so 0x5 (which owns SUI coins on testnet)
/// serves as the sender.
///
/// Run with: flutter test test/grpc_estimate_gas_test.dart
void main() {
  final client = SuiGrpcCompat(SuiNetwork.testnet);

  const sender =
      '0x0000000000000000000000000000000000000000000000000000000000000005';

  test('estimateGas resolves shared-object inputs (stake-shaped tx)',
      () async {
    final state = await client.getLatestSuiSystemState();
    final validator = state.activeValidators.first.suiAddress;

    final tx = Transaction();
    final coin = tx.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(1000000000))]);
    tx.moveCall(
      '0x3::sui_system::request_add_stake',
      arguments: [
        tx.object(normalizeSuiObjectId('0x5')),
        coin,
        tx.pureAddress(validator),
      ],
    );

    final budget = await client.estimateGas(tx, sender);
    print('stake estimate budget=$budget');
    expect(budget, greaterThan(BigInt.zero));
  });

  test('estimateGas still works for offline-buildable transfers', () async {
    final tx = Transaction();
    final coin = tx.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(1000))]);
    tx.transferObjects([coin], tx.pureAddress(sender));

    final budget = await client.estimateGas(tx, sender);
    print('transfer estimate budget=$budget');
    expect(budget, greaterThan(BigInt.zero));
  });

  test('devInspectTransactionBlock resolves shared-object inputs', () async {
    final tx = Transaction();
    tx.moveCall(
      '0x2::clock::timestamp_ms',
      arguments: [
        tx.object(normalizeSuiObjectId('0x6')),
      ],
    );

    final result = await client.devInspectTransactionBlock(sender, tx);
    print('devInspect status=${result.effects.status.status}');
    expect(result.effects.status.status, ExecutionStatusType.success);
  });

  test('estimateGas resolves owned-object inputs (token-send shape)',
      () async {
    // Mirrors the wallet's non-SUI token estimate: the coin being sent enters
    // the transaction as a bare `tx.object(id)` that must be resolved to a
    // full owned-object ref on-chain.
    final coins = await client.getCoins(sender);
    final coinId = coins.data.first.coinObjectId;

    final tx = Transaction();
    tx.transferObjects([tx.object(coinId)], tx.pureAddress(sender));

    final budget = await client.estimateGas(tx, sender);
    print('owned-object estimate budget=$budget');
    expect(budget, greaterThan(BigInt.zero));
  });

  test('devInspect then rebuild of the SAME tx (kiosk NFT send pattern)',
      () async {
    // The wallet dev-inspects a transaction, sets its own budget, then signs
    // and executes the SAME instance — which builds a second time. The second
    // build must tolerate the gas data and resolved inputs left behind by the
    // first.
    final tx = Transaction();
    tx.moveCall(
      '0x2::clock::timestamp_ms',
      arguments: [
        tx.object(normalizeSuiObjectId('0x6')),
      ],
    );

    final inspect = await client.devInspectTransactionBlock(sender, tx);
    expect(inspect.effects.status.status, ExecutionStatusType.success);

    final g = inspect.effects.gasUsed;
    tx.setGasBudget(BigInt.from(g.computationCost + g.storageCost));
    final budget = await client.estimateGas(tx, sender);
    print('rebuild estimate budget=$budget');
    expect(budget, greaterThan(BigInt.zero));
  });
}
