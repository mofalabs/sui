

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
    final resp = await client.request(
      'unsafe_moveCall',
      [
        signerAddress,
        txn.packageObjectId,
        txn.module,
        txn.function,
        txn.typeArguments,
        txn.arguments,
        txn.gasPayment,
        txn.gasBudget.toString(),
      ]
    );
    return Base64DataBuffer.fromBase64String(resp['txBytes']);
  }

  @override
  Future<Base64DataBuffer> newPublish(
    SuiAddress signerAddress, 
    PublishTransaction txn
  ) async {
    final resp = await client.request(
      'unsafe_publish',
      [
        signerAddress, 
        txn.compiledModules,
        txn.dependencies,
        txn.gasPayment, 
        txn.gasBudget.toString()
      ]
    );
    return Base64DataBuffer.fromBase64String(resp['txBytes']);
  }

  @override
  Future<Base64DataBuffer> newTransferObject(
    SuiAddress signerAddress, 
    TransferObjectTransaction txn
  ) async {
    final resp = await client.request(
      'unsafe_transferObject',
      [
        signerAddress, 
        txn.objectId, 
        txn.gasPayment, 
        txn.gasBudget.toString(),
        txn.recipient
      ]
    );
    return Base64DataBuffer.fromBase64String(resp['txBytes']);
  }

  @override
  Future<Base64DataBuffer> newTransferSui(
    SuiAddress signerAddress,
    TransferSuiTransaction txn
  ) async {
    final resp = await client.request(
      'unsafe_transferSui',
      [
        signerAddress, 
        txn.suiObjectId, 
        txn.gasBudget.toString(),
        txn.recipient, 
        txn.amount.toString()
      ]
    );
    return Base64DataBuffer.fromBase64String(resp['txBytes']);
  }

  @override
  Future<Base64DataBuffer> newPay(
    SuiAddress signerAddress, 
    PayTransaction txn
  ) async {
    final resp = await client.request(
      'unsafe_pay',
      [
        signerAddress,
        txn.inputCoins,
        txn.recipients,
        txn.amounts.map((e) => e.toString()).toList(),
        txn.gasPayment,
        txn.gasBudget.toString(),
      ],
    );
    return Base64DataBuffer.fromBase64String(resp['txBytes']);
  }

  @override
  Future<Base64DataBuffer> newPaySui(
    SuiAddress signerAddress, 
    PaySuiTransaction txn
  ) async {
    final resp = await client.request(
      'unsafe_paySui',
      [
        signerAddress, 
        txn.inputCoins, 
        txn.recipients, 
        txn.amountsStr,
        txn.gasBudget.toString()
      ]
    );
    return Base64DataBuffer.fromBase64String(resp['txBytes']);
  }


  @override
  Future<Base64DataBuffer> newPayAllSui(
    SuiAddress signerAddress, 
    PayAllSuiTransaction txn
  ) async {
    final resp = await client.request(
      'unsafe_payAllSui',
      [
        signerAddress, 
        txn.inputCoins, 
        txn.recipient, 
        txn.gasBudget.toString()
      ]
    );
    return Base64DataBuffer.fromBase64String(resp['txBytes']);
  }
    
}


