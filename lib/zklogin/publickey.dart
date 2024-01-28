import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/ed25519_publickey.dart';
import 'package:sui/cryptography/helper.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/types/common.dart';
import 'package:sui/utils/hex.dart';
import 'package:sui/utils/sha.dart';
import 'package:sui/zklogin/utils.dart';

class ZkLoginPublicIdentifier with PublicKey {
  late BigInt _bn;

  ZkLoginPublicIdentifier._(BigInt bn) {
    _bn = bn;
  }

  @override
  bool equals(PublicKey publicKey) {
    return _bn == (publicKey as ZkLoginPublicIdentifier)._bn;
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

  @override
  int flag() {
    return SIGNATURE_SCHEME_TO_FLAG.ZkLogin;
  }

  @override
  String toBase64() {
    return base64Encode(toRawBytes());
  }

  @override
  String toSuiAddress() {
    final tmp = Uint8List(PUBLIC_KEY_SIZE + 1);
    tmp[0] = SIGNATURE_SCHEME_TO_FLAG.ZkLogin;
    tmp.setAll(1, toRawBytes());
    final publicKey = Hex.encode(blake2b(tmp));
    return normalizeSuiAddress(publicKey.substring(0, SUI_ADDRESS_LENGTH * 2));
  }

  /// Verifies that the signature is valid for for the provided PersonalMessage
  Future<bool> verify(Uint8List message, dynamic signature) async {
    throw Exception('does not support');
  }
}

ZkLoginPublicIdentifier toZkLoginPublicIdentifier(
    BigInt addressSeed, String iss) {
  // Consists of iss_bytes_len || iss_bytes || padded_32_byte_address_seed.
  Uint8List addressSeedBytesBigEndian = toPaddedBigEndianBytes(addressSeed, 32);
  List<int> issBytes = utf8.encode(iss);
  Uint8List tmp =
      Uint8List(1 + issBytes.length + addressSeedBytesBigEndian.length);
  tmp[0] = issBytes.length;
  tmp.setAll(1, issBytes);
  tmp.setAll(1 + issBytes.length, addressSeedBytesBigEndian);
  return ZkLoginPublicIdentifier._(decodeBigIntToUnsigned(tmp));
}
