
import 'dart:convert';
import 'dart:typed_data';
import 'package:sui/cryptography/ed25519_publickey.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/secp256_publickey.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/zklogin/address.dart';
import 'package:sui/zklogin/jwt_utils.dart';
import 'package:sui/zklogin/signature.dart';

enum SignatureScheme {
  ED25519,
  Secp256k1,
  Secp256r1,
  MultiSig,
  ZkLogin,
}

abstract class SIGNATURE_SCHEME_TO_FLAG {
  static const int ED25519 = 0x00;
  static const int Secp256k1 = 0x01;
  static const int Secp256r1 = 0x02;
  static const int MultiSig = 0x03;
  static const int ZkLogin = 0x05;

  static int schemeToFlag(SignatureScheme scheme) {
    switch (scheme) {
      case SignatureScheme.ED25519:
        return ED25519;
      case SignatureScheme.Secp256k1:
        return Secp256k1;
      case SignatureScheme.Secp256r1:
        return Secp256r1;
      case SignatureScheme.MultiSig:
        return MultiSig;
      case SignatureScheme.ZkLogin:
        return ZkLogin;
      default:
        throw ArgumentError("Undefined Signature Scheme $scheme");
    }
  }

  static SignatureScheme flagToScheme(int flag) {
    switch (flag) {
      case ED25519:
        return SignatureScheme.ED25519;
      case Secp256k1:
        return SignatureScheme.Secp256k1;
      case Secp256r1:
        return SignatureScheme.Secp256r1;
      case MultiSig:
        return SignatureScheme.MultiSig;
      case ZkLogin:
        return SignatureScheme.ZkLogin;
      default:
        throw ArgumentError("Undefined Signature Flag $flag");
    }
  }
}

String toSerializedSignature(
  SignatureScheme signatureScheme,
  Uint8List signature,
  PublicKey pubKey,
) {
  final serializedSignature = Uint8List(
    1 + signature.length + pubKey.toBytes().length,
  );
  serializedSignature.setAll(0, [SIGNATURE_SCHEME_TO_FLAG.schemeToFlag(signatureScheme)]);
  serializedSignature.setAll(1, signature);
  serializedSignature.setAll(1 + signature.length, pubKey.toBytes());
  return base64Encode(serializedSignature);
}

SignaturePubkeyPair parseSerializedSignature(
  String serializedSignature,
) {
  final bytes = base64Decode(serializedSignature);
  final signatureScheme = SIGNATURE_SCHEME_TO_FLAG.flagToScheme(bytes[0]);
  if (signatureScheme == SignatureScheme.MultiSig) {
    throw ArgumentError('MultiSig is not supported');
  }

  if (signatureScheme == SignatureScheme.ZkLogin) {
		final signatureBytes = bytes.sublist(1);
		final signature = parseZkLoginSignature(signatureBytes);
		final iss = extractClaimValue<String>(signature.inputs.issBase64Details, 'iss');
		final address = computeZkLoginAddressFromSeed(BigInt.parse(signature.inputs.addressSeed), iss);
    final zkLgoin = {
				"inputs": signature.inputs,
				"maxEpoch": signature.maxEpoch,
				"userSignature": signature.userSignature,
				"iss": iss,
				"address": address,
		};
    return SignaturePubkeyPair(signatureScheme, signatureBytes, zkLogin: zkLgoin);
  }

  PublicKey getPublicKey(SignatureScheme scheme, Uint8List bytes) {
    switch (scheme) {
      case SignatureScheme.ED25519:
        return Ed25519PublicKey.fromBytes(bytes);
      case SignatureScheme.Secp256k1:
        return Secp256PublicKey.fromBytes(bytes, SIGNATURE_SCHEME_TO_FLAG.Secp256k1);
      case SignatureScheme.Secp256r1:
        return Secp256PublicKey.fromBytes(bytes, SIGNATURE_SCHEME_TO_FLAG.Secp256r1);
      default:
        throw ArgumentError("Undefined Scheme: $scheme");
    }
  }

  int getPublicKeySize(SignatureScheme scheme) {
    switch (scheme) {
      case SignatureScheme.ED25519:
        return 32;
      case SignatureScheme.Secp256k1:
      case SignatureScheme.Secp256r1:
        return 33;
      default:
        throw ArgumentError("Undefined Public Key Scheme: $scheme");
    }
  }

  final publicKeySize = getPublicKeySize(signatureScheme);
  final signature = bytes.sublist(1, bytes.length - publicKeySize);
  final pubkeyBytes = bytes.sublist(1 + signature.length);
  final pubKey = getPublicKey(signatureScheme, pubkeyBytes);

  return SignaturePubkeyPair(signatureScheme, signature, pubKey: pubKey);
}