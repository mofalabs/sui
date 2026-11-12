import 'dart:convert';
import 'dart:typed_data';
import 'mldsa65_publickey.dart';
import 'passkey_publickey.dart';
import 'package:sui/bcs/sui_bcs.dart';
import 'package:sui/cryptography/ed25519_publickey.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/secp256_publickey.dart';
import 'package:sui/multisig/multsig_publickey.dart';
import 'package:sui/signers/signer_with_provider.dart';
import 'package:sui/zklogin/address.dart';
import 'package:sui/zklogin/jwt_utils.dart';
import 'package:sui/zklogin/signature.dart';

enum SignatureScheme {
  Ed25519,
  Secp256k1,
  Secp256r1,
  MultiSig,
  ZkLogin,
  Passkey,
  MLDSA65,
}

// ignore: camel_case_types
abstract class SIGNATURE_SCHEME_TO_FLAG {
  static const int Ed25519 = 0x00;
  static const int Secp256k1 = 0x01;
  static const int Secp256r1 = 0x02;
  static const int MultiSig = 0x03;
  static const int ZkLogin = 0x05;
  static const int Passkey = 0x06;
  static const int MLDSA65 = 0x07;

  static int schemeToFlag(SignatureScheme scheme) {
    switch (scheme) {
      case SignatureScheme.Ed25519:
        return Ed25519;
      case SignatureScheme.Secp256k1:
        return Secp256k1;
      case SignatureScheme.Secp256r1:
        return Secp256r1;
      case SignatureScheme.MultiSig:
        return MultiSig;
      case SignatureScheme.ZkLogin:
        return ZkLogin;
      case SignatureScheme.Passkey:
        return Passkey;
      case SignatureScheme.MLDSA65:
        return MLDSA65;
      // ignore: unreachable_switch_default
      default:
        throw ArgumentError("Undefined Signature Scheme $scheme");
    }
  }

  static SignatureScheme flagToScheme(int flag) {
    switch (flag) {
      case Ed25519:
        return SignatureScheme.Ed25519;
      case Secp256k1:
        return SignatureScheme.Secp256k1;
      case Secp256r1:
        return SignatureScheme.Secp256r1;
      case MultiSig:
        return SignatureScheme.MultiSig;
      case ZkLogin:
        return SignatureScheme.ZkLogin;
      case Passkey:
        return SignatureScheme.Passkey;
      case MLDSA65:
        return SignatureScheme.MLDSA65;
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
    1 + signature.length + pubKey.toRawBytes().length,
  );
  serializedSignature.setAll(0, [
    SIGNATURE_SCHEME_TO_FLAG.schemeToFlag(signatureScheme),
  ]);
  serializedSignature.setAll(1, signature);
  serializedSignature.setAll(1 + signature.length, pubKey.toRawBytes());
  return base64Encode(serializedSignature);
}

SignaturePubkeyPair parseSerializedSignature(String serializedSignature) {
  final bytes = base64Decode(serializedSignature);
  if (bytes.isEmpty) throw const FormatException('Empty serialized signature');
  final signatureScheme = SIGNATURE_SCHEME_TO_FLAG.flagToScheme(bytes[0]);
  if (signatureScheme == SignatureScheme.MultiSig) {
    final signature = bytes.sublist(1);
    final multisig = MultiSigStruct.fromJson(SuiBcs.MultiSig.parse(signature));
    return SignaturePubkeyPair(signatureScheme, signature, multisig: multisig);
  }

  if (signatureScheme == SignatureScheme.ZkLogin) {
    final signatureBytes = bytes.sublist(1);
    final signature = parseZkLoginSignature(signatureBytes);
    final iss = extractClaimValue<String>(
      signature.inputs.issBase64Details,
      'iss',
    );
    final addressSeed = BigInt.parse(signature.inputs.addressSeed);
    final address = computeZkLoginAddressFromSeed(addressSeed, iss);
    final zkLgoin = {
      "inputs": signature.inputs,
      "maxEpoch": signature.maxEpoch,
      "userSignature": signature.userSignature,
      "iss": iss,
      "address": address,
      "addressSeed": addressSeed,
    };
    return SignaturePubkeyPair(signatureScheme, bytes, zkLogin: zkLgoin);
  }

  if (signatureScheme == SignatureScheme.Passkey) {
    final authenticator = parseSerializedPasskeySignature(bytes);
    if (authenticator.userSignature.length != 98 ||
        authenticator.userSignature.first != 2) {
      throw const FormatException('Invalid passkey user signature');
    }
    return SignaturePubkeyPair(
      signatureScheme,
      bytes,
      pubKey: PasskeyPublicKey(authenticator.userSignature.sublist(65)),
    );
  }

  PublicKey getPublicKey(SignatureScheme scheme, Uint8List bytes) {
    switch (scheme) {
      case SignatureScheme.Ed25519:
        return Ed25519PublicKey.fromBytes(bytes);
      case SignatureScheme.Secp256k1:
        return Secp256PublicKey.fromBytes(
          bytes,
          SIGNATURE_SCHEME_TO_FLAG.Secp256k1,
        );
      case SignatureScheme.Secp256r1:
        return Secp256PublicKey.fromBytes(
          bytes,
          SIGNATURE_SCHEME_TO_FLAG.Secp256r1,
        );
      case SignatureScheme.MLDSA65:
        return Mldsa65PublicKey(bytes);
      default:
        throw ArgumentError("Undefined Scheme: $scheme");
    }
  }

  int getPublicKeySize(SignatureScheme scheme) {
    switch (scheme) {
      case SignatureScheme.Ed25519:
        return 32;
      case SignatureScheme.Secp256k1:
      case SignatureScheme.Secp256r1:
        return 33;
      case SignatureScheme.MLDSA65:
        return mldsa65PublicKeySize;
      default:
        throw ArgumentError("Undefined Public Key Scheme: $scheme");
    }
  }

  final publicKeySize = getPublicKeySize(signatureScheme);
  final signatureSize = signatureScheme == SignatureScheme.MLDSA65
      ? mldsa65SignatureSize
      : 64;
  if (bytes.length != 1 + signatureSize + publicKeySize) {
    throw FormatException(
      'Invalid ${signatureScheme.name} signature length: ${bytes.length}',
    );
  }
  final signature = bytes.sublist(1, bytes.length - publicKeySize);
  final pubkeyBytes = bytes.sublist(1 + signature.length);
  final pubKey = getPublicKey(signatureScheme, pubkeyBytes);

  return SignaturePubkeyPair(signatureScheme, signature, pubKey: pubKey);
}
