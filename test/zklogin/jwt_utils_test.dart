import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

void main() {
  test('test extractClaimValue', () async {
    final result = extractClaimValue(
      Claim(
        value: 'yJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLC',
        indexMod4: 1,
      ),
      'iss',
    );
    final isValid = result == 'https://accounts.google.com';
    expect(isValid, true);
  });
}
