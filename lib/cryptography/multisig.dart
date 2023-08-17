

import 'dart:typed_data';

import 'package:sui/cryptography/keypair.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/types/common.dart';
import 'package:sui/utils/hex.dart';
import 'package:sui/utils/sha.dart';

class PubkeyWeightPair {
  final PublicKey pubKey;
  final int weight;

  PubkeyWeightPair(this.pubKey, this.weight);
}

class MultiSig {

  static const int MAX_SIGNER_IN_MULTISIG = 10;

  /// Derives a multisig address from a list of pk and weights and threshold.
  // It is the 32-byte Blake2b hash of the serializd bytes of `flag_MultiSig || threshold || flag_1 || pk_1 || weight_1
  /// || ... || flag_n || pk_n || weight_n`
  static String toMultiSigAddress(
    List<PubkeyWeightPair> pks,
    int threshold
  ) {
    if (pks.length > MAX_SIGNER_IN_MULTISIG) {
      throw ArgumentError(
        "Max number of signers in a multisig is $MAX_SIGNER_IN_MULTISIG",
      );
    }
    // max length = 1 flag byte + (max pk size + max weight size (u8)) * max signer size + 2 threshold bytes (u16)
    const maxLength = 1 + (64 + 1) * MAX_SIGNER_IN_MULTISIG + 2;
    final tmp = Uint8List(maxLength);
    tmp.setAll(0, [SIGNATURE_SCHEME_TO_FLAG.MultiSig]);
    tmp.setAll(1, toLittleEndianTwoBytes(threshold));

    int i = 3;
    for (var pk in pks) {
      tmp.setAll(i, [pk.pubKey.flag()]);
      tmp.setAll(i + 1, pk.pubKey.toBytes());
      tmp.setAll(i + 1 + pk.pubKey.toBytes().length, [pk.weight]);
      i += pk.pubKey.toBytes().length + 2;
    }
    return normalizeSuiAddress(
      Hex.encode(blake2b(tmp.sublist(0, i))),
    );
  }

  /// Convert u16 to Uint8List of length 2 in little endian.
  static Uint8List toLittleEndianTwoBytes(int threshold) {
    if (threshold < 0 || threshold > 65535) {
      throw ArgumentError('Invalid threshold');
    }
    final arr = Uint8List(2);
    arr[0] = threshold & 0xff;
    arr[1] = threshold >> 8;
    return arr;
  }

}