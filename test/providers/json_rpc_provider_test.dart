import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/sui.dart';

void main() {

  const address = '0x936accb491f0facaac668baaedcf4d0cfc6da1120b66f77fa6a43af718669973';

  late SuiClient client;

  setUp(() {
    client = SuiClient(Constants.mainnetAPI);
  });

  test('test getChainIdentifier', () async {
    final result = await client.getChainIdentifier();
    expect(result, '35834a8a');
  });

  test('test getLatestCheckpointSequenceNumber', () async {
    final resp = await client.getLatestCheckpointSequenceNumber();
    expect(resp > BigInt.zero, true);
  });

  test('test getCheckpoint', () async {
    final seq = await client.getLatestCheckpointSequenceNumber();
    final resp = await client.getCheckpoint(seq.toString());
    expect(resp.sequenceNumber == seq.toString(), true);
  });

  test('test getCheckpoints', () async {
    final resp = await client.getCheckpoints();
    expect(resp.hasNextPage, true);
    expect(resp.data.isNotEmpty, true);
  });

  test('test totalSupply', () async {
    final resp = await client.getTotalSupply("0x2::sui::SUI");
    expect(resp.value, BigInt.zero);
  });

  test('test getLoadedChildObjects', () async {
    const tx = 'D46LzFjYNeN432Sz7rp8BEdAPdUU2mCeExxXJGdpBVRb';
    final resp = await client.getLoadedChildObjects(tx);
    expect(resp.loadedChildObjects.isNotEmpty, true);
  });

  test('test getMoveFunctionArgTypes', () async {
    const package = "0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1";
    const module = "suifrens";
    const function = "burn";
    final resp = await client.getMoveFunctionArgTypes(
      packageId: package,
      moduleName: module,
      functionName: function
    );
    expect(resp.isNotEmpty, true);
  });


  test('test getRpcApiVersion', () async {
    final resp = await client.getRpcApiVersion();
    expect(resp.major >= 0, true);
    expect(resp.minor >= 0, true);
    expect(resp.patch >= 0, true);
  });

  test('test getCoins', () async {
    final resp = await client.getCoins(address);
    expect(resp.data.isNotEmpty, true);
  });

  test('test getAllCoins', () async {
    final resp = await client.getAllCoins(address);
    expect(resp.data.isNotEmpty, true);
  });


  test('test getTransactions', () async {
    final resp = await client.getTransactions(address);
    expect(resp.$1.isNotEmpty, true);
  });

  test('test getTransactionWithEffects', () async {
    final txns = (await client.getTransactions(address)).$1;
    expect(txns.isNotEmpty, true);
    final resp = await client.getTransactionBlock(txns[0].digest);
    expect(txns[0].digest == resp.digest, true);
  });

  test('test getTransactionWithEffectsBatch', () async {
    final txs = (await client.getTransactions(address)).$1;
    List<String> txDigests = [];
    for (var element in txs) {
      txDigests.add(element.digest);
    }
    final resp = await client.getTransactionBlockBatch(txDigests);
    expect(txs.length == resp.length, true);
  });

  test('test getOwnedObjects', () async {
    final resp = await client.getOwnedObjects(address);
    expect(resp.data.isNotEmpty, true);
  });

  test('test getObject by objectId', () async {
    final objResp = await client.getOwnedObjects(address);
    final objectId = objResp.data[0].data!.objectId;
    final resp = await client.getObject(objectId);
    expect(resp.data?.objectId == objectId, true);
  });

  test('test getObjectRef by objectId', () async {
    final objResp = await client.getOwnedObjects(address);
    final objectId = objResp.data[0].data!.objectId;
    final resp = await client.getObjectRef(objectId);
    expect(resp?.objectId == objectId, true);
  });

  test('test getObjectBatch', () async {
    final objResp = await client.getOwnedObjects(address);
    final ids = objResp.data.where((x) => x.data?.objectId != null)
                            .map((obj) => obj.data!.objectId).toList();
    final resp = await client.getObjectBatch(ids);
    expect(resp.length == ids.length, true);
  });

  test('test getTotalTransactionBlocks', () async {
    final txNum = await client.getTotalTransactionBlocks();
    expect(txNum > BigInt.zero, true);
  });

  test('test getCoinBalancesOwnedByAddress', () async {
    final result = await client.getCoinBalancesOwnedByAddress(address);
    expect(result.isNotEmpty, true);
  });

  test('test getObjectsOwnedByObject', () async {
    final objResp = await client.getOwnedObjects(address);
    final objectId = objResp.data[0].data!.objectId;
    final result = await client.getObject(objectId);
    expect(result.data?.objectId == objectId, true);
  });

  test('test getEvents', () async {
    final resp = await client.getEvents("D46LzFjYNeN432Sz7rp8BEdAPdUU2mCeExxXJGdpBVRb");
    expect(resp.isNotEmpty, true);
  });

  test('test query all events', () async {
    final result = await client.queryEvents({ "All": []});
    expect(result.data.isNotEmpty, true);
  });

  test('test query all events paged', () async {
    final result = await client.queryEvents({ "All": []}, limit: 2);
    expect(result.data.isNotEmpty, true);
    expect(result.nextCursor != null, true);
  });

  test('test query events by sender paginated', () async {
    final result = await client.queryEvents({ "Sender": address});
    expect(result.data.isNotEmpty, true);
  });

  test('test query all events', () async {
    final result = await client.queryEvents({ "All": []});
    expect(result.data.isNotEmpty, true);
  });

  test('test queryEventsByTransaction', () async {
    const txn = 'D46LzFjYNeN432Sz7rp8BEdAPdUU2mCeExxXJGdpBVRb';
    final result = await client.queryTransactionEvents(txn);
    if (result.data.isNotEmpty) {
      expect(result.data.first.id.txDigest == txn, true);
    } else {
      expect(result.data.isEmpty, true);
    }
  });

  test('test getBalanceBatch', () async {
    const owners = [
      '0x7312d32411f76db457fe943c3c51641483b80ad40fddeed66c30e385174fe32b',
      '0x223410f50cd360eb4a3ca7eb3c7936af9c4f692e82398594d66399dff7e54ff3',
      '0x7d20dcdb2bca4f508ea9613994683eb4e76e9c4ed371169677c1be02aaf0b58e',
    ];
    final result = await client.getBalanceBatch(owners);
    for (var coin in result) {
      print('coin balance: ${coin.totalBalance}');
    }
    expect(result.isNotEmpty, true);
  });

  test('test getOwnedObjectList', () async {
    const owner =
        '0x73024d967e8714e73cffbac418ee0cb0557308c39e3d6afac28f2bddde6651cd';
    final result = await client.getOwnedObjects(owner);
    expect(result.data.isNotEmpty, true);
  });

  test('test getLatestSuiSystemState', () async {
    final result = await client.getLatestSuiSystemState();
    expect(result.activeValidators.isNotEmpty, true);
  });

  test('test getValidatorsApy', () async {
    final result = await client.getValidatorsApy();
    expect(result.apys.isNotEmpty, true);
  });

  test('test getStakes', () async {
    final result = await client.getStakes(
        "0x4ee37e332292fa904bed062ce207e3c390c4f9b46773cdc46648b1e65d06adc7");
    expect(result.isNotEmpty, true);
  });

  test('test getStakesByIds', () async {
    final result = await client.getStakesByIds(
        ["0x0175d093a5bf9d1f151548b593eed54d29d20d35fcc443be30ac2026a1c6345c"]);
    expect(result.isNotEmpty, true);
  });

  test('test getCommitteeInfo', () async {
    final result = await client.getCommitteeInfo();
    expect(result.validators.isNotEmpty, true);
  });

  test('test resolveNameServiceAddress', () async {
    final result = await client.resolveNameServiceAddress('blockchain.sui');
    expect(result == '0x57514a8dd8f08724d01954953721b738adecb29bca613b0b351adf76e7233bac', true);
  });

  test('test resolveNameServiceNames', () async {
    final result = await client.resolveNameServiceNames('0x57514a8dd8f08724d01954953721b738adecb29bca613b0b351adf76e7233bac');
    expect(result!.data.first == 'blockchain.sui', true);
    expect(result.hasNextPage == false, true);
  });
}
