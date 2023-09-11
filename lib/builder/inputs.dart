import 'dart:typed_data';

import 'package:sui/builder/bcs.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';

class Inputs {
  static Map<String, dynamic> pure(dynamic data, [String? type]) {
    if (data is! Uint8List && type == null) {
      throw ArgumentError.notNull("type");
    }

    return {
      "Pure": List<int>.from(data is Uint8List
          ? data
          : // NOTE: We explicitly set this to be growable to infinity, because we have maxSize validation at the builder-level:
          builder.ser(type, data).toBytes())
    };
  }

  static Map<String, dynamic> objectRef(SuiObjectRef data) {
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
      "Object": {
        "Shared": {
          "mutable": mutable,
          "initialSharedVersion": initialSharedVersion,
          "objectId": normalizeSuiAddress(objectId),
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

dynamic getSharedObjectInput(dynamic arg) {
  if (arg is Map) {
    return arg["Object"]?["Shared"];
  } else {
    return null;
  }
}

bool isSharedObjectInput(dynamic arg) {
  return getSharedObjectInput(arg) ?? false;
}

bool isMutableSharedObjectInput(dynamic arg) {
  final tmp = getSharedObjectInput(arg);
  return tmp?["mutable"] ?? false;
}
