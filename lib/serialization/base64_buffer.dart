
import 'dart:convert';
import 'dart:typed_data';

class Base64DataBuffer {
  late List<int> _data;

  Base64DataBuffer(List<int> data) {
    _data = data;
  }

  factory Base64DataBuffer.fromString(String data) {
    return Base64DataBuffer(utf8.encode(data));
  }

  factory Base64DataBuffer.fromBase64String(String data) {
    return Base64DataBuffer(base64Decode(data));
  }

  Uint8List getData() {
    return Uint8List.fromList(_data);
  }

  int getLength() {
    return _data.length;
  }

  String toBase64() {
    return base64Encode(_data);
  }

  @override
  String toString() {
    return toBase64();
  }
}
