import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

void main() {
  test('test generates the correct address', () async {
    final result = computeZkLoginAddressFromSeed(
      BigInt.parse(
          '13322897930163218532266430409510394316985274769125667290600321564259466511711'),
      'https://accounts.google.com',
    );
    final isValid = result ==
        '0xf7badc2b245c7f74d7509a4aa357ecf80a29e7713fb4c44b0e7541ec43885ee1';
    expect(isValid, true);
  });

  test('test generates the correct address for a seed with leading zeros',
      () async {
    final result = computeZkLoginAddressFromSeed(
      BigInt.parse(
          '380704556853533152350240698167704405529973457670972223618755249929828551006'),
      'https://accounts.google.com',
    );
    final isValid = result ==
        '0xbd8b8ed42d90aebc71518385d8a899af14cef8b5a171c380434dd6f5bbfe7bf3';
    expect(isValid, true);
  });
}
