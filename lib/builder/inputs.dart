import 'dart:typed_data';

import 'package:bcs/bcs_type.dart';
import 'package:bcs/utils.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';

class Inputs {

  static Map<String, dynamic> pure(dynamic data, [String? type]) {
    return {
		  "\$kind": 'Pure',
		  "Pure": {
  			"bytes": data is Uint8List ? toB64(data) : (data as SerializedBcs).toBase64(),
		  },
    };
  }

  static Map<String, dynamic> objectRef(SuiObjectRef data) {
    return {
      "\$kind": 'Object',
      "Object": {
        "\$kind": 'ImmOrOwnedObject',
        "ImmOrOwnedObject": {
          "digest": data.digest,
          "version": data.version,
          "objectId": normalizeSuiAddress(data.objectId),
        },
      },
    };
  }

  static Map<String, dynamic> sharedObjectRef(dynamic data) {
    bool mutable = false;
    int initialSharedVersion;
    String objectId;
    if (data is SuiObject) {
      mutable = data.owner!.immutable ? false : true;
      initialSharedVersion = data.owner!.shared!.initialSharedVersion;
      objectId = data.objectId;
    } else {
      mutable = data["mutable"];
      initialSharedVersion = data["initialSharedVersion"];
      objectId = data["objectId"];
    }
    return {
      "\$kind": 'Object',
      "Object": {
        "\$kind": 'SharedObject',
        "SharedObject": {
          "mutable": mutable,
          "initialSharedVersion": initialSharedVersion,
          "objectId": normalizeSuiAddress(objectId),
        },
      },
    };
  }

	static Map<String, dynamic> receivingRef(SuiObjectRef data) {
		return {
      "\$kind": 'Object',
			"Object": {
        "\$kind": 'Receiving',
				"Receiving": {
					"digest": data.digest,
					"version": data.version,
					"objectId": normalizeSuiAddress(data.objectId),
				},
			},
		};
	}
}

dynamic getIdFromCallArg(dynamic arg) {
  if (arg is String) {
    return normalizeSuiAddress(arg);
  }

  if (arg["Object"] != null) {
    if (arg["Object"]["ImmOrOwnedObject"] != null) {
      return normalizeSuiAddress(arg["Object"]["ImmOrOwnedObject"]["objectId"]);  
    } 
    if (arg["Object"]["Receiving"] != null) {
      return normalizeSuiAddress(arg["Object"]["Receiving"]["objectId"]);
    }
    if (arg["Object"]["SharedObject"] != null) {
      return normalizeSuiAddress(arg["Object"]["SharedObject"]["objectId"]);
    }
  } 

  if (arg["UnresolvedObject"] != null) {
    return arg["UnresolvedObject"]["objectId"];
  }

  return null;
}

dynamic getSharedObjectInput(dynamic arg) {
  return arg["Object"]?["SharedObject"];
}

bool isSharedObjectInput(dynamic arg) {
  return getSharedObjectInput(arg) ?? false;
}

bool isMutableSharedObjectInput(dynamic arg) {
  final tmp = getSharedObjectInput(arg);
  return tmp?["mutable"] ?? false;
}
