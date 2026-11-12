import 'dart:convert';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';

import '../client/core_client.dart';
import '../multisig/multsig_publickey.dart';
import '../utils/sha.dart';
import '../zklogin/publickey.dart';
import 'intent.dart';
import 'keypair.dart';
import 'signature.dart';

class _ParsedSignature {
  _ParsedSignature(this.publicKey, this.bytes, this.multisig);
  final PublicKey publicKey;
  final Uint8List bytes;
  final MultiSigStruct? multisig;
}

_ParsedSignature _parse(String signature, {String? address}) {
  final parsed = parseSerializedSignature(signature);
  final PublicKey key;
  if (parsed.multisig != null) {
    key = MultiSigPublicKey(parsed.multisig!.multisigPK);
  } else if (parsed.signatureScheme == SignatureScheme.ZkLogin) {
    final identifier = toZkLoginPublicIdentifier(
      parsed.zkLogin!['addressSeed'] as BigInt,
      parsed.zkLogin!['iss'] as String,
    );
    key = ZkLoginPublicIdentifier.fromBytes(
      identifier.toRawBytes(),
      address: address,
    );
  } else {
    key = parsed.pubKey!;
  }
  return _ParsedSignature(key, base64Decode(signature), parsed.multisig);
}

/// Returns false for malformed/invalid signatures. Chain lookup and transport
/// failures from [client] propagate, so outages never appear as invalid proofs.
Future<bool> isValidSignature(
  Uint8List bytes,
  String signature, {
  String? address,
}) => _isValid(bytes, signature, address: address);

Future<bool> isValidPersonalMessageSignature(
  Uint8List message,
  String signature, {
  CoreClient? client,
  String? address,
}) => _isValid(
  message,
  signature,
  intent: IntentScope.personalMessage,
  client: client,
  address: address,
);

Future<bool> isValidTransactionSignature(
  Uint8List transaction,
  String signature, {
  CoreClient? client,
  String? address,
}) => _isValid(
  transaction,
  signature,
  intent: IntentScope.transactionData,
  client: client,
  address: address,
);

Future<bool> _isValid(
  Uint8List bytes,
  String signature, {
  IntentScope? intent,
  CoreClient? client,
  String? address,
}) async {
  final _ParsedSignature parsed;
  List<ParsedPartialMultiSigSignature>? partials;
  try {
    parsed = _parse(signature, address: address);
    final key = parsed.publicKey;
    if (address != null &&
        !(key is ZkLoginPublicIdentifier
            ? key.verifyAddress(address)
            : key.toSuiAddress() == address)) {
      return false;
    }
    if (parsed.multisig != null) {
      partials = parsePartialSignatures(parsed.multisig!);
    }
  } catch (_) {
    return false;
  }
  final key = parsed.publicKey;
  if (key is ZkLoginPublicIdentifier) {
    if (intent == null) {
      throw UnsupportedError('zkLogin verification requires an intent');
    }
    if (client == null) {
      throw ArgumentError(
        'A CoreClient is required to verify zkLogin signatures',
      );
    }
    return (await client.verifySignature(
      bytes,
      parsed.bytes,
      intentScope: intent,
      address: address ?? key.toSuiAddress(),
    )).isValid;
  }
  if (partials != null) {
    final payload = intent == IntentScope.personalMessage
        ? Bcs.vector(Bcs.u8()).serialize(bytes).toBytes()
        : bytes;
    final digest = intent == null
        ? bytes
        : blake2b(messageWithIntent(intent, payload));
    var weight = 0;
    for (final part in partials) {
      if (part.publicKey is ZkLoginPublicIdentifier) {
        // Bind the proof to the configured member, even if a different identity
        // produced a valid proof using the same ephemeral key.
        try {
          final identity = _parse(base64Encode(part.signature)).publicKey;
          if (!part.publicKey.equals(identity)) return false;
        } catch (_) {
          return false;
        }
        if (intent == null) {
          throw UnsupportedError('zkLogin verification requires an intent');
        }
        if (client == null) {
          throw ArgumentError(
            'A CoreClient is required to verify zkLogin signatures',
          );
        }
        if (!(await client.verifySignature(
          bytes,
          part.signature,
          intentScope: intent,
          address: part.publicKey.toSuiAddress(),
        )).isValid) {
          return false;
        }
      } else {
        try {
          if (!part.publicKey.verify(digest, part.signature)) return false;
        } catch (_) {
          return false;
        }
      }
      weight += part.weight;
    }
    return weight >= parsed.multisig!.multisigPK.threshold;
  }
  try {
    return switch (intent) {
      IntentScope.personalMessage => key.verifyPersonalMessage(
        bytes,
        signature,
      ),
      IntentScope.transactionData => key.verifyTransaction(bytes, signature),
      null => key.verify(bytes, parsed.bytes),
      _ => key.verifyWithIntent(bytes, signature, intent),
    };
  } catch (_) {
    return false;
  }
}

Future<PublicKey> verifySignature(
  Uint8List bytes,
  String signature, {
  String? address,
}) async {
  if (!await isValidSignature(bytes, signature, address: address)) {
    throw ArgumentError('Invalid signature');
  }
  return _parse(signature, address: address).publicKey;
}

Future<PublicKey> verifyPersonalMessageSignature(
  Uint8List message,
  String signature, {
  CoreClient? client,
  String? address,
}) async {
  if (!await isValidPersonalMessageSignature(
    message,
    signature,
    client: client,
    address: address,
  )) {
    throw ArgumentError('Invalid personal message signature');
  }
  return _parse(signature, address: address).publicKey;
}

Future<PublicKey> verifyTransactionSignature(
  Uint8List transaction,
  String signature, {
  CoreClient? client,
  String? address,
}) async {
  if (!await isValidTransactionSignature(
    transaction,
    signature,
    client: client,
    address: address,
  )) {
    throw ArgumentError('Invalid transaction signature');
  }
  return _parse(signature, address: address).publicKey;
}
