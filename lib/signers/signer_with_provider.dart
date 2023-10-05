
import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/cryptography/signature.dart';
import 'package:sui/providers/json_rpc_provider.dart';
import 'package:sui/rpc/client.dart';
import 'package:sui/signers/txn_data_serializers/rpc_txn_data_serializer.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/sui_account.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';
import 'package:sui/utils/sha.dart';

/// Pair of signature and corresponding public key
class SignaturePubkeyPair {
  SignatureScheme signatureScheme;
  Uint8List signature;
  dynamic pubKey;
  dynamic zkLogin;

  SignaturePubkeyPair(this.signatureScheme, this.signature, {this.pubKey, this.zkLogin});
}

// This is currently hardcoded with [IntentScope::TransactionData = 0, Version::V0 = 0, AppId::Sui = 0]
const INTENT_BYTES = [0, 0, 0];

abstract class SignerWithProvider with JsonRpcProvider {
  late final JsonRpcClient rpcClient;
  late final TxnDataSerializer serializer;

  SignerWithProvider(String endpoint, [TxnDataSerializer? serializer]) {
    rpcClient = JsonRpcClient(endpoint);
    this.serializer =
      serializer ?? RpcTxnDataSerializer(endpoint);
  }


  @override
  JsonRpcClient get client => rpcClient;

  void setSigner(SuiAccount signer);

  SuiAddress getAddress();

  SignaturePubkeyPair signData(Uint8List data);

  /// Sign a transaction and submit to the Fullnode for execution. Only exists on Fullnode
  Future<SuiExecuteTransactionResponse> signAndExecuteTransaction({
    required Uint8List transaction,
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution
  }) async {
      final intentMessage = <int>[];
      intentMessage.addAll(INTENT_BYTES);
      intentMessage.addAll(transaction);
      final digest = blake2b(intentMessage);
      final sig = signData(digest);
      return await executeTransaction(
        txnBytes: transaction,
        signatureScheme: sig.signatureScheme,
        signature: sig.signature,
        pubkey: sig.pubKey,
        requestType: requestType
      );
  }

  Future<SuiExecuteTransactionResponse> signAndExecuteSignableTransaction({
    required SignableTransaction transaction,
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution
  }) async {
    switch (transaction.kind) {
      case UnserializedSignableTransaction.bytes:
        return await signAndExecuteTransaction(
          transaction: Uint8List.fromList(transaction.data),
          options: options,
          requestType: requestType
        );
      case UnserializedSignableTransaction.moveCall:
        return executeMoveCall(
          transaction.data,
          options: options,
          requestType: requestType
        );
      case UnserializedSignableTransaction.transferSui:
        return transferSui(
          transaction.data, 
          options: options, 
          requestType: requestType
        );
      case UnserializedSignableTransaction.transferObject:
        return transferObject(
          transaction.data,
          options: options,
          requestType: requestType
        );
      case UnserializedSignableTransaction.pay:
        return pay(
          transaction.data, 
          options: options, 
          requestType: requestType
        );
      case UnserializedSignableTransaction.paySui:
        return paySui(
          transaction.data, 
          options: options, 
          requestType: requestType
        );
      case UnserializedSignableTransaction.payAllSui:
        return payAllSui(
          transaction.data, 
          options: options, 
          requestType: requestType
        );
      case UnserializedSignableTransaction.publish:
        return publish(
          transaction.data, 
          options: options, 
          requestType: requestType
        );
      case UnserializedSignableTransaction.addStake:
        return addStake(
            transaction.data,
            options: options,
            requestType: requestType
        );
      case UnserializedSignableTransaction.withdrawStake:
        return withdrawStake(
            transaction.data,
            options: options,
            requestType: requestType
        );
      case UnserializedSignableTransaction.splitCoin:
        return splitCoin(
            transaction.data,
            options: options,
            requestType: requestType
        );
      case UnserializedSignableTransaction.splitCoinEqual:
        return splitCoinEqual(
            transaction.data,
            options: options,
            requestType: requestType
        );
      default:
        throw ArgumentError(
          'Error, unknown transaction kind: "${transaction.kind}"'
        );
    }
  }

