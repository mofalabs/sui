
import 'dart:typed_data';

enum SignatureScheme {
  ED25519,
  Secp256k1
}

abstract class SIGNATURE_SCHEME_TO_FLAG {
  static const int ED25519 = 0x00;
  static const int Secp256k1 = 0x01;
}

/// A public key
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
