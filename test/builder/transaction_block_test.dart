
import 'dart:math';

import 'package:bcs/bcs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/bcs.dart';
import 'package:sui/builder/inputs.dart';
import 'package:sui/builder/transaction_block.dart';
import 'package:sui/builder/transactions.dart';
import 'package:sui/types/objects.dart';

void main() {

  test('can construct and serialize an empty tranaction', () {
    final tx = TransactionBlock();
    expect(() => tx.serialize(), throwsA(anything));
  });

  test('can be serialized and deserialized to the same values', () {
    final tx = TransactionBlock();
    tx.add(Transactions.SplitCoins(tx.gas, [tx.pure(100)]));
    final serialized = tx.serialize();
    final tx2 = TransactionBlock.from(serialized);
    expect(serialized, tx2.serialize());
  });

  test('allows transfer with the result of split transactions', () {
    final tx = TransactionBlock();
    final coin = tx.add(Transactions.SplitCoins(tx.gas, [tx.pure(100)]));
    tx.add(Transactions.TransferObjects([coin], tx.object('0x2')));
    debugPrint(tx.serialize());
  });

  test('supports nested results through either array index or destructuring', () {
    final tx = TransactionBlock();
    final registerResult = tx.add(
      Transactions.MoveCall({
        "target": '0x2::game::register',
      }),
    );

    // const [nft, account] = registerResult;

    // // NOTE: This might seem silly but destructuring works differently than property access.
    // expect(nft).toBe(registerResult[0]);
    // expect(account).toBe(registerResult[1]);
  });

  group('offline build', () {

    Map<String, dynamic> ref() {
      return {
        "digest": toB58(Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9])),
        "objectId": (Random().nextDouble() * 100000).toStringAsFixed(0).padRight(64, '0'),
        "version": (Random().nextDouble() * 100000).toInt()
      };
    }

    TransactionBlock setup() {
      final tx = TransactionBlock();
      tx.setSender('0x2');
      tx.setGasPrice(BigInt.from(5));
      tx.setGasBudget(BigInt.from(100));
      tx.setGasPayment([ref()]);
      return tx;
    }

    test('builds an empty transaction offline when provided sufficient data', () async {
      final tx = setup();
      await tx.build();
    });

    test('supports epoch expiration', () async {
      final tx = setup();
      tx.setExpiration({ "Epoch": 1 });
      await tx.build();
    });

    test('builds a split transaction', () async {
      final tx = setup();
      tx.add(Transactions.SplitCoins(tx.gas, [tx.pure(Inputs.Pure(100, 'u64'))]));
      await tx.build();
    });

    test('breaks reference equality', () async {
      final tx = setup();
      final tx2 = TransactionBlock(tx);

      tx.setGasBudget(BigInt.from(999));

      // Ensure that setting budget after a clone does not affect the original:
      expect(tx2.blockData, isNot(equals(tx.blockData)));

      // Ensure `blockData` always breaks reference equality:
      expect(tx.blockData, isNot(same(tx.blockData)));
      expect(tx.blockData.gasConfig, isNot(same(tx.blockData.gasConfig)));
      // expect(tx.blockData.transactions, isNot(same(tx.blockData.transactions)));
      // expect(tx.blockData.inputs, isNot(same(tx.blockData.inputs)));
    });

    test('can determine the type of inputs for built-in transactions', () async {
      final tx = setup();
      // tx.add(Transactions.SplitCoins(tx.gas, [tx.pure(100)]));
      tx.add(Transactions.SplitCoins(tx.gas, [tx.pure(Inputs.Pure(100, 'u64'))]));
      await tx.build();
    });

    test('supports pre-serialized inputs as Uint8Array', () async {
      final tx = setup();
      final inputBytes = builder.ser('u64', BigInt.from(100)).toBytes();
      // Use bytes directly in pure value:
      tx.add(Transactions.SplitCoins(tx.gas, [tx.pure(inputBytes)]));
      // Use bytes in input helper:
      tx.add(Transactions.SplitCoins(tx.gas, [tx.pure(Inputs.Pure(inputBytes))]));
      await tx.build();
    });

    test('builds a more complex interaction', () async {
      final tx = setup();
      final coin = tx.add(Transactions.SplitCoins(tx.gas, [tx.pure(Inputs.Pure(100, 'u64'))]));
      tx.add(Transactions.MergeCoins(tx.gas, [coin, tx.object(Inputs.ObjectRef(ref()))]));
      tx.add(
        Transactions.MoveCall({
          "target": '0x2::devnet_nft::mint',
          "typeArguments": [],
          "arguments": [
            tx.pure(Inputs.Pure('foo', 'string')),
            tx.pure(Inputs.Pure('bar', 'string')),
            tx.pure(Inputs.Pure('baz', 'string')),
          ],
        }),
      );
      await tx.build();
    });

    test('builds a more complex interaction', () async {
      final tx = setup();
      final coin = tx.add(Transactions.SplitCoins(tx.gas, [tx.pure(Inputs.Pure(100, 'u64'))]));
      tx.add(Transactions.MergeCoins(tx.gas, [coin, tx.object(Inputs.ObjectRef(ref()))]));
      tx.add(
        Transactions.MoveCall({
          "target": '0x2::devnet_nft::mint',
          "typeArguments": [],
          "arguments": [
            tx.pure(Inputs.Pure('foo', 'string')),
            tx.pure(Inputs.Pure('bar', 'string')),
            tx.pure(Inputs.Pure('baz', 'string')),
          ],
        }),
      );

      final bytes = await tx.build();
      final tx2 = TransactionBlock.from(bytes);
      final bytes2 = await tx2.build();

      expect(bytes, bytes2);
    });

  });

}