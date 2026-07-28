import 'dart:math';

import '../bcs/sui_bcs.dart';
import '../types/coins.dart';
import '../types/common.dart';
import '../types/objects.dart';
import 'inputs.dart';
import 'transaction.dart';
import 'transaction_block_data.dart';
import 'transaction_builder_client.dart';

/// Resolves `CoinWithBalance` `$Intent` commands into concrete commands.
///
/// The intent (created by `Transaction.coin()` / `Transaction.balance()`, or
/// carried in a dApp's serialized transaction) asks for a coin or balance of an
/// exact amount. This resolves it at build time by choosing between the account's
/// two fund sources:
///  - **Address balance** (per-address accumulator) — withdrawn via
///    `redeem_funds`; a transfer built entirely this way is gasless-eligible.
///  - **Owned coin objects** — merged then split.
/// It mirrors the two-path strategy of the on-chain-aware reference resolver:
/// Path 1 (all balance-output intents and address balance sufficient) does a
/// direct per-intent `balance::redeem_funds`; Path 2 merges available sources
/// (address balance, gas coin, or owned coins) and splits all intents at once,
/// converting to `Balance` via `coin::into_balance` for balance outputs and
/// returning any remainder to the address balance via `coin::send_funds`.
/// Test hook: pretend every CoinWithBalance intent is fully covered by the
/// sender's address balance, skipping the client-side sufficiency check and
/// coin lookup. Lets a knowingly-underfunded transaction reach the node to
/// probe node-side validation (signature scheme, expiration rules) in
/// isolation. Never enable outside tests/debug probes.
bool debugForceAddressBalanceCoverage = false;

const _coinWithBalance = 'CoinWithBalance';
final String _suiType = normalizeStructTagString('0x2::sui::SUI');
const _coinPackage =
    '0x0000000000000000000000000000000000000000000000000000000000000002';

bool _isCwbIntent(dynamic cmd) =>
    cmd is Map &&
    cmd[r'$Intent'] != null &&
    cmd[r'$Intent']['name'] == _coinWithBalance;

typedef _Intent = ({BigInt balance, String outputKind});

