
import 'dart:convert';

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

bool isTxContext(SuiMoveNormalizedType param) {
	final struct = extractStructTag(param)?["Struct"];
  if (struct == null) return false;
	return (
		struct["address"] == '0x2' && struct["module"] == 'tx_context' && struct["name"] == 'TxContext'
	);
}

void expectType(String typeName, SuiJsonValue? argVal) {
	if (argVal == null) {
		return;
	}
	if (argVal is! String) {
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
			if (argVal && !isValidSuiAddress(argVal)) {
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
