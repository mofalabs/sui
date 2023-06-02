
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui_account.dart';

void main() {
  
  test('test isValidAddress', () {
    expect(SuiAccount.isValidAddress(''), false);
    expect(SuiAccount.isValidAddress(' '), false);
    expect(SuiAccount.isValidAddress('0xAAAAAAAAAAAAAAAAAAA'), false);
    expect(SuiAccount.isValidAddress('0xAAAAAAAAAAAAAAAAAAA'), false);
    expect(SuiAccount.isValidAddress('0xggd66378f4470078fbdfcaa8f6f0b94b585cfe0a6a8a2a944862b3733b2e37b1'), false);
    expect(SuiAccount.isValidAddress('0Xeed66378f4470078fbdfcaa8f6f0b94b585cfe0a6a8a2a944862b3733b2e37b1'), false);
    expect(SuiAccount.isValidAddress('0xeed66378f4470078fbdfcaa8f6f0b94b585cfe0a6a8a2a944862b3733b2e37b1'), true);

  });

  test('test isValidSuiNS', () {
    expect(SuiAccount.isValidSuiNS(''), false);
    expect(SuiAccount.isValidSuiNS(' '), false);
    expect(SuiAccount.isValidSuiNS('-.sui'), false);
    expect(SuiAccount.isValidSuiNS('--.sui'), false);
    expect(SuiAccount.isValidSuiNS('-hello.sui'), false);
    expect(SuiAccount.isValidSuiNS('hello-.sui'), false);
    expect(SuiAccount.isValidSuiNS('-hello-.sui'), false);
    expect(SuiAccount.isValidSuiNS('hello--world.sui'), false);
    expect(SuiAccount.isValidSuiNS(String.fromCharCodes(List<int>.filled(64, 48)) + ".sui"), false);
    expect(SuiAccount.isValidSuiNS(String.fromCharCodes(List<int>.filled(2, 48)) + ".sui"), false);
    expect(SuiAccount.isValidSuiNS('hello.sui'), true);
    expect(SuiAccount.isValidSuiNS('hello-world.sui'), true);
    expect(SuiAccount.isValidSuiNS(String.fromCharCodes(List<int>.filled(3, 48)) + ".sui"), true);
    expect(SuiAccount.isValidSuiNS(String.fromCharCodes(List<int>.filled(63, 48)) + ".sui"), true);
  });

}