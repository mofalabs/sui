
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/rpc/faucet_client.dart';

void main() {
  
  test('request sui faucet', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSui('0x936accb491f0facaac668baaedcf4d0cfc6da1120b66f77fa6a43af718669973');
    expect(resp.transferredGasObjects.isNotEmpty, true);
  });

}