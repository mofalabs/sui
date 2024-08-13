
import 'package:bcs/bcs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/bcs/sui_bcs.dart';
import 'package:sui/builder/transaction.dart';

void main() {

  group('tx.pure serialization', () {
    test('serialized pure values', () {
      final tx = Transaction();

      tx.pure.u8(1);
      tx.pure.u16(1);
      tx.pure.u32(1);
      tx.pure.u64(BigInt.one);
      tx.pure.u128(BigInt.one);
      tx.pure.u256(BigInt.one);
      tx.pure.boolean(true);
      tx.pure.string('foo');
      tx.pure.address('0x2');
      tx.pure.id('0x2');
      tx.pure(Bcs.vector(SuiBcs.U8).serialize([1, 2, 3]));
      tx.pure(Bcs.option(SuiBcs.U8).serialize(1));
      tx.pure(Bcs.option(SuiBcs.U8).serialize(null));
      tx.pure(
        Bcs.option(SuiBcs.VECTOR(SuiBcs.VECTOR(Bcs.option(SuiBcs.U8)))).serialize([
          [1, null, 3],
          [4, null, 6],
        ]),
      );

      final tx2 = Transaction();

      tx2.pure('u8', 1);
      tx2.pure('u16', 1);
      tx2.pure('u32', 1);
      tx2.pure('u64', 1);
      tx2.pure('u128', 1);
      tx2.pure('u256', 1);
      tx2.pure('bool', true);
      tx2.pure('string', 'foo');
      tx2.pure('address', '0x2');
      tx2.pure('id', '0x2');
      tx2.pure('vector<u8>', [1, 2, 3]);
      tx2.pure('option<u8>', 1);
      tx2.pure('option<u8>', null);
      tx2.pure('option<vector<vector<option<u8>>>>', [
        [1, null, 3],
        [4, null, 6],
      ]);

      expect(tx.getData().inputs, tx2.getData().inputs);

      expect(tx.getData().inputs, 
        [
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AQ==",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AQA=",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AQAAAA==",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AQAAAAAAAAA=",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AQAAAAAAAAAAAAAAAAAAAA==",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AQ==",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "A2Zvbw==",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAI=",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAI=",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AwECAw==",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AQE=",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AA==",
            },
          },
          {
            "\$kind": "Pure",
            "Pure": {
              "bytes": "AQIDAQEAAQMDAQQAAQY=",
            },
          },
        ]
      );

    });

  });

}