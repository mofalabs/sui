
import 'dart:math';

import 'package:bcs/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/inputs.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/sui_bcs.dart';

void main() {

  test('can construct and serialize an empty tranaction', () {
    final tx = TransactionBlock();
    expect(() => tx.serialize(), returnsNormally);
  });

  test('can construct a receiving transaction argument', () {
    final tx = TransactionBlock();
    tx.object(Inputs.receivingRef(ref()));
    expect(() => tx.serialize(), returnsNormally);
  });

  test('receiving transaction argument different from object argument', () {
    final oref = ref();
    final rtx = TransactionBlock();
    rtx.object(Inputs.receivingRef(oref));
    final otx = TransactionBlock();
    otx.object(Inputs.objectRef(oref));
    expect(() => rtx.serialize(), returnsNormally);
    expect(() => otx.serialize(), returnsNormally);
    expect(otx.serialize() != rtx.serialize(), true);
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
  });

  group('offline build', () {

    late TransactionBlock tx;

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
      tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
      await tx.build();
    });

    test('breaks reference equality', () {
      final tx2 = TransactionBlock(tx);

      tx.setGasBudget(BigInt.from(999));

      // Ensure that setting budget after a clone does not affect the original:
      expect(tx2.blockData != tx.blockData, true);

      // Ensure `blockData` always breaks reference equality:
      expect(tx.blockData != tx.blockData, true);
      expect(tx.blockData.gasConfig != tx.blockData.gasConfig, true);
      expect(tx.blockData.transactions != tx.blockData.transactions, true);
      expect(tx.blockData.inputs != tx.blockData.inputs, true);
    });

    test('can determine the type of inputs for built-in transactions', () async {
      tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
      await tx.build();
    });

    test('supports pre-serialized inputs as Uint8Array', () async {
      final inputBytes = bcs.ser('u64', 100).toBytes();
      // Use bytes directly in pure value:
      tx.add(Transactions.splitCoins(tx.gas, [tx.pure(inputBytes)]));
      // Use bytes in input helper:
      tx.add(Transactions.splitCoins(tx.gas, [tx.pure(Inputs.pure(inputBytes))]));
      await tx.build();
    });

    test('builds a more complex interaction', () async {
      final coin = tx.splitCoins(tx.gas, [tx.pureInt(100)]);
      tx.add(Transactions.mergeCoins(tx.gas, [coin, tx.object(Inputs.objectRef(ref()))]));
      tx.add(
        Transactions.moveCall(
          target: '0x2::devnet_nft::mint',
          typeArguments: [],
          arguments: [tx.pureString('foo'), tx.pureString('bar'), tx.pureString('baz')],
        ),
      );
      await tx.build();
    });

    test('uses a receiving argument', () async {
      tx.object(Inputs.objectRef(ref()));
      final coin = tx.add(Transactions.splitCoins(tx.gas, [tx.pureInt(100)]));
      tx.add(Transactions.mergeCoins(tx.gas, [coin, tx.object(Inputs.objectRef(ref()))]));
      tx.add(
        Transactions.moveCall(
          target: '0x2::devnet_nft::mint',
          typeArguments: [],
          arguments: [tx.object(Inputs.objectRef(ref())), tx.object(Inputs.receivingRef(ref()))],
        ),
      );

      final bytes = await tx.build();
      final tx2 = TransactionBlock.fromBytes(bytes);
      final bytes2 = await tx2.build();

      expect(bytes ,bytes2);
    });

    test('builds a more complex interaction', () async {
      final coin = tx.splitCoins(tx.gas, [tx.pureInt(100)]);
      tx.add(Transactions.mergeCoins(tx.gas, [coin, tx.object(Inputs.objectRef(ref()))]));
      tx.add(
        Transactions.moveCall(
          target: '0x2::devnet_nft::mint',
          typeArguments: [],
          arguments: [tx.pureString('foo'), tx.pureString('bar'), tx.pureString('baz')],
        ),
      );

      final bytes = await tx.build();
      final tx2 = TransactionBlock.fromBytes(bytes);
      final bytes2 = await tx2.build();

      expect(bytes, bytes2);
    });
  });
}

SuiObjectRef ref() {
  final random = Random();
	return SuiObjectRef(
    toB58(Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9])),
    random.nextInt(100000).toString().padRight(64, '0'), 
    random.nextInt(100000),
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
