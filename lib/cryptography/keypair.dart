
import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/intent.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/types/sui_bcs.dart';
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

  /// Get the key scheme of the keypair: Secp256k1 or ED25519
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
			bcs.ser(['vector', 'u8'], bytes).toBytes(),
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

		return verifySerialized(digest, signature, getPublicKey().toBytes());
	}

  /// Verifies that the signature is valid for for the provided PersonalMessage
	bool verifyPersonalMessage(
		Uint8List message,
		String signature
	)  {
		return verifyWithIntent(
			bcs.ser(['vector', 'u8'], message).toBytes(),
			signature,
			IntentScope.personalMessage,
		);
	}

	bool verifyTransactionBlock(
		Uint8List transactionBlock,
		String signature
	) {
		return verifyWithIntent(
      transactionBlock, 
      signature, 
      IntentScope.transactionData
    );
	}

}


mixin PublicKey {

  /// Checks if two public keys are equal
  bool equals(PublicKey publicKey);

  /// Return the base-64 representation of the public key
  String toBase64();

  /// Return the byte array representation of the public key
  Uint8List toBytes();

	/// Return the Sui representation of the public key encoded in
	/// base-64. A Sui public key is formed by the concatenation
	/// of the scheme flag with the raw bytes of the public key
  String toSuiPublicKey() {
		final bytes = toBytes();
		final suiPublicKey = Uint8List(bytes.length + 1);
		suiPublicKey.setAll(0, [flag()]);
		suiPublicKey.setAll(1, bytes);
		return base64Encode(suiPublicKey);
	}


  /// Return the base-64 representation of the public key
  String toString();

  /// Return the Sui address associated with this public key
  String toSuiAddress();

  /// Return signature scheme flag of the public key
  int flag();
}