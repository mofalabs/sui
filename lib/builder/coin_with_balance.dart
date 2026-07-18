import 'dart:math';

import '../bcs/sui_bcs.dart';
import '../types/coins.dart';
import '../types/common.dart';
import '../types/objects.dart';
import 'inputs.dart';
import 'transaction_block_data.dart';
import 'transaction_builder_client.dart';

/// Resolves `CoinWithBalance` `$Intent` commands into concrete
/// `MergeCoins`/`SplitCoins` commands.
///
/// Swap / DeFi dApps build transactions with `@mysten/sui`'s
/// `coinWithBalance({ balance, type })` to obtain a coin of an exact balance,
/// which serializes to an unresolved `$Intent` the wallet must resolve at build
/// time (like the reference TS SDK's `resolveCoinBalance`). Without this,
/// `Transaction.from(dAppJson).build()` fails converting the `$Intent` command.
///
/// This ports the coin-output paths (splitting the gas coin, or gathering and
/// splitting owned coins of a given type). The newer address-balance path
/// (`outputKind: 'balance'` / `FundsWithdrawal`) is not supported and throws.
const _coinWithBalance = 'CoinWithBalance';
final String _suiType = normalizeStructTagString('0x2::sui::SUI');
const _coinPackage =
    '0x0000000000000000000000000000000000000000000000000000000000000002';

bool _isCwbIntent(dynamic cmd) =>
    cmd is Map &&
    cmd[r'$Intent'] != null &&
    cmd[r'$Intent']['name'] == _coinWithBalance;

Future<void> resolveCoinBalanceIntents(
    TransactionBlockDataBuilder data, TransactionBuilderClient? client) async {
  if (!data.commands.any(_isCwbIntent)) return;
  if (data.sender == null) {
    throw ArgumentError('Sender must be set to resolve CoinWithBalance');
  }
  if (client == null) {
    throw ArgumentError('Client must be provided to build transactions '
        'with CoinWithBalance intents');
  }

  final totalByType = <String, BigInt>{};
  final intentsByType = <String, List<BigInt>>{};

  // First pass: sum required balances per coin type and resolve any
  // zero-balance intents in place (they need no coins).
  for (var i = 0; i < data.commands.length; i++) {
    final cmd = data.commands[i];
    if (!_isCwbIntent(cmd)) continue;
    final d = cmd[r'$Intent']['data'] as Map;
    final type = d['type'] as String;
    final balance = BigInt.parse(d['balance'].toString());
    final outputKind = (d['outputKind'] ?? 'coin') as String;
    if (outputKind != 'coin') {
      throw UnsupportedError(
          'CoinWithBalance outputKind "$outputKind" (address-balance) is not '
          'supported');
    }
    if (balance == BigInt.zero) {
      final coinType = type == 'gas' ? _suiType : type;
      _replaceCommand(data, i, [_moveCall('$_coinPackage::coin::zero', [
        coinType
      ], const [])]);
      continue;
    }
    totalByType[type] = (totalByType[type] ?? BigInt.zero) + balance;
    (intentsByType[type] ??= <BigInt>[]).add(balance);
  }

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

  final coinsByType = <String, List<CoinStruct>>{};
  for (final entry in totalByType.entries) {
    if (entry.key == 'gas') continue;
    coinsByType[entry.key] = await _selectCoins(
        client, data.sender!, entry.key, entry.value, usedIds);
  }

  // Second pass: replace each intent with the real commands. All intents of a
  // type share one merge+split, produced when the first is encountered.
  final typeResults = <String, List<dynamic>>{};
  final typeNext = <String, int>{};
  var index = 0;
  while (index < data.commands.length) {
    final cmd = data.commands[index];
    if (!_isCwbIntent(cmd)) {
      index++;
      continue;
    }
    final type = cmd[r'$Intent']['data']['type'] as String;
    final commands = <Map<String, dynamic>>[];

    if (!typeResults.containsKey(type)) {
      final intents = intentsByType[type]!;
      final sources = <dynamic>[];
      if (type == 'gas') {
        sources.add({r'$kind': 'GasCoin', 'GasCoin': true});
      } else {
        for (final coin in coinsByType[type]!) {
          sources.add(data.addInput(
              'object',
              Inputs.objectRef(
                  SuiObjectRef(coin.digest, coin.coinObjectId, coin.version))));
        }
      }
      final baseCoin = sources.first;
      final rest = sources.sublist(1);
      for (var i = 0; i < rest.length; i += 500) {
        commands.add(_mergeCoins(baseCoin, rest.sublist(i, min(i + 500, rest.length))));
      }
      final splitCmdIndex = index + commands.length;
      commands.add(_splitCoins(
          baseCoin,
          intents
              .map((b) =>
                  data.addInput('pure', Inputs.pure(SuiBcs.U64.serialize(b))))
              .toList()));
      typeResults[type] = [
        for (var i = 0; i < intents.length; i++)
          {r'$kind': 'NestedResult', 'NestedResult': [splitCmdIndex, i]}
      ];
      typeNext[type] = 0;
    }

    final intentResult = typeResults[type]![typeNext[type]!];
    typeNext[type] = typeNext[type]! + 1;
    _replaceCommand(data, index, commands, intentResult);
    index += commands.length;
  }
}

Future<List<CoinStruct>> _selectCoins(TransactionBuilderClient client,
    String owner, String coinType, BigInt needed, Set<String> usedIds) async {
  final coins = <CoinStruct>[];
  var total = BigInt.zero;
  var remaining = needed;
  String? cursor;
  while (true) {
    final page = await client.getCoins(owner, coinType: coinType, cursor: cursor);
    for (final c in page.data) {
      if (usedIds.contains(normalizeSuiAddress(c.coinObjectId))) continue;
      coins.add(c);
      final b = BigInt.parse(c.balance);
      total += b;
      remaining -= b;
    }
    if (remaining <= BigInt.zero || !page.hasNextPage) break;
    cursor = page.nextCursor;
  }
  if (total < needed) {
    throw ArgumentError('Insufficient balance of $coinType for owner $owner. '
        'Required: $needed, Available: $total');
  }
  return coins;
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
        } else if (arg['Result'] > index) {
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
