
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'dart:math';
import 'dart:typed_data';

import 'package:bcs/bcs.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/sui_bcs.dart';

void main() {
  
  group('Multisig scenarios', () {

    test('multisig address creation and combine sigs using Secp256r1Keypair', () async {
      final k1 = Ed25519Keypair();
      final pk1 = k1.getPublicKey();

      final k2 = Secp256k1Keypair();
      final pk2 = k2.getPublicKey();

      final k3 = Secp256r1Keypair();
      final pk3 = k3.getPublicKey();

      final pubkeyWeightPairs = [
        PublicKeyWeight(1, pk1),
        PublicKeyWeight(2, pk2),
        PublicKeyWeight(3, pk3),
      ];

      final txb = TransactionBlock();
      txb.setSender(k3.getPublicKey().toSuiAddress());
      txb.setGasPrice(BigInt.from(5));
      txb.setGasBudget(BigInt.from(100));
      txb.setGasPayment([
        SuiObjectRef(
          base58Encode(Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9])),
          (Random().nextDouble() * 100000).toStringAsFixed(0).padRight(64, '0'),
          (Random().nextDouble() * 10000).toInt(),
        )
      ]);
      final bytes = await txb.build();

      final signature = k3.signTransactionBlock(bytes).signature;

      final publicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: pubkeyWeightPairs,
      );

      final multisig = publicKey.combinePartialSignatures([signature]);

      expect(k3.getPublicKey().verifyTransactionBlock(bytes, signature), true);

      final parsed = parseSerializedSignature(multisig);
      final publicKey2 = MultiSigPublicKey(parsed.multisig!.multisigPK);

      // multisig (sig3 weight 3 >= threshold ) verifies ok
      expect(publicKey2.verifyTransactionBlock(bytes, multisig), true);
    });


    test('providing false number of signatures to combining via different methods', () {
      final k1 = Ed25519Keypair();
      final pk1 = k1.getPublicKey();

      final k2 = Secp256k1Keypair();
      final pk2 = k2.getPublicKey();

      final k3 = Secp256r1Keypair();

      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
        ],
      );

      final signData = Uint8List.fromList(utf8.encode('hello world'));
      final sig1 = k1.signPersonalMessage(signData);
      final sig2 = k2.signPersonalMessage(signData);
      final sig3 = k3.signPersonalMessage(signData);

      final isValidSig1 = k1.getPublicKey().verifyPersonalMessage(signData, sig1.signature);
      final isValidSig2 = k2.getPublicKey().verifyPersonalMessage(signData, sig2.signature);

      expect(isValidSig1, true);
      expect(isValidSig2, true);

      // create invalid signature

      final compressedSignatures = [
        {
          "Ed25519": parseSerializedSignature(sig1.signature).signature,
        },
        {
          "Secp256r1": parseSerializedSignature(sig1.signature).signature,
        },
      ];

      final bytes = bcs.ser('MultiSig', {
        "sigs": compressedSignatures,
        "bitmap": 5,
        "multisig_pk": bcs.de('MultiSigPublicKey', multiSigPublicKey.toRawBytes()),
      }).toBytes();

      final tmp = Uint8List(bytes.length + 1);
      tmp.setAll(0, [SIGNATURE_SCHEME_TO_FLAG.MultiSig]);
      tmp.setAll(1, bytes);

      final multisig = toB64(tmp);

      expect(
        () => multiSigPublicKey.combinePartialSignatures([sig1.signature, sig3.signature]),
        throwsArgumentError
      );

      final parsed = parseSerializedSignature(multisig);
      final publicKey = MultiSigPublicKey(parsed.multisig!.multisigPK);

      expect(
        () => publicKey.verifyPersonalMessage(signData, multisig),
        throwsArgumentError
      );
      
    });


  test('providing invalid signature', () {
      final k1 = Ed25519Keypair();
      final pk1 = k1.getPublicKey();

      final k2 = Secp256k1Keypair();
      final pk2 = k2.getPublicKey();

      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
        ],
      );

      final signData = Uint8List.fromList(utf8.encode('hello world'));
      final sig1 = k1.signPersonalMessage(signData);
      final sig2 = k2.signPersonalMessage(signData);

      // Invalid Signature.
      final sig3 = SignatureWithBytes('d', 'd');

      final isValidSig1 = k1.getPublicKey().verifyPersonalMessage(signData, sig1.signature);
      final isValidSig2 = k2.getPublicKey().verifyPersonalMessage(signData, sig2.signature);

      expect(isValidSig1, true);
      expect(isValidSig2, true);

      expect(() => multiSigPublicKey.combinePartialSignatures([sig3.signature]), throwsFormatException);
    });

    test('providing signatures with invalid order', () {
      final k1 = Secp256r1Keypair();
      final pk1 = k1.getPublicKey();

      final k2 = Secp256k1Keypair();
      final pk2 = k2.getPublicKey();

      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
        ],
      );

      final signData = Uint8List.fromList(utf8.encode('hello world'));
      final sig1 = k1.signPersonalMessage(signData);
      final sig2 = k2.signPersonalMessage(signData);

      final isValidSig1 = k1.getPublicKey().verifyPersonalMessage(signData, sig1.signature);
      final isValidSig2 = k2.getPublicKey().verifyPersonalMessage(signData, sig2.signature);

      expect(isValidSig1, true);
      expect(isValidSig2, true);

      final multisig = multiSigPublicKey.combinePartialSignatures([sig2.signature, sig1.signature]);

      final parsed = parseSerializedSignature(multisig);
      final publicKey = MultiSigPublicKey(parsed.multisig!.multisigPK);

      // Invalid order can't be verified.
      expect(() => publicKey.verifyPersonalMessage(signData, multisig), throwsException);
      expect(() => multiSigPublicKey.verifyPersonalMessage(signData, multisig), throwsException);
    });

    test('providing invalid intent scope', () {
      final k1 = Secp256r1Keypair();
      final pk1 = k1.getPublicKey();

      final k2 = Secp256k1Keypair();
      final pk2 = k2.getPublicKey();

      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
        ],
      );

      final signData = Uint8List.fromList(utf8.encode('hello world'));
      final sig1 = k1.signPersonalMessage(signData);
      final sig2 = k2.signPersonalMessage(signData);

      final isValidSig1 = k1.getPublicKey().verifyPersonalMessage(signData, sig1.signature);
      final isValidSig2 = k2.getPublicKey().verifyPersonalMessage(signData, sig2.signature);

      expect(isValidSig1, true);
      expect(isValidSig2, true);

      final multisig = multiSigPublicKey.combinePartialSignatures([sig2.signature, sig1.signature]);

      final parsed = parseSerializedSignature(multisig);
      final publicKey = MultiSigPublicKey(parsed.multisig!.multisigPK);

      // Invalid intentScope.
      expect(() => publicKey.verifyTransactionBlock(signData, multisig), throwsException);
      expect(() => multiSigPublicKey.verifyTransactionBlock(signData, multisig), throwsException);
    });

    test('providing empty values', () {
      final k1 = Secp256r1Keypair();
      final pk1 = k1.getPublicKey();

      final k2 = Secp256k1Keypair();
      final pk2 = k2.getPublicKey();

      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
        ],
      );

      final signData = Uint8List.fromList(utf8.encode('hello world'));
      final sig1 = k1.signPersonalMessage(signData);
      final sig2 = k2.signPersonalMessage(signData);

      final isValidSig1 = k1.getPublicKey().verifyPersonalMessage(signData, sig1.signature);
      final isValidSig2 = k2.getPublicKey().verifyPersonalMessage(signData, sig2.signature);

      expect(isValidSig1, true);
      expect(isValidSig2, true);

      // Empty values.
      final multisig = multiSigPublicKey.combinePartialSignatures([]);

      final parsed = parseSerializedSignature(multisig);
      final publicKey = MultiSigPublicKey(parsed.multisig!.multisigPK);

      expect(publicKey.verifyTransactionBlock(signData, multisig), false);
      expect(multiSigPublicKey.verifyTransactionBlock(signData, multisig), false);
    });

  });


  group('Multisig address creation:', ()  {
    late Ed25519Keypair k1;
    late Ed25519PublicKey pk1;
    late Secp256k1Keypair k2;
    late PublicKey	pk2;
    late Secp256r1Keypair k3;
    late PublicKey	pk3;
    late PublicKey	pk4;
    late PublicKey	pk5;
    late Ed25519Keypair k6;
    late PublicKey pk6;

    setUpAll(() {
      k1 = Ed25519Keypair();
      pk1 = k1.getPublicKey();

      k2 = Secp256k1Keypair();
      pk2 = k2.getPublicKey();

      k3 = Secp256r1Keypair();
      pk3 = k3.getPublicKey();

      pk4 = toZkLoginPublicIdentifier(
        BigInt.parse('20794788559620669596206457022966176986688727876128223628113916380927502737911'),
        'https://id.twitch.tv/oauth2',
      );
      pk5 = toZkLoginPublicIdentifier(
        BigInt.parse('380704556853533152350240698167704405529973457670972223618755249929828551006'),
        'https://id.twitch.tv/oauth2',
      );

      final secret_key_ed25519 = Uint8List.fromList([
        126, 57, 195, 235, 248, 196, 105, 68, 115, 164, 8, 221, 100, 250, 137, 160, 245, 43, 220, 168,
        250, 73, 119, 95, 19, 242, 100, 105, 81, 114, 86, 105,
      ]);
      k6 = Ed25519Keypair.fromSecretKey(secret_key_ed25519);
      pk6 = k6.getPublicKey();
    });

    test('`toMultiSigAddress()` with zklogin identifiers', () {
      // Test derived from rust test `fn test_derive_multisig_address()`
      final multisigPublicKey = MultiSigPublicKey.fromPublicKeys(
        publicKeys: [
          PublicKeyWeight(1, pk4),
          PublicKeyWeight(1, pk5),
        ],
        threshold: 1,
      );
      final multisigAddress = multisigPublicKey.toSuiAddress();

      expect(multisigAddress,
        '0x77a9fbf3c695d78dd83449a81a9e70aa79a77dbfd6fb72037bf09201c12052cd',
      );
    });

    test('`combinePartialSigs()` with zklogin sigs', () {
      // Test derived from rust test `fn multisig_zklogin_scenarios()`
      final publicKey = MultiSigPublicKey.fromPublicKeys(
        publicKeys: [
          PublicKeyWeight(1, pk6),
          PublicKeyWeight(1, pk4),
        ],
        threshold: 1,
      );
      expect(publicKey.toSuiAddress(),
        '0xb9c0780a3943cde13a2409bf1a6f06ae60b0dff2b2f373260cf627aa4f43a588',
      );
      final data = Uint8List.fromList(
        fromB64(
          'AAABACACAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgEBAQABAAC5wHgKOUPN4TokCb8abwauYLDf8rLzcyYM9ieqT0OliAGbB4FfBEl+LgXSLKw6oGFBCyCGjMYZFUxCocYb6ZAnFwEAAAAAAAAAIJZw7UpW1XHubORIOaY8d2+WyBNwoJ+FEAxlsa7h7JHrucB4CjlDzeE6JAm/Gm8GrmCw3/Ky83MmDPYnqk9DpYgBAAAAAAAAABAnAAAAAAAAAA==',
        ),
      );
      final sig1 = k6.signTransactionBlock(data);
      const zklogin_sig =
        'BQNNMTczMTgwODkxMjU5NTI0MjE3MzYzNDIyNjM3MTc5MzI3MTk0Mzc3MTc4NDQyODI0MTAxODc5NTc5ODQ3NTE5Mzk5NDI4OTgyNTEyNTBNMTEzNzM5NjY2NDU0NjkxMjI1ODIwNzQwODIyOTU5ODUzODgyNTg4NDA2ODE2MTgyNjg1OTM5NzY2OTczMjU4OTIyODA5MTU2ODEyMDcBMQMCTDU5Mzk4NzExNDczNDg4MzQ5OTczNjE3MjAxMjIyMzg5ODAxNzcxNTIzMDMyNzQzMTEwNDcyNDk5MDU5NDIzODQ5MTU3Njg2OTA4OTVMNDUzMzU2ODI3MTEzNDc4NTI3ODczMTIzNDU3MDM2MTQ4MjY1MTk5Njc0MDc5MTg4ODI4NTg2NDk2Njg4NDAzMjcxNzA0OTgxMTcwOAJNMTA1NjQzODcyODUwNzE1NTU0Njk3NTM5OTA2NjE0MTA4NDAxMTg2MzU5MjU0NjY1OTcwMzcwMTgwNTg3NzAwNDEzNDc1MTg0NjEzNjhNMTI1OTczMjM1NDcyNzc1NzkxNDQ2OTg0OTYzNzIyNDI2MTUzNjgwODU4MDEzMTMzNDMxNTU3MzU1MTEzMzAwMDM4ODQ3Njc5NTc4NTQCATEBMANNMTU3OTE1ODk0NzI1NTY4MjYyNjMyMzE2NDQ3Mjg4NzMzMzc2MjkwMTUyNjk5ODQ2OTk0MDQwNzM2MjM2MDMzNTI1Mzc2Nzg4MTMxNzFMNDU0Nzg2NjQ5OTI0ODg4MTQ0OTY3NjE2MTE1ODAyNDc0ODA2MDQ4NTM3MzI1MDAyOTQyMzkwNDExMzAxNzQyMjUzOTAzNzE2MjUyNwExMXdpYVhOeklqb2lhSFIwY0hNNkx5OXBaQzUwZDJsMFkyZ3VkSFl2YjJGMWRHZ3lJaXcCMmV5SmhiR2NpT2lKU1V6STFOaUlzSW5SNWNDSTZJa3BYVkNJc0ltdHBaQ0k2SWpFaWZRTTIwNzk0Nzg4NTU5NjIwNjY5NTk2MjA2NDU3MDIyOTY2MTc2OTg2Njg4NzI3ODc2MTI4MjIzNjI4MTEzOTE2MzgwOTI3NTAyNzM3OTExCgAAAAAAAABhABHpkQ5JvxqbqCKtqh9M0U5c3o3l62B6ALVOxMq6nsc0y3JlY8Gf1ZoPA976dom6y3JGBUTsry6axfqHcVrtRAy5xu4WMO8+cRFEpkjbBruyKE9ydM++5T/87lA8waSSAA==';
      final parsed_zklogin_sig = parseSerializedSignature(zklogin_sig);
      final multisig = publicKey.combinePartialSignatures([sig1.signature, zklogin_sig]);
      expect(multisig,
        'AwIAcAEsWrZtlsE3AdGUKJAPag8Tu6HPfMW7gEemeneO9fmNGiJP/rDZu/tL75lr8A22eFDx9K2G1DL4v8XlmuTtCgOaBwUDTTE3MzE4MDg5MTI1OTUyNDIxNzM2MzQyMjYzNzE3OTMyNzE5NDM3NzE3ODQ0MjgyNDEwMTg3OTU3OTg0NzUxOTM5OTQyODk4MjUxMjUwTTExMzczOTY2NjQ1NDY5MTIyNTgyMDc0MDgyMjk1OTg1Mzg4MjU4ODQwNjgxNjE4MjY4NTkzOTc2Njk3MzI1ODkyMjgwOTE1NjgxMjA3ATEDAkw1OTM5ODcxMTQ3MzQ4ODM0OTk3MzYxNzIwMTIyMjM4OTgwMTc3MTUyMzAzMjc0MzExMDQ3MjQ5OTA1OTQyMzg0OTE1NzY4NjkwODk1TDQ1MzM1NjgyNzExMzQ3ODUyNzg3MzEyMzQ1NzAzNjE0ODI2NTE5OTY3NDA3OTE4ODgyODU4NjQ5NjY4ODQwMzI3MTcwNDk4MTE3MDgCTTEwNTY0Mzg3Mjg1MDcxNTU1NDY5NzUzOTkwNjYxNDEwODQwMTE4NjM1OTI1NDY2NTk3MDM3MDE4MDU4NzcwMDQxMzQ3NTE4NDYxMzY4TTEyNTk3MzIzNTQ3Mjc3NTc5MTQ0Njk4NDk2MzcyMjQyNjE1MzY4MDg1ODAxMzEzMzQzMTU1NzM1NTExMzMwMDAzODg0NzY3OTU3ODU0AgExATADTTE1NzkxNTg5NDcyNTU2ODI2MjYzMjMxNjQ0NzI4ODczMzM3NjI5MDE1MjY5OTg0Njk5NDA0MDczNjIzNjAzMzUyNTM3Njc4ODEzMTcxTDQ1NDc4NjY0OTkyNDg4ODE0NDk2NzYxNjExNTgwMjQ3NDgwNjA0ODUzNzMyNTAwMjk0MjM5MDQxMTMwMTc0MjI1MzkwMzcxNjI1MjcBMTF3aWFYTnpJam9pYUhSMGNITTZMeTlwWkM1MGQybDBZMmd1ZEhZdmIyRjFkR2d5SWl3AjJleUpoYkdjaU9pSlNVekkxTmlJc0luUjVjQ0k2SWtwWFZDSXNJbXRwWkNJNklqRWlmUU0yMDc5NDc4ODU1OTYyMDY2OTU5NjIwNjQ1NzAyMjk2NjE3Njk4NjY4ODcyNzg3NjEyODIyMzYyODExMzkxNjM4MDkyNzUwMjczNzkxMQoAAAAAAAAAYQAR6ZEOSb8am6giraofTNFOXN6N5etgegC1TsTKup7HNMtyZWPBn9WaDwPe+naJustyRgVE7K8umsX6h3Fa7UQMucbuFjDvPnERRKZI2wa7sihPcnTPvuU//O5QPMGkkgADAAIADX2rNYyNrapO+gBJp1sHQ2VVsQo2ghm7aA9wVxNJ13UBAzwbaHR0cHM6Ly9pZC50d2l0Y2gudHYvb2F1dGgyLflu6Eag/zG3tLd5CtZRYx9p1t34RovVSn/+uHFiYfcBAQA=',
      );

      final decoded = parsePartialSignatures(MultiSigStruct.fromJson(bcs.de('MultiSig', fromB64(multisig).sublist(1))));

      final origin0 = ParsedPartialMultiSigSignature(
        signatureScheme: k6.getKeyScheme(), 
        signature: parseSerializedSignature(sig1.signature).signature, 
        publicKey: pk6,
        weight: 1
      );

      expect(decoded[0].signatureScheme, origin0.signatureScheme);
      expect(decoded[0].signature, origin0.signature);
      expect(decoded[0].publicKey.toString(), origin0.publicKey.toString());
      expect(decoded[0].weight, origin0.weight);

      final origin1 = ParsedPartialMultiSigSignature(
        signatureScheme: SignatureScheme.ZkLogin,
        signature: parsed_zklogin_sig.signature,
        publicKey: pk4,
        weight: 1
      );

      expect(decoded[1].signatureScheme, origin1.signatureScheme);
      expect(decoded[1].signature, origin1.signature);
      expect(decoded[1].publicKey.toString(), origin1.publicKey.toString());
      expect(decoded[1].weight, origin1.weight);

    });

    test('with unreachable threshold', () {
      expect(() =>
        MultiSigPublicKey.fromPublicKeys(
          threshold: 7,
          publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
          ],
        ),
      throwsArgumentError);
    });

    test('with more public keys than limited number', () {
      final k4 = Secp256r1Keypair();
      final pk4 = k4.getPublicKey();

      final k5 = Secp256r1Keypair();
      final pk5 = k5.getPublicKey();

      final k6 = Secp256r1Keypair();
      final pk6 = k6.getPublicKey();

      final k7 = Secp256r1Keypair();
      final pk7 = k7.getPublicKey();

      final k8 = Secp256r1Keypair();
      final pk8 = k8.getPublicKey();

      final k9 = Secp256r1Keypair();
      final pk9 = k9.getPublicKey();

      final k10 = Secp256r1Keypair();
      final pk10 = k10.getPublicKey();

      final k11 = Secp256r1Keypair();
      final pk11 = k11.getPublicKey();

      expect(() =>
        MultiSigPublicKey.fromPublicKeys(
          threshold: 10,
          publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
            PublicKeyWeight(4, pk4),
            PublicKeyWeight(5, pk5),
            PublicKeyWeight(1, pk6),
            PublicKeyWeight(2, pk7),
            PublicKeyWeight(3, pk8),
            PublicKeyWeight(4, pk9),
            PublicKeyWeight(5, pk10),
            PublicKeyWeight(6, pk11),
          ],
        ),
        throwsArgumentError
      );
    });

    test('with max weights and max threshold values', () {
      expect(() =>
        MultiSigPublicKey.fromPublicKeys(
          threshold: 65535,
          publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(256, pk2),
            PublicKeyWeight(3, pk3),
          ],
        ),
        throwsArgumentError
      );

      expect(() =>
        MultiSigPublicKey.fromPublicKeys(
          threshold: 65536,
          publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
          ],
        ),
        throwsArgumentError
      );
    });

    test('with zero weight value', () {
      expect(() =>
        MultiSigPublicKey.fromPublicKeys(
          threshold: 10,
          publicKeys: [
            PublicKeyWeight(0, pk1),
            PublicKeyWeight(6, pk2),
            PublicKeyWeight(10, pk3),
          ]
        ),
        throwsArgumentError
      );
    });

    test('with zero threshold value', () {
      expect(() =>
        MultiSigPublicKey.fromPublicKeys(
          threshold: 0,
          publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
          ],
        ),
        throwsArgumentError
      );
    });

    test('with empty values', () {
      expect(() =>
        MultiSigPublicKey.fromPublicKeys(
          threshold: 2,
          publicKeys: [],
        ),
        throwsArgumentError
      );
    });

    test('with duplicated publickeys', () {
      expect(() =>
        MultiSigPublicKey.fromPublicKeys(
          threshold: 4,
          publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk1),
            PublicKeyWeight(3, pk3),
          ],
        ),
        throwsArgumentError
      );
    });

  });

}