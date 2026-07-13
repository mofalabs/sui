import 'dart:typed_data';

class Hex {
  static String encode(List<int> bytes) {
    var buffer = StringBuffer();
    for (int byte in bytes) {
      if (byte & 0xff != byte) {
        throw FormatException("Invalid byte $byte detected");
      }
      buffer.write('${byte < 16 ? '0' : ''}${byte.toRadixString(16)}');
    }
    return buffer.toString();
  }

  static Uint8List decode(String hex) {
    String str = trimHex(hex);
    if (str.length % 2 != 0) {
      str = "0$str";
    }

    var result = Uint8List(str.length ~/ 2);
    for (int i = 0; i < str.length; i += 2) {
      final high = _hexDigit(str.codeUnitAt(i));
      final low = _hexDigit(str.codeUnitAt(i + 1));
      if (high == -1 || low == -1) {
        throw FormatException("Invalid hexadecimal string", hex);
      }
      result[i ~/ 2] = (high << 4) | low;
    }
    return result;
  }

  static int _hexDigit(int code) {
    if (code >= 0x30 && code <= 0x39) return code - 0x30; // 0-9
    if (code >= 0x61 && code <= 0x66) return code - 0x57; // a-f
    if (code >= 0x41 && code <= 0x46) return code - 0x37; // A-F
    return -1;
  }

  static String trimHex(String hex) {
    if (hex.startsWith(RegExp('^0[xX]'))) return hex.substring(2);
    return hex;
  }

  static String prefixHex(String hex) {
    if (hex.startsWith(RegExp('^0[xX]'))) return hex;
    return "0x$hex";
  }
}
