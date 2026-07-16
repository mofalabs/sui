import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/bcs/sui_bcs.dart';
import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/secp256.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/types/common.dart';
import 'package:sui/utils/hex.dart';
import 'package:sui/utils/sha.dart';

/// A passkey (SIP-9) public key: a 33-byte compressed secp256r1 (P-256) point.
const PASSKEY_PUBLIC_KEY_SIZE = 33;
const PASSKEY_UNCOMPRESSED_PUBLIC_KEY_SIZE = 65;
const PASSKEY_SIGNATURE_SIZE = 64;

/// Fixed DER `SubjectPublicKeyInfo` header for a secp256r1/prime256v1 key.
/// The full SPKI is `header || 0x04 || x || y` (65-byte uncompressed point).
final Uint8List SECP256R1_SPKI_HEADER = Uint8List.fromList(const [
  0x30, 0x59, // SEQUENCE, length 89
  0x30, 0x13, // SEQUENCE, length 19
  0x06, 0x07, // OID, length 7
  0x2a, 0x86, 0x48, 0xce, 0x3d, 0x02, 0x01, // 1.2.840.10045.2.1 ecPublicKey
  0x06, 0x08, // OID, length 8
  0x2a, 0x86, 0x48, 0xce, 0x3d, 0x03, 0x01, 0x07, // 1.2.840.10045.3.1.7 P-256
  0x03, 0x42, // BIT STRING, length 66
  0x00, // no unused bits
]);

/// A passkey public key. Mirrors Mysten's `PasskeyPublicKey`
/// (SIP-9): flag `0x06`, 33-byte compressed secp256r1 point.
class PasskeyPublicKey with PublicKey {
  final Uint8List _data;

  PasskeyPublicKey(Uint8List value) : _data = Uint8List.fromList(value) {
    if (_data.length != PASSKEY_PUBLIC_KEY_SIZE) {
      throw ArgumentError(
          "Invalid public key input. Expected $PASSKEY_PUBLIC_KEY_SIZE bytes, got ${_data.length}");
    }
  }

  factory PasskeyPublicKey.fromBase64(String base64String) =>
      PasskeyPublicKey(base64Decode(base64String));

  @override
  int flag() => SIGNATURE_SCHEME_TO_FLAG.Passkey;

  @override
  Uint8List toRawBytes() => _data;

  @override
  String toBase64() => base64Encode(_data);

  @override
  String toString() => toBase64();

  /// Sui address = `blake2b256(flag(0x06) || compressedPubKey)[:32]`.
  @override
  String toSuiAddress() {
    final tmp = Uint8List(PASSKEY_PUBLIC_KEY_SIZE + 1);
    tmp[0] = flag();
    tmp.setAll(1, _data);
    final hex = Hex.encode(blake2b(tmp));
    return normalizeSuiAddress(hex.substring(0, SUI_ADDRESS_LENGTH * 2));
  }

  /// Verifies a serialized passkey signature over [message] (the challenge the
  /// passkey signed, i.e. `blake2b(intentMessage)`).
  @override
  bool verify(Uint8List message, Uint8List signature) {
    final parsed = parseSerializedPasskeySignature(signature);
    final Map<String, dynamic> clientData = jsonDecode(parsed.clientDataJson);

    if (clientData['type'] != 'webauthn.get') return false;

    // The WebAuthn challenge is base64url — must equal the signed message.
    final challenge = _base64UrlDecode(clientData['challenge'] as String);
    if (!bytesEqual(message, challenge)) return false;

    // userSignature = flag(0x02) || 64-byte sig || 33-byte pubkey.
    final pk = parsed.userSignature.sublist(1 + PASSKEY_SIGNATURE_SIZE);
    if (!bytesEqual(toRawBytes(), pk)) return false;

    final payload = Uint8List.fromList([
      ...parsed.authenticatorData,
      ...sha256(Uint8List.fromList(utf8.encode(parsed.clientDataJson))),
    ]);
    final sig = parsed.userSignature.sublist(1, PASSKEY_SIGNATURE_SIZE + 1);
    return Secp256.fromSecp256r1().verifySignature(
      sha256(payload),
      SignatureData.fromBytes(sig),
      pk,
    );
  }
}

/// Decodes an unpadded base64url string (the WebAuthn challenge format).
Uint8List _base64UrlDecode(String input) {
  final normalized = base64.normalize(
    input.replaceAll('-', '+').replaceAll('_', '/'),
  );
  return base64Decode(normalized);
}

/// Parses a DER `SubjectPublicKeyInfo` into an uncompressed P-256 point
/// (`0x04 || x || y`), verifying the fixed secp256r1 header.
Uint8List parseDerSPKI(Uint8List derBytes) {
  if (derBytes.length !=
      SECP256R1_SPKI_HEADER.length + PASSKEY_UNCOMPRESSED_PUBLIC_KEY_SIZE) {
    throw ArgumentError('Invalid DER length');
  }
  for (var i = 0; i < SECP256R1_SPKI_HEADER.length; i++) {
    if (derBytes[i] != SECP256R1_SPKI_HEADER[i]) {
      throw ArgumentError('Invalid spki header');
    }
  }
  if (derBytes[SECP256R1_SPKI_HEADER.length] != 0x04) {
    throw ArgumentError('Invalid point marker');
  }
  return Uint8List.fromList(derBytes.sublist(SECP256R1_SPKI_HEADER.length));
}

/// The decoded fields of a serialized passkey signature.
class ParsedPasskeySignature {
  final Uint8List authenticatorData;
  final String clientDataJson;
  final Uint8List userSignature;

  ParsedPasskeySignature({
    required this.authenticatorData,
    required this.clientDataJson,
    required this.userSignature,
  });

  /// The 33-byte compressed public key carried in [userSignature].
  Uint8List get publicKey =>
      userSignature.sublist(1 + PASSKEY_SIGNATURE_SIZE);
}

/// Parses `flag(0x06) || BCS(PasskeyAuthenticator)` into its fields.
ParsedPasskeySignature parseSerializedPasskeySignature(Uint8List signature) {
  if (signature[0] != SIGNATURE_SCHEME_TO_FLAG.Passkey) {
    throw ArgumentError('Invalid signature scheme');
  }
  final dec = SuiBcs.PasskeyAuthenticator.parse(
      Uint8List.fromList(signature.sublist(1)));
  return ParsedPasskeySignature(
    authenticatorData:
        Uint8List.fromList(List<int>.from(dec['authenticatorData'])),
    clientDataJson: dec['clientDataJson'] as String,
    userSignature: Uint8List.fromList(List<int>.from(dec['userSignature'])),
  );
}
