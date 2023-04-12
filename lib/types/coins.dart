import 'common.dart';

import 'objects.dart';

class CoinStruct {
  String coinType;
  ObjectId coinObjectId;
  String version;
  TransactionDigest digest;
  String balance;
  dynamic lockedUntilEpoch;
  TransactionDigest previousTransaction;

  CoinStruct(
    this.coinType,
    this.coinObjectId,
    this.version,
    this.digest,
    this.balance,
    this.lockedUntilEpoch,
    this.previousTransaction,
  );

  factory CoinStruct.fromJson(dynamic data) {
    return CoinStruct(
      data['coinType'],
      data['coinObjectId'],
      data['version'],
      data['digest'],
      data['balance'],
      data['lockedUntilEpoch'],
      data['previousTransaction'],
    );
  }
}

class PaginatedCoins {
  List<CoinStruct> data;
  String nextCursor;
  bool hasNextPage;

  PaginatedCoins(
    this.data,
    this.nextCursor,
    this.hasNextPage,
  );

  factory PaginatedCoins.fromJson(dynamic data) {
    List<CoinStruct> list = [];
    if (data['data'] != null) {
      for (var coin in list) {
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
