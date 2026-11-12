import 'dart:convert';

import 'package:bcs/bcs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/normalized.dart';

class _Client implements TransactionBuilderClient, TransactionNameResolver {
  _Client({this.allowance, this.addressBalance = 100, this.coins = const []});
  final SuiObjectResponse? allowance;
  final int addressBalance;
  final List<CoinStruct> coins;
  int lookups = 0;
  @override
  Future<List<SuiObjectResponse>> multiGetObjects(
    List<String> ids, {
    SuiObjectDataOptions? options,
  }) async {
    lookups++;
    expect(options!.showBcs, isTrue);
    return [allowance!];
  }

  @override
  Future<CoinBalanceBreakdown> getBalanceBreakdown(
    String owner,
    String type,
  ) async => CoinBalanceBreakdown(
    total:
        BigInt.from(addressBalance) +
        coins.fold(BigInt.zero, (n, c) => n + BigInt.parse(c.balance)),
    addressBalance: BigInt.from(addressBalance),
    coinBalance: coins.fold(BigInt.zero, (n, c) => n + BigInt.parse(c.balance)),
  );
  @override
  Future<PaginatedCoins> getCoins(
    String owner, {
    String? coinType,
    String? cursor,
    int? limit,
  }) async => PaginatedCoins(coins, null, false);
  @override
  Future<dynamic> getProtocolConfig([String? version]) async => null;
  @override
  Future<String> resolveType(String type) async =>
      type.replaceAll('@org/coin', '0x123');
  @override
  Future<String> resolvePackage(String package) async => '0x123';
  @override
  Future<ResolvedGasData?> resolveGasData(
    TransactionBlockDataBuilder data,
  ) async => throw StateError('Unexpected gas resolution');
  @override
  Future<SuiMoveNormalizedFunction> getNormalizedMoveFunction(
    String p,
    String m,
    String f,
  ) => throw StateError('Unexpected signature lookup');
  @override
  Future<BigInt> getReferenceGasPrice() =>
      throw StateError('Unexpected price lookup');
  @override
  Future<DryRunTransactionBlockResponse> dryRunTransaction<T>(
    T tx, {
    String? signerAddress,
  }) => throw StateError('Unexpected dry-run');
}

