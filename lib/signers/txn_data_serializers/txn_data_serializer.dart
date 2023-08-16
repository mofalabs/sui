
import 'dart:typed_data';

import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';

class TransferObjectTransaction {
  ObjectId objectId;
  ObjectId? gasPayment;
  int gasBudget;
  SuiAddress recipient;

  TransferObjectTransaction(this.objectId, this.gasPayment, this.gasBudget, this.recipient);
}

class TransferSuiTransaction {
  ObjectId suiObjectId;
  int gasBudget;
  SuiAddress recipient;
  int? amount;

  TransferSuiTransaction(this.suiObjectId, this.gasBudget, this.recipient, this.amount);
}

/// Send Coin<T> to a list of addresses, where `T` can be any coin type, following a list of amounts,
/// The object specified in the `gas` field will be used to pay the gas fee for the transaction.
/// The gas object can not appear in `input_coins`. If the gas object is not specified, the RPC server
/// will auto-select one.
class PayTransaction {
  List<ObjectId> inputCoins;
  List<SuiAddress> recipients;
  List<int> amounts;
  int gasBudget;
  ObjectId? gasPayment;

  PayTransaction(this.inputCoins, this.recipients, this.amounts, this.gasBudget, [this.gasPayment]);
}

/// Send SUI coins to a list of addresses, following a list of amounts.
/// This is for SUI coin only and does not require a separate gas coin object.
/// Specifically, what pay_sui does are:
/// 1. debit each input_coin to create new coin following the order of
/// amounts and assign it to the corresponding recipient.
/// 2. accumulate all residual SUI from input coins left and deposit all SUI to the first
/// input coin, then use the first input coin as the gas coin object.
/// 3. the balance of the first input coin after tx is sum(input_coins) - sum(amounts) - actual_gas_cost
/// 4. all other input coints other than the first one are deleted.
class PaySuiTransaction {
  List<ObjectId> inputCoins;
  List<SuiAddress> recipients;
  List<int> amounts;
  int gasBudget;

  PaySuiTransaction(this.inputCoins, this.recipients, this.amounts, this.gasBudget);

  List<String> get amountsStr => amounts.map((e) => e.toString()).toList();
}

/// Send all SUI coins to one recipient.
/// This is for SUI coin only and does not require a separate gas coin object.
/// Specifically, what pay_all_sui does are:
/// 1. accumulate all SUI from input coins and deposit all SUI to the first input coin
/// 2. transfer the updated first coin to the recipient and also use this first coin as gas coin object.
/// 3. the balance of the first input coin after tx is sum(input_coins) - actual_gas_cost.
/// 4. all other input coins other than the first are deleted.
class PayAllSuiTransaction {
  List<ObjectId> inputCoins;
  SuiAddress recipient;
  int gasBudget;

  PayAllSuiTransaction(this.inputCoins, this.recipient, this.gasBudget);
}

class MoveCallTransaction {
  ObjectId packageObjectId;
  String module;
  String function;
  List<dynamic> typeArguments;
  List<dynamic> arguments;
  int gasBudget;
  ObjectId? gasPayment;

  MoveCallTransaction(
    this.packageObjectId,
    this.module,
    this.function,
    this.typeArguments,
    this.arguments,
    this.gasBudget,
    [this.gasPayment]
  );
}

enum UnserializedSignableTransaction {
  moveCall,  // MoveCallTransaction
  transferSui,  // TransferSuiTransaction
  transferObject,  // TransferObjectTransaction
  pay,  // PayTransaction
  paySui,  // PaySuiTransaction
  payAllSui,  // PayAllSuiTransaction
  publish,  // PublishTransaction
  addStake,  // AddStakeTransaction
  withdrawStake,  // WithdrawStakeTransaction
  splitCoin,  // SplitCoinTransaction
  splitCoinEqual,  // SplitCoinEqualTransaction
  bytes  // Uint8Array
}

class SignableTransaction {
  UnserializedSignableTransaction kind;
  dynamic data;

  SignableTransaction(this.kind, this.data);
}

class PublishTransaction {
  List<String> compiledModules;
  List<ObjectId> dependencies;
  int gasBudget;
  ObjectId? gasPayment;

  PublishTransaction(this.compiledModules, this.dependencies, this.gasBudget, [this.gasPayment]);
}

class AddStakeTransaction {
  List<ObjectId> coins;
  BigInt amount;
  SuiAddress validator;
  int gasBudget;
  ObjectId? gasPayment;

  AddStakeTransaction(this.coins, this.amount, this.validator, this.gasBudget,
      [this.gasPayment]);
}

class WithdrawStakeTransaction {
  ObjectId stakeSui;
  int gasBudget;
  ObjectId? gasPayment;

  WithdrawStakeTransaction(this.stakeSui, this.gasBudget, [this.gasPayment]);
}


class SplitCoinTransaction {
  ObjectId coinObjectId;
  List<BigInt> splitAmounts;
  int gasBudget;
  ObjectId? gasPayment;

  SplitCoinTransaction(this.coinObjectId, this.splitAmounts, this.gasBudget,
      [this.gasPayment]);
}

class SplitCoinEqualTransaction {
  ObjectId coinObjectId;
  BigInt splitCount;
  int gasBudget;
  ObjectId? gasPayment;

  SplitCoinEqualTransaction(this.coinObjectId, this.splitCount, this.gasBudget,
      [this.gasPayment]);
}

mixin TxnDataSerializer {
  Future<Uint8List> newTransferObject(
    SuiAddress signerAddress,
    TransferObjectTransaction txn
  );

  Future<Uint8List> newTransferSui(
    SuiAddress signerAddress,
    TransferSuiTransaction txn
  );

  Future<Uint8List> newPay(
    SuiAddress signerAddress,
    PayTransaction txn
  );

  Future<Uint8List> newPaySui(
    SuiAddress signerAddress,
    PaySuiTransaction txn
  );

  Future<Uint8List> newPayAllSui(
    SuiAddress signerAddress,
    PayAllSuiTransaction txn
  );

  Future<Uint8List> newMoveCall(
    SuiAddress signerAddress,
    MoveCallTransaction txn
  );

  Future<Uint8List> newPublish(
    SuiAddress signerAddress,
    PublishTransaction txn
  );

  Future<Uint8List> newAddStake(
    SuiAddress signerAddress,
    AddStakeTransaction txn,
  );

  Future<Uint8List> newWithdrawStake(
    SuiAddress signerAddress,
    WithdrawStakeTransaction txn,
  );

  Future<Uint8List> newSplitCoin(
    SuiAddress signerAddress,
    SplitCoinTransaction txn,
  );

  Future<Uint8List> newSplitCoinEqual(
    SuiAddress signerAddress,
    SplitCoinEqualTransaction txn,
  );
}
