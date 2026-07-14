import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

void main() {
  test('request sui faucet v2', () async {
    final faucet = FaucetClient(SuiUrls.faucetDev);
    final resp = await faucet.requestSuiFromFaucetV2(
        '0x936accb491f0facaac668baaedcf4d0cfc6da1120b66f77fa6a43af718669973');
    expect(resp.isSuccess, true);
    expect(resp.coinsSent.isNotEmpty, true);
    expect(resp.coinsSent.first.transferTxDigest.isNotEmpty, true);
  });
}
