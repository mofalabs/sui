
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/types/common.dart';

void main() {

  group('parseStructTag', () {
    test('parses struct tags correctly', () {

      expect(jsonEncode(parseStructTag('0x2::foo::bar')),
        jsonEncode({
          "address": "0x0000000000000000000000000000000000000000000000000000000000000002",
          "module": "foo",
          "name": "bar",
          "typeParams": [],
        })
      );

      expect(
        jsonEncode(parseStructTag('0x2::foo::bar<0x3::baz::qux<0x4::nested::result, 0x4::nested::other>, bool>')),
        jsonEncode({
          "address": "0x0000000000000000000000000000000000000000000000000000000000000002",
          "module": "foo",
          "name": "bar",
          "typeParams": [
            {
              "address": "0x0000000000000000000000000000000000000000000000000000000000000003",
              "module": "baz",
              "name": "qux",
              "typeParams": [
                {
                  "address": "0x0000000000000000000000000000000000000000000000000000000000000004",
                  "module": "nested",
                  "name": "result",
                  "typeParams": [],
                },
                {
                  "address": "0x0000000000000000000000000000000000000000000000000000000000000004",
                  "module": "nested",
                  "name": "other",
                  "typeParams": [],
                },
              ],
            },
            "bool",
          ],
        })
      );
    });
  });

  group('normalizeStructTag', () {
    test('normalizes package addresses', () {
      expect(normalizeStructTagString('0x2::kiosk::Item'),
        '0x0000000000000000000000000000000000000000000000000000000000000002::kiosk::Item',
      );

      expect(normalizeStructTagString('0x2::foo::bar<0x3::another::package>'),
        '0x0000000000000000000000000000000000000000000000000000000000000002::foo::bar<0x0000000000000000000000000000000000000000000000000000000000000003::another::package>',
      );
    });
  });

}
