import 'dart:convert';
import 'dart:io';

import 'package:bcs/bcs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';
import 'package:sui/utils/hex.dart';

void main() {
  final document =
      jsonDecode(File('test/fixtures/upstream_bcs.json').readAsStringSync())
          as Map;
  final schemas = <String, BcsType>{
    'TransactionExpiration': SuiBcs.TransactionExpiration,
    'CallArg': SuiBcs.CallArg,
    'TransactionKind': SuiBcs.TransactionKind,
    'TransactionEffects': SuiBcs.TransactionEffects,
  };
  for (final fixture in document['fixtures'] as List) {
    test('BCS matches official 2.37.0: ${fixture['name']}', () {
      final schema = schemas[fixture['type']]!;
      final expected = fixture['hex'] as String;
      expect(
        schema
            .serialize(
              fixture['input'],
              options: BcsWriterOptions(maxSize: 100000),
            )
            .toHex(),
        expected,
      );
      expect(
        schema
            .serialize(
              schema.parse(Hex.decode(expected)),
              options: BcsWriterOptions(maxSize: 100000),
            )
            .toHex(),
        expected,
      );
    });
  }

  test('allowed proposers reject empty, duplicates, unsorted and overflow', () {
    for (final values in <List<int>>[
      [],
      [1, 1],
      [2, 1],
      [-1],
      [0x100000000],
    ]) {
      expect(
        () => SuiBcs.AllowedProposers.serialize({
          'epoch': '1',
          'proposers': values,
        }),
        throwsArgumentError,
      );
    }
    // Decoding an unsorted set is allowed on chain; serializing/submitting is not.
    final bytes =
        Bcs.struct('wire', {
          'epoch': Bcs.u64(),
          'proposers': Bcs.vector(Bcs.u32()),
        }).serialize({
          'epoch': '1',
          'proposers': [2, 1],
        }).toBytes();
    expect(SuiBcs.AllowedProposers.parse(bytes)['proposers'], [2, 1]);
  });
}