Future<void> resolveCoinBalanceIntents(
    TransactionBlockDataBuilder data, TransactionBuilderClient? client) async {
  if (!data.commands.any(_isCwbIntent)) return;

  // Command arguments may hold `TransactionResult` instances — e.g. the value
  // returned by `tx.coin()`/`tx.balance()` and passed into another command.
  // Normalize them to their `Result`/`NestedResult` map form up front so the
  // index remapping below (which matches on those maps) can rewrite references
  // to a resolved intent. Left as instances, such an argument would serialize
  // as a `Result` pointing at the now-replaced intent command and the node
  // would reject it (wrong result arity).
  for (final cmd in data.commands) {
    _mapCommandArgs(cmd, (arg) => arg is TransactionResult ? arg.toJson() : arg);
  }

  if (data.sender == null) {
    throw ArgumentError('Sender must be set to resolve CoinWithBalance');
  }
  if (client == null) {
    throw ArgumentError('Client must be provided to build transactions '
        'with CoinWithBalance intents');
  }

  final totalByType = <String, BigInt>{};
  final intentsByType = <String, List<_Intent>>{};

  // First pass: sum required balances per coin type and resolve any
  // zero-balance intents in place (they need no funds) — a zero coin or a zero
  // balance depending on the intent's output kind.
  for (var i = 0; i < data.commands.length; i++) {
    final cmd = data.commands[i];
    if (!_isCwbIntent(cmd)) continue;
    final d = cmd[r'$Intent']['data'] as Map;
    final type = d['type'] as String;
    final balance = BigInt.parse(d['balance'].toString());
    final outputKind = (d['outputKind'] ?? 'coin') as String;
    if (balance == BigInt.zero) {
      final coinType = type == 'gas' ? _suiType : type;
      final target = outputKind == 'balance'
          ? '$_coinPackage::balance::zero'
          : '$_coinPackage::coin::zero';
      _replaceCommand(data, i, [_moveCall(target, [coinType], const [])]);
      continue;
    }
    totalByType[type] = (totalByType[type] ?? BigInt.zero) + balance;
    (intentsByType[type] ??= <_Intent>[])
        .add((balance: balance, outputKind: outputKind));
  }

  if (totalByType.isEmpty) return; // all intents were zero-balance

  if (totalByType.containsKey('gas') && totalByType.containsKey(_suiType)) {
    throw ArgumentError('Cannot mix SUI CoinWithBalance intents that use the '
        'gas coin with ones that do not (useGasCoin: false).');
  }

  // Object ids already used by other inputs must not be re-selected as coins.
  final usedIds = <String>{};
  for (final input in data.inputs) {
    final owned = input['Object']?['ImmOrOwnedObject']?['objectId'];
    if (owned != null) usedIds.add(normalizeSuiAddress(owned));
    final unresolved = input['UnresolvedObject']?['objectId'];
    if (unresolved != null) usedIds.add(normalizeSuiAddress(unresolved));
  }

  // Resolve owned coins + address balance per type. For 'gas', only the SUI
  // address balance matters (coins come from the gas coin, not selected here).
  final coinsByType = <String, List<CoinStruct>>{};
  final addressBalanceByType = <String, BigInt>{};
  for (final entry in totalByType.entries) {
    if (debugForceAddressBalanceCoverage) {
      coinsByType[entry.key] = const [];
      addressBalanceByType[entry.key] = entry.value;
    } else if (entry.key == 'gas') {
      final b = await client.getBalanceBreakdown(data.sender!, _suiType);
      addressBalanceByType['gas'] = b.addressBalance;
    } else {
      final r = await _getCoinsAndBalance(
          client, data.sender!, entry.key, entry.value, usedIds);
      coinsByType[entry.key] = r.coins;
      addressBalanceByType[entry.key] = r.addressBalance;
    }
  }

  final mergedCoins = <String, dynamic>{};
  final exactBalanceByType = <String, bool>{};
  final usedAddressBalance = <String>{};
  // Per-type Path-2 state: the ordered intent results + a cursor.
  final typeResults = <String, List<dynamic>>{};
  final typeNext = <String, int>{};

  var index = 0;
  while (index < data.commands.length) {
    final cmd = data.commands[index];
    if (!_isCwbIntent(cmd)) {
      index++;
      continue;
    }
    final d = cmd[r'$Intent']['data'] as Map;
    final type = d['type'] as String;
    final balance = BigInt.parse(d['balance'].toString());
    final coinType = type == 'gas' ? _suiType : type;
    final totalRequired = totalByType[type]!;
    final addressBalance = addressBalanceByType[type] ?? BigInt.zero;
    final intents = intentsByType[type]!;
    final allBalance = intents.every((i) => i.outputKind == 'balance');

    final commands = <Map<String, dynamic>>[];
    dynamic intentResult;

    if (allBalance && addressBalance >= totalRequired) {
      // Path 1: all balance-output intents with sufficient address balance —
      // withdraw this intent's amount directly (no coins; parallel-safe).
      commands.add(_moveCall('$_coinPackage::balance::redeem_funds', [coinType], [
        data.addInput('withdrawal', _fundsWithdrawal(balance, coinType))
      ]));
      intentResult = {
        r'$kind': 'NestedResult',
        'NestedResult': [index + commands.length - 1, 0]
      };
    } else {
      // Path 2: merge sources then split all intents of this type at once,
      // built the first time the type is seen.
      if (!typeResults.containsKey(type)) {
        final sources = <dynamic>[];

        if (addressBalance >= totalRequired) {
          // Source entirely from address balance — no coins needed.
          usedAddressBalance.add(type);
          commands.add(_moveCall('$_coinPackage::coin::redeem_funds', [coinType], [
            data.addInput('withdrawal', _fundsWithdrawal(totalRequired, coinType))
          ]));
          sources.add(
              {r'$kind': 'Result', 'Result': index + commands.length - 1});
        } else if (type == 'gas') {
          sources.add({r'$kind': 'GasCoin', 'GasCoin': true});
        } else {
          final coins = coinsByType[type]!;
          final loaded =
              coins.fold(BigInt.zero, (s, c) => s + BigInt.parse(c.balance));
          final abNeeded =
              totalRequired > loaded ? totalRequired - loaded : BigInt.zero;
          exactBalanceByType[type] = loaded + abNeeded == totalRequired;
          for (final coin in coins) {
            sources.add(data.addInput(
                'object',
                Inputs.objectRef(SuiObjectRef(
                    coin.digest, coin.coinObjectId, coin.version))));
          }
          if (abNeeded > BigInt.zero) {
            usedAddressBalance.add(type);
            commands.add(
                _moveCall('$_coinPackage::coin::redeem_funds', [coinType], [
              data.addInput('withdrawal', _fundsWithdrawal(abNeeded, coinType))
            ]));
            sources.add(
                {r'$kind': 'Result', 'Result': index + commands.length - 1});
          }
        }

        final baseCoin = sources.first;
        final rest = sources.sublist(1);
        for (var i = 0; i < rest.length; i += 500) {
          commands.add(_mergeCoins(
              baseCoin, rest.sublist(i, min(i + 500, rest.length))));
        }

        // Remember the merged coin so its remainder can be handled after all
        // intents are placed (see the remainder pass below).
        mergedCoins[type] = baseCoin;

        final splitCmdIndex = index + commands.length;
        commands.add(_splitCoins(
            baseCoin,
            intents
                .map((it) => data.addInput(
                    'pure', Inputs.pure(SuiBcs.U64.serialize(it.balance))))
                .toList()));

        final results = <dynamic>[];
        for (var i = 0; i < intents.length; i++) {
          final splitResult = {
            r'$kind': 'NestedResult',
            'NestedResult': [splitCmdIndex, i]
          };
          if (intents[i].outputKind == 'balance') {
            commands.add(_moveCall(
                '$_coinPackage::coin::into_balance', [coinType], [splitResult]));
            results.add({
              r'$kind': 'NestedResult',
              'NestedResult': [index + commands.length - 1, 0]
            });
          } else {
            results.add(splitResult);
          }
        }

        typeResults[type] = results;
        typeNext[type] = 0;
      }

      intentResult = typeResults[type]![typeNext[type]!];
      typeNext[type] = typeNext[type]! + 1;
    }

    _replaceCommand(data, index, commands, intentResult);
    index += commands.length;
  }

  // Remainder pass: after every intent is placed, dispose of each merged coin's
  // leftover. The merged coin's argument (an object input, a `redeem_funds`
  // result, or the gas coin) keeps its position across the earlier splices, so
  // these commands can be appended to the end of the list.
  for (final entry in mergedCoins.entries) {
    final type = entry.key;
    final mergedCoin = entry.value;
    // Gas coin funded from itself (not the address balance): the leftover simply
    // stays in the gas coin, so nothing to return.
    if (type == 'gas' && !usedAddressBalance.contains(type)) continue;

    final coinType = type == 'gas' ? _suiType : type;
    final hasBalanceIntent =
        (intentsByType[type] ?? const <_Intent>[]).any((i) => i.outputKind == 'balance');
    final sourcedFromAB = usedAddressBalance.contains(type);

    if (hasBalanceIntent || sourcedFromAB) {
      // Sourced from the address balance, or a balance output was produced:
      // return the remainder to the sender's address balance (gasless-eligible,
      // and a no-op for a zero remainder).
      data.commands.add(_moveCall('$_coinPackage::coin::send_funds', [coinType], [
        mergedCoin,
        data.addInput('pure', Inputs.pure(SuiBcs.Address.serialize(data.sender!)))
      ]));
    } else if (exactBalanceByType[type] == true) {
      // Coin-only sources matched the amount exactly: destroy the zero dust.
      data.commands.add(
          _moveCall('$_coinPackage::coin::destroy_zero', [coinType], [mergedCoin]));
    }
    // Coin-only with a surplus: the merged coin stays with the sender as an
    // owned object.
  }
}

