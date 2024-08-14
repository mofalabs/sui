
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:sui/types/common.dart';

enum UpgradePolicy {
  COMPATIBLE,
  ADDITIVE,
  DEP_ONLY,
}

class Commands {
  static Map<String, dynamic> moveCall(dynamic input) {
    late String pkg, mod, fn;
    List<dynamic> typeArguments = [], arguments = [];

    if (input is Map<String, dynamic> && input.containsKey('target')) {
      final parts = (input['target'] as String).split('::');
      pkg = parts[0];
      mod = parts.length > 1 ? parts[1] : '';
      fn = parts.length > 2 ? parts[2] : '';
      typeArguments = input['typeArguments'] ?? [];
      arguments = input['arguments'] ?? [];
    } else if (input is Map<String, dynamic>) {
      pkg = input['package'];
      mod = input['module'];
      fn = input['function'];
      typeArguments = input['typeArguments'] ?? [];
      arguments = input['arguments'] ?? [];
    }

    return {
      '\$kind': 'MoveCall',
      'MoveCall': {
        'package': pkg,
        'module': mod,
        'function': fn,
        'typeArguments': typeArguments,
        'arguments': arguments,
      },
    };
  }

  static Map<String, dynamic> transferObjects(List<dynamic> objects, dynamic address) {
    return {
      '\$kind': 'TransferObjects',
      'TransferObjects': {
        'objects': objects,
        'address': address,
      },
    };
  }

  static Map<String, dynamic> splitCoins(dynamic coin, List<dynamic> amounts) {
    return {
      '\$kind': 'SplitCoins',
      'SplitCoins': {
        'coin': coin,
        'amounts': amounts,
      },
    };
  }

  static Map<String, dynamic> mergeCoins(dynamic destination, List<dynamic> sources) {
    return {
      '\$kind': 'MergeCoins',
      'MergeCoins': {
        'destination': destination,
        'sources': sources,
      },
    };
  }

  static Map<String, dynamic> publish({
    required List<dynamic> modules,
    required List<String> dependencies,
  }) {
    return {
      '\$kind': 'Publish',
      'Publish': {
        'modules': modules.map((module) =>
          module is String ? module : toB64(Uint8List.fromList(module))
        ).toList(),
        'dependencies': dependencies.map((dep) => normalizeSuiObjectId(dep)).toList(),
      },
    };
  }

  static Map<String, dynamic> upgrade({
    required List<dynamic> modules,
    required List<String> dependencies,
    required String package,
    required dynamic ticket,
  }) {
    return {
      '\$kind': 'Upgrade',
      'Upgrade': {
        'modules': modules.map((module) =>
          module is String ? module : toB64(Uint8List.fromList(module))
        ).toList(),
        'dependencies': dependencies.map((dep) => normalizeSuiObjectId(dep)).toList(),
        'package': package,
        'ticket': ticket,
      },
    };
  }

  static Map<String, dynamic> makeMoveVec({
    String? type,
    required List<dynamic> elements,
  }) {
    return {
      '\$kind': 'MakeMoveVec',
      'MakeMoveVec': {
        'type': type,
        'elements': elements,
      },
    };
  }

  static Map<String, dynamic> intent({
    required String name,
    Map<String, dynamic>? inputs,
    Map<String, dynamic>? data,
  }) {
    return {
      '\$kind': '\$Intent',
      '\$Intent': {
        'name': name,
        'inputs': inputs?.map((key, value) => MapEntry(
          key,
          value
        )) ?? {},
        'data': data ?? {},
      },
    };
  }
}