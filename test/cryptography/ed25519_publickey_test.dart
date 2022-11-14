
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/ed25519_publickey.dart';
import 'package:sui/cryptography/secp256k1.dart';
import 'package:sui/utils/hex.dart';

void main() {

  final tmp = { "helo": "" };

  final TEST_CASES = [
    [
      'UdGRWooy48vGTs0HBokIis5NK+DUjiWc9ENUlcfCCBE=',
      '0x3415400a4bfdf924aefa55446e5f4cd6e9a9399f',
    ],
    [
      '0PTAfQmNiabgbak9U/stWZzKc5nsRqokda2qnV2DTfg=',
      '0x2e6dad710b343b8655825bc420783aaa5ade08c2',
    ],
    [
      '6L/l0uhGt//9cf6nLQ0+24Uv2qanX/R6tn7lWUJX1Xk=',
      '0x607a2403069d547c3fbba4b9e22793c7d78abb1f',
    ],
    [
      '6qZ88i8NJjaD+qZety3qXi4pLptGKS3wwO8bfDmUD+Y=',
      '0x7a4b0fd76cce17ef014d64ec5e073117bfc0b4de',
    ],
    [
      'RgdFhZXGe21x48rhe9X+Kh/WyFCo9ft6e9nQKZYHpi0=',
      '0xecd7ef15f92a26bc8f22a88a7786fe1aae1051c6',
    ],
  ];

  const VALID_KEY_BASE64 = 'Uz39UFseB/B38iBwjesIU1JZxY6y+TRL9P84JFw41W4=';

  const BASE64_KEY_BYTES = [
    180, 107, 26, 32, 169, 88, 248, 46, 88, 100, 108, 243, 255, 87, 146, 92, 42,
    147, 104, 2, 39, 200, 114, 145, 37, 122, 8, 37, 170, 238, 164, 236,
  ];

  group('Ed25519PublicKey', () {

    test('invalid', () {
      // public key length 33 is invalid for Ed25519
      expect(() {
        Ed25519PublicKey.fromBytes(Uint8List.fromList([
          3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
          0, 0, 0, 0, 0, 0, 0, 0, 0,
        ]));
      }, throwsArgumentError);

      expect(() {
        Uint8List publicKey = Hex.decode('0x300000000000000000000000000000000000000000000000000000000000000000000');
        Ed25519PublicKey(decodeBigIntToUnsigned(publicKey));
      }, throwsArgumentError);

      expect(() {
        Uint8List publicKey = Hex.decode('135693854574979916511997248057056142015550763280047535983739356259273198796800000');
        Ed25519PublicKey(decodeBigIntToUnsigned(publicKey));
      }, throwsArgumentError);

      expect(() {
        Ed25519PublicKey.fromBytes(Uint8List.fromList(utf8.encode('12345')));
      }, throwsArgumentError);
    });


    test('toBase64', () {
      final key = Ed25519PublicKey.fromString(VALID_KEY_BASE64);
      expect(key.toBase64() == VALID_KEY_BASE64, true);
      expect(key.toString() == VALID_KEY_BASE64, true);
    });

    test('toBuffer', () {
      final key = Ed25519PublicKey.fromString(VALID_KEY_BASE64);
      expect(key.toBytes().length == 32, true);
      expect(Ed25519PublicKey.fromBytes(key.toBytes()).equals(key), true);
    });

    test('toSuiAddress', () {
      final key = Ed25519PublicKey.fromBytes(BASE64_KEY_BYTES);
      expect(key.toSuiAddress() == '0x98fc1c8179b95274327069cf3b0ed051fb14e0bc', true);
    });

    TEST_CASES.forEach((data) {
      test('toSuiAddress from base64 public key ${data[1]}', () {
        final key = Ed25519PublicKey.fromString(data[0]);
        expect(key.toSuiAddress() == data[1], true);
      });
    });

  });

}
