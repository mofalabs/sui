
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/rpc/faucet_client.dart';

void main() {
  
  test('request sui faucet', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSui('0xad1009b99cf989546d24818bbb1861f066187c36');
    expect(resp.transferredGasObjects.isNotEmpty, true);
  });

}