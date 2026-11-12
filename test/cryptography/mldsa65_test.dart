import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';
import 'package:sui/utils/hex.dart';

void main() {
  final vector =
      jsonDecode(File('test/fixtures/mldsa65.json').readAsStringSync())
          as Map<String, dynamic>;

  test(
    'matches official Rust/TypeScript key, address and private-key vector',
    () {
      final key = Mldsa65Keypair.fromSeed(Hex.decode(vector['seed'] as String));
      expect(key.getPublicKey().toSuiAddress(), vector['address']);
      expect(
        encodeSuiPrivateKey(key.getSecretKey(), key.getKeyScheme()),
        vector['suiprivkey'],
      );
      expect(
        SuiAccount.fromPrivateKey(vector['suiprivkey'] as String).getAddress(),
        vector['address'],
      );
      final parsed = parseSerializedSignature(vector['signature'] as String);
      expect(parsed.signatureScheme, SignatureScheme.MLDSA65);
      expect(parsed.pubKey!.toRawBytes(), key.getPublicKey().toRawBytes());
      expect(
        key.getPublicKey().verifyPersonalMessage(
          Uint8List.fromList(utf8.encode('hello')),
          vector['signature'] as String,
        ),
        isTrue,
      );
      expect(
        key.getPublicKey().verifyPersonalMessage(
          Uint8List.fromList(utf8.encode('other')),
          vector['signature'] as String,
        ),
        isFalse,
      );
    },
  );

  test('hedged signing and defensive seed ownership', () {
    final seed = Uint8List.fromList(List.filled(32, 2));
    final key = Mldsa65Keypair.fromSeed(seed);
    seed.fillRange(0, seed.length, 0);
    expect(key.getSecretKey(), List.filled(32, 2));
    final message = Uint8List.fromList([1, 2, 3]);
    final first = key.signData(message);
    final second = key.signData(message);
    expect(first, isNot(second));
    expect(key.getPublicKey().verify(message, first), isTrue);
    expect(key.getPublicKey().verify(message, second), isTrue);
    first[0] ^= 1;
    expect(key.getPublicKey().verify(message, first), isFalse);
  });

  test('ML-DSA members serialize and verify in multisig', () {
    final key = Mldsa65Keypair.fromSeed(Uint8List.fromList(List.filled(32, 2)));
    final ed = Ed25519Keypair.fromSeed(Uint8List(32));
    final multi = MultiSigPublicKey.fromPublicKeys(
      threshold: 2,
      publicKeys: [
        PublicKeyWeight(1, key.getPublicKey()),
        PublicKeyWeight(1, ed.getPublicKey()),
      ],
    );
    expect(multi.toSuiAddress().length, 66);
    final message = Uint8List.fromList([1, 2, 3]);
    final signature = multi.combinePartialSignatures([
      key.signPersonalMessage(message).signature,
      ed.signPersonalMessage(message).signature,
    ]);
    expect(multi.verifyPersonalMessage(message, signature), isTrue);
    expect(
      MultiSigPublicKey.fromBytes(multi.toRawBytes()).toSuiAddress(),
      multi.toSuiAddress(),
    );
  });
}
