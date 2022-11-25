

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

  RpcTxnDataSerializer(String endpoint) {
    client = JsonRpcClient(endpoint);
  }

  @override
  Future<Base64DataBuffer> newMoveCall(
    SuiAddress signerAddress, 
    MoveCallTransaction txn
  ) async {
    try {
      final resp = await client.request(
        'sui_moveCall',
        [
          signerAddress,
          txn.packageObjectId,
          txn.module,
          txn.function,
          txn.typeArguments,
          txn.arguments,
          txn.gasPayment,
          txn.gasBudget,
        ]
      );
      return Base64DataBuffer.fromBase64String(resp['txBytes']);
    } catch (err) {
      throw ArgumentError(
        'Error executing a move call: $err with args $txn'
      );
    }
  }

  @override
  Future<Base64DataBuffer> newPublish(
    SuiAddress signerAddress, 
    PublishTransaction txn
  ) async {
    try {
      final resp = await client.request(
        'sui_publish',
        [
          signerAddress, 
          txn.compiledModules, 
          txn.gasPayment, 
          txn.gasBudget
        ]
      );
      return Base64DataBuffer.fromBase64String(resp['txBytes']);
    } catch (err) {
      throw ArgumentError('Error publishing package $err');
    }
  }

  @override
  Future<Base64DataBuffer> newTransferObject(
    SuiAddress signerAddress, 
    TransferObjectTransaction txn
  ) async {
    try {
      final resp = await client.request(
        'sui_transferObject',
        [
          signerAddress, 
          txn.objectId, 
          txn.gasPayment, 
          txn.gasBudget, 
          txn.recipient
        ]
      );
      return Base64DataBuffer.fromBase64String(resp['txBytes']);
    } catch (err) {
      throw ArgumentError(
        'Error transferring object: $err with args $txn'
      );
    }
  }

  @override
  Future<Base64DataBuffer> newTransferSui(
    SuiAddress signerAddress,
    TransferSuiTransaction txn
  ) async {
    try {
      final resp = await client.request(
        'sui_transferSui',
        [
          signerAddress, 
          txn.suiObjectId, 
          txn.gasBudget, 
          txn.recipient, 
          txn.amount
        ]
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


