import 'dart:typed_data';

import 'package:sui/builder/bcs.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';


class Inputs {
	static Map<String, dynamic> Pure(dynamic data, [String? type]) {
    if (data is! Uint8List && type == null) {
      throw ArgumentError.notNull("type");
    }

		return {
			"Pure": List<int>.from(
				data is Uint8List
					? data
					: // NOTE: We explicitly set this to be growable to infinity, because we have maxSize validation at the builder-level:
					  builder.ser(type, data).toBytes()
      )
		};
	}

	static Map<String, dynamic> ObjectRef(SuiObjectRef data) {
		return {
			"Object": {
				"ImmOrOwned": {
					"digest": data.digest,
					"version": data.version,
					"objectId": normalizeSuiAddress(data.objectId),
				},
			},
		};
	}

	static Map<String, dynamic> SharedObjectRef(dynamic data) {
		return {
			"Object": {
				"Shared": {
					"mutable": data["mutable"],
					"initialSharedVersion": data["initialSharedVersion"],
					"objectId": normalizeSuiAddress(data["objectId"]),
				},
			},
		};
	}
}

getIdFromCallArg(dynamic arg) {
	if (arg is String) {
		return normalizeSuiAddress(arg);
	}
	if ((arg["Object"] as Map).containsKey("ImmOrOwned")) {
		return normalizeSuiAddress(arg["Object"]["ImmOrOwned"]["objectId"]);
	}
	return normalizeSuiAddress(arg["Object"]["Shared"]["objectId"]);
}

dynamic getSharedObjectInput(Map arg) {
  return (arg.containsKey("Object") && arg["Object"].containsKey("Shared")) ? arg["Object"]["Shared"] : null;
}

bool isSharedObjectInput(dynamic arg) {
	return getSharedObjectInput(arg) ?? false;
}

bool isMutableSharedObjectInput(dynamic arg) {
  final tmp = getSharedObjectInput(arg);
  if (tmp == null) return false;
  return tmp["mutable"] ?? false;
}