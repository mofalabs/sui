import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';
import 'package:sui/grpc/proto/sui/rpc/v2/signature_verification_service.pb.dart';
import '../support/grpc_fixture_transport.dart';
import '../passkey_test.dart' show MockPasskeySigner;
import '../zklogin/signature_test.dart' show aSignature, aSignatureInputs;

void main() {
  final message = Uint8List.fromList([1, 2, 3]);
  final ed = Ed25519Keypair.fromSeed(Uint8List(32));

  test(
    'boolean verification separates malformed, invalid and wrong-address signatures',
    () async {
      final signature = ed.signPersonalMessage(message).signature;
      expect(await isValidPersonalMessageSignature(message, signature), isTrue);
      expect(
        await isValidPersonalMessageSignature(Uint8List(1), signature),
        isFalse,
      );
      expect(
        await isValidPersonalMessageSignature(
          message,
          signature,
          address: normalizeSuiAddress('0x1'),
        ),
        isFalse,
      );
      for (final malformed in [
        '',
        '!',
        base64Encode([255]),
        base64Encode([0, 1]),
      ]) {
        expect(
          await isValidPersonalMessageSignature(message, malformed),
          isFalse,
        );
      }
      expect(
        (await verifyPersonalMessageSignature(message, signature)).toRawBytes(),
        ed.getPublicKey().toRawBytes(),
      );
    },
  );

  test('Passkey multisig preserves its outer signature flag', () async {
    final curve = Secp256.fromSecp256r1();
    final sk = curve.generatePrivateKeyBytes();
    final raw = curve.getPublicKey(decodeBigIntToUnsigned(sk), false);
    final passkey = await PasskeyKeypair.getPasskeyInstance(
      MockPasskeySigner(
        sk: sk,
        der: Uint8List.fromList([...SECP256R1_SPKI_HEADER, 4, ...raw]),
      ),
    );
    final multi = MultiSigPublicKey.fromPublicKeys(
      threshold: 2,
      publicKeys: [
        PublicKeyWeight(1, ed.getPublicKey()),
        PublicKeyWeight(1, passkey.getPublicKey()),
      ],
    );
    final partial = await passkey.signPersonalMessage(message);
    final combined = multi.combinePartialSignatures([
      ed.signPersonalMessage(message).signature,
      partial.signature,
    ]);
    final body = SuiBcs.MultiSig.parse(base64Decode(combined).sublist(1));
    expect(body['sigs'][1]['Passkey'][0], 6);
    expect(multi.verifyPersonalMessage(message, combined), isTrue);
    expect(await multi.verifyPersonalMessageAsync(message, combined), isTrue);
    expect(
      await isValidPersonalMessageSignature(Uint8List(1), combined),
      isFalse,
    );
  });

  test(
    'malformed Passkey inner signatures fail for single and multisig verification',
    () async {
      final curve = Secp256.fromSecp256r1();
      final sk = curve.generatePrivateKeyBytes();
      final raw = curve.getPublicKey(decodeBigIntToUnsigned(sk), false);
      final passkey = await PasskeyKeypair.getPasskeyInstance(
        MockPasskeySigner(
          sk: sk,
          der: Uint8List.fromList([...SECP256R1_SPKI_HEADER, 4, ...raw]),
        ),
      );
      final signed = await passkey.signPersonalMessage(message);
      final authenticator = SuiBcs.PasskeyAuthenticator.parse(
        base64Decode(signed.signature).sublist(1),
      );
      final inner = List<int>.from(authenticator['userSignature']);
      final multi = MultiSigPublicKey.fromPublicKeys(
        threshold: 1,
        publicKeys: [PublicKeyWeight(1, passkey.getPublicKey())],
      );
      final publicKey = SuiBcs.MultiSigPublicKey.parse(multi.toRawBytes());
      for (final invalid in <List<int>>[
        [0, ...inner.sublist(1)],
        inner.sublist(0, inner.length - 1),
        [...inner, 0],
        [],
      ]) {
        final malformed = Uint8List.fromList([
          SIGNATURE_SCHEME_TO_FLAG.Passkey,
          ...SuiBcs.PasskeyAuthenticator.serialize({
            ...authenticator,
            'userSignature': invalid,
          }).toBytes(),
        ]);
        expect(
          () => parseSerializedPasskeySignature(malformed),
          throwsFormatException,
        );
        expect(
          await isValidPersonalMessageSignature(
            message,
            base64Encode(malformed),
          ),
          isFalse,
        );
        // Construct the wire payload directly: the normal combiner should reject
        // invalid partial signatures before a multisig can be produced.
        final serializedMulti = base64Encode([
          SIGNATURE_SCHEME_TO_FLAG.MultiSig,
          ...SuiBcs.MultiSig.serialize({
            'sigs': [
              {'Passkey': malformed},
            ],
            'bitmap': 1,
            'multisig_pk': publicKey,
          }).toBytes(),
        ]);
        expect(
          await isValidPersonalMessageSignature(message, serializedMulti),
          isFalse,
        );
      }
    },
  );

  test(
    'zkLogin signer wraps intent signature and validates expected address',
    () async {
      final signer = ZkLoginSigner(
        ephemeralSigner: ed,
        inputs: aSignatureInputs,
        maxEpoch: 174,
        legacyAddress: false,
      );
      final signed = await signer.signPersonalMessage(message);
      final parsed = parseSerializedSignature(signed.signature);
      expect(parsed.signatureScheme, SignatureScheme.ZkLogin);
      expect(parsed.zkLogin!['maxEpoch'], 174);
      expect(
        base64Encode(parsed.zkLogin!['userSignature'] as Uint8List),
        ed.signPersonalMessage(message).signature,
      );
      expect(signer.getPublicKey().toRawBytes().length, greaterThan(32));
      expect(signer.getPublicKey().toSuiAddress(), signer.getAddress());
      expect(
        () => ZkLoginSigner(
          ephemeralSigner: ed,
          inputs: aSignatureInputs,
          maxEpoch: 174,
          legacyAddress: false,
          address: normalizeSuiAddress('0x1'),
        ),
        throwsArgumentError,
      );
      expect(() => signer.signData(message), throwsUnsupportedError);
    },
  );

  test(
    'zkLogin modern and legacy identities preserve padding and addresses',
    () {
      final seed = BigInt.one;
      final modern = toZkLoginPublicIdentifier(seed, 'accounts.google.com');
      final legacy = toZkLoginPublicIdentifier(
        seed,
        'accounts.google.com',
        legacyAddress: true,
      );
      expect(modern.toRawBytes(), legacy.toRawBytes());
      expect(modern.toSuiAddress(), isNot(legacy.toSuiAddress()));
      expect(
        legacy.toSuiAddress(),
        computeZkLoginAddressFromSeed(seed, 'accounts.google.com'),
      );
      expect(modern.verifyAddress(legacy.toSuiAddress()), isTrue);
      expect(
        ZkLoginPublicIdentifier.fromBytes(
          modern.toRawBytes(),
          address: legacy.toSuiAddress(),
        ).legacyAddress,
        isTrue,
      );
    },
  );

  test(
    'zkLogin multisig binds proof to its member and preserves client errors',
    () async {
      var calls = 0;
      var fail = false;
      final expected = toZkLoginPublicIdentifier(
        BigInt.parse(aSignatureInputs.addressSeed),
        'https://accounts.google.com',
      );
      final core = GrpcCoreClient(
        network: SuiNetwork.localnet,
        transport: GrpcFixtureTransport(
          onUnary: (method, bytes) {
            calls++;
            if (fail) {
              throw GrpcWebException(
                GrpcStatus.unavailable,
                'JWK lookup unavailable',
              );
            }
            expect(method, 'VerifySignature');
            final request = VerifySignatureRequest.fromBuffer(bytes);
            expect(request.address, expected.toSuiAddress());
            return VerifySignatureResponse(isValid: true).writeToBuffer();
          },
        ),
      );
      String signatureFor(PublicKey key) {
        final multi = MultiSigPublicKey.fromPublicKeys(
          threshold: 1,
          publicKeys: [PublicKeyWeight(1, key)],
        );
        final pk = SuiBcs.MultiSigPublicKey.parse(multi.toRawBytes());
        return base64Encode([
          3,
          ...SuiBcs.MultiSig.serialize({
            'sigs': [
              {'ZkLogin': base64Decode(aSignature)},
            ],
            'bitmap': 1,
            'multisig_pk': pk,
          }).toBytes(),
        ]);
      }

      expect(
        await isValidPersonalMessageSignature(
          message,
          signatureFor(
            toZkLoginPublicIdentifier(
              BigInt.one,
              'https://accounts.google.com',
            ),
          ),
          client: core,
        ),
        isFalse,
      );
      expect(calls, 0);
      final signature = signatureFor(expected);
      expect(
        await isValidPersonalMessageSignature(message, signature, client: core),
        isTrue,
      );
      expect(calls, 1);
      fail = true;
      await expectLater(
        isValidPersonalMessageSignature(message, signature, client: core),
        throwsA(isA<GrpcWebException>()),
      );
    },
  );
}
