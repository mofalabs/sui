import "dart:typed_data";
import "package:sui/utils/hex.dart";

Uint8List toBufferBE(BigInt num, int width) {
  final hex = num.toRadixString(16);
  final pad = hex.padLeft(width * 2, '0');
  return Hex.decode(pad.substring(pad.length - width * 2));
}
