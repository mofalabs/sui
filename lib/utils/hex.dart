
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
      str = "0" + str;
    }

    var result = Uint8List(str.length ~/ 2);
    for (int i = 0; i < str.length; i += 2) {
      String num = str.substring(i, i + 2);
      int byte = int.parse(num, radix: 16);
      result[i ~/ 2] = byte;
    }
    return result;
  }

  static String trimHex(String hex) {
    if (hex.startsWith(RegExp('^0[xX]'))) return hex.substring(2);
    return hex;
  }

  static String prefixHex(String hex) {
    if (hex.startsWith(RegExp('^0[xX]'))) return hex;
    return "0x" + hex;
  }

}