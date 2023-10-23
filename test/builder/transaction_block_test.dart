
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
    expect(() => tx.serialize(), returnsNormally);
  });

  test('can be serialized and deserialized to the same values with onlyTransactionKind', () async {
    final tx = TransactionBlock();
    tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
    final bytes = await tx.build(BuildOptions(onlyTransactionKind: true));
    final tx2 = TransactionBlock.fromKind(bytes);
    final bytes2 = await tx2.build(BuildOptions(onlyTransactionKind: true));
    expect(bytes, bytes2);
  });

  test('can be serialized and deserialized to the same values', () {
    final tx = TransactionBlock();
    tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
    final serialized = tx.serialize();
    final tx2 = TransactionBlock.from(serialized);
    expect(serialized, tx2.serialize());
  });

  test('allows transfer with the result of split transactions', () {
    final tx = TransactionBlock();
    final coin = tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
    tx.add(Transactions.transferObjects([coin], tx.object('0x2')));
    debugPrint(tx.serialize());
  });

  test('supports nested results through either array index or destructuring', () {
    final tx = TransactionBlock();
    final registerResult = tx.add(
      Transactions.moveCall(
        target: '0x2::game::register',
      )
    );

    final result0 = {"kind": "NestedResult", "index": 0, "resultIndex": 0};
    final result1 = {"kind": "NestedResult", "index": 0, "resultIndex": 1};

    expect(result0, registerResult[0]);
    expect(result1, registerResult[1]);
  });

  group('offline build', () {

    SuiObjectRef ref() {
      return SuiObjectRef(
        toB58(Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9])),
        (Random().nextDouble() * 100000).toStringAsFixed(0).padRight(64, '0'),
        (Random().nextDouble() * 100000).toInt()
      );
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
      tx.setExpiration(1);
      await tx.build();
    });

    test('builds a split transaction', () async {
      final tx = setup();
      tx.add(Transactions.splitCoins(tx.gas, [tx.pure(Inputs.pure(100, 'u64'))]));
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
    });

    test('can determine the type of inputs for built-in transactions', () async {
      final tx = setup();
      tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
      tx.add(Transactions.splitCoins(tx.gas, [tx.pure(Inputs.pure(100, BCS.U64))]));
      await tx.build();
    });

    test('supports pre-serialized inputs as Uint8Array', () async {
      final tx = setup();
      final inputBytes = builder.ser(BCS.U64, BigInt.from(100)).toBytes();
      // Use bytes directly in pure value:
      tx.add(Transactions.splitCoins(tx.gas, [tx.pureBytes(inputBytes)]));
      // Use bytes in input helper:
      tx.add(Transactions.splitCoins(tx.gas, [tx.pure(Inputs.pure(inputBytes))]));
      await tx.build();
    });

    test('builds a more complex interaction', () async {
      final tx = setup();
      final coin = tx.add(Transactions.splitCoins(tx.gas, [tx.pure(Inputs.pure(100, 'u64'))]));
      tx.add(Transactions.mergeCoins(tx.gas, [coin, tx.object(Inputs.objectRef(ref()))]));
      tx.add(
        Transactions.moveCall(
          target: '0x2::devnet_nft::mint',
          typeArguments: [],
          arguments: [
            tx.pure(Inputs.pure('foo', 'string')),
            tx.pure(Inputs.pure('bar', 'string')),
            tx.pure(Inputs.pure('baz', 'string')),
          ],
        ),
      );

      final bytes = await tx.build();
      final tx2 = TransactionBlock.fromBytes(bytes);
      final bytes2 = await tx2.build();

      expect(bytes, bytes2);
    });

  });

}