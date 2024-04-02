
import 'dart:typed_data';

import 'package:bcs/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

import 'utils/setup.dart';

void main() {
  
  group('MultiSig with zklogin signature', () {
    test('Execute tx with multisig with 1 sig and 1 zkLogin sig combined', () async {
      // set up default zklogin public identifier consistent with default zklogin proof.
      final pkZklogin = toZkLoginPublicIdentifier(
        BigInt.parse('20794788559620669596206457022966176986688727876128223628113916380927502737911'),
        'https://id.twitch.tv/oauth2',
      );
      // set up ephemeral keypair, consistent with default zklogin proof.
      final ephemeralKeypair = Ed25519Keypair.fromSecretKey(
        Uint8List.fromList([
          155, 244, 154, 106, 7, 85, 249, 83, 129, 31, 206, 18, 95, 38, 131, 213, 4, 41, 195, 187, 73,
          224, 116, 20, 126, 0, 137, 165, 46, 174, 21, 95,
        ]),
      );

      // set up default single keypair.
      final kp = Ed25519Keypair.fromSecretKey(
        Uint8List.fromList([
          126, 57, 195, 235, 248, 196, 105, 68, 115, 164, 8, 221, 100, 250, 137, 160, 245, 43, 220,
          168, 250, 73, 119, 95, 19, 242, 100, 105, 81, 114, 86, 105,
        ]),
      );
      final pkSingle = kp.getPublicKey();
      // construct multisig address.
      final multiSigPublicKey = MultiSigPublicKey.fromPublicKeys(
        threshold: 1,
        publicKeys: [
          PublicKeyWeight(1, pkSingle),
          PublicKeyWeight(1, pkZklogin),
        ],
      );
      final multisigAddr = multiSigPublicKey.toSuiAddress();
      final toolbox = await setupWithFundedAddress(kp, multisigAddr);

      // construct a transfer from the multisig address.
      final txb = TransactionBlock();
      txb.setSenderIfNotSet(multisigAddr);
      final coin = txb.splitCoins(txb.gas, [txb.pureInt(1)]);
      txb.transferObjects([coin], txb.pureAddress(DEFAULT_RECIPIENT));
      final client = toolbox.client;
      final bytes = await txb.build(BuildOptions(client: client));

      // sign with the single keypair.
      final singleSig = kp.signTransactionBlock(bytes).signature;

      // construct default zklogin inputs defined in rust: https://github.com/MystenLabs/sui/blob/577537c76281b95ab8036b21e8ca5a25fde5d4b5/crates/sui-types/src/zk_login_util.rs
      final zkLoginInputs = {
        "addressSeed": '20794788559620669596206457022966176986688727876128223628113916380927502737911',
        "headerBase64": 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjEifQ',
        "issBase64Details": {
          "indexMod4": 2,
          "value": 'wiaXNzIjoiaHR0cHM6Ly9pZC50d2l0Y2gudHYvb2F1dGgyIiw',
        },
        "proofPoints": {
          "a": [
            '17318089125952421736342263717932719437717844282410187957984751939942898251250',
            '11373966645469122582074082295985388258840681618268593976697325892280915681207',
            '1',
          ],
          "b": [
            [
              '5939871147348834997361720122238980177152303274311047249905942384915768690895',
              '4533568271134785278731234570361482651996740791888285864966884032717049811708',
            ],
            [
              '10564387285071555469753990661410840118635925466597037018058770041347518461368',
              '12597323547277579144698496372242615368085801313343155735511330003884767957854',
            ],
            ['1', '0'],
          ],
          "c": [
            '15791589472556826263231644728873337629015269984699404073623603352537678813171',
            '4547866499248881449676161158024748060485373250029423904113017422539037162527',
            '1',
          ],
        },
      };
      final ephemeralSig = ephemeralKeypair.signTransactionBlock(bytes).signature;
      
      // create zklogin signature based on default zk proof.
      final zkLoginSig = getZkLoginSignature(
        ZkLoginSignature(inputs: ZkLoginSignatureInputs.fromJson(zkLoginInputs), maxEpoch: 10, userSignature: fromB64(ephemeralSig))
      );

      // combine to multisig and execute the transaction.
      final signature = multiSigPublicKey.combinePartialSignatures([singleSig, zkLoginSig]);
      final result = await client.executeTransactionBlock(
        toB64(bytes),
        [signature],
        options: SuiTransactionBlockResponseOptions(showEffects: true),
      );

      // check the execution result and digest.
      final localDigest = await txb.getDigest(BuildOptions(client: client));
      expect(localDigest, result.digest);
      expect(result.effects?.status.status, ExecutionStatusType.success);
    });
  });

}