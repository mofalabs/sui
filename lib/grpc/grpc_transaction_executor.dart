import 'dart:convert';
import 'dart:typed_data';

import '../builder/transaction.dart';
import '../sui_account.dart';
import '../types/objects.dart';
import 'grpc_builder_adapter.dart';
import 'grpc_core_client.dart';
import 'proto/sui/rpc/v2/executed_transaction.pb.dart';

/// Automates gas preparation for the gRPC path so a [Transaction] can be built,
/// signed and executed without a legacy JSON-RPC client.
///
/// Fills, when unset:
///  - gas price   -> `getReferenceGasPrice`
///  - gas payment -> a `Coin<SUI>` from `listOwnedObjects`
///  - gas budget  -> estimated from a `simulateTransaction` dry run
///
/// Object resolution for `moveCall` arguments (the builder's client-backed
/// `resolveObjectReferences`) is out of scope here; provide fully-resolved
/// object references for those cases.
extension GrpcTransactionExecutor on GrpcCoreClient {
  /// Extra headroom over the simulated computation cost.
  static final BigInt _safeOverhead = BigInt.from(1000);

  /// Select a `Coin<SUI>` owned by [owner] to pay for gas.
  Future<SuiObjectRef> _selectGasCoin(String owner) async {
    final owned = await listOwnedObjects(
      owner,
      objectType: '0x2::coin::Coin<0x2::sui::SUI>',
      readMask: const ['object_id', 'version', 'digest', 'object_type'],
      pageSize: 10,
    );
    if (owned.objects.isEmpty) {
      throw StateError('No Coin<SUI> owned by $owner to pay for gas');
    }
    final o = owned.objects.first;
    return SuiObjectRef(o.digest, o.objectId, o.version.toInt());
  }

  /// Prepare [tx] (sender, gas price/payment/budget) and return the built
  /// TransactionData BCS bytes, ready to sign.
  Future<Uint8List> prepareTransaction(
    Transaction tx, {
    required String sender,
    BigInt? gasBudget,
  }) async {
    // The adapter lets the builder resolve object references and moveCall
    // signatures over gRPC; offline limits avoid a protocol-config fetch.
    final buildOptions = BuildOptions(
      client: GrpcBuilderAdapter(this),
      limits: <String, dynamic>{},
    );

    // Resolve any Move Registry (`@org/app`) names in moveCall targets/types.
    await tx.resolveNames(
      resolvePackage: resolvePackage,
      resolveType: resolveType,
    );

    tx.setSenderIfNotSet(sender);

    final gasPrice = BigInt.from((await getReferenceGasPrice()).toInt());
    tx.setGasPrice(gasPrice);

    final gasCoin = await _selectGasCoin(sender);
    tx.setGasPayment([gasCoin]);

    if (gasBudget != null) {
      tx.setGasBudget(gasBudget);
      return tx.build(buildOptions);
    }

    // Estimate budget by simulating. The provisional budget must (a) not exceed
    // the gas coin's balance and (b) leave room for amounts the transaction
    // splits off the gas coin. Use a modest cap; callers moving large amounts
    // from gas should pass an explicit [gasBudget].
    final suiBalance = BigInt.from((await getBalance(sender)).balance.toInt());
    final provisionalCap = BigInt.from(100000000); // 0.1 SUI
    tx.setGasBudget(suiBalance < provisionalCap ? suiBalance : provisionalCap);
    final provisional = await tx.build(buildOptions);
    final sim = await simulateTransaction(provisional);
    final status = sim.transaction.effects.status;
    if (!status.success) {
      throw StateError('Gas estimation simulation failed: ${status.error}');
    }
    final gas = sim.transaction.effects.gasUsed;
    final computation = BigInt.from(gas.computationCost.toInt());
    final storage = BigInt.from(gas.storageCost.toInt());
    final rebate = BigInt.from(gas.storageRebate.toInt());
    final base = computation + _safeOverhead * gasPrice;
    final withStorage = base + storage - rebate;
    final budget = withStorage > base ? withStorage : base;

    tx.setGasBudget(budget);
    return tx.build(buildOptions);
  }

  /// Prepare, sign and execute [tx] in one call.
  Future<ExecutedTransaction> signAndExecuteTransaction(
    SuiAccount signer,
    Transaction tx, {
    BigInt? gasBudget,
    List<String>? readMask,
  }) async {
    final bytes = await prepareTransaction(
      tx,
      sender: signer.getAddress(),
      gasBudget: gasBudget,
    );
    final signed = signer.keyPair.signTransactionBlock(bytes);
    return executeTransaction(
      bytes,
      [Uint8List.fromList(base64Decode(signed.signature))],
      readMask: readMask,
    );
  }
}
