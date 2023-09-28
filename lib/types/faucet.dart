
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';

class FaucetCoinInfo {
  final int amount;
  final ObjectId id;
  final TransactionDigest transferTxDigest;

  FaucetCoinInfo(this.amount, this.id, this.transferTxDigest);

  factory FaucetCoinInfo.fromJson(dynamic data) {
    return FaucetCoinInfo(
      data['amount'],
      data['id'],
      data['transferTxDigest']
    );
  }
}

class FaucetResponse {
  final List<FaucetCoinInfo> transferredGasObjects;
  final String? error;

  FaucetResponse(this.transferredGasObjects, this.error);

  factory FaucetResponse.fromJson(dynamic data) {
    final gasObjects = (data['transferredGasObjects'] as List)
      .map((x) => FaucetCoinInfo.fromJson(x))
      .toList();
      
    return FaucetResponse(
      gasObjects,
      data['error']
    );
  }
}


class BatchFaucetResponse {
  final String? task;
  final String? error;

  BatchFaucetResponse(this.task, this.error);

  factory BatchFaucetResponse.fromJson(dynamic data) {
    return BatchFaucetResponse(
      data['task'],
      data['error']
    );
  }
}

enum BatchSendStatus {
  INPROGRESS, SUCCEEDED, DISCARDED
}

class BatchSendStatusType  {
	BatchSendStatus status;
	List<FaucetCoinInfo>? gasObjects;

  BatchSendStatusType(this.status, this.gasObjects);

  factory BatchSendStatusType.fromJson(dynamic data) {
    var gasObjects = data['transferred_gas_objects'];
    if (gasObjects != null) {
      gasObjects = (gasObjects["sent"] as List)
        .map((x) => FaucetCoinInfo.fromJson(x))
        .toList();
    }

    return BatchSendStatusType(
      BatchSendStatus.values.byName(data['status']),
      gasObjects
    );
  }
}

class BatchStatusFaucetResponse {
  BatchSendStatusType status;
  final String? error;

  BatchStatusFaucetResponse(this.status, this.error);

  factory BatchStatusFaucetResponse.fromJson(dynamic data) {
    return BatchStatusFaucetResponse(
      BatchSendStatusType.fromJson(data['status']),
      data['error']
    );
  }
}