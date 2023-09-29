
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/rpc/faucet_client.dart';
import 'package:sui/types/faucet.dart';

void main() {
  
  test('request sui faucet v0', () async {
    final faucet = FaucetClient(Constants.faucetDevAPI);
    final resp = await faucet.requestSuiFromFaucetV0('0x936accb491f0facaac668baaedcf4d0cfc6da1120b66f77fa6a43af718669973');
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