
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/multisig.dart';
import 'package:sui/cryptography/signature.dart';
import 'package:sui/sui.dart';
import 'package:sui/utils/sha.dart';

void main() {
  
    test('combines signature to multisig', () async {
      const VALID_SECP256K1_SECRET_KEY = [
        59, 148, 11, 85, 134, 130, 61, 253, 2, 174, 59, 70, 27, 180, 51, 107, 94,
        203, 174, 253, 102, 39, 170, 146, 46, 252, 4, 143, 236, 12, 136, 28,
      ];
      final secretKey = Uint8List.fromList(VALID_SECP256K1_SECRET_KEY);
      final k1 = Ed25519Keypair.fromSecretKey(secretKey);
      final pk1 = k1.getPublicKey();

      final k2 = Secp256k1Keypair.fromSecretKey(secretKey);
      final pk2 = k2.getPublicKey();

      final k3 = Ed25519Keypair.fromSecretKey(Uint8List(32));
      final pk3 = k3.getPublicKey();

      List<PubkeyWeightPair> pks = [];
      pks.add(PubkeyWeightPair(pk1, 1));
      pks.add(PubkeyWeightPair(pk2, 2));
      pks.add(PubkeyWeightPair(pk3, 3));
      String multisigAddress = MultiSig.toMultiSigAddress(pks, 3);
      expect(multisigAddress, "0x37b048598ca569756146f4e8ea41666c657406db154a31f11bb5c1cbaf0b98d7");

      final data = Uint8List.fromList([0, 0, 0, 5, 72, 101, 108, 108, 111]);
      final digest = blake2b(data);

      final ser_sig1 = toSerializedSignature(k1.getKeyScheme(), k1.signData(digest), pk1);

      final ser_sig2 = toSerializedSignature(k2.getKeyScheme(), k2.signData(digest), pk2);

    });

}
