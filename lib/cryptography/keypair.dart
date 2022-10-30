
import 'package:sui/cryptography/publickey.dart';
import 'package:sui/serialization/base64_buffer.dart';

/// A keypair used for signing transactions.
mixin Keypair {

  /// The public key for this keypair
  PublicKey getPublicKey();

  /// Return the signature for the data
  Base64DataBuffer signData(Base64DataBuffer data);

  /// Get the key scheme of the keypair: Secp256k1 or ED25519
  SignatureScheme getKeyScheme();
}
