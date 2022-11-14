
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
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
  ) async {
      final sig = signData(transaction);
      return await provider.executeTransactionWithRequestType(
        transaction.toString(),
        sig.signatureScheme,
        sig.signature.toString(),
        sig.pubKey.toString(),
        requestType
      );
  }

  /// Sign a transaction and submit to the Fullnode for execution. Only exists on Fullnode
  Future<SuiExecuteTransactionResponse> signAndExecuteTransactionWithRequestType(
    SignableTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
  ) async {
    switch (transaction.kind) {
      case UnserializedSignableTransaction.bytes:
        return await signAndExecuteTransaction(transaction.data);
      case UnserializedSignableTransaction.moveCall:
        return executeMoveCallWithRequestType(
          transaction.data,
          requestType
        );
      case UnserializedSignableTransaction.transferSui:
        return transferSuiWithRequestType(transaction.data, requestType);
      case UnserializedSignableTransaction.transferObject:
        return transferObjectWithRequestType(
          transaction.data,
          requestType
        );
      case UnserializedSignableTransaction.mergeCoin:
        return mergeCoinWithRequestType(transaction.data, requestType);
      case UnserializedSignableTransaction.splitCoin:
        return splitCoinWithRequestType(transaction.data, requestType);
      case UnserializedSignableTransaction.pay:
        return payWithRequestType(transaction.data, requestType);
      case UnserializedSignableTransaction.paySui:
        return paySuiWithRequestType(transaction.data, requestType);
      case UnserializedSignableTransaction.payAllSui:
        return payAllSuiWithRequestType(transaction.data, requestType);
      case UnserializedSignableTransaction.publish:
        return publishWithRequestType(transaction.data, requestType);
      default:
        throw ArgumentError(
          'Unknown transaction kind: "${transaction.kind}"'
        );
    }
  }

  /// Serialize and sign a `TransferObject` transaction and submit to the Fullnode for execution
  Future<SuiExecuteTransactionResponse> transferObjectWithRequestType(
    TransferObjectTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
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

  /// Serialize and sign a `TransferSui` transaction and submit to the Fullnode for execution
  Future<SuiExecuteTransactionResponse> transferSuiWithRequestType(
    TransferSuiTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
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

  /// Serialize and Sign a `Pay` transaction and submit to the fullnode for execution
  Future<SuiExecuteTransactionResponse> payWithRequestType(
    PayTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPay(signerAddress, transaction);
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  /// Serialize and Sign a `PaySui` transaction and submit to the fullnode for execution
  Future<SuiExecuteTransactionResponse> paySuiWithRequestType(
    PaySuiTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
  ) async {
    final signerAddress = getAddress();
    final txBytes = await serializer.newPaySui(signerAddress, transaction);
    return await signAndExecuteTransaction(
      txBytes,
      requestType
    );
  }

  /// Serialize and Sign a `PayAllSui` transaction and submit to the fullnode for execution
  Future<SuiExecuteTransactionResponse> payAllSuiWithRequestType(
    PayAllSuiTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
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

  /// Serialize and sign a `MergeCoin` transaction and submit to the Fullnode for execution
  Future<SuiExecuteTransactionResponse> mergeCoinWithRequestType(
    MergeCoinTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
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

  /// Serialize and sign a `SplitCoin` transaction and submit to the Fullnode for execution
  Future<SuiExecuteTransactionResponse> splitCoinWithRequestType(
    SplitCoinTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
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

  /// Serialize and sign a `MoveCall` transaction and submit to the Fullnode for execution
  Future<SuiExecuteTransactionResponse> executeMoveCallWithRequestType(
    MoveCallTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
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

  /// Serialize and sign a `Publish` transaction and submit to the Fullnode for execution
  Future<SuiExecuteTransactionResponse> publishWithRequestType(
    PublishTransaction transaction,
    [ExecuteTransactionRequestType requestType = ExecuteTransactionRequestType.WaitForLocalExecution]
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
}
