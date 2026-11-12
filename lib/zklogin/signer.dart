import 'dart:convert';
import 'dart:typed_data';
import 'package:bcs/bcs.dart';

import '../cryptography/intent.dart';
import '../cryptography/keypair.dart';
import '../cryptography/signature.dart';
import 'jwt_utils.dart';
import 'publickey.dart';
import 'signature.dart';
import 'types.dart';

/// Wraps an ephemeral keypair's intent signatures in a zkLogin proof.
class ZkLoginSigner implements Signer {
  ZkLoginSigner({
    required Signer ephemeralSigner,
    required ZkLoginSignatureInputs inputs,
    required this.maxEpoch,
    required bool legacyAddress,
    String? address,
  }) : _ephemeralSigner = ephemeralSigner,
       _inputs = ZkLoginSignatureInputs.fromJson(
         jsonDecode(jsonEncode(inputs.toJson())) as Map<String, dynamic>,
       ) {
    if (maxEpoch < 0) throw ArgumentError.value(maxEpoch, 'maxEpoch');
    _publicKey = toZkLoginPublicIdentifier(
      BigInt.parse(_inputs.addressSeed),
      extractClaimValue<String>(_inputs.issBase64Details, 'iss'),
      legacyAddress: legacyAddress,
    );
    if (address != null && address != _publicKey.toSuiAddress()) {
      throw ArgumentError('Proof does not match address; check legacyAddress');
    }
  }
  final Signer _ephemeralSigner;
  final ZkLoginSignatureInputs _inputs;
  final int maxEpoch;
  late final ZkLoginPublicIdentifier _publicKey;

  @override
  ZkLoginPublicIdentifier getPublicKey() => _publicKey;
  String getAddress() => _publicKey.toSuiAddress();
  SignatureScheme getKeyScheme() => SignatureScheme.ZkLogin;
  @override
  Future<SignatureWithBytes> signWithIntent(
    Uint8List bytes,
    IntentScope intent,
  ) async {
    final signed = await _ephemeralSigner.signWithIntent(bytes, intent);
    return SignatureWithBytes(
      getZkLoginSignature(
        ZkLoginSignature(
          inputs: _inputs,
          maxEpoch: maxEpoch,
          userSignature: base64Decode(signed.signature),
        ),
      ),
      signed.bytes,
    );
  }

  Future<SignatureWithBytes> signTransactionBlock(Uint8List bytes) =>
      signWithIntent(bytes, IntentScope.transactionData);
  Future<SignatureWithBytes> signPersonalMessage(Uint8List bytes) =>
      signWithIntent(
        Bcs.vector(Bcs.u8()).serialize(bytes).toBytes(),
        IntentScope.personalMessage,
      );

  Uint8List signData(Uint8List data) =>
      throw UnsupportedError('Use intent signing for zkLogin');
  Uint8List getSecretKey() =>
      throw UnsupportedError('A zkLogin signer has no exportable private key');
  bool verify(Uint8List data, Uint8List signature, Uint8List publicKey) =>
      throw UnsupportedError(
        'Use async zkLogin verification with a CoreClient',
      );
  bool verifySerialized(
    Uint8List message,
    String signature,
    Uint8List publicKey,
  ) => throw UnsupportedError(
    'Use async zkLogin verification with a CoreClient',
  );
}