/// A FundsWithdrawal input CallArg reserving [amount] of [coinType] from the
/// sender's address balance (materialized by `redeem_funds`).
Map<String, dynamic> _fundsWithdrawal(BigInt amount, String coinType) => {
      r'$kind': 'FundsWithdrawal',
      'FundsWithdrawal': {
        'reservation': {'MaxAmountU64': amount.toString()},
        'typeArg': {'Balance': coinType},
        'withdrawFrom': {'Sender': true},
      },
    };

/// Loads the owner's owned [coinType] coins (excluding [usedIds]) plus their
/// address balance. Loads whole pages, paginating only while owned coins +
/// address balance remain below [needed]; throws if the total can't cover it.
Future<({List<CoinStruct> coins, BigInt addressBalance})> _getCoinsAndBalance(
    TransactionBuilderClient client,
    String owner,
    String coinType,
    BigInt needed,
    Set<String> usedIds) async {
  final breakdown = await client.getBalanceBreakdown(owner, coinType);
  if (breakdown.total < needed) {
    throw ArgumentError('Insufficient balance of $coinType for owner $owner. '
        'Required: $needed, Available: ${breakdown.total}');
  }
  var remaining = needed - breakdown.addressBalance;
  final coins = <CoinStruct>[];
  String? cursor;
  while (remaining > BigInt.zero) {
    final page = await client.getCoins(owner, coinType: coinType, cursor: cursor);
    for (final c in page.data) {
      if (usedIds.contains(normalizeSuiAddress(c.coinObjectId))) continue;
      coins.add(c);
      remaining -= BigInt.parse(c.balance);
    }
    if (!page.hasNextPage) break;
    cursor = page.nextCursor;
  }
  return (coins: coins, addressBalance: breakdown.addressBalance);
}

