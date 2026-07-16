import 'dart:convert';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:sui/bcs/sui_bcs.dart';
import 'package:sui/cryptography/intent.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/passkey_publickey.dart';
import 'package:sui/cryptography/secp256.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/utils/sha.dart';

/// The result of creating a passkey credential (WebAuthn `create`).
class PasskeyRegistration {
  /// The DER `SubjectPublicKeyInfo` (secp256r1) from `getPublicKey()`.
  final Uint8List derSPKI;

  /// The credential id (`rawId`), used to constrain later assertions.
  final Uint8List credentialId;

  PasskeyRegistration(this.derSPKI, this.credentialId);
}

/// The result of a passkey assertion (WebAuthn `get`).
class PasskeyAssertion {
  final Uint8List authenticatorData;

  /// The clientDataJSON, UTF-8 encoded (as returned by the authenticator).
  final Uint8List clientDataJSON;

  /// The DER-encoded secp256r1 signature over
  /// `authenticatorData || sha256(clientDataJSON)`.
  final Uint8List signature;

  PasskeyAssertion(this.authenticatorData, this.clientDataJSON, this.signature);
}

/// Platform-agnostic passkey provider. The application supplies a WebAuthn
/// backed implementation (browser / iOS / Android); this SDK performs the
/// Sui-specific encoding. Mirrors Mysten's `PasskeyProvider`.
abstract class PasskeyProvider {
  /// Create a new passkey credential.
  Future<PasskeyRegistration> create();

  /// Sign [challenge] with the passkey, optionally constrained to
  /// [credentialId].
  Future<PasskeyAssertion> get(Uint8List challenge, [Uint8List? credentialId]);
}

/// A passkey signer implementing SIP-9. Holds the 33-byte compressed secp256r1
/// public key and a [PasskeyProvider]; the private key never leaves the
/// authenticator. Mirrors Mysten's `PasskeyKeypair`.
class PasskeyKeypair {
  final Uint8List publicKey;
  final PasskeyProvider provider;
  final Uint8List? credentialId;

  PasskeyKeypair(this.publicKey, this.provider, [this.credentialId]);

  SignatureScheme getKeyScheme() => SignatureScheme.Passkey;

  PasskeyPublicKey getPublicKey() => PasskeyPublicKey(publicKey);

  Uint8List? getCredentialId() => credentialId;

  /// Creates a passkey signer by invoking the provider to create a fresh
  /// credential. Only call this when creating a passkey wallet for the first
  /// time. To reconstruct from an existing passkey, use [signAndRecover].
  static Future<PasskeyKeypair> getPasskeyInstance(
      PasskeyProvider provider) async {
    final reg = await provider.create();
    final uncompressed = parseDerSPKI(reg.derSPKI);
    final compressed = Secp256.fromSecp256r1().compressPoint(uncompressed);
    return PasskeyKeypair(compressed, provider, reg.credentialId);
  }

  /// Signs [data] (the challenge, i.e. `blake2b(intentMessage)`) with the
  /// passkey and returns the serialized `PasskeyAuthenticator` BCS bytes
  /// (without the outer passkey flag).
  Future<Uint8List> sign(Uint8List data) async {
    final assertion = await provider.get(data, credentialId);
    final clientDataJson = utf8.decode(assertion.clientDataJSON);

    // Low-S–normalized 64-byte compact secp256r1 signature.
    final normalized =
        Secp256.fromSecp256r1().derToNormalizedCompact(assertion.signature);
    if (normalized.length != PASSKEY_SIGNATURE_SIZE ||
        publicKey.length != PASSKEY_PUBLIC_KEY_SIZE) {
      throw ArgumentError('Invalid signature or public key length');
    }

    // userSignature = flag(secp256r1) || sig || pubkey.
    final userSignature = Uint8List(1 + normalized.length + publicKey.length);
    userSignature[0] = SIGNATURE_SCHEME_TO_FLAG.Secp256r1;
    userSignature.setAll(1, normalized);
    userSignature.setAll(1 + normalized.length, publicKey);

    return Uint8List.fromList(SuiBcs.PasskeyAuthenticator.serialize({
      'authenticatorData': assertion.authenticatorData,
      'clientDataJson': clientDataJson,
      'userSignature': userSignature,
    }).toBytes());
  }

  /// Signs [bytes] under [intent], returning the base64 passkey signature
  /// (`flag(0x06) || BCS(PasskeyAuthenticator)`) and the base64 message bytes.
  Future<SignatureWithBytes> signWithIntent(
      Uint8List bytes, IntentScope intent) async {
    final intentMessage = messageWithIntent(intent, bytes);
    final digest = blake2b(intentMessage);
    final signature = await sign(digest);

    final serialized = Uint8List(1 + signature.length);
    serialized[0] = SIGNATURE_SCHEME_TO_FLAG.Passkey;
    serialized.setAll(1, signature);
    return SignatureWithBytes(base64Encode(serialized), base64Encode(bytes));
  }

  Future<SignatureWithBytes> signTransactionBlock(Uint8List bytes) {
    return signWithIntent(bytes, IntentScope.transactionData);
  }

  Future<SignatureWithBytes> signPersonalMessage(Uint8List bytes) {
    return signWithIntent(
      Bcs.vector(Bcs.u8()).serialize(bytes).toBytes(),
      IntentScope.personalMessage,
    );
  }

  /// Asks the passkey to sign [message] and returns every (up to 4) public key
  /// that could have produced the signature. Call twice with different messages
  /// and intersect with [findCommonPublicKey] to identify a previously created
  /// passkey wallet whose public key isn't stored locally.
  static Future<List<PasskeyPublicKey>> signAndRecover(
      PasskeyProvider provider, Uint8List message) async {
    final assertion = await provider.get(message);
    // The signed message is authenticatorData || sha256(clientDataJSON).
    final fullMessage = Uint8List.fromList([
      ...assertion.authenticatorData,
      ...sha256(assertion.clientDataJSON),
    ]);
    final candidates = Secp256.fromSecp256r1()
        .recoverCompressedFromDer(assertion.signature, sha256(fullMessage));
    return candidates.map((pk) => PasskeyPublicKey(pk)).toList();
  }
}

/// Returns the single public key present in both candidate lists; throws if
/// there isn't exactly one common key.
PasskeyPublicKey findCommonPublicKey(
    List<PasskeyPublicKey> a, List<PasskeyPublicKey> b) {
  final matches = <PasskeyPublicKey>[];
  for (final x in a) {
    for (final y in b) {
      if (x.equals(y)) matches.add(x);
    }
  }
  if (matches.length != 1) {
    throw ArgumentError('No unique public key found');
  }
  return matches.first;
}
