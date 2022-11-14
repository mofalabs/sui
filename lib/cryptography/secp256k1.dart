
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/key_generators/ec_key_generator.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';
import 'package:pointycastle/src/utils.dart' as utils;
import 'package:sui/utils/hex.dart';

final curveParams = ECCurve_secp256k1();

class SignatureData extends ECSignature {
  final int v;
  
  SignatureData(BigInt r, BigInt s, this.v): super(r, s);

  factory SignatureData.fromBytes(Uint8List data) {
    if (data.length != 65) {
      throw ArgumentError("Invalid bytes length ${data.length}");
    }

    final r = decodeBigIntToUnsigned(data.sublist(0, 32));
    final s = decodeBigIntToUnsigned(data.sublist(32, 64));
    final v = data[64];
    return SignatureData(r, s, v);
  }

  Uint8List toBytes() {
    final buffer = Uint8List(65);
    buffer.setAll(0, padLeftUint8List(encodeBigIntAsUnsigned(r)));
    buffer.setAll(32, padLeftUint8List(encodeBigIntAsUnsigned(s)));
    buffer[64] = v;
    return buffer;
  }
}

Uint8List encodeBigInt(BigInt? number) => utils.encodeBigInt(number);

Uint8List encodeBigIntAsUnsigned(BigInt number) => utils.encodeBigIntAsUnsigned(number);

BigInt decodeBigIntToUnsigned(List<int> magnitude) => utils.decodeBigIntWithSign(1, magnitude);

FortunaRandom getRandom() {
  final secureRandom = FortunaRandom();
  final seedSource = Random.secure();
  final seeds = <int>[];
  for (int i = 0; i < 32; i++) {
    seeds.add(seedSource.nextInt(255));
  }
  secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));
  return secureRandom;
}

AsymmetricKeyPair<PublicKey, PrivateKey> generateKeypair([SecureRandom? random]) {
  random ??= getRandom();
  CipherParameters cipherParams = ECKeyGeneratorParameters(curveParams);
  cipherParams = ParametersWithRandom(cipherParams, random);

  final generator = ECKeyGenerator()..init(cipherParams);
  final keypair = generator.generateKeyPair();
  return keypair;
}

BigInt generatePrivateKey([SecureRandom? random]) {
  final keypair = generateKeypair(random);
  final ecPrivateKey = keypair.privateKey as ECPrivateKey;
  return ecPrivateKey.d!;
}

Uint8List generatePrivateKeyBytes([SecureRandom? random]) {
  final privateKey = generatePrivateKey(random);
  return encodeBigIntAsUnsigned(privateKey);
}

/// If [isCompressed] is `true`, return public key length is 33 (flag + x),
/// otherwise, public key length is 64 (x + y)
Uint8List getPublicKey(BigInt privateKey, [bool isCompressed = true]) {
  final p = (curveParams.G * privateKey);
  final buffer = p!.getEncoded(isCompressed);
  return isCompressed ? buffer : Uint8List.sublistView(buffer, 1);
}

Uint8List getPublicKeyFromPrivateKeyBytes(Uint8List privateKey, [bool isCompressed = true]) {
  BigInt privKey = decodeBigIntToUnsigned(privateKey);
  return getPublicKey(privKey, isCompressed);
}

Uint8List padLeftUint8List(Uint8List data, [int len = 32]) {
  assert(data.length <= len);
  if (data.length == len) return data;

  return Uint8List(len)..setRange(len - data.length, len, data);
}

