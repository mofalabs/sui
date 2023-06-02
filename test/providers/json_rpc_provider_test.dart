import 'package:flutter_test/flutter_test.dart';
import 'package:sui/constants.dart';
import 'package:sui/providers/json_rpc_provider.dart';

void main() {

  const address = '0x936accb491f0facaac668baaedcf4d0cfc6da1120b66f77fa6a43af718669973';

  late JsonRpcProvider provider;

  setUp(() {
    provider = JsonRpcProvider(Constants.mainnetAPI);
  });

  test('test getCheckpoint', () async {
    final resp = await provider.getCheckpoint("2525432");
    expect(resp.sequenceNumber == "2525432", true);
  });

  test('test getCheckpoints', () async {
    final resp = await provider.getCheckpoints();
    expect(resp.hasNextPage, true);
    expect(resp.data.isNotEmpty, true);
  });

  test('test getLatestCheckpointSequenceNumber', () async {
    final resp = await provider.getLatestCheckpointSequenceNumber();
    expect(resp > BigInt.zero, true);
  });

  test('test getLoadedChildObjects', () async {
    const tx = 'D46LzFjYNeN432Sz7rp8BEdAPdUU2mCeExxXJGdpBVRb';
    final resp = await provider.getLoadedChildObjects(tx);
    expect(resp.loadedChildObjects.isNotEmpty, true);
  });

  test('test getMoveFunctionArgTypes', () async {
    const package = "0xf45f752bc45dadff2ebc867c69af682c7192686d2455f655e2c54c9c75e95cff";
    const module = "post";
    const function = "create_post";
    final resp = await provider.getMoveFunctionArgTypes(
      packageId: package,
      moduleName: module,
      functionName: function
    );
    expect(resp.length > 0, true);
  });


  test('test getRpcApiVersion', () async {
    final resp = await provider.getRpcApiVersion();
    expect(resp.major >= 0, true);
    expect(resp.minor >= 0, true);
    expect(resp.patch >= 0, true);
  });

  test('test getTransactions', () async {
    final resp = await provider.getTransactions(address);
    expect(resp.isNotEmpty, true);
  });

  test('test getTransactionWithEffects', () async {
    final txns = await provider.getTransactions(address);
    expect(txns.isNotEmpty, true);
    final resp = await provider.getTransactionBlock(txns[0].digest);
    expect(txns[0].digest == resp.digest, true);
  });

  test('test getTransactionWithEffectsBatch', () async {
    final txs = await provider.getTransactions(address);
    List<String> txDigests = [];
    for (var element in txs) {
      txDigests.add(element.digest);
    }
    final resp = await provider.getTransactionBlockBatch(txDigests);
    expect(txs.length == resp.length, true);
  });

  test('test getOwnedObjects', () async {
    final resp = await provider.getOwnedObjects(address);
    expect(resp.isNotEmpty, true);
  });

  test('test getObject by objectId', () async {
    final objectsID = await provider.getOwnedObjects(address);
    final objectId = objectsID[0].objectId;
    final resp = await provider.getObject(objectId);
    expect(resp.data?.objectId == objectId, true);
  });

  test('test getObjectRef by objectId', () async {
    final objectsID = await provider.getOwnedObjects(address);
    final objectId = objectsID[0].objectId;
    final resp = await provider.getObjectRef(objectId);
    expect(resp?.objectId == objectId, true);
  });

  test('test getObjectBatch', () async {
    final objectsID = await provider.getOwnedObjects(address);
    final ids = objectsID.map((obj) => obj.objectId).toList();
    final resp = await provider.getObjectBatch(ids);
    expect(resp.length == ids.length, true);
  });

  test('test getTotalTransactionBlocks', () async {
    final txNum = await provider.getTotalTransactionBlocks();
    expect(txNum > BigInt.zero, true);
  });

  test('test getCoinBalancesOwnedByAddress', () async {
    final result = await provider.getCoinBalancesOwnedByAddress(address);
    expect(result.isNotEmpty, true);
  });

  test('test getObjectsOwnedByObject', () async {
    final objectsID = await provider.getOwnedObjects(address);
    final objectId = objectsID[0].objectId;
    final result = await provider.getObject(objectId);
    expect(result.data?.objectId == objectId, true);
  });

  test('test getEvents', () async {
    final resp = await provider.getEvents("D46LzFjYNeN432Sz7rp8BEdAPdUU2mCeExxXJGdpBVRb");
    expect(resp.isNotEmpty, true);
  });

  test('test query all events', () async {
    final result = await provider.queryEvents({ "All": []});
    expect(result.data.isNotEmpty, true);
  });

  test('test query all events paged', () async {
    final result = await provider.queryEvents({ "All": []}, limit: 2);
    expect(result.data.isNotEmpty, true);
    expect(result.nextCursor != null, true);
  });

  test('test query events by sender paginated', () async {
    final result = await provider.queryEvents({ "Sender": address});
    expect(result.data.isNotEmpty, true);
  });

  test('test query all events', () async {
    final result = await provider.queryEvents({ "All": []});
    expect(result.data.isNotEmpty, true);
  });

  test('test queryEventsByTransaction', () async {
    const txn = 'D46LzFjYNeN432Sz7rp8BEdAPdUU2mCeExxXJGdpBVRb';
    final result = await provider.queryTransactionEvents(txn);
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
    final result = await provider.getBalanceBatch(owners);
    for (var coin in result) {
      print('coin balance: ${coin.totalBalance}');
    }
    expect(result.isNotEmpty, true);
  });

  test('test getOwnedObjectList', () async {
    const owner =
        '0x73024d967e8714e73cffbac418ee0cb0557308c39e3d6afac28f2bddde6651cd';
    final result = await provider.getOwnedObjectList(owner);
    expect(result.data.isNotEmpty, true);
  });

  test('test getLatestSuiSystemState', () async {
    final result = await provider.getLatestSuiSystemState();
    expect(result.activeValidators.isNotEmpty, true);
  });

  test('test getValidatorsApy', () async {
    final result = await provider.getValidatorsApy();
    expect(result.apys.isNotEmpty, true);
  });

  test('test getStakes', () async {
    final result = await provider.getStakes(
        "0x4ee37e332292fa904bed062ce207e3c390c4f9b46773cdc46648b1e65d06adc7");
    expect(result.isNotEmpty, true);
  });

  test('test getStakesByIds', () async {
    final result = await provider.getStakesByIds(
        ["0x0175d093a5bf9d1f151548b593eed54d29d20d35fcc443be30ac2026a1c6345c"]);
    expect(result.isNotEmpty, true);
  });

  test('test getCommitteeInfo', () async {
    final result = await provider.getCommitteeInfo();
    expect(result.validators.isNotEmpty, true);
  });

  test('test resolveNameServiceAddress', () async {
    final result = await provider.resolveNameServiceAddress('blockchain.sui');
    expect(result == '0x57514a8dd8f08724d01954953721b738adecb29bca613b0b351adf76e7233bac', true);
  });

  test('test resolveNameServiceNames', () async {
    final result = await provider.resolveNameServiceNames('0x57514a8dd8f08724d01954953721b738adecb29bca613b0b351adf76e7233bac');
    expect(result!.data.first == 'blockchain.sui', true);
    expect(result.hasNextPage == false, true);
  });
}
