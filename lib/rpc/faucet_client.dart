import 'package:sui/http/http.dart';
import 'package:sui/types/faucet.dart';
import 'package:dio/dio.dart';
import 'faucet_pow.dart';

class FaucetClient {
  final String endpoint;
  FaucetClient(this.endpoint);

  /// Requests SUI into the recipient's address balance using a PoW faucet.
  Future<FaucetV3Response> requestSuiFromFaucetV3(
    String recipient, {
    Dio? dio,
    CancelToken? cancelToken,
    Duration timeout = const Duration(minutes: 3),
    Map<String, String> headers = const {},
  }) => requestFaucetV3(
    endpoint,
    recipient,
    dio: dio,
    cancelToken: cancelToken,
    timeout: timeout,
    headers: headers,
  );

  /// Requests SUI from the faucet via the `/v2/gas` route.
  ///
  /// The older `/gas` (V0) and `/v1/gas` (V1) routes are deprecated and
  /// already rejected by devnet with "Route deprecated. Use `/v2/gas`
  /// instead." Use V3 for address-balance payouts where supported.
  ///
  /// Throws if the faucet reports a non-success status (rate limits and
  /// other HTTP-level errors already surface as DioExceptions).
  Future<FaucetResponse> requestSuiFromFaucetV2(String recipient) async {
    final data = {
      "FixedAmountRequest": {"recipient": recipient},
    };

    final resp = await http.post("$endpoint/v2/gas", data: data);
    final faucetResp = FaucetResponse.fromJson(resp.data);
    if (!faucetResp.isSuccess) {
      throw Exception('Faucet request failed: ${faucetResp.error}');
    }
    return faucetResp;
  }
}
