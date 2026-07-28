import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction.dart';
import 'package:sui/builder/transaction_block_data.dart';
import 'package:sui/builder/transaction_builder_client.dart';
import 'package:sui/types/coins.dart';
import 'package:sui/types/normalized.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';

/// Verifies that `Transaction.balance()` + `0x2::balance::send_funds` resolves
/// to the right on-chain commands for the two `CoinWithBalance` paths — the
/// gasless address-balance withdrawal and the owned-coin fallback — without any
/// network (the client is mocked).
class _MockClient implements TransactionBuilderClient {
  _MockClient({required this.addressBalance, this.coins = const []});

  final BigInt addressBalance;
  final List<CoinStruct> coins;

  BigInt get _coinTotal =>
      coins.fold(BigInt.zero, (s, c) => s + BigInt.parse(c.balance));

  @override
  Future<CoinBalanceBreakdown> getBalanceBreakdown(
          String owner, String coinType) async =>
      CoinBalanceBreakdown(
        total: addressBalance + _coinTotal,
        addressBalance: addressBalance,
        coinBalance: _coinTotal,
      );

  @override
  Future<PaginatedCoins> getCoins(String owner,
          {String? coinType, String? cursor, int? limit}) async =>
      PaginatedCoins(coins, null, false);

  // Not reached for these already-resolved, kind-only builds.
  @override
  Future<List<SuiObjectResponse>> multiGetObjects(List<String> objectIds,
          {SuiObjectDataOptions? options}) =>
      throw UnimplementedError();
  @override
  Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(
          String p, String m, String f) =>
      throw UnimplementedError();
  @override
  Future<BigInt> getReferenceGasPrice() => throw UnimplementedError();
  @override
  Future<dynamic> getProtocolConfig([String? version]) async => null;
  @override
  Future<DryRunTransactionBlockResponse> dryRunTransaction<T>(T tx,
          {String? signerAddress}) =>
      throw UnimplementedError();
  @override
  Future<ResolvedGasData?> resolveGasData(TransactionBlockDataBuilder data) async =>
      null;
}

void main() {
  const usdc =
      '0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC';
  const sender =
      '0x0000000000000000000000000000000000000000000000000000000000000abc';
  const recipient =
      '0x0000000000000000000000000000000000000000000000000000000000000def';
  final amount = BigInt.from(1000000); // 1.0 USDC (6 decimals)

  Transaction sendFundsTx() {
    final tx = Transaction();
    final bal = tx.balance(usdc, amount, useGasCoin: false);
    tx.moveCall('0x2::balance::send_funds',
        typeArguments: [usdc], arguments: [bal, tx.pureAddress(recipient)]);
    tx.setSender(sender);
    return tx;
  }

  List<String> moveFns(List commands) => [
        for (final c in commands)
          if ((c as Map)['MoveCall'] != null)
            '${c['MoveCall']['module']}::${c['MoveCall']['function']}'
      ];

  test('Path 1: address balance sufficient -> balance::redeem_funds (gasless)',
      () async {
    final tx = sendFundsTx();
    await tx.build(BuildOptions(
        onlyTransactionKind: true,
        client: _MockClient(addressBalance: BigInt.from(5000000))));

    final data = tx.getData();
    // The balance() intent resolved to a redeem_funds; send_funds deposits it.
    expect(moveFns(data.commands!),
        containsAllInOrder(['balance::redeem_funds', 'balance::send_funds']));
    // A FundsWithdrawal input reserving the amount from the sender's balance.
    final fw = data.inputs!.firstWhere((i) => i['FundsWithdrawal'] != null);
    expect(fw['FundsWithdrawal']['reservation'], {'MaxAmountU64': '1000000'});
    expect(fw['FundsWithdrawal']['typeArg'], {'Balance': usdc});
    // No owned coin objects touched — this is the gasless path.
    expect(data.inputs!.any((i) => i['Object'] != null), isFalse);
  });

  test('Path 2: no address balance -> merge/split owned coins + into_balance',
      () async {
    final tx = sendFundsTx();
    final coin = CoinStruct(usdc, '0x${'1' * 64}', 1, '11111111111111111111111111111111',
        '5000000', '');
    await tx.build(BuildOptions(
        onlyTransactionKind: true,
        client: _MockClient(addressBalance: BigInt.zero, coins: [coin])));

    final data = tx.getData();
    final fns = moveFns(data.commands!);
    // Split the owned coin, convert to Balance, and deposit; remainder returns
    // to the sender's address balance.
    expect(data.commands!.any((c) => (c as Map)['SplitCoins'] != null), isTrue);
    expect(fns, contains('coin::into_balance'));
    expect(fns, contains('coin::send_funds')); // remainder back to sender AB
    expect(fns, contains('balance::send_funds')); // the transfer
    // Sourced an owned coin object (not the address balance).
    expect(data.inputs!.any((i) => i['Object'] != null), isTrue);
  });

  // A coin-output intent (tx.coin) sourced from owned coins. These exercise the
  // remainder pass's non-send_funds branches, which the balance-output cases
  // above don't reach.
  Transaction coinTransferTx(BigInt amount) {
    final tx = Transaction();
    final c = tx.coin(usdc, amount, useGasCoin: false);
    tx.transferObjects([c], tx.pureAddress(recipient));
    tx.setSender(sender);
    return tx;
  }

  test('Path 2 coin output, surplus coin -> merged coin kept (no remainder call)',
      () async {
    final tx = coinTransferTx(amount); // need 1.0 USDC
    final coin = CoinStruct(usdc, '0x${'1' * 64}', 1,
        '11111111111111111111111111111111', '5000000', ''); // 5.0 surplus
    await tx.build(BuildOptions(
        onlyTransactionKind: true,
        client: _MockClient(addressBalance: BigInt.zero, coins: [coin])));

    final fns = moveFns(tx.getData().commands!);
    // Split off the transferred coin; convert nothing; the 4.0 remainder stays
    // as an owned object, so no send_funds/destroy_zero/into_balance is emitted.
    expect(tx.getData().commands!.any((c) => (c as Map)['SplitCoins'] != null),
        isTrue);
    expect(fns, isNot(contains('coin::into_balance')));
    expect(fns, isNot(contains('coin::send_funds')));
    expect(fns, isNot(contains('coin::destroy_zero')));
  });

  test('Path 2 coin output, exact coin -> destroy_zero dust', () async {
    final tx = coinTransferTx(amount); // need 1.0 USDC
    final coin = CoinStruct(usdc, '0x${'1' * 64}', 1,
        '11111111111111111111111111111111', '1000000', ''); // exact 1.0
    await tx.build(BuildOptions(
        onlyTransactionKind: true,
        client: _MockClient(addressBalance: BigInt.zero, coins: [coin])));

    final fns = moveFns(tx.getData().commands!);
    // Coin sources matched the amount exactly, so the emptied base coin is
    // destroyed rather than returned.
    expect(fns, contains('coin::destroy_zero'));
    expect(fns, isNot(contains('coin::send_funds')));
  });
}
