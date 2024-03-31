
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/cryptography/intent.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/sui_bcs.dart';
import 'package:sui/utils/hex.dart';
import 'package:sui/utils/sha.dart';

void main() {
  
  group('PublicKey', () { 

    late Ed25519Keypair k1;
    late Ed25519PublicKey pk1;
    late Secp256k1Keypair k2;
    late PublicKey	pk2;
    late Secp256r1Keypair k3;
    late PublicKey	pk3;

    setUpAll(() {
      const VALID_SECP256K1_SECRET_KEY = [
        59, 148, 11, 85, 134, 130, 61, 253, 2, 174, 59, 70, 27, 180, 51, 107, 94, 203, 174, 253, 102,
        39, 170, 146, 46, 252, 4, 143, 236, 12, 136, 28,
      ];

      const VALID_SECP256R1_SECRET_KEY = [
        66, 37, 141, 205, 161, 76, 241, 17, 198, 2, 184, 151, 27, 140, 200, 67, 233, 30, 70, 202, 144,
        81, 81, 192, 39, 68, 166, 176, 23, 230, 147, 22,
      ];

      final secret_key_k1 = Uint8List.fromList(VALID_SECP256K1_SECRET_KEY);
      final secret_key_r1 = Uint8List.fromList(VALID_SECP256R1_SECRET_KEY);

      k1 = Ed25519Keypair.fromSecretKey(secret_key_k1);
      pk1 = k1.getPublicKey();

      k2 = Secp256k1Keypair.fromSecretKey(secret_key_k1);
      pk2 = k2.getPublicKey();

      k3 = Secp256r1Keypair.fromSecretKey(secret_key_r1);
      pk3 = k3.getPublicKey();
    });

    test('`fromPublicKeys()` should create multisig correctly', () {
      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
          PublicKeyWeight(3, pk3),
        ],
      );

      expect(multiSigPublicKey.publicKeys.length, 3);

      final publicKey1 = multiSigPublicKey.publicKeys[0];
      expect(publicKey1.publicKey.toBase64(), pk1.toBase64());
      expect(publicKey1.weight, 1);

      final publicKey2 = multiSigPublicKey.publicKeys[1];
      expect(publicKey2.publicKey.toBase64(), pk2.toBase64());
      expect(publicKey2.weight, 2);

      final publicKey3 = multiSigPublicKey.publicKeys[2];
      expect(publicKey3.publicKey.toBase64(), pk3.toBase64());
      expect(publicKey3.weight, 3);
    });

    test('`fromPublicKeys()` should handle invalid parameters', () {
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

      expect(() => {
        MultiSigPublicKey.fromPublicKeys(
          threshold: 10, publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
            PublicKeyWeight(1, pk4),
            PublicKeyWeight(2, pk5),
            PublicKeyWeight(3, pk6),
            PublicKeyWeight(1, pk7),
            PublicKeyWeight(2, pk8),
            PublicKeyWeight(3, pk9),
            PublicKeyWeight(1, pk10),
            PublicKeyWeight(2, pk11),
          ]
        )
      }, throwsArgumentError);

    });

    test('`constructor()` should create multisig correctly', () {
      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
          PublicKeyWeight(3, pk3),
        ],
      );
      final data = Uint8List.fromList([0, 0, 0, 5, 72, 101, 108, 108, 111]);

      final sig1 = k1.signPersonalMessage(data);
      final sig2 = k2.signPersonalMessage(data);

      final multisig = multiSigPublicKey.combinePartialSignatures([sig1.signature, sig2.signature]);
      final parsed = parseSerializedSignature(multisig);

      final publicKey = MultiSigPublicKey(MultiSigPublicKeyStruct.fromJson(parsed.multisig["multisig_pk"]));
      final pks = publicKey.publicKeys;
      expect(pks.length, 3);
      expect(pks[0].weight, 1);
      expect(pks[0].publicKey.toBase64(), pk1.toBase64());
      expect(pks[1].weight, 2);
      expect(pks[1].publicKey.toBase64(), pk2.toBase64());
      expect(pks[2].weight, 3);
      expect(pks[2].publicKey.toBase64(), pk3.toBase64());
      expect(publicKey.equals(multiSigPublicKey), true);
    });

    test('`equals()` should handle multisig comparison correctly', () {
      final multiSigPublicKey1 = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
          PublicKeyWeight(3, pk3),
        ],
      );

      final multiSigPublicKey2 = MultiSigPublicKey.fromPublicKeys(
        threshold: 4,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
          PublicKeyWeight(3, pk3),
        ],
      );

      final multiSigPublicKey3 = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
        ],
      );

      final multiSigPublicKey4 = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
          PublicKeyWeight(1, pk1),
          PublicKeyWeight(2, pk2),
          PublicKeyWeight(3, pk3),
        ],
      );

      expect(multiSigPublicKey1.equals(multiSigPublicKey2), false);
      expect(multiSigPublicKey1.equals(multiSigPublicKey3), false);
      expect(multiSigPublicKey1.equals(multiSigPublicKey4), true);
    });

    test('`toRawBytes()` should return correct array representation', () {
        final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
          threshold: 3,
          publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
          ],
        );

        final data = Uint8List.fromList([0, 0, 0, 5, 72, 101, 108, 108, 111]);

        final sig1 = k1.signPersonalMessage(data);
        final sig2 = k2.signPersonalMessage(data);

        final multisig = multiSigPublicKey.combinePartialSignatures([sig1.signature, sig2.signature]);
        final rawBytes = base64Decode(multisig).sublist(134);  // ?

        expect(multiSigPublicKey.toRawBytes(), rawBytes);
        expect(multiSigPublicKey.toRawBytes(),
          Uint8List.fromList([
            3, 0, 90, 226, 32, 180, 178, 246, 94, 151, 124, 18, 237, 230, 21, 121, 255, 81, 112, 182,
            194, 44, 0, 97, 104, 195, 123, 94, 124, 97, 175, 1, 128, 131, 1, 1, 2, 29, 21, 35, 7, 198,
            183, 43, 14, 208, 65, 139, 14, 112, 205, 128, 231, 245, 41, 91, 141, 134, 245, 114, 45, 63,
            82, 19, 251, 210, 57, 79, 54, 2, 2, 2, 39, 50, 43, 58, 137, 26, 10, 40, 13, 107, 193, 251,
            44, 187, 35, 210, 143, 84, 144, 111, 214, 64, 127, 95, 116, 31, 109, 239, 87, 98, 96, 154,
            3, 3, 0,
          ]),
        );
    });

    test('`toSuiAddress()` should return correct sui address associated with multisig publickey', () {
      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
        ],
      );

      const maxLength = 1 + (64 + 1) * MAX_SIGNER_IN_MULTISIG + 2;
      final tmp = Uint8List(maxLength);
      tmp.setAll(0, [0x03]);
      tmp.setAll(1, bcs.ser('u16', 3).toBytes());
      int i = 3;
      for (var item in multiSigPublicKey.publicKeys) {
        final publicKey = item.publicKey;
        final weight = item.weight;
        final bytes = publicKey.toSuiBytes();
        tmp.setAll(i, bytes);
        i += bytes.length;
        tmp.setAll(i++, [weight]);
      }
      final multisigSuiAddress = normalizeSuiAddress(
        Hex.encode(blake2b(tmp.sublist(0, i))),
      );

      expect(multiSigPublicKey.toSuiAddress(), multisigSuiAddress);
      expect(multiSigPublicKey.toSuiAddress(),
        '0x8ee027fe556a3f6c0a23df64f090d2429fec0bb21f55594783476e81de2dec27',
      );
    });

    test('`flag()` should return correct signature scheme', () {
      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
        ],
      );

      expect(multiSigPublicKey.flag(), 3);
      expect(multiSigPublicKey.flag(), SIGNATURE_SCHEME_TO_FLAG.MultiSig);
    });

    test('`parsePartialSignatures()` should parse serialized signatures correctly', () {
      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
        ],
      );

      final data = Uint8List.fromList([0, 0, 0, 5, 72, 101, 108, 108, 111]);

      final sig1 = k1.signPersonalMessage(data);
      final sig2 = k2.signPersonalMessage(data);

      final multisig = multiSigPublicKey.combinePartialSignatures([sig1.signature, sig2.signature]);

      final bytes = base64Decode(multisig);
      final multiSigStruct = bcs.de('MultiSig', bytes.sublist(1));

      final parsedPartialSignatures = parsePartialSignatures(multiSigStruct);

      expect(parsedPartialSignatures.length, 2);

      final parsedPK1 = parsedPartialSignatures[0];
      expect(parsedPK1.publicKey.toRawBytes(), pk1.toRawBytes());
      expect(parsedPK1.weight, 1);
      expect(parsedPK1.signatureScheme, SIGNATURE_SCHEME_TO_FLAG.flagToScheme(pk1.flag()));
      expect(parsedPK1.signature, parseSerializedSignature(k1.signPersonalMessage(data).signature).signature);

      final parsedPK2 = parsedPartialSignatures[1];
      expect(parsedPK2.publicKey.toRawBytes(), pk2.toRawBytes());
      expect(parsedPK2.weight, 2);
      expect(parsedPK2.signatureScheme, SIGNATURE_SCHEME_TO_FLAG.flagToScheme(pk2.flag()));
      expect(parsedPK2.signature, parseSerializedSignature(k2.signPersonalMessage(data).signature).signature);
      expect(parsedPK2.signature, parseSerializedSignature(k2.signPersonalMessage(data).signature).signature);
    });

    test('`verify()` should verify the signature correctly', () {
      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
        ],
      );

      final data = Uint8List.fromList([0, 0, 0, 5, 72, 101, 108, 108, 111]);

      final sig1 = k1.signPersonalMessage(data);
      final sig2 = k2.signPersonalMessage(data);

      final multisig = multiSigPublicKey.combinePartialSignatures([sig1.signature, sig2.signature]);

      final intentMessage = messageWithIntent(
        IntentScope.personalMessage,
        bcs.ser(['vector', 'u8'], data).toBytes(),
      );
      final digest = blake2b(intentMessage);

      expect(multiSigPublicKey.verify(digest, base64Decode(multisig)), true);
    });

    test('`verify()` should handle invalid signature schemes', () {
      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
        ],
      );

      final data = Uint8List.fromList([0, 0, 0, 5, 72, 101, 108, 108, 111]);

      final sig1 = k1.signPersonalMessage(data);
      final sig2 = k2.signPersonalMessage(data);

      multiSigPublicKey.combinePartialSignatures([sig1.signature, sig2.signature]);

      final intentMessage = messageWithIntent(
        IntentScope.personalMessage,
        bcs.ser(['vector', 'u8'], data).toBytes(),
      );
      final digest = blake2b(intentMessage);

      expect(() => multiSigPublicKey.verify(digest, base64Decode(sig1.signature)), throwsArgumentError);
    });

    test('`combinePartialSignatures()` should combine with different signatures into a single multisig correctly', () {
      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 3,
        publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
            PublicKeyWeight(3, pk3),
        ],
      );

      final data = Uint8List.fromList([0, 0, 0, 5, 72, 101, 108, 108, 111]);

      final sig1 = k1.signPersonalMessage(data);
      final sig2 = k2.signPersonalMessage(data);

      final multisig = multiSigPublicKey.combinePartialSignatures([sig1.signature, sig2.signature]);

		  expect(multisig,
			  'AwIANe9gJJmT5m1UvpV8Hj7nOyif76rS5Zgg1bi7VApts+KwtSc2Bg8WJ6LBfGnZKugrOqtQsk5d2Q+IMRLD4hYmBQFYlrlXc01/ZSdgwSD3eGEdm6kxwtOwAvTWdb2wNZP2Hnkgrh+indYN4s2Qd99iYCz+xsY6aT5lpOBsDZb2x9LyAwADAFriILSy9l6XfBLt5hV5/1FwtsIsAGFow3tefGGvAYCDAQECHRUjB8a3Kw7QQYsOcM2A5/UpW42G9XItP1IT+9I5TzYCAgInMis6iRoKKA1rwfssuyPSj1SQb9ZAf190H23vV2JgmgMDAA==',
		  );

      final decoded = bcs.de("MultiSig", base64Decode(multisig).sublist(1));
      expect(decoded["bitmap"], 3);
      expect(decoded["multisig_pk"], bcs.de("MultiSigPublicKey", multiSigPublicKey.toRawBytes()));
      expect(decoded["sigs"], [
        {
          "Ed25519": parseSerializedSignature((k1.signPersonalMessage(data)).signature).signature,
        },
        {
          "Secp256k1": parseSerializedSignature((k2.signPersonalMessage(data)).signature).signature!,
        }
      ]);
    });

	test('`combinePartialSignatures()` should handle invalid parameters', () {
		final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
			threshold: 3,
			publicKeys: [
            PublicKeyWeight(1, pk1),
            PublicKeyWeight(2, pk2),
			],
		);

		final data = Uint8List.fromList([0, 0, 0, 5, 72, 101, 108, 108, 111]);

		final sig1 = k1.signPersonalMessage(data);
		final sig2 = k2.signPersonalMessage(data);
		final sig3 = k3.signPersonalMessage(data);

		expect(
      () => multiSigPublicKey.combinePartialSignatures([sig1.signature, sig3.signature]),
      throwsArgumentError
    );

		expect(
      () => multiSigPublicKey.combinePartialSignatures([sig1.signature, sig1.signature]),
		  throwsArgumentError
    );

		final multisig = multiSigPublicKey.combinePartialSignatures([sig1.signature, sig2.signature]);

		expect(
      () => multiSigPublicKey.combinePartialSignatures([multisig, sig1.signature]),
      throwsArgumentError
		);

	});

  });

}