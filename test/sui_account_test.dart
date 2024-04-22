
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/signature.dart';
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

  test('test encode bech32 private key', () {
    final account1 = SuiAccount.fromPrivateKey(
      "0x9dd9ae36ee51b912a0364c58c1f21333bcdad2d91911aa127226c512be285102",
      SignatureScheme.Ed25519
    );
    expect(account1.privateKey(), "suiprivkey1qzwant3kaegmjy4qxex93s0jzvemekkjmyv3r2sjwgnv2y479pgsywhveae");
    expect(account1.getAddress(), "0x90f3e6d73b5730f16974f4df1d3441394ebae62186baf83608599f226455afa7");

    final account2 = SuiAccount.fromPrivateKey(
      "0xeea84be738c59f56ee94dae8fd5a68082d4579ed38548d6ec4017da6c5619bf3",
      SignatureScheme.Ed25519
    );
    expect(account2.privateKey(), "suiprivkey1qrh2sjl88rze74hwjndw3l26dqyz63tea5u9frtwcsqhmfk9vxdlx8cpv0g");
    expect(account2.getAddress(), "0xfd233cd9a5dd7e577f16fa523427c75fbc382af1583c39fdf1c6747d2ed807a3");

    final account3 = SuiAccount.fromPrivateKey(
      "0x91e8808c489ee0cc99c2edf79e63be6a144f8f600c7411bc2e806f7255710674",
      SignatureScheme.Ed25519
    );
    expect(account3.privateKey(), "suiprivkey1qzg73qyvfz0wpnyectkl08nrhe4pgnu0vqx8gydu96qx7uj4wyr8gcrjlh3");
    expect(account3.getAddress(), "0x81aaefa4a883e72e8b6ccd3bec307e25fe3d79b14e43b778695c55dcec42f4f0");

    final account4 = SuiAccount.fromPrivateKey(
      "0x829c19b0682724588bf3c5a846506743e9b88ba2b2cfea0ba14a85917a57ab99",
      SignatureScheme.Secp256k1
    );
    expect(account4.privateKey(), "suiprivkey1qxpfcxdsdqnjgkyt70z6s3jsvap7nwyt52evl6st599gtyt6274ej2j4nvj");
    expect(account4.getAddress(), "0x538aecb0f3bad974ff1a8c1d3c23210cffb9f6f43370e5ebf25ef19e30018ed6");

    final account5 = SuiAccount.fromPrivateKey(
      "346938e2fdaebd7381eb00d454b21ae8bdc211bdcb5c53c476de7d712393b549",
      SignatureScheme.Secp256r1
    );
    expect(account5.privateKey(), "suiprivkey1qg6xjw8zlkht6uupavqdg49jrt5tmss3hh94c57ywm086ufrjw65j0lwsdz");
    expect(account5.getAddress(), "0xa3d8923a5ceadbb4fd4168e4de7f5b7c3c49cc43adbbe096bb6a7f349b279f20");

  });

  test('test decode bech32 private key', () {
    final account1 = SuiAccount.fromPrivKey(
      "suiprivkey1qzwant3kaegmjy4qxex93s0jzvemekkjmyv3r2sjwgnv2y479pgsywhveae"
    );
    expect(account1.privateKey(), "suiprivkey1qzwant3kaegmjy4qxex93s0jzvemekkjmyv3r2sjwgnv2y479pgsywhveae");
    expect(account1.getAddress(), "0x90f3e6d73b5730f16974f4df1d3441394ebae62186baf83608599f226455afa7");

    final account2 = SuiAccount.fromPrivKey(
      "suiprivkey1qrh2sjl88rze74hwjndw3l26dqyz63tea5u9frtwcsqhmfk9vxdlx8cpv0g"
    );
    expect(account2.privateKey(), "suiprivkey1qrh2sjl88rze74hwjndw3l26dqyz63tea5u9frtwcsqhmfk9vxdlx8cpv0g");
    expect(account2.getAddress(), "0xfd233cd9a5dd7e577f16fa523427c75fbc382af1583c39fdf1c6747d2ed807a3");

    final account3 = SuiAccount.fromPrivKey(
      "suiprivkey1qzg73qyvfz0wpnyectkl08nrhe4pgnu0vqx8gydu96qx7uj4wyr8gcrjlh3"
    );
    expect(account3.privateKey(), "suiprivkey1qzg73qyvfz0wpnyectkl08nrhe4pgnu0vqx8gydu96qx7uj4wyr8gcrjlh3");
    expect(account3.getAddress(), "0x81aaefa4a883e72e8b6ccd3bec307e25fe3d79b14e43b778695c55dcec42f4f0");

    final account4 = SuiAccount.fromPrivKey(
      "suiprivkey1qxpfcxdsdqnjgkyt70z6s3jsvap7nwyt52evl6st599gtyt6274ej2j4nvj"
    );
    expect(account4.privateKey(), "suiprivkey1qxpfcxdsdqnjgkyt70z6s3jsvap7nwyt52evl6st599gtyt6274ej2j4nvj");
    expect(account4.getAddress(), "0x538aecb0f3bad974ff1a8c1d3c23210cffb9f6f43370e5ebf25ef19e30018ed6");

    final account5 = SuiAccount.fromPrivKey(
      "suiprivkey1qg6xjw8zlkht6uupavqdg49jrt5tmss3hh94c57ywm086ufrjw65j0lwsdz"
    );
    expect(account5.privateKey(), "suiprivkey1qg6xjw8zlkht6uupavqdg49jrt5tmss3hh94c57ywm086ufrjw65j0lwsdz");
    expect(account5.getAddress(), "0xa3d8923a5ceadbb4fd4168e4de7f5b7c3c49cc43adbbe096bb6a7f349b279f20");

  });

}