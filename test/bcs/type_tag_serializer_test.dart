
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/bcs/type_tag_serializer.dart';

void main() {

  group('parseFromStr', () {

    test('parses nested struct type from a string', () {
      const typeStr =
        '0x2::balance::Supply<0x72de5feb63c0ab6ed1cda7e5b367f3d0a999add7::amm::LP<0x2::sui::SUI, 0xfee024a3c0c03ada5cdbda7d0e8b68802e6dec80::example_coin::EXAMPLE_COIN>>';
      final act = TypeTagSerializer.parseFromStr(typeStr);
      final exp = {
        "struct": {
          "address": '0x2',
          "module": 'balance',
          "name": 'Supply',
          "typeParams": [
            {
              "struct": {
                "address": '0x72de5feb63c0ab6ed1cda7e5b367f3d0a999add7',
                "module": 'amm',
                "name": 'LP',
                "typeParams": [
                  {
                    "struct": {
                      "address": '0x2',
                      "module": 'sui',
                      "name": 'SUI',
                      "typeParams": [],
                    },
                  },
                  {
                    "struct": {
                      "address": '0xfee024a3c0c03ada5cdbda7d0e8b68802e6dec80',
                      "module": 'example_coin',
                      "name": 'EXAMPLE_COIN',
                      "typeParams": [],
                    },
                  },
                ],
              },
            },
          ],
        },
      };
      expect(act, exp);
    });

    test('parses non parametrized struct type from a string', () {
      const typeStr = '0x72de5feb63c0ab6ed1cda7e5b367f3d0a999add7::foo::FOO';
      final act = TypeTagSerializer.parseFromStr(typeStr);
      final exp = {
        "struct": {
          "address": '0x72de5feb63c0ab6ed1cda7e5b367f3d0a999add7',
          "module": 'foo',
          "name": 'FOO',
          "typeParams": [],
        },
      };
      expect(act, exp);
    });
    
  });

  group('tagToString', () {
    test('converts nested struct type to a string', () {
      final type = {
        "struct": {
          "address": '0x2',
          "module": 'balance',
          "name": 'Supply',
          "typeParams": [
            {
              "struct": {
                "address": '0x72de5feb63c0ab6ed1cda7e5b367f3d0a999add7',
                "module": 'amm',
                "name": 'LP',
                "typeParams": [
                  {
                    "struct": {
                      "address": '0x2',
                      "module": 'sui',
                      "name": 'SUI',
                      "typeParams": [],
                    },
                  },
                  {
                    "struct": {
                      "address": '0xfee024a3c0c03ada5cdbda7d0e8b68802e6dec80',
                      "module": 'example_coin',
                      "name": 'EXAMPLE_COIN',
                      "typeParams": [],
                    },
                  },
                ],
              },
            },
          ],
        },
      };
      final act = TypeTagSerializer.tagToString(type);
      const exp =
        '0x2::balance::Supply<0x72de5feb63c0ab6ed1cda7e5b367f3d0a999add7::amm::LP<0x2::sui::SUI, 0xfee024a3c0c03ada5cdbda7d0e8b68802e6dec80::example_coin::EXAMPLE_COIN>>';
      expect(act, exp);
    });
  });

}