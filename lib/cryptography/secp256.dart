import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:pointycastle/export.dart';
import 'package:sui/cryptography/helper.dart';
import 'package:sui/utils/hex.dart';

final curve256k1Params = ECCurve_secp256k1();
final curve256r1Params = ECCurve_secp256r1();

class Secp256KeypairData {
  Uint8List publicKey;
  Uint8List secretKey;

  Secp256KeypairData(this.publicKey, this.secretKey);
}

class Secp256 {
  static const magicNum = 27;

  ECDomainParametersImpl _ecDomainParams;

  Secp256(this._ecDomainParams);

  factory Secp256.fromSecp256k1() => Secp256(curve256k1Params);

  factory Secp256.fromSecp256r1() => Secp256(curve256r1Params);

  // Field prime (p) of the underlying curve, selected by the curve order (n) so
  // point recovery/verify use the right modulus for BOTH secp256k1 and
  // secp256r1 (passkey). Previously this was hardcoded to secp256k1's prime,
  // which could wrongly reject valid secp256r1 candidates for recovery id 2/3.
  static final BigInt _secp256k1FieldPrime = BigInt.parse(
      'fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f',
      radix: 16);
  static final BigInt _secp256r1FieldPrime = BigInt.parse(
      'ffffffff00000001000000000000000000000000ffffffffffffffffffffffff',
      radix: 16);
  static final BigInt _secp256r1Order = BigInt.parse(
      'ffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551',
      radix: 16);

  BigInt get _fieldPrime => _ecDomainParams.n == _secp256r1Order
      ? _secp256r1FieldPrime
      : _secp256k1FieldPrime;

  AsymmetricKeyPair<PublicKey, PrivateKey> generateKeypair(
      [SecureRandom? random]) {
    random ??= getRandom();
    CipherParameters cipherParams = ECKeyGeneratorParameters(_ecDomainParams);
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
    final p = (_ecDomainParams.G * privateKey);
    final buffer = p!.getEncoded(isCompressed);
    return isCompressed ? buffer : Uint8List.sublistView(buffer, 1);
  }

  Uint8List getPublicKeyFromPrivateKeyBytes(Uint8List privateKey,
      [bool isCompressed = true]) {
    BigInt privKey = decodeBigIntToUnsigned(privateKey);
    return getPublicKey(privKey, isCompressed);
  }

  /// Given an arbitrary message hash and an Ethereum message signature encoded in bytes, returns
  /// the public key that was used to sign it.
  /// https://github.com/web3j/web3j/blob/c0b7b9c2769a466215d416696021aa75127c2ff1/crypto/src/main/java/org/web3j/crypto/Sign.java#L241
  Uint8List ecRecover(int recId, Uint8List messageHash, SignatureData signature,
      [bool isCompressed = false, bool isEthereum = false]) {
    var header = recId & 0xFF;
    // The header byte: 0x1B = first key with even y, 0x1C = first key with odd y,
    //                  0x1D = second key with even y, 0x1E = second key with odd y
    header = isEthereum ? header : header + magicNum;
    if (header < magicNum || header > 34) {
      throw Exception('Header byte out of range: $header');
    }

    final sig = ECSignature(signature.r, signature.s);

    recId = header - magicNum;
    Uint8List? pubKey =
        recoverFromSignature(recId, sig, messageHash, isCompressed);
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
    int recId = recoveryId(signature, messageHash, publicKey);
    final recoveredPublicKey =
        ecRecover(recId, messageHash, signature, publicKey.length == 33);
    return Hex.encode(publicKey) == Hex.encode(recoveredPublicKey);
  }

  SignatureData sign(Uint8List messageHash, Uint8List privateKey,
      [bool isEthereum = false]) {
    final signer = ECDSASigner(null, HMac(SHA256Digest(), 64));
    final key =
        ECPrivateKey(decodeBigIntToUnsigned(privateKey), _ecDomainParams);
    signer.init(true, PrivateKeyParameter(key));
    var signature = signer.generateSignature(messageHash) as ECSignature;
    if (!signature.isNormalized(_ecDomainParams)) {
      signature = signature.normalize(_ecDomainParams);
    }

    return SignatureData(signature.r, signature.s);
  }

  /// Compress an uncompressed (`0x04 || x || y`) EC point to 33 bytes.
  Uint8List compressPoint(Uint8List uncompressed) {
    final point = _ecDomainParams.curve.decodePoint(uncompressed);
    if (point == null) throw ArgumentError('Invalid EC point');
    return Uint8List.fromList(point.getEncoded(true));
  }

