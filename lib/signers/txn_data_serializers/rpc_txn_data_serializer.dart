

import 'dart:convert';

import 'package:sui/rpc/client.dart';
import 'package:sui/serialization/base64_buffer.dart';
import 'package:sui/signers/txn_data_serializers/txn_data_serializer.dart';
import 'package:sui/types/common.dart';

/// This is a temporary implementation of the `TxnDataSerializer` class
/// that uses the Sui Fullnode RPC API to serialize a transaction into BCS bytes. We will
/// deprecate this implementation once `LocalTxnDataSerializer` stabilizes.
///
/// Prefer to use `LocalTxnDataSerializer` instead for better performance and safety, otherwise
/// this needs to be used with a trusted fullnode and it is recommended to verify the returned
/// BCS bytes matches the input.
class RpcTxnDataSerializer with TxnDataSerializer {
  late JsonRpcClient client;
  late bool skipDataValidation;

  RpcTxnDataSerializer(String endpoint, [bool skipDataValidation = false]) {
    client = JsonRpcClient(endpoint);
    this.skipDataValidation = skipDataValidation;
  }

  @override
  Future<Base64DataBuffer> newMergeCoin(SuiAddress signerAddress, MergeCoinTransaction txn) {
    // TODO: implement newMergeCoin
    throw UnimplementedError();
  }

  @override
  Future<Base64DataBuffer> newMoveCall(SuiAddress signerAddress, MoveCallTransaction txn) {
    // TODO: implement newMoveCall
    throw UnimplementedError();
  }

  @override
  Future<Base64DataBuffer> newPublish(SuiAddress signerAddress, PublishTransaction txn) {
    // TODO: implement newPublish
    throw UnimplementedError();
  }

  @override
  Future<Base64DataBuffer> newSplitCoin(SuiAddress signerAddress, SplitCoinTransaction txn) {
    // TODO: implement newSplitCoin
    throw UnimplementedError();
  }

  @override
  Future<Base64DataBuffer> newTransferObject(SuiAddress signerAddress, TransferObjectTransaction txn) {
    // TODO: implement newTransferObject
    throw UnimplementedError();
  }

  @override
  Future<Base64DataBuffer> newTransferSui(
    SuiAddress signerAddress,
    TransferSuiTransaction txn
  ) async {
    try {
      final resp = await client.request(
        'sui_transferSui',
        [signerAddress, txn.suiObjectId, txn.gasBudget, txn.recipient, txn.amount],
        skipDataValidation
      );
      return Base64DataBuffer.fromBase64String(resp['txBytes']);
    } catch (err) {
      throw ArgumentError('Error transferring Sui coin: $err');
    }
  }

  @override
  Future<Base64DataBuffer> newPay(
    SuiAddress signerAddress, 
    PayTransaction txn
  ) async {
    try {
      final resp = await client.request(
        'sui_pay',
        [
          signerAddress,
          txn.inputCoins,
          txn.recipients,
          txn.amounts,
          txn.gasPayment,
          txn.gasBudget,
        ],
      );
      return Base64DataBuffer.fromBase64String(resp['txBytes']);
    } catch (err) {
      throw ArgumentError('Error executing Pay transaction: $err}');
    }
  }

  @override
  Future<Base64DataBuffer> newPaySui(
    SuiAddress signerAddress, 
    PaySuiTransaction txn
  ) async {
    try {
      final resp = await client.request(
        'sui_paySui',
        [
          signerAddress, 
          txn.inputCoins, 
          txn.recipients, 
          txn.amounts, 
          txn.gasBudget
        ]
      );
      return Base64DataBuffer.fromBase64String(resp['txBytes']);
    } catch (err) {
      throw ArgumentError('Error executing PaySui transaction: $err');
    }
  }


  @override
  Future<Base64DataBuffer> newPayAllSui(
    SuiAddress signerAddress, 
    PayAllSuiTransaction txn
  ) async {
    try {
      final resp = await client.request(
        'sui_payAllSui',
        [
          signerAddress, 
          txn.inputCoins, 
          txn.recipient, 
          txn.gasBudget
        ]
      );
      return Base64DataBuffer.fromBase64String(resp['txBytes']);
    } catch (err) {
      throw ArgumentError('Error executing PayAllSui transaction: $err');
    }
  }
    
}


