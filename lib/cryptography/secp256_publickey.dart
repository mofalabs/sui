
import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/helper.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/secp256.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/types/common.dart';
import 'package:sui/utils/hex.dart';
import 'package:sui/utils/sha.dart';

const SECP256_PUBLIC_KEY_SIZE = 33;

class Secp256PublicKey with PublicKey {
  late int _flag;
  late BigInt _bn;

  Secp256PublicKey._(BigInt bn, int flag) {
      _bn = bn;
      _flag = flag;
  }

  factory Secp256PublicKey.fromBytes(Uint8List publicKey, int flag) {
    final buffer = Uint8List.fromList(publicKey);
    if (buffer.length != SECP256_PUBLIC_KEY_SIZE) {
      throw ArgumentError(
        "Invalid public key input. Expected $SECP256_PUBLIC_KEY_SIZE bytes, got ${buffer.length}"
      );
    }
    return Secp256PublicKey._(decodeBigIntToUnsigned(buffer), flag);
  }

  /// Create a new Secp256PublicKey object.
  /// 
  /// secp256 [publicKeyBase64] as base-64 encoded string.
  factory Secp256PublicKey.fromString(String publicKeyBase64, int flag) {
    Uint8List buffer = base64Decode(publicKeyBase64);
    return Secp256PublicKey.fromBytes(buffer, flag);
  }

  @override
  bool equals(PublicKey publicKey) {
    return _bn == (publicKey as Secp256PublicKey)._bn;
  }

  @override
  String toBase64() {
    return base64Encode(toRawBytes());
  }

  /// Return the byte array representation of the Secp256 public key
  @override
  Uint8List toRawBytes() {
    Uint8List buffer = encodeBigIntAsUnsigned(_bn);
    if (buffer.length == SECP256_PUBLIC_KEY_SIZE) {
      return buffer;
    }

    final zeroPad = Uint8List(SECP256_PUBLIC_KEY_SIZE);
    zeroPad.setAll(SECP256_PUBLIC_KEY_SIZE - buffer.length, buffer);
    return zeroPad;
  }

  /// Return the base-64 representation of the Secp256 public key
  @override
  String toString() {
    return toBase64();
  }

  /// Return the Sui address associated with this Secp256 public key
  /// [flag] SIGNATURE_SCHEME_TO_FLAG
  @override
  String toSuiAddress() {
    final tmp = Uint8List(SECP256_PUBLIC_KEY_SIZE + 1);
    tmp[0] = _flag;
    tmp.setAll(1, toRawBytes());
    final publicKey = Hex.encode(blake2b(tmp));
    return normalizeSuiAddress(publicKey.substring(0, SUI_ADDRESS_LENGTH * 2));
  }

  @override
  int flag() => _flag;
  
  @override
  bool verify(Uint8List data, Uint8List signature) {
    final msgHash = sha256(data);
    if (signature.length != 64) {
      signature = parseSerializedSignature(base64Encode(signature)).signature;
    }
    switch (flag()) {
      case SIGNATURE_SCHEME_TO_FLAG.Secp256k1:
        return Secp256.fromSecp256k1().verifySignature(msgHash, SignatureData.fromBytes(signature), toRawBytes());
      case SIGNATURE_SCHEME_TO_FLAG.Secp256r1:
        return Secp256.fromSecp256r1().verifySignature(msgHash, SignatureData.fromBytes(signature), toRawBytes());
      default:
        throw ArgumentError("Invalid flag ${flag()}");
    }
  }
}
