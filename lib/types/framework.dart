import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/sui_bcs.dart';

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


typedef ObjectData = dynamic; // SuiObjectResponse || SuiMoveObject || SuiObjectInfo

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

  static bool isSUI(ObjectData obj) {
    final arg = Coin.getCoinTypeArg(obj);
    return arg != null ? Coin.getCoinSymbol(arg) == 'SUI' : false;
  }

  static getCoinSymbol(String coinTypeArg) {
    return coinTypeArg.substring(coinTypeArg.lastIndexOf(':') + 1);
  }

	static StructTag getCoinStructTag(String coinTypeArg) {
    return StructTag(
      normalizeSuiObjectId(coinTypeArg.split('::')[0]),
      coinTypeArg.split('::')[1],
      coinTypeArg.split('::')[2],
      []
    );
	}

  static String? getType(ObjectData data) {
    if (data is SuiObject) {
      return data.type;
    }
    if (data is SuiMoveObject) {
      return data.type;
    }
    if (data is SuiObjectResponse) {
      return data.data?.type ?? data.data?.content?.type;
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
