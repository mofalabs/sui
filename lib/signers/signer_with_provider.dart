
import 'dart:typed_data';

import 'package:sui/cryptography/publickey.dart';
import 'package:sui/providers/json_rpc_provider.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/txn_data_serializers/rpc_txn_data_serializer.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/types/coins.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/framework.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';
import 'package:sui/utils/sha.dart';

/// Pair of signature and corresponding public key
class SignaturePubkeyPair {
  SignatureScheme signatureScheme;
  Base64DataBuffer signature;
  PublicKey pubKey;

  SignaturePubkeyPair(this.signatureScheme, this.signature, this.pubKey);
}

// This is currently hardcoded with [IntentScope::TransactionData = 0, Version::V0 = 0, AppId::Sui = 0]
const INTENT_BYTES = [0, 0, 0];

abstract class SignerWithProvider {
  late final JsonRpcProvider provider;
  late final TxnDataSerializer serializer;

  SignerWithProvider(String endpoint, [TxnDataSerializer? serializer]) {
    provider = JsonRpcProvider(endpoint);
    this.serializer =
      serializer ?? RpcTxnDataSerializer(provider.endpoint);
  }

  SuiAddress getAddress();

  SignaturePubkeyPair signData(Base64DataBuffer data);

  /// Sign a transaction and submit to the Fullnode for execution. Only exists on Fullnode
  Future<SuiExecuteTransactionResponse> signAndExecuteTransaction(
    Base64DataBuffer transaction,
    [ExecuteTransaction requestType = ExecuteTransaction.WaitForLocalExecution]
  ) async {
      final intentMessage = <int>[];
      intentMessage.addAll(INTENT_BYTES);
      intentMessage.addAll(transaction.getData());
      final digest = blake2b(intentMessage);
      final dataToSign = Base64DataBuffer(digest);
      final sig = signData(dataToSign);
      return await provider.executeTransaction(
        transaction,
        sig.signatureScheme,
        sig.signature,
        sig.pubKey,
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

  Future<DryRunTransactionBlockResponse> dryRunTransaction<T>(T tx) async {
    final address = getAddress();
    Base64DataBuffer dryRunTxBytes;
    if (tx is Uint8List) {
      dryRunTxBytes = Base64DataBuffer(tx);
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
    } else {
      throw ArgumentError("Error, unknown transaction kind ${tx.runtimeType}. Can't dry run transaction.");
    }
    return provider.dryRunTransaction(dryRunTxBytes.toString());
  }

  Future<List<SuiObjectInfo>> getOwnedObjects(String address) async {
    return await provider.getOwnedObjects(address);
  }

  Future<List<SuiObjectInfo>> getGasObjectsOwnedByAddress(String address) async {
    return await provider.getGasObjectsOwnedByAddress(address);
  }

  Future<CoinBalance> getBalance(String address) async {
    return await provider.getBalance(address);
  }

  Future<List<CoinBalance>> getAllBalance(String address) async {
    return await provider.getAllBalance(address);
  }

  Future<PaginatedCoins> getCoins(String address) async {
    return await provider.getCoins(address);
  }

  Future<PaginatedCoins> getAllCoins(String address) async {
    return await provider.getAllCoins(address);
  }

  Future<CoinMetadataStruct> getCoinMetadata(String coinType) async {
    return await provider.getCoinMetadata(coinType);
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
    final gasUsed = txEffects.effects.gasUsed;
    final gasEstimation = gasUsed.computationCost + gasUsed.storageCost;
    return gasEstimation;
  }

}
