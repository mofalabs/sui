import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:bcs/bcs_type.dart';
import 'package:sui/bcs/sui_bcs.dart';

typedef PureCreator<T> = T Function(dynamic);

enum PureType {
  u8,
  u16,
  u32,
  u64,
  u128,
  u256,
  bool,
  id,
  string,
  address
}

class Pure {
  final PureCreator _makePure;

  Pure(this._makePure);

  dynamic call(dynamic typeOrSerializedValue, [dynamic value]) {
    if (typeOrSerializedValue is String) {
      return _makePure(schemaFromName(typeOrSerializedValue).serialize(value));
    }

    if (typeOrSerializedValue is Uint8List || typeOrSerializedValue is SerializedBcs) {
      return _makePure(typeOrSerializedValue);
    }

    throw ArgumentError('pure must be called with either a bcs type name, or a serialized bcs value');
  }

  dynamic u8(int value) => _makePure(SuiBcs.U8.serialize(value));
  dynamic u16(int value) => _makePure(SuiBcs.U16.serialize(value));
  dynamic u32(int value) => _makePure(SuiBcs.U32.serialize(value));
  dynamic u64(BigInt value) => _makePure(SuiBcs.U64.serialize(value));
  dynamic u128(BigInt value) => _makePure(SuiBcs.U128.serialize(value));
  dynamic u256(BigInt value) => _makePure(SuiBcs.U256.serialize(value));
  dynamic boolean(bool value) => _makePure(SuiBcs.BOOL.serialize(value));
  dynamic string(String value) => _makePure(SuiBcs.STRING.serialize(value));
  dynamic address(String value) => _makePure(SuiBcs.Address.serialize(value));
  dynamic id(String value) => address(value);

  dynamic vector(String type, List value) {
    return _makePure(Bcs.vector(schemaFromName(type)).serialize(value));
  }

  dynamic option(String type, dynamic value) {
    return _makePure(Bcs.option(schemaFromName(type)).serialize(value));
  }
}

BcsType schemaFromName(String name) {
  switch (name) {
    case 'u8': return SuiBcs.U8;
    case 'u16': return SuiBcs.U16;
    case 'u32': return SuiBcs.U32;
    case 'u64': return SuiBcs.U64;
    case 'u128': return SuiBcs.U128;
    case 'u256': return SuiBcs.U256;
    case 'bool': return SuiBcs.BOOL;
    case 'string': return SuiBcs.STRING;
    case 'id':
    case 'address': return SuiBcs.Address;
  }

  final generic = RegExp(r'^(vector|option)<(.+)>$').firstMatch(name);
  if (generic != null) {
    final kind = generic.group(1);
    final inner = generic.group(2)!;
    if (kind == 'vector') {
      return Bcs.vector(schemaFromName(inner));
    } else {
      return Bcs.option(schemaFromName(inner));
    }
  }

  throw ArgumentError('Invalid Pure type name: $name');
}

Pure createPure<T>(PureCreator<T> makePure) {
  return Pure(makePure);
}