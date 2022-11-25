
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/rpc/faucet_client.dart';

void main() {
  
  test('request sui faucet', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSui('0xd95533b6c8c9c7e4a06fbc0a4def0110782e7d28');
    expect(resp.transferredGasObjects.isNotEmpty, true);
  });

}