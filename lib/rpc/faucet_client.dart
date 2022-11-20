
import 'package:sui/http/http.dart';
import 'package:sui/types/faucet.dart';

class FaucetClient {

  final String endpoint;
  FaucetClient(this.endpoint);

  Future<FaucetResponse> requestSui(String recipient) async {
    final data = {
      "FixedAmountRequest": {
        "recipient": recipient
      }
    };

    final resp = await http.post(endpoint, data: data);
    return FaucetResponse.fromJson(resp.data);
  }
}
