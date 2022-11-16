

import 'package:sui/types/objects.dart';

const SUI_FRAMEWORK_ADDRESS = '0x2';
const MOVE_STDLIB_ADDRESS = '0x1';
const OBJECT_MODULE_NAME = 'object';
const UID_STRUCT_NAME = 'UID';
const ID_STRUCT_NAME = 'ID';
const SUI_TYPE_ARG = "$SUI_FRAMEWORK_ADDRESS::sui::SUI";
const COIN_TYPE = "$SUI_FRAMEWORK_ADDRESS::coin::Coin";

// `sui::pay` module is used for Coin management (split, join, join_and_transfer etc);
const PAY_MODULE_NAME = 'pay';
const PAY_SPLIT_COIN_VEC_FUNC_NAME = 'split_vec';
const PAY_JOIN_COIN_FUNC_NAME = 'join';
final COIN_TYPE_ARG_REGEX = RegExp(r'^0x2::coin::Coin<(.+)>$');

class ObjectData {
  SuiObjectInfo? objectInfo;
  GetObjectDataResponse? dataResponse;
  SuiMoveObject? moveObject;

  ObjectData({this.objectInfo, this.dataResponse, this.moveObject});
}

class Coin {
  static bool isCoin(ObjectData data) {
    return Coin.getType(data)?.startsWith(COIN_TYPE) ?? false;
  }

  static bool suiObjectIsCoin(SuiObjectInfo data) {
    return data.type.startsWith(COIN_TYPE);
  }

  static String? getCoinType(String type) {
    final match = COIN_TYPE_ARG_REGEX.firstMatch(type);
    return match?.group(1);
  }

  static String? getCoinTypeArg(ObjectData obj) {
    final type = Coin.getType(obj);
    return type != null ? Coin.getCoinType(type) : null;
  }

  static isSUI(ObjectData obj) {
    final arg = Coin.getCoinTypeArg(obj);
    return arg != null ? Coin.getCoinSymbol(arg) == 'SUI' : false;
  }

  static getCoinSymbol(String coinTypeArg) {
    return coinTypeArg.substring(coinTypeArg.lastIndexOf(':') + 1);
  }

  // static StructTag getCoinStructTag(String coinTypeArg) {
  //   return {
  //     address: normalizeSuiObjectId(coinTypeArg.split('::')[0]),
  //     module: coinTypeArg.split('::')[1],
  //     name: coinTypeArg.split('::')[2],
  //     typeParams: [],
  //   };
  // }

  // static ObjectId getID(ObjectData obj) {
  //   if (isSuiMoveObject(obj)) {
  //     return obj.fields.id.id;
  //   }
  //   return getObjectId(obj);
  // }

  // /**
  //  * Convenience method for select coin objects that has a balance greater than or equal to `amount`
  //  *
  //  * @param amount coin balance
  //  * @param exclude object ids of the coins to exclude
  //  * @return a list of coin objects that has balance greater than `amount` in an ascending order
  //  */
  // static selectCoinsWithBalanceGreaterThanOrEqual(
  //   coins: ObjectDataFull[],
  //   amount: bigint,
  //   exclude: ObjectId[] = []
  // ): ObjectDataFull[] {
  //   return Coin.sortByBalance(
  //     coins.filter(
  //       (c) => !exclude.includes(Coin.getID(c)) && Coin.getBalance(c)! >= amount
  //     )
  //   );
  // }

  // /**
  //  * Convenience method for select an arbitrary coin object that has a balance greater than or
  //  * equal to `amount`
  //  *
  //  * @param amount coin balance
  //  * @param exclude object ids of the coins to exclude
  //  * @return an arbitray coin with balance greater than or equal to `amount
  //  */
  // static selectCoinWithBalanceGreaterThanOrEqual(
  //   coins: ObjectDataFull[],
  //   amount: bigint,
  //   exclude: ObjectId[] = []
  // ): ObjectDataFull | undefined {
  //   return coins.find(
  //     (c) => !exclude.includes(Coin.getID(c)) && Coin.getBalance(c)! >= amount
  //   );
  // }

  // /**
  //  * Convenience method for select a minimal set of coin objects that has a balance greater than
  //  * or equal to `amount`. The output can be used for `PayTransaction`
  //  *
  //  * @param amount coin balance
  //  * @param exclude object ids of the coins to exclude
  //  * @return a minimal list of coin objects that has a combined balance greater than or equal
  //  * to`amount` in an ascending order. If no such set exists, an empty list is returned
  //  */
  // static selectCoinSetWithCombinedBalanceGreaterThanOrEqual(
  //   coins: ObjectDataFull[],
  //   amount: bigint,
  //   exclude: ObjectId[] = []
  // ): ObjectDataFull[] {
  //   const sortedCoins = Coin.sortByBalance(
  //     coins.filter((c) => !exclude.includes(Coin.getID(c)))
  //   );

  //   const total = Coin.totalBalance(sortedCoins);
  //   // return empty set if the aggregate balance of all coins is smaller than amount
  //   if (total < amount) {
  //     return [];
  //   } else if (total === amount) {
  //     return sortedCoins;
  //   }

  //   let sum = BigInt(0);
  //   let ret = [];
  //   while (sum < total) {
  //     // prefer to add a coin with smallest sufficient balance
  //     const target = amount - sum;
  //     const coinWithSmallestSufficientBalance = sortedCoins.find(
  //       (c) => Coin.getBalance(c)! >= target
  //     );
  //     if (coinWithSmallestSufficientBalance) {
  //       ret.push(coinWithSmallestSufficientBalance);
  //       break;
  //     }

  //     const coinWithLargestBalance = sortedCoins.pop()!;
  //     ret.push(coinWithLargestBalance);
  //     sum += Coin.getBalance(coinWithLargestBalance)!;
  //   }

  //   return Coin.sortByBalance(ret);
  // }

  // static totalBalance(coins: ObjectDataFull[]): bigint {
  //   return coins.reduce(
  //     (partialSum, c) => partialSum + Coin.getBalance(c)!,
  //     BigInt(0)
  //   );
  // }

  // /**
  //  * Sort coin by balance in an ascending order
  //  */
  // static sortByBalance(coins: ObjectDataFull[]): ObjectDataFull[] {
  //   return coins.sort((a, b) =>
  //     Coin.getBalance(a)! < Coin.getBalance(b)!
  //       ? -1
  //       : Coin.getBalance(a)! > Coin.getBalance(b)!
  //       ? 1
  //       : 0
  //   );
  // }

  // static getBalance(data: ObjectDataFull): bigint | undefined {
  //   if (!Coin.isCoin(data)) {
  //     return undefined;
  //   }
  //   const balance = getObjectFields(data)?.balance;
  //   return BigInt(balance);
  // }

  static BigInt getZero() {
    return BigInt.zero;
  }

  static String? getType(ObjectData data) {
    if (data.objectInfo != null) {
      return data.objectInfo?.type;
    }

    if (data.moveObject != null) {
      return data.moveObject?.type;
    }

    if (data.dataResponse != null) {
      return data.dataResponse?.details.data.type;
    }
  }
}