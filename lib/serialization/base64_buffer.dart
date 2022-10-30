
import 'dart:convert';
import 'dart:typed_data';

class Base64DataBuffer {
  late Uint8List _data;

  Base64DataBuffer(Uint8List data) {
    _data = data;
  }

  factory Base64DataBuffer.fromString(String data) {
    return Base64DataBuffer(Uint8List.fromList(utf8.encode(data)));
  }

  factory Base64DataBuffer.fromBase64String(String data) {
    return Base64DataBuffer(base64Decode(data));
  }

  Uint8List getData() {
    return _data;
  }

  int getLength() {
    return _data.length;
  }

  @override
  String toString() {
    return base64Encode(_data);
  }
}
