import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction_block_data.dart';

Map<String, dynamic> inputArg(int index) =>
    {"\$kind": 'Input', "Input": index};

void main() {
  group('TransactionBlockDataBuilder.getInputUses', () {
    // Regression: list-valued argument positions used to be rewritten with a
    // lazy `.map(...)`, so the visitor callback never fired during
    // resolution (e.g. isUsedAsMutable missed shared objects passed as
    // MergeCoins sources and serialized them as immutable).
    test('visits arguments in every command position eagerly', () {
      final builder = TransactionBlockDataBuilder();
      builder.inputs.add({"\$kind": 'Object', "Object": {}});
      builder.commands.addAll([
        <String, dynamic>{
          'MoveCall': <String, dynamic>{
            'package': '0x2',
            'module': 'coin',
            'function': 'join',
            'typeArguments': [],
            'arguments': [inputArg(0)],
          },
        },
        <String, dynamic>{
          'TransferObjects': <String, dynamic>{
            'objects': [inputArg(0)],
            'address': inputArg(0),
          },
        },
        <String, dynamic>{
          'SplitCoins': <String, dynamic>{
            'coin': inputArg(0),
            'amounts': [inputArg(0)],
          },
        },
        <String, dynamic>{
          'MergeCoins': <String, dynamic>{
            'destination': inputArg(0),
            'sources': [inputArg(0)],
          },
        },
        <String, dynamic>{
          'MakeMoveVec': <String, dynamic>{
            'type': null,
            'elements': [inputArg(0)],
          },
        },
        <String, dynamic>{
          'Upgrade': <String, dynamic>{
            'modules': [],
            'dependencies': [],
            'package': '0x2',
            'ticket': inputArg(0),
          },
        },
      ]);

      var visits = 0;
      builder.getInputUses(0, (arg, command) => visits++);
      expect(visits, 9);

      // The rewritten argument lists must be real lists, not lazy iterables
      // that re-run the visitor on every later iteration.
      for (final command in builder.commands) {
        final body = (command.values.first as Map);
        for (final value in body.values) {
          if (value is Iterable) {
            expect(value, isA<List>(),
                reason: 'lazy iterable left in $command');
          }
        }
      }
      expect(visits, 9);
    });
  });
}
