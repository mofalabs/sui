import 'package:flutter_test/flutter_test.dart';
import 'package:sui/builder/transaction.dart';
import 'package:sui/grpc/sui_grpc_client.dart';
import 'package:sui/sui.dart';

import 'package:sui/grpc/proto/sui/rpc/v2/owner.pb.dart';

/// Party (consensus-address-owned) objects must enter transactions as
/// SharedObject inputs with the owner's start version — the adapter maps
/// `CONSENSUS_ADDRESS` like `SHARED`, mirroring the TS core-resolver. The old
/// `AddressOwner` mapping made the builder emit an owned-object ref, which the
/// node rejects for consensus objects.
///
/// No party objects exist on public testnet to borrow, so the test creates its
/// own: party-transfer a freshly split coin to the stable test account, then
/// use it as a transaction input through devInspect and estimateGas.
///
/// Shares the stable faucet-funded account with grpc_execute_test.dart — when
/// running multiple test files together, run sequentially (-j 1) so two
/// transactions don't race on the same gas coin version.
///
/// Run with: flutter test test/grpc_party_object_test.dart
void main() {
  final client = SuiGrpcClient(network: SuiNetwork.testnet);
  final compat = SuiGrpcCompat(SuiNetwork.testnet);

  const testPrivKey =
      'suiprivkey1qrhwmd5a92dkdym3mp3ldk9w6pr94xrkku6yp5lm97kv4dnvp30njag85ke';
  final account = SuiAccount.fromPrivateKey(testPrivKey);
  final address = account.getAddress();

  test('party-transferred coin resolves as a consensus (shared-form) input',
      () async {
    // 1. Create a party object: split a tiny coin and party-transfer it to
    //    ourselves (single-owner party).
    final txb = Transaction();
    final coin = txb.splitCoins(txb.gas, [txb.pureInt(1000000)]);
    final party = txb.moveCall('0x2::party::single_owner',
        arguments: [txb.pureAddress(address)]);
    txb.moveCall(
      '0x2::transfer::public_party_transfer',
      typeArguments: ['0x2::coin::Coin<0x2::sui::SUI>'],
      arguments: [coin, party],
    );

    final executed = await client.signAndExecuteTransaction(account, txb);
    expect(executed.effects.status.success, isTrue,
        reason: 'party transfer failed: ${executed.effects.status.error}');

    final createdId = executed.effects.changedObjects
        .firstWhere((co) => co.idOperation.value == 2)
        .objectId;
    print('party coin=$createdId digest=${executed.digest}');

    // 2. The created coin must be consensus-address-owned. Wait out read-node
    //    indexing lag before the object becomes visible.
    await client.waitForTransaction(executed.digest,
        timeout: const Duration(seconds: 30), readMask: const ['digest']);
    late dynamic obj;
    for (var i = 0;; i++) {
      try {
        obj = await client.core
            .getObject(createdId, readMask: const ['object_id', 'owner']);
        break;
      } catch (_) {
        if (i >= 20) rethrow;
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    print('ownerKind=${obj.owner.kind} startVersion=${obj.owner.version}');
    expect(obj.owner.kind, Owner_OwnerKind.CONSENSUS_ADDRESS);

    // 3. Use it as a transaction input: read-only moveCall via devInspect.
    final inspectTx = Transaction();
    inspectTx.moveCall(
      '0x2::coin::value',
      typeArguments: ['0x2::sui::SUI'],
      arguments: [inspectTx.object(createdId)],
    );
    final inspect = await compat.devInspectTransactionBlock(address, inspectTx);
    print('devInspect status=${inspect.effects.status.status}');
    expect(inspect.effects.status.status, ExecutionStatusType.success);

    // 4. And through estimateGas (build + simulate with gas selection).
    final estimateTx = Transaction();
    estimateTx.moveCall(
      '0x2::coin::value',
      typeArguments: ['0x2::sui::SUI'],
      arguments: [estimateTx.object(createdId)],
    );
    final budget = await compat.estimateGas(estimateTx, address);
    print('estimate budget=$budget');
    expect(budget, greaterThan(BigInt.zero));
  }, timeout: const Timeout(Duration(minutes: 3)));
}
