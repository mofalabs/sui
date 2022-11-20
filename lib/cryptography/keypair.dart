
import 'dart:typed_data';

import 'package:sui/cryptography/publickey.dart';
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
