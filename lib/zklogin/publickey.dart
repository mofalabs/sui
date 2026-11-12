import 'dart:convert';
import 'dart:typed_data';

import '../client/core_client.dart';
import '../cryptography/intent.dart';
import '../cryptography/keypair.dart';
import '../cryptography/signature.dart';
import '../utils/hex.dart';
import '../utils/sha.dart';
import '../types/common.dart';
import 'jwt_utils.dart';
import 'types.dart';
import 'utils.dart';

/// A zkLogin identity. Raw bytes always retain a padded 32-byte address seed;
/// [legacyAddress] controls only the address derivation.
class ZkLoginPublicIdentifier with PublicKey {
  ZkLoginPublicIdentifier._(this._data, this.legacyAddress);
  final Uint8List _data;
  final bool legacyAddress;

  factory ZkLoginPublicIdentifier.fromBytes(
    Uint8List bytes, {
    bool? legacyAddress,
    String? address,
  }) {
    if (bytes.isEmpty ||
        bytes.first == 0 ||
        bytes.length <= bytes.first + 1 ||
        bytes.length > bytes.first + 33) {
      throw const FormatException('Invalid zkLogin public identifier');
    }
    final offset = bytes.first + 1;
    utf8.decode(bytes.sublist(1, offset));
    final seed = BigInt.parse(Hex.encode(bytes.sublist(offset)), radix: 16);
    final data = Uint8List.fromList([
      ...bytes.sublist(0, offset),
      ...toPaddedBigEndianBytes(seed, 32),
    ]);
    var key = ZkLoginPublicIdentifier._(
      data,
      legacyAddress ?? bytes.length != offset + 32,
    );
    if (address != null &&
        key.toSuiAddress() != address &&
        legacyAddress == null) {
      key = ZkLoginPublicIdentifier._(data, !key.legacyAddress);
    }
    if (address != null && key.toSuiAddress() != address) {
      throw ArgumentError('Public identifier does not match address');
    }
    return key;
  }

  factory ZkLoginPublicIdentifier.fromProof(
    String address,
    ZkLoginSignatureInputs proof,
  ) => ZkLoginPublicIdentifier.fromBytes(
    toZkLoginPublicIdentifier(
      BigInt.parse(proof.addressSeed),
      extractClaimValue<String>(proof.issBase64Details, 'iss'),
    ).toRawBytes(),
    address: address,
  );

  @override
  bool equals(PublicKey publicKey) =>
      publicKey is ZkLoginPublicIdentifier &&
      bytesEqual(_data, publicKey._data);
  @override
  Uint8List toRawBytes() => Uint8List.fromList(_data);
  @override
  int flag() => SIGNATURE_SCHEME_TO_FLAG.ZkLogin;
  @override
  String toBase64() => base64Encode(_data);
  @override
  String toString() => toBase64();

  String _address(bool legacy) {
    final offset = _data.first + 1;
    final seed = BigInt.parse(Hex.encode(_data.sublist(offset)), radix: 16);
    final bytes = Uint8List.fromList([
      flag(),
      ..._data.sublist(0, offset),
      ...legacy ? toBigEndianBytes(seed, 32) : toPaddedBigEndianBytes(seed, 32),
    ]);
    return normalizeSuiAddress(Hex.encode(blake2b(bytes)));
  }

  @override
  String toSuiAddress() => _address(legacyAddress);
  bool verifyAddress(String address) =>
      address == _address(false) || address == _address(true);

  /// zkLogin verification needs chain JWKs and epoch state. Use the async
  /// methods with an explicit client; transport errors propagate to the caller.
  @override
  bool verify(Uint8List data, Uint8List signature) => throw UnsupportedError(
    'Use async zkLogin verification with a CoreClient',
  );

  Future<bool> verifyPersonalMessageAsync(
    Uint8List message,
    String signature, {
    required CoreClient client,
  }) async => (await client.verifySignature(
    message,
    base64Decode(signature),
    intentScope: IntentScope.personalMessage,
    address: toSuiAddress(),
  )).isValid;

  Future<bool> verifyTransactionAsync(
    Uint8List transaction,
    String signature, {
    required CoreClient client,
  }) async => (await client.verifySignature(
    transaction,
    base64Decode(signature),
    intentScope: IntentScope.transactionData,
    address: toSuiAddress(),
  )).isValid;
}

ZkLoginPublicIdentifier toZkLoginPublicIdentifier(
  BigInt addressSeed,
  String iss, {
  bool legacyAddress = false,
}) {
  if (addressSeed.isNegative || addressSeed >= (BigInt.one << 256)) {
    throw ArgumentError.value(addressSeed, 'addressSeed', 'Expected u256');
  }
  if (iss == 'accounts.google.com') iss = 'https://accounts.google.com';
  final issuer = utf8.encode(iss);
  if (issuer.isEmpty || issuer.length > 255) {
    throw ArgumentError.value(iss, 'iss');
  }
  return ZkLoginPublicIdentifier._(
    Uint8List.fromList([
      issuer.length,
      ...issuer,
      ...toPaddedBigEndianBytes(addressSeed, 32),
    ]),
    legacyAddress,
  );
}
