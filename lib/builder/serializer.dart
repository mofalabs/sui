
import 'dart:convert';
import 'dart:typed_data';

import 'package:bcs/bcs_type.dart';
import 'package:sui/bcs/sui_bcs.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/normalized.dart';
import 'package:sui/types/transactions.dart';


const STD_ASCII_MODULE_NAME = 'ascii';
const STD_ASCII_STRUCT_NAME = 'String';

const STD_UTF8_MODULE_NAME = 'string';
const STD_UTF8_STRUCT_NAME = 'String';

const STD_OPTION_MODULE_NAME = 'option';
const STD_OPTION_STRUCT_NAME = 'Option';

const RESOLVED_SUI_ID = {
	"address": SUI_FRAMEWORK_ADDRESS,
	"module": OBJECT_MODULE_NAME,
	"name": ID_STRUCT_NAME,
};
const RESOLVED_ASCII_STR = {
	"address": MOVE_STDLIB_ADDRESS,
	"module": STD_ASCII_MODULE_NAME,
	"name": STD_ASCII_STRUCT_NAME,
};
const RESOLVED_UTF8_STR = {
	"address": MOVE_STDLIB_ADDRESS,
	"module": STD_UTF8_MODULE_NAME,
	"name": STD_UTF8_STRUCT_NAME,
};

const RESOLVED_STD_OPTION = {
	"address": MOVE_STDLIB_ADDRESS,
	"module": STD_OPTION_MODULE_NAME,
	"name": STD_OPTION_STRUCT_NAME,
};

bool isSameStruct(a, b) =>
	a["address"] == b["address"] && a["module"] == b["module"] && a["name"] == b["name"];

bool isTxContext(dynamic param) {
	final struct = param?["body"] is Map ? param["body"]["datatype"] : null;

	return (
		struct != null &&
		normalizeSuiAddress(struct["package"]) == normalizeSuiAddress('0x2') &&
		struct["module"] == 'tx_context' &&
		struct["type"] == 'TxContext'
	);
}

BcsType? getPureBcsSchema(dynamic typeSignature) {
	if (typeSignature is String) {
		switch (typeSignature) {
			case 'address':
				return SuiBcs.Address;
			case 'bool':
				return SuiBcs.BOOL;
			case 'u8':
				return SuiBcs.U8;
			case 'u16':
				return SuiBcs.U16;
			case 'u32':
				return SuiBcs.U32;
			case 'u64':
				return SuiBcs.U64;
			case 'u128':
				return SuiBcs.U128;
			case 'u256':
				return SuiBcs.U256;
			default:
				throw ArgumentError("Unknown type signature $typeSignature");
		}
	}

  if (typeSignature is Map<String, dynamic> && typeSignature.containsKey('vector')) {
    if (typeSignature['vector'] == 'u8') {
      return SuiBcs.VECTOR(SuiBcs.U8).transform(
        input: (dynamic val) => val is String ? Uint8List.fromList(val.codeUnits) : val,
        output: (val) => val,
      );
    }
    final type = getPureBcsSchema(typeSignature['vector']);
    return type != null ? SuiBcs.VECTOR(type) : null;
  }

  if (typeSignature is Map<String, dynamic> && typeSignature.containsKey('datatype')) {
    final datatypeInfo = typeSignature['datatype'] as Map<String, dynamic>;
    final pkg = normalizeSuiAddress(datatypeInfo['package']);

    if (pkg == normalizeSuiAddress(MOVE_STDLIB_ADDRESS)) {
      if (datatypeInfo['module'] == STD_ASCII_MODULE_NAME &&
          datatypeInfo['type'] == STD_ASCII_STRUCT_NAME) {
        return SuiBcs.STRING;
      }

      if (datatypeInfo['module'] == STD_UTF8_MODULE_NAME &&
          datatypeInfo['type'] == STD_UTF8_STRUCT_NAME) {
        return SuiBcs.STRING;
      }

      if (datatypeInfo['module'] == STD_OPTION_MODULE_NAME &&
          datatypeInfo['type'] == STD_OPTION_STRUCT_NAME) {
        final type = getPureBcsSchema(datatypeInfo['typeParameters'][0]);
        return type != null ? SuiBcs.VECTOR(type) : null;
      }
    }

    if (pkg == normalizeSuiAddress(SUI_FRAMEWORK_ADDRESS) &&
        datatypeInfo['module'] == OBJECT_MODULE_NAME &&
        datatypeInfo['type'] == ID_STRUCT_NAME) {
      return SuiBcs.Address;
    }
  }

  return null;
}

