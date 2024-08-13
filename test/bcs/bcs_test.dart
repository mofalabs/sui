
import 'dart:math';

import 'package:bcs/bcs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/bcs/sui_bcs.dart';
import 'package:sui/builder/commands.dart';
import 'package:sui/builder/inputs.dart';
import 'package:sui/builder/transaction.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/common.dart';

void main() {

  test('can construct and serialize an empty tranaction', () {
    final tx = Transaction();
    expect(() => tx.serialize(), returnsNormally);
  });

  test('can construct a receiving transaction argument', () {
    final tx = Transaction();
    tx.object(Inputs.receivingRef(ref()));
    expect(() => tx.serialize(), returnsNormally);
  });

  test('receiving transaction argument different from object argument', () {
    final oref = ref();
    final rtx = Transaction();
    rtx.object(Inputs.receivingRef(oref));
    final otx = Transaction();
    otx.object(Inputs.objectRef(oref));
    expect(() => rtx.serialize(), returnsNormally);
    expect(() => otx.serialize(), returnsNormally);
    expect(otx.serialize() != rtx.serialize(), true);
  });

  test('can be serialized and deserialized to the same values', () {
    final tx = Transaction();
    tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
    final serialized = tx.serialize();
    final tx2 = Transaction.from(serialized);
    expect(serialized, tx2.serialize());
  });

  test('allows transfer with the result of split transactions', () {
    final tx = Transaction();
    final coin = tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
    tx.add(Transactions.transferObjects([coin], tx.object('0x2')));
  });

test('can serialize simplified programmable call struct', () {
    Map<String, dynamic> moveCall = {
      'package': '0x2',
      'module': 'display',
      'function': 'new',
      'typeArguments': [normalizeStructTagString('0x6::capy::Capy')],
      'arguments': [
        {
          '\$kind': 'GasCoin',
          'GasCoin': true,
        },
        {
          '\$kind': 'NestedResult',
          'NestedResult': [0, 1],
        },
        {
          '\$kind': 'Input',
          'Input': 3,
        },
        {
          '\$kind': 'Result',
          'Result': 1,
        },
      ],
    };

    final bytes = SuiBcs.ProgrammableMoveCall.serialize(moveCall).toBytes();
    final result = SuiBcs.ProgrammableMoveCall.parse(bytes);

    expect(result['arguments'], equals(moveCall['arguments']));
    expect(result['function'], equals(moveCall['function']));
    expect(result['module'], equals(moveCall['module']));
    expect(
      normalizeSuiAddress(result['package'] as String),
      equals(normalizeSuiAddress(moveCall['package'] as String)),
    );
    expect(result['typeArguments'][0], equals(moveCall['typeArguments'][0]));
  });

  test('can serialize transaction data with a programmable transaction', () {
    final sui = normalizeSuiAddress('0x2');
    final txData = {
      '\$kind': 'V1',
      'V1': {
        'sender': normalizeSuiAddress('0xBAD'),
        'expiration': {'\$kind': 'None', 'None': true},
        'gasData': {
          'payment': [ref().toJson()],
          'owner': sui,
          'price': BigInt.parse('1'),
          'budget': BigInt.parse('1000000'),
        },
        'kind': {
          '\$kind': 'ProgrammableTransaction',
          'ProgrammableTransaction': {
            'inputs': [
              {
                '\$kind': 'Object',
                'Object': {
                  '\$kind': 'ImmOrOwnedObject',
                  'ImmOrOwnedObject': ref().toJson(),
                },
              },
              {
                '\$kind': 'Pure',
                'Pure': {
                  'bytes': Bcs.vector(SuiBcs.STRING).serialize(['name', 'description', 'img_url']).toBase64(),
                },
              },
              {
                '\$kind': 'Pure',
                'Pure': {
                  'bytes': Bcs.vector(SuiBcs.STRING).serialize([
                    'Capy {name}',
                    'A cute little creature',
                    'https://api.capy.art/{id}/svg',
                  ]).toBase64(),
                },
              },
              {
                '\$kind': 'Pure',
                'Pure': {
                  'bytes': SuiBcs.Address.serialize(ref().objectId).toBase64(),
                },
              },
            ],
            'commands': [
              {
                '\$kind': 'MoveCall',
                'MoveCall': {
                  'package': sui,
                  'module': 'display',
                  'function': 'new',
                  'typeArguments': ['$sui::capy::Capy'],
                  'arguments': [
                    {
                      '\$kind': 'Input',
                      'Input': 0,
                    },
                  ],
                },
              },
              {
                '\$kind': 'MoveCall',
                'MoveCall': {
                  'package': sui,
                  'module': 'display',
                  'function': 'add_multiple',
                  'typeArguments': ['$sui::capy::Capy'],
                  'arguments': [
                    {
                      '\$kind': 'Result',
                      'Result': 0,
                    },
                    {
                      '\$kind': 'Input',
                      'Input': 1,
                    },
                    {
                      '\$kind': 'Input',
                      'Input': 2,
                    },
                  ],
                },
              },
              {
                '\$kind': 'MoveCall',
                'MoveCall': {
                  'package': sui,
                  'module': 'display',
                  'function': 'update_version',
                  'typeArguments': ['$sui::capy::Capy'],
                  'arguments': [
                    {
                      '\$kind': 'Result',
                      'Result': 0,
                    },
                  ],
                },
              },
              {
                '\$kind': 'TransferObjects',
                'TransferObjects': {
                  'objects': [
                    {
                      '\$kind': 'Result',
                      'Result': 0,
                    },
                  ],
                  'address': {
                    '\$kind': 'Input',
                    'Input': 3,
                  },
                },
              },
            ],
          },
        },
      },
    };

    final bytes = SuiBcs.TransactionData.serialize(txData).toBytes();
    final result = SuiBcs.TransactionData.parse(bytes);
    expect(result, equals(txData));
  });

  group('offline build', () {

    late Transaction tx;

    setUpAll(() {
      tx = setup();
    });

    test('builds an empty transaction offline when provided sufficient data', () async {
      await tx.build();
    });

    test('supports epoch expiration', () async {
      tx.setExpiration(1);
      await tx.build();
    });

    test('builds a split transaction', () async {
      // tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
      tx.add(Commands.splitCoins(tx.gas, [tx.pure.u8(100)]));
      await tx.build();
    });

    test('breaks reference equality', () {
      final tx2 = Transaction(tx);

      tx.setGasBudget(BigInt.from(999));

      // Ensure that setting budget after a clone does not affect the original:
      expect(tx2.getData() != tx.getData(), true);

      // Ensure `blockData` always breaks reference equality:
      expect(tx.getData() != tx.getData(), true);
      expect(tx.getData().gasData != tx.getData().gasData, true);
      expect(tx.getData().commands != tx.getData().commands, true);
      expect(tx.getData().inputs != tx.getData().inputs, true);
    });

    test('can determine the type of inputs for built-in transactions', () async {
      tx.add(Commands.splitCoins(tx.gas, [tx.pure.u8(100)]));
      await tx.build();
    });

    test('supports pre-serialized inputs as Uint8Array', () async {
      final inputBytes = SuiBcs.U64.serialize(100).toBytes();
      // Use bytes directly in pure value:
      tx.add(Commands.splitCoins(tx.gas, [tx.pure(inputBytes)]));
      await tx.build();
    });

    test('builds a more complex interaction', () async {
      final coin = tx.splitCoins(tx.gas, [tx.pure.u8(100)]);
      tx.add(Commands.mergeCoins(tx.gas, [coin, tx.object(Inputs.objectRef(ref()))]));
      tx.add(
        Commands.moveCall({
          "target": '0x2::devnet_nft::mint',
          "typeArguments": [],
          "arguments": [tx.pure.string('foo'), tx.pure.string('bar'), tx.pure.string('baz')],
        }),
      );

      final bytes = await tx.build();
      final tx2 = Transaction.fromBytes(bytes);
      final bytes2 = await tx2.build();

      expect(bytes, bytes2);
    });

  });

}

SuiObjectRef ref() {
  final random = Random();
	return SuiObjectRef(
    toB58(Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 2,])),
    normalizeSuiAddress(random.nextInt(100000).toString().padRight(64, '0')), 
    random.nextInt(100000),
  );
}

Transaction setup() {
	final tx = Transaction();
	tx.setSender('0x2');
	tx.setGasPrice(BigInt.from(5));
	tx.setGasBudget(BigInt.from(100));
	tx.setGasPayment([ref()]);
	return tx;
}
