import 'dart:convert';
import 'dart:typed_data';

import 'package:hex/hex.dart';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed25519;

class Keys {
  Keys({this.key, this.chainCode});

  final Uint8List? key;
  final Uint8List? chainCode;
}

const pathRegex = r"^m(\/[0-9]+')+$";
const HMAC_KEY = "ed25519 seed";
const HARDENED_OFFSET = 0x80000000;

String replaceDerive(String val) => val.replaceAll("'", "");

Uint8List hmacSha512(Uint8List hmacKey, Uint8List data) {
  final hmac = HMac(SHA512Digest(), 128) 
    ..init(KeyParameter(hmacKey));

  return hmac.process(data);
}

Keys getMasterKeyFromSeed(String seed) {
  final keyBytes = Uint8List.fromList(utf8.encode(HMAC_KEY));
  final seedBytes = Uint8List.fromList(HEX.decode(seed));
  final digest = hmacSha512(keyBytes, seedBytes);
  final IL = digest.sublist(0, 32);
  final IR = digest.sublist(32);
  return Keys(key: IL, chainCode: IR);
}

Keys ckdPriv(Keys keys, int index) {
  final buffer = Uint8List(4);
  ByteData.sublistView(buffer).setUint32(0, index);
  final indexBytes = buffer;
  final zero = Uint8List.fromList([0]);
  final data = <int>[];
  data.addAll(zero);
  data.addAll(keys.key!);
  data.addAll(indexBytes);
  final I = hmacSha512(keys.chainCode!, Uint8List.fromList(data));
  final IL = I.sublist(0, 32);
  final IR = I.sublist(32);
  return Keys(key: IL, chainCode: IR);
}

Uint8List getPublicKey(Uint8List privateKey, [bool withZeroByte = true]) {
  final keyPair = ed25519.newKeyFromSeed(privateKey);
  final signPk = Uint8List.fromList(keyPair.bytes.sublist(32));
  if (!withZeroByte) return signPk;
  final zero = Uint8List.fromList([0]);
  final data = Uint8List(zero.lengthInBytes + signPk.lengthInBytes);
  data.addAll(zero);
  data.addAll(signPk);
  return data;
}

bool isValidPath(String path) {
  if (!RegExp(pathRegex).hasMatch(path)) {
    return false;
  }
  return !path
    .split("/")
    .sublist(1)
    .map(replaceDerive)
    .any((e) => int.tryParse(e) == null);
}

Keys derivePath(String path, String seed, {int offset = HARDENED_OFFSET}) {
  if (!isValidPath(path)) {
    throw ArgumentError("Invalid derivation path");
  }

  final keys = getMasterKeyFromSeed(seed);
  final segments = path
    .split("/")
    .sublist(1)
    .map(replaceDerive)
    .map((el) => int.parse(el, radix: 10));

  Keys parentKeys = keys; 
  for (int i in segments) {
    parentKeys = ckdPriv(parentKeys, i + offset);
  }
  return parentKeys;
}
