import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:sui/client/network.dart';
import 'package:sui/grpc/sui_grpc_client.dart';
import 'package:sui/utils/dynamic_fields.dart';

/// Coverage for the parity-gap methods added to match the official TS SDK's
/// CoreClient: getCurrentSystemState, listCoins, getDynamicFieldObject
/// (+ deriveDynamicFieldID), and waitForTransaction. All over gRPC-web on
/// testnet (read-only, no faucet).
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.testnet);

  const framework =
      '0x0000000000000000000000000000000000000000000000000000000000000005';
  const clock =
      '0x0000000000000000000000000000000000000000000000000000000000000006';

  test('getCurrentSystemState', () async {
    final s = await client.getCurrentSystemState();
    print('epoch=${s.epoch} protocolVersion=${s.protocolVersion} '
        'rgp=${s.referenceGasPrice} safeMode=${s.safeMode}');
    expect(s.epoch.toInt(), greaterThan(0));
    expect(s.referenceGasPrice.toInt(), greaterThan(0));
  });

  test('listCoins returns Coin<SUI> objects with balance', () async {
    final page = await client.listCoins(framework);
    print('coins=${page.coins.length} hasNextPage=${page.hasNextPage}');
    expect(page.coins, isNotEmpty);
    final c = page.coins.first;
    expect(c.coinType, '0x2::sui::SUI');
    expect(c.coinObjectId, isNotEmpty);
    expect(c.balance, greaterThanOrEqualTo(BigInt.zero));
  });

  test('deriveDynamicFieldID matches on-chain field_id + getDynamicFieldObject',
      () async {
    final fields = await client.listDynamicFields(framework, pageSize: 1);
    expect(fields.dynamicFields, isNotEmpty);
    final f = fields.dynamicFields.first;
    final nameType = f.name.name;
    final nameBcs = Uint8List.fromList(f.name.value);

    // The ported derivation must reproduce the chain's field id.
    final derived = deriveDynamicFieldID(framework, nameType, nameBcs);
    print('nameType="$nameType" field_id=${f.fieldId} derived=$derived');
    expect(derived, f.fieldId);

    // And fetching the field object via name resolves to the same object.
    final obj = await client.getDynamicFieldObject(framework, nameType, nameBcs);
    expect(obj.objectId, f.fieldId);
  });

  test('waitForTransaction resolves an already-executed digest', () async {
    // Get a real digest via the Clock's last-mutating transaction.
    final clockObj =
        await client.getObject(clock, readMask: const ['previous_transaction']);
    final digest = clockObj.previousTransaction;
    expect(digest, isNotEmpty);

    final tx = await client.waitForTransaction(digest,
        timeout: const Duration(seconds: 20));
    print('waited digest=${tx.digest}');
    expect(tx.digest, digest);
  });
}
