
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/rpc/faucet_client.dart';

void main() {
  
  test('request sui faucet', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSui('0x7ec1b6df34a4018c377109851af1cf70db6687dd4a880a51f9119af86d855643');
    expect(resp.transferredGasObjects.isNotEmpty, true);
  });

}