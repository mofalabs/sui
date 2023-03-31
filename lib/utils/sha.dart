import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

final sha256Hash = SHA256Digest();
final sha3Hash = SHA3Digest(256);
final blake2bDigest = Blake2bDigest(digestSize: 32);

Uint8List sha256(List<int> data) {
  sha256Hash.reset();
  return sha256Hash.process(Uint8List.fromList(data));
}

Uint8List sha256FromString(String str) {
  sha256Hash.reset();
  final data = Uint8List.fromList(utf8.encode(str));
  return sha256Hash.process(data);
}

Uint8List hmacSha256Sync(Uint8List hmacKey, Uint8List data) {
  final hmac = HMac(SHA256Digest(), 64) 
    ..init(KeyParameter(hmacKey));

  return hmac.process(data);
}

Uint8List sha3256(List<int> data) {
  sha3Hash.reset();
  return sha3Hash.process(Uint8List.fromList(data));
}

Uint8List sha3256FromString(String str) {
  sha3Hash.reset();
  final data = Uint8List.fromList(utf8.encode(str));
  return sha3Hash.process(data);
}

Uint8List blake2b(List<int> data) {
  blake2bDigest.reset();
  return blake2bDigest.process(Uint8List.fromList(data));
}