import 'package:sui/types/objects.dart';

const SUI_FRAMEWORK_ADDRESS = '0x2';
const MOVE_STDLIB_ADDRESS = '0x1';
const OBJECT_MODULE_NAME = 'object';
const UID_STRUCT_NAME = 'UID';
const ID_STRUCT_NAME = 'ID';
const SUI_TYPE_ARG = "$SUI_FRAMEWORK_ADDRESS::sui::SUI";
const COIN_TYPE = "$SUI_FRAMEWORK_ADDRESS::coin::Coin";

const PAY_MODULE_NAME = 'pay';
const PAY_SPLIT_COIN_VEC_FUNC_NAME = 'split_vec';
const PAY_JOIN_COIN_FUNC_NAME = 'join';
final COIN_TYPE_ARG_REGEX = RegExp(r'^0x2::coin::Coin<(.+)>$');

class ObjectData {
  SuiObject? objectInfo;
  SuiObjectResponse? dataResponse;
  SuiMoveObject? moveObject;

  ObjectData({this.objectInfo, this.dataResponse, this.moveObject});
}

class Coin {
  static bool isCoin(ObjectData data) {
    return Coin.getType(data)?.startsWith(COIN_TYPE) ?? false;
  }

  static bool suiObjectIsCoin(SuiObject data) {
    return data.type?.startsWith(COIN_TYPE) ?? false;
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
      return data.dataResponse?.data?.content?.type ?? '';
    }
    return null;
  }
}

class CoinMetadataStruct {
  int decimals;
  String name;
  String symbol;
  String description;
  String iconUrl;
  ObjectId id;

  CoinMetadataStruct(
    this.decimals,
    this.name,
    this.symbol,
    this.description,
    this.iconUrl,
    this.id,
  );

  factory CoinMetadataStruct.fromJson(dynamic data) {
    return CoinMetadataStruct(
      int.parse((data['decimals'] ?? "0").toString()),
      data['name'] ?? '',
      data['symbol'] ?? '',
      data['description'] ?? '',
      data['iconUrl'] ?? '',
      data['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'decimals': decimals,
      'name': name,
      'symbol': symbol,
      'description': description,
      'iconUrl': iconUrl,
      'id': id,
    };
  }
}