  Future<DryRunTransactionBlockResponse> dryRunTransaction<T>(T tx, String? signerAddress) async {
    final address = signerAddress ?? getAddress();
    Uint8List dryRunTxBytes;
    if (tx is Uint8List) {
      dryRunTxBytes = tx;
    } else if (tx is MoveCallTransaction) {
      dryRunTxBytes = await serializer.newMoveCall(address, tx);
    } else if (tx is PayTransaction) {
      dryRunTxBytes = await serializer.newPay(address, tx);
    } else if (tx is PayAllSuiTransaction) {
      dryRunTxBytes = await serializer.newPayAllSui(address, tx);
    } else if (tx is PaySuiTransaction) {
      dryRunTxBytes = await serializer.newPaySui(address, tx);
    } else if (tx is PublishTransaction) {
      dryRunTxBytes = await serializer.newPublish(address, tx);
    } else if (tx is TransferObjectTransaction) {
      dryRunTxBytes = await serializer.newTransferObject(address, tx);
    } else if (tx is TransferSuiTransaction) {
      dryRunTxBytes = await serializer.newTransferSui(address, tx);
    } else if (tx is AddStakeTransaction) {
      dryRunTxBytes = await serializer.newAddStake(address, tx);
    } else if (tx is WithdrawStakeTransaction) {
      dryRunTxBytes = await serializer.newWithdrawStake(address, tx);
    } else if (tx is SplitCoinTransaction) {
      dryRunTxBytes = await serializer.newSplitCoin(address, tx);
    } else if (tx is SplitCoinEqualTransaction) {
      dryRunTxBytes = await serializer.newSplitCoinEqual(address, tx);
    } else {
      throw ArgumentError("Error, unknown transaction kind ${tx.runtimeType}. Can't dry run transaction.");
    }
    return dryRunTransactionBlock(base64Encode(dryRunTxBytes));
  }

  Future<PaginatedObjectsResponse> getOwnedObjectsShowAllOptions(String address, {
    Map<String,dynamic>? filter,
    int limit = 50,
    String? cursor,
  }) async {
    final options = SuiObjectDataOptions(
      showBcs: true,
      showContent: true,
      showDisplay: true,
      showOwner: true,
      showPreviousTransaction: true,
      showStorageRebate: true,
      showType: true
    );
    return await getOwnedObjects(
      address, 
      filter: filter, 
      options: options,
      limit: limit,
      cursor: cursor);
  }

  Future<SuiExecuteTransactionResponse> transferObject(
    TransferObjectTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution
  }) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newTransferObject(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType
    );
  }

  Future<SuiExecuteTransactionResponse> transferSui(
    TransferSuiTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution
  }) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newTransferSui(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType
    );
  }

  Future<SuiExecuteTransactionResponse> pay(
    PayTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution
  }) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPay(signerAddress, transaction);
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType
    );
  }

  Future<SuiExecuteTransactionResponse> paySui(
    PaySuiTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution
  }) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPaySui(signerAddress, transaction);
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType
    );
  }

  Future<SuiExecuteTransactionResponse> payAllSui(
    PayAllSuiTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution
  }) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPayAllSui(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType
    );
  }

  Future<SuiExecuteTransactionResponse> addStake(
    AddStakeTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution,
  }) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newAddStake(signerAddress, transaction);
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType,
    );
  }

  Future<SuiExecuteTransactionResponse> withdrawStake(
    WithdrawStakeTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution,
  }) async {
    final signerAddress = getAddress();
    final txBytes =
        await serializer.newWithdrawStake(signerAddress, transaction);
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType,
    );
  }

  Future<SuiExecuteTransactionResponse> splitCoin(
    SplitCoinTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution,
  }) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newSplitCoin(signerAddress, transaction);
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType,
    );
  }

  Future<SuiExecuteTransactionResponse> splitCoinEqual(
    SplitCoinEqualTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution,
  }) async {
    final signerAddress = getAddress();
    final txBytes =
        await serializer.newSplitCoinEqual(signerAddress, transaction);
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType,
    );
  }

  Future<SuiExecuteTransactionResponse> executeMoveCall(
    MoveCallTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution
  }) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newMoveCall(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType
    );
  }

  Future<SuiExecuteTransactionResponse> publish(
    PublishTransaction transaction, {
    SuiTransactionBlockResponseOptions? options,
    ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution
  }) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPublish(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      transaction: txBytes,
      options: options,
      requestType: requestType
    );
  }

  /// Returns the estimated gas cost for the transaction,
  /// throw whens fails to estimate the gas cost.
  Future<int> getGasCostEstimation<T>(T tx, [String? signerAddress]) async {
    try {
      if (signerAddress == null || signerAddress.isEmpty) {
        getAddress(); // check signer address not null
      }
    } catch (e) {
      throw ArgumentError.notNull("signerAddress");
    }

    final txEffects = await dryRunTransaction(tx, signerAddress);
    if (txEffects.effects.status.status == ExecutionStatusType.failure) {
      throw ArgumentError(txEffects.effects.status.error);
    }
    final gasUsed = txEffects.effects.gasUsed;
    final gasEstimation = gasUsed.computationCost + gasUsed.storageCost;
    return gasEstimation;
  }

}
