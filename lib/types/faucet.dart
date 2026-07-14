import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';

class FaucetCoinInfo {
  final int amount;
  final ObjectId id;
  final TransactionDigest transferTxDigest;

  FaucetCoinInfo(this.amount, this.id, this.transferTxDigest);

  factory FaucetCoinInfo.fromJson(dynamic data) {
    return FaucetCoinInfo(data['amount'], data['id'], data['transferTxDigest']);
  }
}

/// Response of the faucet `/v2/gas` route.
///
/// On success the faucet returns
/// `{"status": "Success", "coins_sent": [...]}`; on failure `status` is an
/// object such as `{"Failure": {"Internal": "..."}}` and `coins_sent` is
/// null, so [error] carries the stringified failure and [isSuccess] is false.
class FaucetResponse {
  final List<FaucetCoinInfo> coinsSent;
  final String? error;

  bool get isSuccess => error == null;

  FaucetResponse(this.coinsSent, this.error);

  factory FaucetResponse.fromJson(dynamic data) {
    final status = data['status'];
    final error =
        status == 'Success' ? null : (status?.toString() ?? 'Unknown error');
    final coins = (data['coins_sent'] as List?) ?? const [];
    return FaucetResponse(
      coins.map((x) => FaucetCoinInfo.fromJson(x)).toList(),
      error,
    );
  }
}
