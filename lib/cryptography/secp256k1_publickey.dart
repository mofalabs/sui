
import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/publickey.dart';
import 'package:sui/cryptography/secp256k1.dart';
import 'package:sui/utils/hex.dart';
import 'package:sui/utils/sha.dart';

const SECP256K1_PUBLIC_KEY_SIZE = 33;

class Secp256k1PublicKey with PublicKey {
  late BigInt _bn;

  Secp256k1PublicKey(BigInt bn) {
      Uint8List buffer = encodeBigIntAsUnsigned(bn);
      if (buffer.length != SECP256K1_PUBLIC_KEY_SIZE) {
        throw ArgumentError(
          "Invalid public key input. Expected $SECP256K1_PUBLIC_KEY_SIZE bytes, got ${buffer.length}"
        );
      }

      _bn = bn;
  }

  factory Secp256k1PublicKey.fromBytes(Uint8List publicKey) {
    final buffer = Uint8List.fromList(publicKey);
    if (buffer.length != SECP256K1_PUBLIC_KEY_SIZE) {
      throw ArgumentError(
        "Invalid public key input. Expected $SECP256K1_PUBLIC_KEY_SIZE bytes, got ${buffer.length}"
      );
    }
    return Secp256k1PublicKey(decodeBigIntToUnsigned(buffer));
  }

  /// Create a new Secp256k1PublicKey object.
  /// 
  /// secp256k1 [publicKeyBase64] as base-64 encoded string.
  factory Secp256k1PublicKey.fromString(String publicKeyBase64) {
    Uint8List buffer = base64Decode(publicKeyBase64);
    return Secp256k1PublicKey.fromBytes(buffer);
  }

  @override
  bool equals(PublicKey publicKey) {
    return _bn == (publicKey as Secp256k1PublicKey)._bn;
  }

  @override
  String toBase64() {
    return base64Encode(toBytes());
  }

  /// Return the byte array representation of the Secp256k1 public key
  @override
  Uint8List toBytes() {
    Uint8List buffer = encodeBigIntAsUnsigned(_bn);
    if (buffer.length == SECP256K1_PUBLIC_KEY_SIZE) {
      return buffer;
    }

    final zeroPad = Uint8List(SECP256K1_PUBLIC_KEY_SIZE);
    zeroPad.setAll(SECP256K1_PUBLIC_KEY_SIZE - buffer.length, buffer);
    return zeroPad;
  }

  /// Return the base-64 representation of the Secp256k1 public key
  @override
  String toString() {
    return toBase64();
  }

  /// Return the Sui address associated with this Secp256k1 public key
  @override
  String toSuiAddress() {
    final tmp = Uint8List(SECP256K1_PUBLIC_KEY_SIZE + 1);
    tmp[0] = SIGNATURE_SCHEME_TO_FLAG.Secp256k1;
    tmp.setAll(1, toBytes());
    final publicKey = Hex.encode(sha256(tmp));
    return "0x" + publicKey.substring(0, 40);
  }
}