/// Given an arbitrary message hash and an Ethereum message signature encoded in bytes, returns
/// the public key that was used to sign it.
/// https://github.com/web3j/web3j/blob/c0b7b9c2769a466215d416696021aa75127c2ff1/crypto/src/main/java/org/web3j/crypto/Sign.java#L241
Uint8List ecRecover(Uint8List messageHash, SignatureData signature, [bool isCompressed = false]) {

  Uint8List r = padLeftUint8List(encodeBigIntAsUnsigned(signature.r));
  Uint8List s = padLeftUint8List(encodeBigIntAsUnsigned(signature.s));

  final header = signature.v & 0xFF;
  // The header byte: 0x1B = first key with even y, 0x1C = first key with odd y,
  //                  0x1D = second key with even y, 0x1E = second key with odd y
  if (header < 27 || header > 34) {
    throw Exception('Header byte out of range: $header');
  }

  final sig = ECSignature(signature.r, signature.s);

  int recId = header - 27;
  Uint8List? pubKey = recoverFromSignature(recId, sig, messageHash, isCompressed);
  if (pubKey == null) {
    throw Exception('Could not recover public key from signature');
  }
  return isCompressed ? pubKey : pubKey.sublist(1);
}

bool verifySignature(
  Uint8List messageHash,
  SignatureData signature,
  Uint8List publicKey,
) {
  final recoveredPublicKey = ecRecover(messageHash, signature, publicKey.length == 33);
  return Hex.encode(publicKey) == Hex.encode(recoveredPublicKey);
}

SignatureData sign(Uint8List messageHash, Uint8List privateKey) {
  final signer = ECDSASigner(null, HMac(SHA256Digest(), 64));
  final key = ECPrivateKey(decodeBigIntToUnsigned(privateKey), curveParams);
  signer.init(true, PrivateKeyParameter(key));
  var signature = signer.generateSignature(messageHash) as ECSignature;
  if(!signature.isNormalized(curveParams)) {
    signature = signature.normalize(curveParams);
  }

  BigInt privateKeyNum = decodeBigIntToUnsigned(privateKey);
  final publicKeyBytes = Uint8List.view(getPublicKey(privateKeyNum, false).buffer, 1);
  BigInt publicKey = decodeBigIntToUnsigned(publicKeyBytes);

  int recId = -1;
  for (int i = 0; i < 4; i++) {
    Uint8List? k = recoverFromSignature(i, signature, messageHash, false);
    if (k != null && decodeBigIntToUnsigned(k.sublist(1)) == publicKey) {
      recId = i;
      break;
    }
  }

  if (recId == -1) {
    throw Exception(
      'Could not construct a recoverable key. Are your credentials valid?',
    );
  }

  return SignatureData(signature.r, signature.s, recId + 27);
}

Uint8List? recoverFromSignature(int recId, ECSignature sig, Uint8List msg, [bool encoded = false]) {
  final n = curveParams.n;
  final i = BigInt.from(recId ~/ 2);
  final x = sig.r + (i * n);

  final prime = BigInt.parse(
    'fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f',
    radix: 16,
  );
  if (x.compareTo(prime) >= 0) return null;

  final R = _decompressKey(x, (recId & 1) == 1);
  if (!(R * n)!.isInfinity) return null;

  final e = decodeBigIntToUnsigned(msg);

  final eInv = (BigInt.zero - e) % n;
  final rInv = sig.r.modInverse(n);
  final srInv = (rInv * sig.s) % n;
  final eInvrInv = (rInv * eInv) % n;

  final q = (curveParams.G * eInvrInv)! + (R * srInv);

  final bytes = q!.getEncoded(encoded);
  return bytes;
}

ECPoint _decompressKey(BigInt xBN, bool yBit) {
  final compEnc = _x9IntegerToBytes(xBN, 1 + ((curveParams.curve.fieldSize + 7) ~/ 8));
  compEnc[0] = yBit ? 0x03 : 0x02;
  return curveParams.curve.decodePoint(compEnc)!;
}

/// https://github.com/bcgit/bc-java/blob/master/core/src/main/java/org/bouncycastle/asn1/x9/X9IntegerConverter.java#L45
List<int> _x9IntegerToBytes(BigInt s, int qLength) {
  final bytes = encodeBigInt(s);

  if (qLength < bytes.length) {
    return bytes.sublist(0, bytes.length - qLength);
  } else if (qLength > bytes.length) {
    final offset = qLength - bytes.length;
    final tmp = Uint8List(qLength);
    tmp.setRange(offset, qLength, bytes);
    return tmp;
  }

  return bytes;
}