  /// Decode a DER ECDSA signature into `(r, s)`. ECDSA signatures are short
  /// (< 128 bytes) so the ASN.1 lengths are always single-byte.
  (BigInt, BigInt) _decodeDer(Uint8List der) {
    var i = 0;
    if (der[i++] != 0x30) throw ArgumentError('Invalid DER: no sequence');
    i++; // total sequence length
    if (der[i++] != 0x02) throw ArgumentError('Invalid DER: no r integer');
    final rLen = der[i++];
    final r = decodeBigIntToUnsigned(der.sublist(i, i + rLen));
    i += rLen;
    if (der[i++] != 0x02) throw ArgumentError('Invalid DER: no s integer');
    final sLen = der[i++];
    final s = decodeBigIntToUnsigned(der.sublist(i, i + sLen));
    return (r, s);
  }

  /// Decode a DER ECDSA signature into a low-S–normalized 64-byte compact sig.
  Uint8List derToNormalizedCompact(Uint8List der) {
    final (r, s) = _decodeDer(der);
    var sig = ECSignature(r, s);
    if (!sig.isNormalized(_ecDomainParams)) {
      sig = sig.normalize(_ecDomainParams);
    }
    return SignatureData(sig.r, sig.s).toBytes();
  }

  /// Recover up to 4 candidate compressed public keys from a DER ECDSA
  /// signature over [messageHash] (used for passkey wallet recovery).
  List<Uint8List> recoverCompressedFromDer(
      Uint8List der, Uint8List messageHash) {
    final (r, s) = _decodeDer(der);
    final sig = SignatureData(r, s);
    final res = <Uint8List>[];
    for (var i = 0; i < 4; i++) {
      try {
        res.add(ecRecover(i, messageHash, sig, true));
      } catch (_) {
        continue;
      }
    }
    return res;
  }

  int recoveryId(
    ECSignature signature,
    Uint8List messageHash,
    Uint8List publicKeyBytes,
  ) {
    final isCompressed = publicKeyBytes.length == 33;
    BigInt publicKey = decodeBigIntToUnsigned(publicKeyBytes);

    int recId = -1;
    for (int i = 0; i < 4; i++) {
      Uint8List? k =
          recoverFromSignature(i, signature, messageHash, isCompressed);
      if (k != null &&
          decodeBigIntToUnsigned(k.sublist(isCompressed ? 0 : 1)) ==
              publicKey) {
        recId = i;
        break;
      }
    }

    if (recId == -1) {
      throw Exception(
        'Could not construct a recoverable key. Are your credentials valid?',
      );
    }

    return recId;
  }

  Uint8List? recoverFromSignature(int recId, ECSignature sig, Uint8List msg,
      [bool encoded = false]) {
    final n = _ecDomainParams.n;
    final i = BigInt.from(recId ~/ 2);
    final x = sig.r + (i * n);

    if (x.compareTo(_fieldPrime) >= 0) return null;

    final R = _decompressKey(x, (recId & 1) == 1);
    if (!(R * n)!.isInfinity) return null;

    final e = decodeBigIntToUnsigned(msg);

    final eInv = (BigInt.zero - e) % n;
    final rInv = sig.r.modInverse(n);
    final srInv = (rInv * sig.s) % n;
    final eInvrInv = (rInv * eInv) % n;

    final q = (_ecDomainParams.G * eInvrInv)! + (R * srInv);

    final bytes = q!.getEncoded(encoded);
    return bytes;
  }

  ECPoint _decompressKey(BigInt xBN, bool yBit) {
    final compEnc = _x9IntegerToBytes(
        xBN, 1 + ((_ecDomainParams.curve.fieldSize + 7) ~/ 8));
    compEnc[0] = yBit ? 0x03 : 0x02;
    return _ecDomainParams.curve.decodePoint(compEnc)!;
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
}

class SignatureData extends ECSignature {
  SignatureData(super.r, super.s);

  factory SignatureData.fromBytes(Uint8List data) {
    if (data.length != 64) {
      throw ArgumentError("Invalid bytes length ${data.length}");
    }

    final r = decodeBigIntToUnsigned(data.sublist(0, 32));
    final s = decodeBigIntToUnsigned(data.sublist(32, 64));
    return SignatureData(r, s);
  }

  Uint8List toBytes() {
    final buffer = Uint8List(64);
    buffer.setAll(0, padLeftUint8List(encodeBigIntAsUnsigned(r)));
    buffer.setAll(32, padLeftUint8List(encodeBigIntAsUnsigned(s)));
    return buffer;
  }
}
