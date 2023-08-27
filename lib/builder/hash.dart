
import 'dart:typed_data';

import 'package:sui/utils/sha.dart';

/// Generates a Blake2b hash of typed data as a base64 string.
Uint8List hashTypedData(String typeTag, Uint8List data) {
  final typeTagBytes = "$typeTag::".codeUnits;

	final dataWithTag = Uint8List(typeTagBytes.length + data.length);
	dataWithTag.setAll(0, typeTagBytes);
	dataWithTag.setAll(typeTagBytes.length, data);

	return blake2b(dataWithTag);
}