Map<String, dynamic> _moveCall(
    String target, List<String> typeArguments, List<dynamic> arguments) {
  final parts = target.split('::');
  return {
    r'$kind': 'MoveCall',
    'MoveCall': {
      'package': parts[0],
      'module': parts[1],
      'function': parts[2],
      'typeArguments': typeArguments,
      'arguments': arguments,
    }
  };
}

Map<String, dynamic> _mergeCoins(dynamic destination, List<dynamic> sources) => {
      r'$kind': 'MergeCoins',
      'MergeCoins': {'destination': destination, 'sources': sources},
    };

Map<String, dynamic> _splitCoins(dynamic coin, List<dynamic> amounts) => {
      r'$kind': 'SplitCoins',
      'SplitCoins': {'coin': coin, 'amounts': amounts},
    };

/// Replaces the command at [index] with [replacement], remapping every argument
/// in later commands that referenced the old command's result. When
/// [resultIndex] is a `Result`/`NestedResult` map (not an int), references to
/// the replaced command are rewritten to it. Ports the TS SDK's
/// `TransactionDataBuilder.replaceCommand`.
void _replaceCommand(TransactionBlockDataBuilder data, int index,
    List<Map<String, dynamic>> replacement,
    [dynamic resultIndex]) {
  resultIndex ??= index;
  final sizeDiff = replacement.length - 1;
  data.commands
      .replaceRange(index, index + 1, replacement.map(_clone).cast<Map<dynamic, dynamic>>());

  for (var ci = 0; ci < data.commands.length; ci++) {
    if (ci < index + replacement.length) continue;
    _mapCommandArgs(data.commands[ci], (arg) {
      if (arg is! Map) return arg;
      if (resultIndex is! int) {
        final refsReplaced =
            (arg.containsKey('Result') && arg['Result'] == index) ||
                (arg.containsKey('NestedResult') &&
                    (arg['NestedResult'] as List)[0] == index);
        if (refsReplaced) {
          if (!arg.containsKey('NestedResult') ||
              (arg['NestedResult'] as List)[1] == 0) {
            return _clone(resultIndex);
          }
          throw ArgumentError('Cannot replace command $index with a specific '
              'result type: nested element cannot be mapped');
        }
      }
      if (arg.containsKey('Result')) {
        if (arg['Result'] == index && resultIndex is int) {
          arg['Result'] = resultIndex;
        }
        if (arg['Result'] > index) {
          arg['Result'] = arg['Result'] + sizeDiff;
        }
      } else if (arg.containsKey('NestedResult')) {
        final nr = arg['NestedResult'] as List;
        if (nr[0] == index && resultIndex is int) {
          return {
            r'$kind': 'NestedResult',
            'NestedResult': [resultIndex, nr[1]]
          };
        }
        if (nr[0] > index) nr[0] = nr[0] + sizeDiff;
      }
      return arg;
    });
  }
}

void _mapCommandArgs(Map command, dynamic Function(dynamic) fn) {
  if (command['MoveCall'] != null) {
    command['MoveCall']['arguments'] =
        (command['MoveCall']['arguments'] as List).map(fn).toList();
  } else if (command['TransferObjects'] != null) {
    command['TransferObjects']['objects'] =
        (command['TransferObjects']['objects'] as List).map(fn).toList();
    command['TransferObjects']['address'] =
        fn(command['TransferObjects']['address']);
  } else if (command['SplitCoins'] != null) {
    command['SplitCoins']['coin'] = fn(command['SplitCoins']['coin']);
    command['SplitCoins']['amounts'] =
        (command['SplitCoins']['amounts'] as List).map(fn).toList();
  } else if (command['MergeCoins'] != null) {
    command['MergeCoins']['destination'] =
        fn(command['MergeCoins']['destination']);
    command['MergeCoins']['sources'] =
        (command['MergeCoins']['sources'] as List).map(fn).toList();
  } else if (command['MakeMoveVec'] != null) {
    command['MakeMoveVec']['elements'] =
        (command['MakeMoveVec']['elements'] as List).map(fn).toList();
  } else if (command['Upgrade'] != null) {
    command['Upgrade']['ticket'] = fn(command['Upgrade']['ticket']);
  }
  // Publish and (already-resolved) $Intent carry no result arguments.
}

dynamic _clone(dynamic v) {
  if (v is Map) {
    return {for (final e in v.entries) e.key: _clone(e.value)};
  }
  if (v is List) return v.map(_clone).toList();
  return v;
}
