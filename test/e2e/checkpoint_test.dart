
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui.dart';

void main() {

  group('Checkpoints Reading API', () {

    late SuiClient client;

    setUpAll(() async {
      client = SuiClient(Constants.devnetAPI);
    });

    test('Get latest checkpoint sequence number', () async {
      final checkpointSequenceNumber = await client.getLatestCheckpointSequenceNumber();
      expect(checkpointSequenceNumber > BigInt.zero, true);
    });

    test('gets checkpoint by id', () async {
      final resp = await client.getCheckpoint('0');
      expect(resp.digest.isNotEmpty, true);
      expect(resp.transactions.isNotEmpty, true);
      expect(resp.epoch, "0");
      expect(resp.sequenceNumber, "0");
      expect(resp.networkTotalTransactions, "1");
      expect(resp.epochRollingGasCostSummary.computationCost, "0");
    });

    test('get checkpoint contents by digest', () async {
      final checkpointResp = await client.getCheckpoint('0');
      final digest = checkpointResp.digest;
      final resp = await client.getCheckpoint(digest);
      expect(checkpointResp.digest, resp.digest);
    });

    test('getCheckpoints',  () async {
      final checkpoints = await client.getCheckpoints(
        descendingOrder: false,
        limit: 1
      );

      expect(checkpoints.nextCursor, '0');
      expect(checkpoints.data.length, 1);
      expect(checkpoints.hasNextPage, true);

      final checkpoints1 = await client.getCheckpoints(
        cursor: checkpoints.nextCursor!,
        limit: 1,
        descendingOrder: false,
      );
      expect(checkpoints1.nextCursor, '1');
      expect(checkpoints1.data.length, 1);
      expect(checkpoints1.hasNextPage, true);
    });
  });

}