import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/helper.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/types/common.dart';
import 'package:sui/utils/hex.dart';
import 'package:sui/utils/sha.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed25519;

const PUBLIC_KEY_SIZE = 32;

class Ed25519PublicKey with PublicKey {
  late BigInt _bn;

  Ed25519PublicKey._(BigInt bn) {
    _bn = bn;
  }

  factory Ed25519PublicKey.fromBytes(List<int> publicKey) {
    final buffer = Uint8List.fromList(publicKey);
    if (buffer.length != PUBLIC_KEY_SIZE) {
      throw ArgumentError(
          "Invalid public key input. Expected $PUBLIC_KEY_SIZE bytes, got ${buffer.length}");
    }
    return Ed25519PublicKey._(decodeBigIntToUnsigned(buffer));
  }

  /// Create a new Ed25519PublicKey object.
  ///
  /// ed25519 [publicKey] as base-64 encoded string.
  factory Ed25519PublicKey.fromString(String publicKeyBase64) {
    Uint8List buffer = base64Decode(publicKeyBase64);
    return Ed25519PublicKey.fromBytes(buffer);
  }

  @override
  bool equals(PublicKey publicKey) {
    return _bn == (publicKey as Ed25519PublicKey)._bn;
  }

  @override
  String toBase64() {
    return base64Encode(toRawBytes());
  }

  @override
  Uint8List toRawBytes() {
    Uint8List buffer = encodeBigIntAsUnsigned(_bn);
    if (buffer.length == PUBLIC_KEY_SIZE) {
      return buffer;
    }

    final zeroPad = Uint8List(PUBLIC_KEY_SIZE);
    zeroPad.setAll(PUBLIC_KEY_SIZE - buffer.length, buffer);
    return zeroPad;
  }

  /// Return the base-64 representation of the Ed25519 public key
  @override
  String toString() {
    return toBase64();
  }

  /// Return the Sui address associated with this Ed25519 public key
  @override
  String toSuiAddress() {
    final tmp = Uint8List(PUBLIC_KEY_SIZE + 1);
    tmp[0] = SIGNATURE_SCHEME_TO_FLAG.Ed25519;
    tmp.setAll(1, toRawBytes());
    final publicKey = Hex.encode(blake2b(tmp));
    return normalizeSuiAddress(publicKey.substring(0, SUI_ADDRESS_LENGTH * 2));
  }

  @override
  int flag() => SIGNATURE_SCHEME_TO_FLAG.Ed25519;
  
  @override
  bool verify(Uint8List data, Uint8List signature) {
    if (signature.length != 64) {
      signature = parseSerializedSignature(base64Encode(signature)).signature;
    }
    return ed25519.verify(ed25519.PublicKey(toRawBytes()), data, signature);
  }
}
