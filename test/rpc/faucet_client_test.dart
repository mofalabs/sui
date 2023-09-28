
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/rpc/faucet_client.dart';
import 'package:sui/types/faucet.dart';

void main() {
  
  test('request sui faucet v0', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSuiFromFaucetV0('0xac7b88158310cff855983520c03c0705b18bc633e9eab943f4718d4167764509');
    expect(resp.transferredGasObjects.isNotEmpty, true);
  });

  test('request sui faucet v1', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSuiFromFaucetV1('0x374114b640af9825ad85bd174f28ea38ed217c0740b4e5f588e8535dfbbe92e0');
    expect(resp.task?.isNotEmpty, true);
    final statusResp = await faucet.getFaucetRequestStatus(resp.task!);
    expect(statusResp.status.status, BatchSendStatus.INPROGRESS);
  });

  test('get faucet request status', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.getFaucetRequestStatus("2442c39e-5cc5-4162-a7ef-e328cdc0332e");
    expect(resp.status.status, BatchSendStatus.SUCCEEDED);
  });

}