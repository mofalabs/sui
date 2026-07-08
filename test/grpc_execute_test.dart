import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction.dart';
import 'package:sui/client/network.dart';
import 'package:sui/grpc/sui_grpc_client.dart';
import 'package:sui/sui_account.dart';

/// End-to-end write-path proofs over gRPC-web (auto gas handling).
///
/// Both tests share ONE stable, faucet-funded account and live in the SAME file
/// so they run sequentially — `flutter test` parallelises across files, and two
/// concurrent transactions from one gas coin would collide on object version.
///
/// Run with: flutter test test/grpc_execute_test.dart
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.testnet);

  // Stable throwaway account; a self-transfer/moveCall preserves its balance,
  // so the faucet is only needed the first time (avoids per-IP rate limits).
  const testPrivKey =
      'suiprivkey1qrhwmd5a92dkdym3mp3ldk9w6pr94xrkku6yp5lm97kv4dnvp30njag85ke';
  const clock =
      '0x0000000000000000000000000000000000000000000000000000000000000006';

  final account = SuiAccount.fromPrivateKey(testPrivKey);
  final address = account.getAddress();

  Future<bool> hasGasCoin() async {
    final owned = await client.listOwnedObjects(
      address,
      objectType: '0x2::coin::Coin<0x2::sui::SUI>',
      readMask: const ['object_id'],
      pageSize: 1,
    );
    return owned.objects.isNotEmpty;
  }

  setUpAll(() async {
    if (await hasGasCoin()) return;
    final faucet = Dio(BaseOptions(validateStatus: (_) => true));
    for (var i = 0; i < 8; i++) {
      final r = await faucet.post(
        'https://faucet.testnet.sui.io/v2/gas',
        data: {
          'FixedAmountRequest': {'recipient': address}
        },
      );
      if (r.statusCode == 200 || r.statusCode == 202) break;
      await Future.delayed(const Duration(seconds: 20));
    }
    for (var i = 0; i < 40; i++) {
      if (await hasGasCoin()) return;
      await Future.delayed(const Duration(seconds: 3));
    }
    fail('faucet did not deliver coins in time');
  });

  test('signAndExecuteTransaction: self-transfer (auto gas)', () async {
    final txb = Transaction();
    final coin = txb.splitCoins(txb.gas, [txb.pureInt(1000000)]);
    txb.transferObjects([coin], txb.pureAddress(address));

    final executed = await client.signAndExecuteTransaction(account, txb);
    print('transfer: digest=${executed.digest} '
        'status=${executed.effects.status.success}');
    expect(executed.effects.status.success, isTrue,
        reason: 'execution failed: ${executed.effects.status.error}');
  }, timeout: const Timeout(Duration(minutes: 3)));

  test('signAndExecuteTransaction: moveCall with object arg (&Clock)',
      () async {
    // Exercises the builder's gRPC-backed resolution:
    //  - getNormalizedMoveFunction: 0x2::clock::timestamp_ms takes &Clock
    //  - multiGetObjects: resolve 0x6 as a shared object (initialSharedVersion)
    final txb = Transaction();
    txb.moveCall('0x2::clock::timestamp_ms', arguments: [txb.object(clock)]);

    final executed = await client.signAndExecuteTransaction(account, txb);
    print('moveCall: digest=${executed.digest} '
        'status=${executed.effects.status.success}');
    expect(executed.effects.status.success, isTrue,
        reason: 'execution failed: ${executed.effects.status.error}');
  }, timeout: const Timeout(Duration(minutes: 3)));
}
