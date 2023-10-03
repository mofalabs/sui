import 'common.dart';

import 'objects.dart';

class CoinStruct extends SuiObjectRef {
  String coinType;
  ObjectId coinObjectId;
  String balance;
  TransactionDigest previousTransaction;

  CoinStruct(
    this.coinType,
    this.coinObjectId,
    int version,
    TransactionDigest digest,
    this.balance,
    this.previousTransaction,
  ): super(digest, coinObjectId, version);

  factory CoinStruct.fromJson(dynamic data) {
    return CoinStruct(
      data['coinType'],
      data['coinObjectId'],
      int.parse(data['version']),
      data['digest'],
      data['balance'],
      data['previousTransaction'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "coinType": coinType,
      "coinObjectId": coinObjectId,
      "version": version,
      "digest": digest,
      "balance": balance,
      "previousTransaction": previousTransaction
    };
  }
}

class PaginatedCoins {
  List<CoinStruct> data;
  String? nextCursor;
  bool hasNextPage;

  PaginatedCoins(
    this.data,
    this.nextCursor,
    this.hasNextPage,
  );

  factory PaginatedCoins.fromJson(dynamic data) {
    List<CoinStruct> list = [];
    if (data['data'] != null) {
      for (var coin in data['data']) {
        list.add(CoinStruct.fromJson(coin));
      }
    }

    return PaginatedCoins(
      list,
      data['nextCursor'],
      data['hasNextPage'],
    );
  }
}

class CoinBalance {
  String coinType;
  int coinObjectCount;
  BigInt totalBalance;
  dynamic lockedBalance;

  CoinBalance(
    this.coinType,
    this.coinObjectCount,
    this.totalBalance,
    this.lockedBalance,
  );

  factory CoinBalance.fromJson(dynamic data) {
    return CoinBalance(
      data['coinType'],
      data['coinObjectCount'],
      BigInt.parse((data['totalBalance'] ?? '0').toString()),
      data['lockedBalance'],
    );
  }
}

class CoinSupply {
  BigInt value;

  CoinSupply(this.value);

  factory CoinSupply.fromJson(Map<String, dynamic> data) {
    return CoinSupply(BigInt.parse((data['value'] ?? '0').toString()));
  }
}
