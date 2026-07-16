import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/helper.dart';
import 'package:sui/cryptography/passkey_keypair.dart';
import 'package:sui/cryptography/passkey_publickey.dart';
import 'package:sui/cryptography/secp256.dart';
import 'package:sui/utils/sha.dart';

/// Default authenticator data used by Mysten's passkey test vectors.
final _defaultAuthenticatorData = Uint8List.fromList(const [
  88, 14, 103, 167, 58, 122, 146, 250, 216, 102, 207, 153, 185, 74, 182, 103, //
  89, 162, 151, 100, 181, 113, 130, 31, 171, 174, 46, 139, 29, 123, 54, 228, //
  29, 0, 0, 0, 0,
]);

/// Fixed DER SubjectPublicKeyInfo returned by the default mock (maps to the
/// known address vector below).
final _defaultDerSPKI = Uint8List.fromList(const [
  48, 89, 48, 19, 6, 7, 42, 134, 72, 206, 61, 2, 1, 6, 8, 42, 134, 72, 206, //
  61, 3, 1, 7, 3, 66, 0, 4, 232, 238, 71, 180, 129, 19, 164, 11, 106, 184, //
  25, 185, 136, 226, 178, 64, 72, 105, 218, 94, 85, 28, 244, 5, 19, 172, 167, //
  65, 137, 42, 193, 31, 97, 55, 49, 168, 234, 185, 163, 251, 162, 235, 213, //
  185, 116, 178, 194, 7, 128, 238, 255, 59, 121, 255, 175, 188, 137, 89, 147, //
  168, 103, 128, 97, 52,
]);

/// A Dart port of Mysten's `MockPasskeySigner` — simulates a secp256r1
/// authenticator so the SIP-9 encoding can be tested without a real device.
class MockPasskeySigner implements PasskeyProvider {
  final Uint8List? sk;
  final Uint8List? der;
  final Uint8List authenticatorData;
  final bool changeDigest;
  final bool wrongType;

  MockPasskeySigner({
    this.sk,
    this.der,
    Uint8List? authenticatorData,
    this.changeDigest = false,
    this.wrongType = false,
  }) : authenticatorData = authenticatorData ?? _defaultAuthenticatorData;

  @override
  Future<PasskeyRegistration> create() async {
    return PasskeyRegistration(
        der ?? _defaultDerSPKI, Uint8List.fromList([1, 2, 3]));
  }

  @override
  Future<PasskeyAssertion> get(Uint8List challenge,
      [Uint8List? credentialId]) async {
    var ch = challenge;
    if (changeDigest) ch = sha256(challenge);

    final clientDataJson = jsonEncode({
      'type': wrongType ? 'webauthn.create' : 'webauthn.get',
      'challenge': base64Encode(ch),
      'origin': 'https://www.sui.io',
      'crossOrigin': false,
    });
    final clientDataBytes = Uint8List.fromList(utf8.encode(clientDataJson));

    final dataToSign = Uint8List.fromList([
      ...authenticatorData,
      ...sha256(clientDataBytes),
    ]);
    final sig = Secp256.fromSecp256r1().sign(sha256(dataToSign), sk!);
    return PasskeyAssertion(
        authenticatorData, clientDataBytes, _derEncode(sig.r, sig.s));
  }
}

/// DER-encodes an ECDSA signature `(r, s)` (single-byte ASN.1 lengths).
Uint8List _derEncode(BigInt r, BigInt s) {
  final content = [..._derInt(r), ..._derInt(s)];
  return Uint8List.fromList([0x30, content.length, ...content]);
}

List<int> _derInt(BigInt v) {
  var b = encodeBigIntAsUnsigned(v).toList();
  var i = 0;
  while (i < b.length - 1 && b[i] == 0) {
    i++;
  }
  b = b.sublist(i);
  if (b[0] & 0x80 != 0) b = [0, ...b];
  return [0x02, b.length, ...b];
}

/// Builds a mock backed by a freshly generated secp256r1 key.
Future<MockPasskeySigner> _mockWithFreshKey({
  bool changeDigest = false,
  bool wrongType = false,
}) async {
  final s = Secp256.fromSecp256r1();
  final sk = s.generatePrivateKeyBytes();
  final uncompressed = s.getPublicKey(decodeBigIntToUnsigned(sk), false);
  final der =
      Uint8List.fromList([...SECP256R1_SPKI_HEADER, 0x04, ...uncompressed]);
  return MockPasskeySigner(
      sk: sk, der: der, changeDigest: changeDigest, wrongType: wrongType);
}

void main() {
  test('derives the known Sui address from the default passkey vector',
      () async {
    final signer = await PasskeyKeypair.getPasskeyInstance(MockPasskeySigner());
    expect(
      signer.getPublicKey().toSuiAddress(),
      '0x05d52348e3e3a785e1e458ebe74d71e21dd4db2ba3088484cab22eca5a07da02',
    );
  });

  test('signs a personal message and verifies against the pubkey', () async {
    final signer =
        await PasskeyKeypair.getPasskeyInstance(await _mockWithFreshKey());
    final message = Uint8List.fromList(utf8.encode('Hello world!'));
    final signed = await signer.signPersonalMessage(message);

    expect(
        signer.getPublicKey().verifyPersonalMessage(message, signed.signature),
        isTrue);

    final parsed =
        parseSerializedPasskeySignature(base64Decode(signed.signature));
    expect(parsed.publicKey, signer.publicKey);
    expect(parsed.authenticatorData, _defaultAuthenticatorData);
  });

  test('signs a transaction and verifies against the pubkey', () async {
    final signer =
        await PasskeyKeypair.getPasskeyInstance(await _mockWithFreshKey());
    final txBytes = Uint8List.fromList(List<int>.generate(64, (i) => i));
    final signed = await signer.signTransactionBlock(txBytes);

    expect(signer.getPublicKey().verifyTransaction(txBytes, signed.signature),
        isTrue);
  });

  test('rejects a signature over the wrong digest', () async {
    final signer = await PasskeyKeypair.getPasskeyInstance(
        await _mockWithFreshKey(changeDigest: true));
    final txBytes = Uint8List.fromList(List<int>.generate(64, (i) => i));
    final signed = await signer.signTransactionBlock(txBytes);
    expect(signer.getPublicKey().verifyTransaction(txBytes, signed.signature),
        isFalse);
  });

  test('rejects a non webauthn.get client data type', () async {
    final signer = await PasskeyKeypair.getPasskeyInstance(
        await _mockWithFreshKey(wrongType: true));
    final message = Uint8List.fromList(utf8.encode('Hello world!'));
    final signed = await signer.signPersonalMessage(message);
    expect(
        signer.getPublicKey().verifyPersonalMessage(message, signed.signature),
        isFalse);
  });

  test('recovers the public key from two signings', () async {
    final mock = await _mockWithFreshKey();
    final expected =
        (await PasskeyKeypair.getPasskeyInstance(mock)).getPublicKey();

    final pks1 = await PasskeyKeypair.signAndRecover(
        mock, Uint8List.fromList(utf8.encode('m1')));
    final pks2 = await PasskeyKeypair.signAndRecover(
        mock, Uint8List.fromList(utf8.encode('m2')));
    final common = findCommonPublicKey(pks1, pks2);
    expect(common.equals(expected), isTrue);
  });
}
