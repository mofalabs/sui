
import 'dart:convert';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:sui/cryptography/intent.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/utils/sha.dart';

class SignatureWithBytes {
  String bytes;
  String signature;

  SignatureWithBytes(this.signature, this.bytes);
}

/// A keypair used for signing transactions.
mixin Keypair {

  /// The public key for this keypair
  PublicKey getPublicKey();

  /// The secret key for this keypair
  Uint8List getSecretKey();

  /// Return the signature for the data
  Uint8List signData(Uint8List data);

  /// Get the key scheme of the keypair: Secp256k1 or Ed25519
  SignatureScheme getKeyScheme();

  /// Verify signature
  bool verify(Uint8List data, Uint8List signature, Uint8List publicKey);

  /// Verify serialized signature
  bool verifySerialized(Uint8List message, String signature, Uint8List publicKey);

  Uint8List sign(Uint8List bytes) {
    return signData(bytes);
  }

	SignatureWithBytes signWithIntent(Uint8List bytes, IntentScope intent) {
		final intentMessage = messageWithIntent(intent, bytes);
		final digest = blake2b(intentMessage);

		final signature = toSerializedSignature(
			getKeyScheme(),
			sign(digest),
			getPublicKey()
		);

		return SignatureWithBytes(
			signature,
			base64Encode(bytes)
    );
	}

	SignatureWithBytes signTransactionBlock(Uint8List bytes) {
		return signWithIntent(bytes, IntentScope.transactionData);
	}

	SignatureWithBytes signPersonalMessage(Uint8List bytes) {
		return signWithIntent(
			Bcs.vector(Bcs.u8()).serialize(bytes).toBytes(),
			IntentScope.personalMessage
		);
	}

  bool verifyWithIntent(
		Uint8List bytes,
		String signature,
		IntentScope intent,
	) {
		final intentMessage = messageWithIntent(intent, bytes);
		final digest = blake2b(intentMessage);

		return verifySerialized(digest, signature, getPublicKey().toRawBytes());
	}

  /// Verifies that the signature is valid for for the provided PersonalMessage
	bool verifyPersonalMessage(
		Uint8List message,
		String signature
	)  {
		return verifyWithIntent(
      Bcs.vector(Bcs.u8()).serialize(message).toBytes(),
			signature,
			IntentScope.personalMessage,
		);
	}

	bool verifyTransaction(
		Uint8List transaction,
		String signature
	) {
		return verifyWithIntent(
      transaction, 
      signature, 
      IntentScope.transactionData
    );
	}

}

bool bytesEqual(Uint8List a, Uint8List b) {
	if (a == b) return true;

	if (a.length != b.length) {
		return false;
	}

	for (int i = 0; i < a.length; i++) {
		if (a[i] != b[i]) {
			return false;
		}
	}
	return true;
}


mixin PublicKey {

  /// Checks if two public keys are equal
  bool equals(PublicKey publicKey) {
    return bytesEqual(toRawBytes(), publicKey.toRawBytes());
  }

  /// Return the base-64 representation of the public key
  String toBase64();

  /// Return the byte array representation of the public key
  Uint8List toRawBytes();

	/// Returns the bytes representation of the public key
	/// prefixed with the signature scheme flag
	Uint8List toSuiBytes() {
		final bytes = toRawBytes();
		final suiPublicKey = Uint8List(bytes.length + 1);
		suiPublicKey.setAll(0, [flag()]);
		suiPublicKey.setAll(1, bytes);
    return suiPublicKey;
  }

	/// Return the Sui representation of the public key encoded in
	/// base-64. A Sui public key is formed by the concatenation
	/// of the scheme flag with the raw bytes of the public key
  String toSuiPublicKey() {
		return base64Encode(toSuiBytes());
	}

	bool verifyWithIntent(
		Uint8List bytes,
		String signature,
		IntentScope intent,
	) {
		final intentMessage = messageWithIntent(intent, bytes);
		final digest = blake2b(intentMessage);

		return verify(digest, base64Decode(signature));
	}

	bool verifyPersonalMessage(
		Uint8List message,
		String signature,
	) {
		return verifyWithIntent(
      Bcs.vector(Bcs.u8()).serialize(message).toBytes(),
			signature,
			IntentScope.personalMessage,
		);
	}

  bool verifyTransaction(
		Uint8List transaction,
		String signature,
	) {
		return verifyWithIntent(
      transaction, 
      signature, 
      IntentScope.transactionData
    );
	}

  /// Return the base-64 representation of the public key
  String toString();

  /// Return the Sui address associated with this public key
  String toSuiAddress();

  /// Return signature scheme flag of the public key
  int flag();

	/// Verifies that the signature is valid for for the provided message
	bool verify(Uint8List data, Uint8List signature);
}