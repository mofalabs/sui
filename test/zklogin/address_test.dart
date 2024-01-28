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
          '38070455685353315235024069816770440552997345767097222361875524992982855100600'),
      'https://accounts.google.com',
    );
    final isValid = result ==
        '0x947652eca856ec647422a99f6aaf59698403fe73cd633e5bd5ada0e0e26931f9';
    expect(isValid, true);
  });
}
