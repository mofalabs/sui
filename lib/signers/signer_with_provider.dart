
import 'dart:typed_data';

import 'package:sui/cryptography/publickey.dart';
import 'package:sui/providers/json_rpc_provider.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/txn_data_serializers/rpc_txn_data_serializer.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/transactions.dart';

/// Pair of signature and corresponding public key
class SignaturePubkeyPair {
  SignatureScheme signatureScheme;
  Base64DataBuffer signature;
  PublicKey pubKey;

  SignaturePubkeyPair(this.signatureScheme, this.signature, this.pubKey);
}

abstract class SignerWithProvider {
  late final JsonRpcProvider provider;
  late final TxnDataSerializer serializer;

  SignerWithProvider(String endpoint, [bool skipDataValidation = true, TxnDataSerializer? serializer]) {
    provider = JsonRpcProvider(endpoint);
    this.serializer =
      serializer ?? RpcTxnDataSerializer(provider.endpoint, provider.skipDataValidation);
  }

  SuiAddress getAddress();

  SignaturePubkeyPair signData(Base64DataBuffer data);

  /// Sign a transaction and submit to the Fullnode for execution. Only exists on Fullnode
  Future<SuiExecuteTransactionResponse> signAndExecuteTransaction(
    Base64DataBuffer transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
      final sig = signData(transaction);
      return await provider.executeTransaction(
        transaction.toString(),
        sig.signatureScheme,
        sig.signature.toString(),
        sig.pubKey.toString(),
        requestType
      );
  }

  Future<SuiExecuteTransactionResponse> signAndExecuteSignableTransaction(
    SignableTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    switch (transaction.kind) {
      case UnserializedSignableTransaction.bytes:
        return await signAndExecuteTransaction(
          Base64DataBuffer(transaction.data),
          requestType
        );
      case UnserializedSignableTransaction.moveCall:
        return executeMoveCall(
          transaction.data,
          requestType
        );
      case UnserializedSignableTransaction.transferSui:
        return transferSui(transaction.data, requestType);
      case UnserializedSignableTransaction.transferObject:
        return transferObject(
          transaction.data,
          requestType
        );
      case UnserializedSignableTransaction.mergeCoin:
        return mergeCoin(transaction.data, requestType);
      case UnserializedSignableTransaction.splitCoin:
        return splitCoin(transaction.data, requestType);
      case UnserializedSignableTransaction.pay:
        return pay(transaction.data, requestType);
      case UnserializedSignableTransaction.paySui:
        return paySui(transaction.data, requestType);
      case UnserializedSignableTransaction.payAllSui:
        return payAllSui(transaction.data, requestType);
      case UnserializedSignableTransaction.publish:
        return publish(transaction.data, requestType);
      default:
        throw ArgumentError(
          'Error, unknown transaction kind: "${transaction.kind}"'
        );
    }
  }

  Future<TransactionEffects> dryRunTransaction<T>(T tx) async {
    final address = getAddress();
    Base64DataBuffer dryRunTxBytes;
    if (tx is Uint8List) {
      dryRunTxBytes = Base64DataBuffer(tx);
    } else if (tx is MergeCoinTransaction) {
      dryRunTxBytes = await serializer.newMergeCoin(address, tx);
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
    } else if (tx is SplitCoinTransaction) {
      dryRunTxBytes = await serializer.newSplitCoin(address, tx);
    } else if (tx is TransferObjectTransaction) {
      dryRunTxBytes = await serializer.newTransferObject(address, tx);
    } else if (tx is TransferSuiTransaction) {
      dryRunTxBytes = await serializer.newTransferSui(address, tx);
    } else {
      throw ArgumentError("Error, unknown transaction kind ${tx.runtimeType}. Can't dry run transaction.");
    }
    return provider.dryRunTransaction(dryRunTxBytes.toString());
  }

  Future<SuiExecuteTransactionResponse> transferObject(
    TransferObjectTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newTransferObject(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  Future<SuiExecuteTransactionResponse> transferSui(
    TransferSuiTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newTransferSui(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  Future<SuiExecuteTransactionResponse> pay(
    PayTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPay(signerAddress, transaction);
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  Future<SuiExecuteTransactionResponse> paySui(
    PaySuiTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPaySui(signerAddress, transaction);
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  Future<SuiExecuteTransactionResponse> payAllSui(
    PayAllSuiTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPayAllSui(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  Future<SuiExecuteTransactionResponse> mergeCoin(
    MergeCoinTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newMergeCoin(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  Future<SuiExecuteTransactionResponse> splitCoin(
    SplitCoinTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newSplitCoin(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  Future<SuiExecuteTransactionResponse> executeMoveCall(
    MoveCallTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newMoveCall(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  Future<SuiExecuteTransactionResponse> publish(
    PublishTransaction transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPublish(
      signerAddress,
      transaction
    );
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  /// Returns the estimated gas cost for the transaction,
  /// throw whens fails to estimate the gas cost.
  Future<int> getGasCostEstimation<T>(T tx) async {
    final txEffects = await dryRunTransaction(tx);
    final gasUsed = txEffects.gasUsed;
    final gasEstimation = gasUsed.computationCost + gasUsed.storageCost;
    return gasEstimation;
  }

}