void expectType(String typeName, SuiJsonValue? argVal) {
  if (argVal == null) {
    return;
  }
  bool isError = false;
  if (typeName == 'boolean') {
    isError = argVal is! String && argVal is! bool;
  } else if (typeName == 'number') {
    isError = argVal is! String && argVal is! num &&
        argVal is! int && argVal is! BigInt;
  } else {
    isError = argVal is! String;
  }
  if (isError) {
    throw ArgumentError("Expect $argVal to be $typeName, received ${argVal.runtimeType}");
  }
}

const allowedTypes = ['Address', 'Bool', 'U8', 'U16', 'U32', 'U64', 'U128', 'U256'];

String? getPureSerializationType(
	SuiMoveNormalizedType normalizedType,
	SuiJsonValue? argVal,
) {
	if (normalizedType is String && allowedTypes.contains(normalizedType)) {
		if (['U8', 'U16', 'U32', 'U64', 'U128', 'U256'].contains(normalizedType)) {
			expectType('number', argVal);
		} else if (normalizedType == 'Bool') {
			expectType('boolean', argVal);
		} else if (normalizedType == 'Address') {
			expectType('string', argVal);
			if (argVal is String && !isValidSuiAddress(argVal)) {
				throw ArgumentError('Invalid Sui Address');
			}
		}
		return normalizedType.toLowerCase();
	} else if (normalizedType is String) {
		throw ArgumentError("Unknown pure normalized type ${jsonEncode(normalizedType)}");
	}

	if ((normalizedType as Map).containsKey("Vector")) {
		if ((argVal == null || argVal is String) && normalizedType["Vector"] == 'U8') {
			return 'string';
		}

		if (argVal != null && argVal is! Iterable) {
			throw ArgumentError("Expect $argVal to be a array, received ${argVal.runtimeType}");
		}

		final innerType = getPureSerializationType(
			normalizedType["Vector"],
			argVal ? argVal[0] : null,
		);

		if (innerType == null) {
			return null;
		}

		return "vector<$innerType>";
	}

	if (normalizedType["Struct"] != null) {
		if (isSameStruct(normalizedType["Struct"], RESOLVED_ASCII_STR)) {
			return 'string';
		} else if (isSameStruct(normalizedType["Struct"], RESOLVED_UTF8_STR)) {
			return 'utf8string';
		} else if (isSameStruct(normalizedType["Struct"], RESOLVED_SUI_ID)) {
			return 'address';
		} else if (isSameStruct(normalizedType["Struct"], RESOLVED_STD_OPTION)) {
			final optionToVec = {
				"Vector": normalizedType["Struct"]["typeArguments"][0],
			};
			return getPureSerializationType(optionToVec, argVal);
		}
	}

	return null;
}

dynamic normalizedTypeToMoveTypeSignature(
	SuiMoveNormalizedType type
) {
	if (type is Map && type['Reference'] != null) {
		return {
			"ref": '&',
			"body": normalizedTypeToMoveTypeSignatureBody(type["Reference"]),
		};
	}
	if (type is Map && type['MutableReference'] != null) {
		return {
			"ref": '&mut',
			"body": normalizedTypeToMoveTypeSignatureBody(type["MutableReference"]),
		};
	}

	return {
		"ref": null,
		"body": normalizedTypeToMoveTypeSignatureBody(type),
	};
}

dynamic normalizedTypeToMoveTypeSignatureBody(
	SuiMoveNormalizedType type
) {
	if (type is String) {
		switch (type) {
			case 'Address':
				return 'address';
			case 'Bool':
				return 'bool';
			case 'U8':
				return 'u8';
			case 'U16':
				return 'u16';
			case 'U32':
				return 'u32';
			case 'U64':
				return 'u64';
			case 'U128':
				return 'u128';
			case 'U256':
				return 'u256';
			default:
				throw ArgumentError("Unexpected type $type");
		}
	}

	if (type['Vector'] != null) {
		return { "vector": normalizedTypeToMoveTypeSignatureBody(type["Vector"]) };
	}

	if (type['Struct'] != null) {
		return {
			"datatype": {
				"package": type["Struct"]["address"],
				"module": type["Struct"]["module"],
				"type": type["Struct"]["name"],
				"typeParameters": type["Struct"]["typeArguments"].map(normalizedTypeToMoveTypeSignatureBody),
			},
		};
	}

	if (type['TypeParameter'] != null) {
		return { "typeParameter": type["TypeParameter"] };
	}

	throw ArgumentError("Unexpected type $type");
}