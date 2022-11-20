
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';

class FaucetCoinInfo {
  int amount;
  ObjectId id;
  TransactionDigest transferTxDigest;

  FaucetCoinInfo(this.amount, this.id, this.transferTxDigest);

  factory FaucetCoinInfo.fromJson(dynamic data) {
    return FaucetCoinInfo(
      data['amount'],
      data['id'],
      data['transfer_tx_digest']
    );
  }
}

class FaucetResponse {
  List<FaucetCoinInfo> transferredGasObjects;
  String? error;

  FaucetResponse(this.transferredGasObjects, this.error);

  factory FaucetResponse.fromJson(dynamic data) {
    final gasObjects = (data['transferred_gas_objects'] as List)
      .map((x) => FaucetCoinInfo.fromJson(x))
      .toList();
      
    return FaucetResponse(
      gasObjects,
      data['error']
    );
  }
}
