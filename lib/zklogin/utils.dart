import "dart:typed_data";
import "package:sui/utils/hex.dart";

Uint8List toBufferBE(BigInt num, int width) {
  final hex = num.toRadixString(16);
  final pad = hex.padLeft(width * 2, '0');
  return Hex.decode(pad.substring(pad.length - width * 2));
}

int findFirstNonZeroIndex(Uint8List bytes) {
  for (int i = 0; i < bytes.length; i++) {
    if (bytes[i] != 0) {
      return i;
    }
  }
  return -1;
}

/// Derive bytearray from num where the bytearray is padded to the left with 0s to the specified width.
Uint8List toPaddedBigEndianBytes(BigInt num, int width) {
  String hex = num.toRadixString(16);
  return Hex.decode(
      hex.padLeft(width * 2, '0').substring(hex.length - width * 2));
}

/// Derive bytearray from num where the bytearray is not padded with 0.
Uint8List toBigEndianBytes(BigInt num, int width) {
  Uint8List bytes = toPaddedBigEndianBytes(num, width);

  int firstNonZeroIndex = findFirstNonZeroIndex(bytes);

  if (firstNonZeroIndex == -1) {
    return Uint8List.fromList([0]);
  }

  return bytes.sublist(firstNonZeroIndex);
}
