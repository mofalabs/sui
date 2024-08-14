
import 'dart:math';
import 'dart:typed_data';

import 'package:bcs/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/bcs/sui_bcs.dart';
import 'package:sui/builder/commands.dart';
import 'package:sui/builder/inputs.dart';
import 'package:sui/builder/transaction.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';

void main() {
  test('can construct and serialize an empty transaction', () {
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
    expect(otx.serialize(), isNot(equals(rtx.serialize())));
  });

  test(
      'can be serialized and deserialized to the same values with onlyTransactionKind',
      () async {
    final tx = Transaction();
    tx.add(Commands.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(100))]));
    final bytes = await tx.build(BuildOptions(onlyTransactionKind: true));
    final tx2 = Transaction.fromKind(bytes);
    final bytes2 = await tx2.build(BuildOptions(onlyTransactionKind: true));
    expect(bytes, bytes2);
  });

  test('can be serialized and deserialized to the same values', () {
    final tx = Transaction();
    tx.add(Commands.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(100))]));
    final serialized = tx.serialize();
    final tx2 = Transaction.from(serialized);
    expect(serialized, equals(tx2.serialize()));
  });

  test('allows transfer with the result of split Commands', () {
    final tx = Transaction();
    final coin = tx.add(Commands.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(100))]));
    tx.add(Commands.transferObjects([coin], tx.object('0x2')));
  });

  test('supports nested results through either array index or destructuring', () {
    final tx = Transaction();
    final registerResult = tx.add(
      Commands.moveCall({
        "target": '0x2::game::register',
      }),
    );

    final nft = registerResult[0];
    final account = registerResult[1];

    expect(nft, equals(registerResult[0]));
    expect(account, equals(registerResult[1]));
  });

  group('offline build', () {
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
      tx.add(Commands.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(100))]));
      await tx.build();
    });

    test('breaks reference equality', () {
      final tx = setup();
      final tx2 = Transaction(tx);

      tx.setGasBudget(BigInt.from(999));

      expect(tx2.blockData, isNot(equals(tx.blockData)));

      expect(tx.blockData, isNot(same(tx.blockData)));
      expect(tx.blockData.gasConfig, isNot(same(tx.blockData.gasConfig)));
      // expect(tx.blockData.transactions, isNot(same(tx.blockData.transactions)));
      expect(tx.blockData.inputs, isNot(same(tx.blockData.inputs)));
    });

    test('can determine the type of inputs for built-in Commands', () async {
      final tx = setup();
      tx.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(100))]);
      await tx.build();
    });

    test('supports pre-serialized inputs as Uint8List', () async {
      final tx = setup();
      final inputBytes = SuiBcs.U64.serialize(BigInt.from(100)).toBytes();
      // Use bytes directly in pure value:
      tx.add(Commands.splitCoins(tx.gas, [tx.pure(inputBytes)]));
      await tx.build();
    });

    test('builds a more complex interaction', () async {
      final tx = setup();
      final coin = tx.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(100))]);
      tx.add(Commands.mergeCoins(tx.gas, [coin, tx.object(Inputs.objectRef(ref()))]));
      tx.add(
        Commands.moveCall({
          "target": '0x2::devnet_nft::mint',
          "typeArguments": [],
          "arguments": [tx.pure.string('foo'), tx.pure.string('bar'), tx.pure.string('baz')],
        }),
      );
      await tx.build();
    });

    test('uses a receiving argument', () async {
      final tx = setup();
      tx.object(Inputs.objectRef(ref()));
      final coin = tx.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(100))]);
      tx.add(Commands.mergeCoins(tx.gas, [coin, tx.object(Inputs.objectRef(ref()))]));
      tx.add(
        Commands.moveCall({
          "target": '0x2::devnet_nft::mint',
          "typeArguments": [],
          "arguments": [tx.object(Inputs.objectRef(ref())), tx.object(Inputs.receivingRef(ref()))],
        }),
      );

      final bytes = await tx.build();
      final tx2 = Transaction.fromBytes(bytes);
      final bytes2 = await tx2.build();

      expect(bytes, equals(bytes2));
    });

    test('builds a more complex interaction and verifies consistency', () async {
      final tx = setup();
      final coin = tx.splitCoins(tx.gas, [tx.pure.u64(BigInt.from(100))]);
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

      expect(bytes, equals(bytes2));
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