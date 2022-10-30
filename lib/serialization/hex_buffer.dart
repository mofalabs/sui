
import 'dart:typed_data';

import 'package:sui/utils/hex.dart';

class HexDataBuffer {
  late Uint8List _data;

  HexDataBuffer(Uint8List data) {
    _data = data;
  }

  factory HexDataBuffer.fromString(String data) {
    return HexDataBuffer(Hex.decode(data));
  }

  Uint8List getData() {
    return _data;
  }

  int getLength() {
    return _data.length;
  }

  @override
  String toString() {
    return Hex.encode(_data);
  }
}
