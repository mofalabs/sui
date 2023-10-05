
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction_block.dart';
import 'package:sui/models/object_read.dart';
import 'package:sui/sui.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/objects.dart';

import 'e2e/utils/setup.dart';

void main() {
  group('Object Reading API', () {
    late TestToolbox toolbox;

    setUpAll(() async {
      toolbox = await setup(5);
    });

    test('Get Owned Objects', () async {
      final gasObjects = await toolbox.client.getOwnedObjects(toolbox.address());
      expect(gasObjects.data.isNotEmpty, true);
    });

    test('Get Object', () async {
      final gasObjects = await toolbox.getGasObjectsOwnedByAddress();
      expect(gasObjects.isNotEmpty, true);
      final objectInfos = await Future.wait(
        gasObjects.map((gasObject) {
          return toolbox.client.getObject(
            gasObject.objectId,
            options: SuiObjectDataOptions(showType: true)
          );
        }),
      );
      for (var objectInfo in objectInfos) {
        expect(objectInfo.data?.type == '0x2::coin::Coin<0x2::sui::SUI>', true);
      }
    });

    test('Get Objects', () async {
      final gasObjects = await toolbox.getGasObjectsOwnedByAddress();
      expect(gasObjects.isNotEmpty, true);
      final gasObjectIds = gasObjects.map((gasObject) => gasObject.objectId).toList();
      final objectInfos = await toolbox.client.multiGetObjects(
        gasObjectIds,
        options: SuiObjectDataOptions(showType: true)
      );

      expect(gasObjects.length, objectInfos.length);

      for (var objectInfo in objectInfos) {
        expect(objectInfo.data?.type, '0x2::coin::Coin<0x2::sui::SUI>');
      }
    });

    test('handles trying to get non-existent old objects', () async {
      final res = await toolbox.client.tryGetPastObject(
        normalizeSuiAddress('0x9999'),
        0,
      );

      expect(res.status, ObjectReadStatus.ObjectNotExists);
    });

    test('can read live versions', () async {
      final data = await toolbox.client.getCoins(
        toolbox.address(),
        coinType: SUI_TYPE_ARG,
      );

      final res = await toolbox.client.tryGetPastObject(
        data.data[0].coinObjectId,
        data.data[0].version,
      );

      expect(res.status, ObjectReadStatus.VersionFound);
    });

    test('handles trying to get a newer version than the latest version', () async {
      final data = await toolbox.client.getCoins(
        toolbox.address(),
        coinType: SUI_TYPE_ARG,
      );

      final res = await toolbox.client.tryGetPastObject(
        data.data[0].coinObjectId,
        data.data[0].version + 1,
      );

      expect(res.status, ObjectReadStatus.VersionTooHigh);
    });

    test('handles fetching versions that do not exist', () async {
      final data = await toolbox.client.getCoins(
        toolbox.address(),
        coinType: SUI_TYPE_ARG,
      );

      final res = await toolbox.client.tryGetPastObject(
        data.data[0].coinObjectId,
        // NOTE: This works because we know that this is a fresh coin that hasn't been modified:
        data.data[0].version - 1,
      );

      expect(res.status, ObjectReadStatus.VersionNotFound);
    });

    test('can find old versions of objects', () async {
      final data = await toolbox.client.getCoins(
        toolbox.address(),
        coinType: SUI_TYPE_ARG,
      );

      final tx = TransactionBlock();
      // Transfer the entire gas object:
      tx.transferObjects([tx.gas], tx.pure(normalizeSuiAddress('0x2')));

      await toolbox.client.signAndExecuteTransactionBlock(
        SuiAccount(toolbox.keypair),
        tx,
      );

      final res = await toolbox.client.tryGetPastObject(
        data.data[0].coinObjectId,
        // NOTE: This works because we know that this is a fresh coin that hasn't been modified:
        data.data[0].version,
      );

      expect(res.status, ObjectReadStatus.VersionFound);
    });
  });
}
