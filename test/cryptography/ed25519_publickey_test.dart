
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/ed25519_publickey.dart';

void main() {

  final TEST_CASES = [
	{
		"rawPublicKey": "UdGRWooy48vGTs0HBokIis5NK+DUjiWc9ENUlcfCCBE=",
		"suiPublicKey": "AFHRkVqKMuPLxk7NBwaJCIrOTSvg1I4lnPRDVJXHwggR",
		"suiAddress": "0xd77a6cd55073e98d4029b1b0b8bd8d88f45f343dad2732fc9a7965094e635c55"
	},
	{
		"rawPublicKey": "0PTAfQmNiabgbak9U/stWZzKc5nsRqokda2qnV2DTfg=",
		"suiPublicKey": "AND0wH0JjYmm4G2pPVP7LVmcynOZ7EaqJHWtqp1dg034",
		"suiAddress": "0x7e8fd489c3d3cd9cc7cbcc577dc5d6de831e654edd9997d95c412d013e6eea23"
	},
    {
      "rawPublicKey": "6L/l0uhGt//9cf6nLQ0+24Uv2qanX/R6tn7lWUJX1Xk=",
      "suiPublicKey": "AOi/5dLoRrf//XH+py0NPtuFL9qmp1/0erZ+5VlCV9V5",
      "suiAddress": "0x3a1b4410ebe9c3386a429c349ba7929aafab739c277f97f32622b971972a14a2"
    },
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
      expect(key.toSuiAddress() == '0xc148b7b3e42129e236fb603dceb142de8695f1a276c9cab8a7daff8442b7b421', true);
    });

    TEST_CASES.forEach((data) {
      final rawPublicKey = data["rawPublicKey"]!;
      final suiPublicKey = data["suiPublicKey"]!;
      final suiAddress = data["suiAddress"]!;

      test('toSuiAddress from base64 public key $suiAddress', () {
        final key = Ed25519PublicKey.fromString(rawPublicKey);
        expect(key.toSuiAddress() == suiAddress, true);
      });

		  test('toSuiPublicKey from base64 public key $suiAddress', () {
        final key = Ed25519PublicKey.fromString(rawPublicKey);
        expect(key.toSuiPublicKey(), suiPublicKey);
      });
    });

  });

}
