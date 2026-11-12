import 'dart:convert';
import 'dart:typed_data';

import 'package:pqcrypto/pqcrypto.dart' show MlDsa, DilithiumParams;

import '../utils/hex.dart';
import '../utils/sha.dart';
import 'keypair.dart';

const mldsa65PublicKeySize = 1952;
const mldsa65SignatureSize = 3309;

/// FIPS 204 ML-DSA-65 public key (Sui signature flag 0x07).
class Mldsa65PublicKey with PublicKey {
  Mldsa65PublicKey(Uint8List bytes) : _bytes = Uint8List.fromList(bytes) {
    if (_bytes.length != mldsa65PublicKeySize) {
      throw ArgumentError.value(
        bytes.length,
        'bytes.length',
        'Expected $mldsa65PublicKeySize',
      );
    }
  }

  factory Mldsa65PublicKey.fromBase64(String value) =>
      Mldsa65PublicKey(base64Decode(value));
  final Uint8List _bytes;

  @override
  int flag() => 7;
  @override
  Uint8List toRawBytes() => Uint8List.fromList(_bytes);
  @override
  String toBase64() => base64Encode(_bytes);
  @override
  String toString() => toBase64();
  @override
  String toSuiAddress() => '0x${Hex.encode(blake2b(toSuiBytes()))}';

  @override
  bool verify(Uint8List data, Uint8List signature) {
    var bytes = signature;
    if (bytes.length == 1 + mldsa65SignatureSize + mldsa65PublicKeySize) {
      if (bytes.first != flag() ||
          !bytesEqual(_bytes, bytes.sublist(1 + mldsa65SignatureSize))) {
        return false;
      }
      bytes = bytes.sublist(1, 1 + mldsa65SignatureSize);
    }
    return bytes.length == mldsa65SignatureSize &&
        MlDsa.verify(_bytes, data, bytes, DilithiumParams.mlDsa65);
  }
}
