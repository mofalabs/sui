
import 'dart:typed_data';

import 'package:sui/cryptography/helper.dart';
import 'package:sui/serialization/base64_buffer.dart';

/// A keypair used for signing transactions.
mixin Keypair {

  /// The public key for this keypair
  PublicKey getPublicKey();

  /// The secret key for this keypair
  Uint8List getSecretKey();

  /// Return the signature for the data
  Base64DataBuffer signData(Base64DataBuffer data);

  /// Get the key scheme of the keypair: Secp256k1 or ED25519
  SignatureScheme getKeyScheme();

  /// Verify signature
  bool verify(Base64DataBuffer data, Base64DataBuffer signature, Uint8List publicKey);
}


mixin PublicKey {

  /// Checks if two public keys are equal
  bool equals(PublicKey publicKey);

  /// Return the base-64 representation of the public key
  String toBase64();

  /// Return the byte array representation of the public key
  Uint8List toBytes();

  /// Return the base-64 representation of the public key
  @override
  String toString();

  /// Return the Sui address associated with this public key
  String toSuiAddress();
}