void main() {
  const digest = '11111111111111111111111111111111';
  const type = '0x123::coin::COIN';
  final sender = normalizeSuiAddress('0xabc');
  final id = normalizeSuiAddress('0x1234');
  final coin = CoinStruct(
    type,
    normalizeSuiAddress('0x222'),
    1,
    digest,
    '100',
    '',
  );

  Transaction txWithAllowance({AllowanceApp? app, String? funder}) {
    final tx = Transaction()..setSender(sender);
    tx.object(
      Inputs.sharedObjectRef({
        'objectId': id,
        'initialSharedVersion': 2,
        'mutable': false,
      }),
    );
    tx.object(
      Inputs.sharedObjectRef({
        'objectId': '0x6',
        'initialSharedVersion': 1,
        'mutable': false,
      }),
    );
    final boundApp = app == null
        ? null
        : AllowanceApp(
            type: app.type,
            permit: tx.moveCall('0x123::app::authorize'),
          );
    final balance = tx.balance(
      type,
      '15',
      allowance: AllowanceReference(
        objectId: id,
        funder: funder,
        app: boundApp,
      ),
    );
    tx.moveCall(
      '0x2::balance::send_funds',
      typeArguments: [type],
      arguments: [balance, tx.pureAddress(sender)],
    );
    return tx;
  }

  test(
    'Validity survives modern JSON, legacy JSON and BCS round trips',
    () async {
      final tx = Transaction()
        ..setSender(sender)
        ..setGasPrice(BigInt.one)
        ..setGasBudget(BigInt.from(100))
        ..setGasPayment([]);
      tx.setValidityExpiration(
        chain: digest,
        nonce: 7,
        minEpoch: BigInt.one,
        maxEpoch: BigInt.two,
        minTimestamp: BigInt.from(100123),
        proposerEpoch: BigInt.one,
        allowedProposers: [0, 2],
      );
      final modern = Transaction.from(tx.toJson());
      // ignore: deprecated_member_use_from_same_package
      final legacy = Transaction.from(tx.serialize());
      final bytes = await tx.build();
      expect(await modern.build(), bytes);
      expect(await legacy.build(), bytes);
      expect(
        Transaction.fromBytes(
          bytes,
        ).getData().expiration!.validity!['allowedProposers']['proposers'],
        [0, 2],
      );
      final unsupported = jsonDecode(tx.toJson()) as Map<String, dynamic>;
      unsupported['expiration'] = {'FutureRestriction': {}};
      expect(
        () => Transaction.from(jsonEncode(unsupported)),
        throwsFormatException,
      );
    },
  );

  test(
    'offline address-balance builds need bounded expiration before inferring empty gas',
    () async {
      final tx = Transaction()
        ..setSender(sender)
        ..setGasPrice(BigInt.one)
        ..setGasBudget(BigInt.from(100));
      tx.setValidityExpiration(
        chain: digest,
        nonce: 7,
        minEpoch: BigInt.one,
        maxEpoch: BigInt.two,
      );
      final value = tx.balance(type, '15', useGasCoin: false);
      tx.moveCall(
        '0x2::balance::send_funds',
        typeArguments: [type],
        arguments: [value, tx.pureAddress(sender)],
      );
      final bytes = await tx.build(
        BuildOptions(assumeSufficientAddressBalances: true),
      );
      expect(Transaction.fromBytes(bytes).getData().gasData.payment, isEmpty);
      expect(
        tx
            .getData()
            .inputs!
            .where((input) => input['FundsWithdrawal'] != null)
            .length,
        1,
      );
      final unbounded = Transaction()
        ..setSender(sender)
        ..setGasPrice(BigInt.one)
        ..setGasBudget(BigInt.from(100));
      await expectLater(
        unbounded.build(BuildOptions(assumeSufficientAddressBalances: true)),
        throwsArgumentError,
      );
    },
  );

  test(
    'known-funder allowance builds offline and upgrades the shared input to mutable',
    () async {
      final tx = txWithAllowance(funder: sender);
      await tx.build(BuildOptions(onlyTransactionKind: true));
      final data = tx.getData();
      expect(data.inputs![0]['Object']['SharedObject']['mutable'], isTrue);
      final withdrawal = data.inputs!.singleWhere(
        (input) => input['FundsWithdrawal'] != null,
      )['FundsWithdrawal'];
      expect(withdrawal['withdrawFrom'], {
        'SenderAllowance': {'funder': sender, 'allowance': id},
      });
      expect(withdrawal['reservation'], {'MaxAmountU64': '15'});
      expect(data.commands![0]['MoveCall']['function'], 'balance_spend');
      expect(data.commands![1]['MoveCall']['arguments'][0]['NestedResult'], [
        0,
        0,
      ]);
    },
  );

  test(
    'allowance metadata enforces app binding and never falls back to sender funds',
    () async {
      SuiObjectResponse metadata(String? app) {
        final prefix =
            Bcs.struct('AllowancePrefix', {
              'id': SuiBcs.Address,
              'funder': SuiBcs.Address,
              'spender': Bcs.option(SuiBcs.Address),
              'app': Bcs.option(Bcs.string()),
            }).serialize({
              'id': id,
              'funder': sender,
              'spender': null,
              'app': app,
            }).toBytes();
        return SuiObjectResponse.fromJson({
          'data': {
            'objectId': id,
            'version': '2',
            'digest': digest,
            'type': '0x2::allowance::Allowance<0x2::balance::Balance<$type>>',
            'owner': {
              'Shared': {'initial_shared_version': 2},
            },
            'bcs': {
              'dataType': 'moveObject',
              'type': '0x2::allowance::Allowance<0x2::balance::Balance<$type>>',
              'version': 2,
              'hasPublicTransfer': false,
              'bcsBytes': base64Encode([...prefix, 0, 0, 0]),
            },
          },
        });
      }

      final client = _Client(allowance: metadata('0x123::app::APP'));
      final tx = txWithAllowance();
      await expectLater(
        tx.build(BuildOptions(onlyTransactionKind: true, client: client)),
        throwsArgumentError,
      );
      expect(client.lookups, 1);
      final matching = txWithAllowance(
        app: AllowanceApp(
          type: '0x123::app::APP',
          permit: {r'$kind': 'Result', 'Result': 0},
        ),
      );
      await matching.build(
        BuildOptions(onlyTransactionKind: true, client: client),
      );
      expect(
        matching.getData().commands![1]['MoveCall']['function'],
        'app_balance_spend',
      );
    },
  );

  test(
    'reserved withdrawals reduce available sender balance before coin selection',
    () async {
      Transaction make() {
        final tx = Transaction()..setSender(sender);
        tx.withdrawal(
          amount: '60',
          type: type,
          from: WithdrawalSource.allowance,
          funder: sender,
          allowance: id,
        );
        final value = tx.balance(type, '50', useGasCoin: false);
        tx.moveCall(
          '0x2::balance::send_funds',
          typeArguments: [type],
          arguments: [value, tx.pureAddress(sender)],
        );
        return tx;
      }

      await expectLater(
        make().build(
          BuildOptions(onlyTransactionKind: true, client: _Client()),
        ),
        throwsArgumentError,
      );
      final tx = make();
      await tx.build(
        BuildOptions(onlyTransactionKind: true, client: _Client(coins: [coin])),
      );
      expect(
        tx.getData().commands!.any((c) => c['SplitCoins'] != null),
        isTrue,
      );
      final functions = tx
          .getData()
          .commands!
          .map((c) => c['MoveCall']?['function'])
          .toList();
      expect(functions, isNot(contains('redeem_funds')));
    },
  );

  test('coin cleanup precedes later random calls', () async {
    final tx = Transaction()..setSender(sender);
    final value = tx.balance(type, '50', useGasCoin: false);
    tx.moveCall('0x123::app::random', arguments: [value]);
    await tx.build(
      BuildOptions(
        onlyTransactionKind: true,
        client: _Client(addressBalance: 0, coins: [coin]),
      ),
    );
    final commands = tx.getData().commands!;
    final cleanup = commands.indexWhere(
      (c) => c['MoveCall']?['function'] == 'send_funds',
    );
    final random = commands.indexWhere(
      (c) => c['MoveCall']?['function'] == 'random',
    );
    expect(cleanup, greaterThanOrEqualTo(0));
    expect(cleanup, lessThan(random));
  });

  test(
    'MVR resolves intent, withdrawal and app types before selection',
    () async {
      final tx = Transaction()..setSender(sender);
      tx.withdrawal(amount: '1', type: '@org/coin::coin::COIN');
      final value = tx.balance('@org/coin::coin::COIN', '2', useGasCoin: false);
      tx.moveCall(
        '0x2::balance::send_funds',
        typeArguments: ['@org/coin::coin::COIN'],
        arguments: [value, tx.pureAddress(sender)],
      );
      await tx.build(
        BuildOptions(onlyTransactionKind: true, client: _Client()),
      );
      expect(jsonEncode(tx.getData()), isNot(contains('@org')));
    },
  );

  test(
    'shared custom resolver runs once for only its assigned intent names',
    () async {
      final tx = Transaction();
      for (final name in ['First', 'Second', 'WalletSupported']) {
        tx.add({
          r'$Intent': {'name': name, 'inputs': {}, 'data': {}},
        });
      }
      var calls = 0;
      void resolver(
        TransactionBlockDataBuilder data,
        IntentResolverOptions options,
      ) {
        calls++;
        expect(options.intentNames, ['First', 'Second']);
        data.commands.removeWhere(
          (command) =>
              options.intentNames.contains(command[r'$Intent']?['name']),
        );
      }

      final copy = Transaction.from(
        tx.toJson(),
        intentResolvers: {'First': resolver, 'Second': resolver},
      );
      final serialized = await copy.toJsonAsync(
        SerializeTransactionOptions(supportedIntents: ['WalletSupported']),
      );
      expect(calls, 1);
      expect(jsonDecode(serialized)['commands'].length, 1);
      await expectLater(
        copy.build(BuildOptions(onlyTransactionKind: true)),
        throwsArgumentError,
      );
    },
  );

  test(
    'copy constructors preserve custom intent resolvers without sharing registrations',
    () async {
      final original = Transaction();
      var calls = 0;
      void resolver(
        TransactionBlockDataBuilder data,
        IntentResolverOptions options,
      ) {
        calls++;
        expect(options.intentNames, ['First', 'Second']);
        // Replace the command list: mutating snapshots in place is not required
        // for this resolver and would test unrelated legacy shallow-copy behavior.
        data.commands = [];
      }

      for (final name in ['First', 'Second']) {
        original.addIntentResolver(name, resolver);
        original.add({
          r'$Intent': {'name': name, 'inputs': {}, 'data': {}},
        });
      }
      final copy = Transaction(original);
      final kind = await copy.build(BuildOptions(onlyTransactionKind: true));
      expect(
        await original.build(BuildOptions(onlyTransactionKind: true)),
        kind,
      );
      expect(calls, 2);

      copy.addIntentResolver('CopyOnly', (data, _) => data.commands = []);
      original.add({
        r'$Intent': {'name': 'CopyOnly', 'inputs': {}, 'data': {}},
      });
      await expectLater(
        original.build(BuildOptions(onlyTransactionKind: true)),
        throwsA(
          isA<ArgumentError>().having(
            (error) => error.message,
            'message',
            contains('No resolver registered for intent CopyOnly'),
          ),
        ),
      );
    },
  );

  test('amounts reject floating point, signed strings and u64 overflow', () {
    final tx = Transaction();
    for (final amount in <Object>[
      1.0,
      '-1',
      '+1',
      '1e3',
      '1.2',
      BigInt.one << 64,
    ]) {
      expect(() => tx.coin(type, amount), throwsArgumentError);
    }
    expect(
      parseBalanceAmount('18446744073709551615'),
      (BigInt.one << 64) - BigInt.one,
    );
  });
}
