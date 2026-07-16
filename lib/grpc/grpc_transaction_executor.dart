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

    if (gasBudget != null) {
      tx.setGasPayment([await _selectGasCoin(sender)]);
      tx.setGasBudget(gasBudget);
      return tx.build(buildOptions);
    }

    // Estimate gas the way Mysten's TS SDK does: dry-run with a fixed MAX_GAS
    // budget and an EMPTY gas payment, so the estimate isn't constrained by any
    // single coin's balance. Pinning a coin and capping the budget at the
    // balance breaks a partial transfer that splits SUI off the gas coin, since
    // (budget + split) must fit in that one coin. An explicit empty payment
    // skips the builder's coin auto-selection; the server picks gas for the dry
    // run (doGasSelection). The real coin + computed budget are set afterwards.
    tx.setGasPayment(<SuiObjectRef>[]);
    tx.setGasBudget(BigInt.from(50000000000)); // 50 SUI (matches TS MAX_GAS)
    final sim = await simulateTransaction(await tx.build(buildOptions));
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

    tx.setGasPayment([await _selectGasCoin(sender)]);
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
