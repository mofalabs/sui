import 'package:flutter/foundation.dart';
import 'package:sui/builder/transaction_block.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/coins.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';
import 'package:sui/types/validator.dart';


const DEFAULT_FAUCET_URL = Constants.faucetDevAPI;
const DEFAULT_FULLNODE_URL = Constants.devnetAPI;

const DEFAULT_RECIPIENT =
	'0x0c567ffdf8162cb6d51af74be0199443b92e823d4ba6ced24de5c6c463797d46';
const DEFAULT_RECIPIENT_2 =
	'0xbb967ddbebfee8c40d8fdd2c24cb02452834cd3a7061d18564448f900eb9e66d';
const DEFAULT_GAS_BUDGET = 10000000;
const DEFAULT_SEND_AMOUNT = 1000;

class TestToolbox {
	Ed25519Keypair keypair;
	SuiClient client;

	TestToolbox(this.keypair, this.client);

	String address() {
		return keypair.getPublicKey().toSuiAddress();
	}

  Future<List<SuiObject>> getGasObjectsOwnedByAddress() async {
    final objects = await client.getOwnedObjects(
			address(),
      options: SuiObjectDataOptions(showType: true, showContent: true, showOwner: true)
		);
		return objects.data.where((obj) => Coin.isSUI(obj)).map((x) => x.data!).toList();
	}

	Future<List<CoinStruct>> getCoinsByAddress() async {
    return (await client.getCoins(address())).data;
	}

	Future<List<SuiValidatorSummary>> getActiveValidators() async {
		return (await client.getLatestSuiSystemState()).activeValidators;
	}
}

Future<TestToolbox> setup([int faucetCount = 1]) async {
	final keypair = Ed25519Keypair();
	final address = keypair.getPublicKey().toSuiAddress();
	final client = SuiClient(DEFAULT_FULLNODE_URL);
  final faucetClient = FaucetClient(DEFAULT_FAUCET_URL);
  for (var i = 0; i < faucetCount; i++) {
    try {
      await faucetClient.requestSuiFromFaucetV0(address);
    } catch(e) {
      debugPrint(e.toString());
    }
    await Future.delayed(const Duration(seconds: 3));
  }
	return TestToolbox(keypair, client);
}

Future<SuiExecuteTransactionResponse> paySui(
	SuiClient client,
	Keypair signer,
	List<String> recipients,
	List<int> amounts,
	String? coinId,
	[int numRecipients = 1]
) async {
	final tx = TransactionBlock();

	recipients = recipients;
	amounts = amounts;

	if(recipients.length != amounts.length) throw ArgumentError('recipients and amounts must be the same length');

	coinId =
		coinId ??
		(
			await client.getCoins(signer.getPublicKey().toSuiAddress(),
				coinType: '0x2::sui::SUI',
			)
		).data[0].coinObjectId;

	(recipients as Map).forEach((i, recipient) {
		final coin = tx.splitCoins(tx.object(coinId!), [tx.pure(amounts[i])]);
		tx.transferObjects([coin], tx.pure(recipient));
	});

	final txn = await client.signAndExecuteTransactionBlock(
		SuiAccount(signer),
		tx,
    responseOptions: SuiTransactionBlockResponseOptions(showEffects: true, showObjectChanges: true),
	);
	return txn;
}

Future<List<SuiExecuteTransactionResponse>> executePaySuiNTimes(
	SuiClient client,
	Keypair signer,
	int nTimes,
	List<String> recipients,
	List<int> amounts,
	[int numRecipientsPerTxn = 1]
) async {
	final txns = <SuiExecuteTransactionResponse>[];
	for (int i = 0; i < nTimes; i++) {
		// must await here to make sure the txns are executed in order
		txns.add(await paySui(client, signer, recipients, amounts, null, numRecipientsPerTxn));
	}
	return txns;
}
