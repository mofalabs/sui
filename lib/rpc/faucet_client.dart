import 'package:sui/http/http.dart';
import 'package:sui/types/faucet.dart';

class FaucetClient {
  final String endpoint;
  FaucetClient(this.endpoint);

  /// Requests SUI from the faucet via the `/v2/gas` route.
  ///
  /// The older `/gas` (V0) and `/v1/gas` (V1) routes are deprecated and
  /// already rejected by devnet with "Route deprecated. Use `/v2/gas`
  /// instead.", so this is the only request method the client exposes.
  ///
  /// Throws if the faucet reports a non-success status (rate limits and
  /// other HTTP-level errors already surface as DioExceptions).
  Future<FaucetResponse> requestSuiFromFaucetV2(String recipient) async {
    final data = {
      "FixedAmountRequest": {"recipient": recipient}
    };

    final resp = await http.post("$endpoint/v2/gas", data: data);
    final faucetResp = FaucetResponse.fromJson(resp.data);
    if (!faucetResp.isSuccess) {
      throw Exception('Faucet request failed: ${faucetResp.error}');
    }
    return faucetResp;
  }
}
