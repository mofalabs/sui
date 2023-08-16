import 'dart:convert';
import 'dart:typed_data';

import 'package:sui/rpc/client.dart';
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
  Future<Uint8List> newMoveCall(
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
    return base64Decode(resp['txBytes']);
  }

  @override
  Future<Uint8List> newPublish(
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
    return base64Decode(resp['txBytes']);
  }

  @override
  Future<Uint8List> newTransferObject(
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
    return base64Decode(resp['txBytes']);
  }

  @override
  Future<Uint8List> newTransferSui(
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
    return base64Decode(resp['txBytes']);
  }

  @override
  Future<Uint8List> newPay(
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
    return base64Decode(resp['txBytes']);
  }

  @override
  Future<Uint8List> newPaySui(
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
    return base64Decode(resp['txBytes']);
  }


  @override
  Future<Uint8List> newPayAllSui(
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
    return base64Decode(resp['txBytes']);
  }

  @override
  Future<Uint8List> newAddStake(
      SuiAddress signerAddress,
      AddStakeTransaction txn
      ) async {
    final resp = await client.request(
        'unsafe_requestAddStake',
        [
          signerAddress,
          txn.coins,
          txn.amount.toString(),
          txn.validator,
          txn.gasPayment,
          txn.gasBudget.toString()
        ]
    );
    return base64Decode(resp['txBytes']);
  }

  @override
  Future<Uint8List> newWithdrawStake(SuiAddress signerAddress,
      WithdrawStakeTransaction txn) async {
    final resp = await client.request(
        'unsafe_requestWithdrawStake',
        [
          signerAddress,
          txn.stakeSui,
          txn.gasPayment,
          txn.gasBudget.toString()
        ]
    );
    return base64Decode(resp['txBytes']);
  }

  @override
  Future<Uint8List> newSplitCoin(SuiAddress signerAddress,
      SplitCoinTransaction txn) async {
    final resp = await client.request(
        'unsafe_splitCoin',
        [
          signerAddress,
          txn.coinObjectId,
          txn.splitAmounts.map((e) => e.toString()).toList(),
          txn.gasPayment,
          txn.gasBudget.toString()
        ]
    );
    return base64Decode(resp['txBytes']);
  }

  @override
  Future<Uint8List> newSplitCoinEqual(SuiAddress signerAddress,
      SplitCoinEqualTransaction txn) async {
    final resp = await client.request(
        'unsafe_splitCoinEqual',
        [
          signerAddress,
          txn.splitCount.toString(),
          txn.gasPayment,
          txn.gasBudget.toString()
        ]
    );
    return base64Decode(resp['txBytes']);
  }
}


