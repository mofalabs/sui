import 'dart:typed_data';

import 'package:hex/hex.dart';

import '../bcs/sui_bcs.dart';
import 'sha.dart';

/// Derive the object ID of a dynamic field on [parentId] with the given field
/// name type ([nameType], e.g. `u64` or `0x2::foo::Bar`) and BCS-encoded name
/// value ([nameBcs]).
///
/// Mirrors `deriveDynamicFieldID` in the TypeScript SDK:
/// `blake2b(0xf0 || parent || u64(len(key)) || key || typeTag)[0..32]`.
String deriveDynamicFieldID(
  String parentId,
  String nameType,
  Uint8List nameBcs,
) {
  final address = SuiBcs.Address.serialize(parentId).toBytes();
  final tag = SuiBcs.TypeTag.serialize(nameType).toBytes();
  final keyLength = SuiBcs.U64.serialize(nameBcs.length).toBytes();

  final buf = <int>[
    0xf0,
    ...address,
    ...keyLength,
    ...nameBcs,
    ...tag,
  ];

  final hash = blake2b(buf);
  return '0x${HEX.encode(hash.sublist(0, 32))}';
}
