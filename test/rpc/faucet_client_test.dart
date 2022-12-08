
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/rpc/faucet_client.dart';

void main() {
  
  test('request sui faucet', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSui('0xed17b3f435c03ff69c2cdc6d394932e68375f20f');
    expect(resp.transferredGasObjects.isNotEmpty, true);
  });

}