
import 'package:sui/http/http.dart';
import 'package:sui/types/faucet.dart';

class FaucetClient {

  final String endpoint;
  FaucetClient(this.endpoint);

  Future<FaucetResponse> requestSuiFromFaucetV0(String recipient) async {
    final data = {
      "FixedAmountRequest": {
        "recipient": recipient
      }
    };

    final resp = await http.post(endpoint + "/gas", data: data);
    return FaucetResponse.fromJson(resp.data);
  }

  Future<BatchFaucetResponse> requestSuiFromFaucetV1(String recipient) async {
    final data = {
      "FixedAmountRequest": {
        "recipient": recipient
      }
    };

    final resp = await http.post(endpoint + "/v1/gas", data: data);
    return BatchFaucetResponse.fromJson(resp.data);
  }

  Future<BatchStatusFaucetResponse> getFaucetRequestStatus(String taskId) async {
    final resp = await http.get(endpoint + "/v1/status/$taskId");
    return BatchStatusFaucetResponse.fromJson(resp.data);
  }

}
