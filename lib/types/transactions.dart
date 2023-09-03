
import 'package:sui/models/sui_event.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';

enum Ordering {
  Ascending, Descending
}

enum ExecuteTransaction {
  WaitForEffectsCert,
  WaitForLocalExecution
}
enum TransactionKindName {
  TransferObject,
  Publish,
  Call,
  TransferSui,
  ChangeEpoch,
  Pay,
  PaySui,
  PayAllSui
}

typedef SuiJsonValue = dynamic;

typedef TransactionEvents = List<SuiEvent>;

dynamic getTransactionKind(SuiTransactionBlockResponse data){
  return data.transaction?.data.transaction;
}

//  class TxCert {
//    CertifiedTransaction certificate;

//    TxCert(this.certificate);

//    factory TxCert.fromJson(dynamic data) {
//     return TxCert(
//       CertifiedTransaction.fromJson(data['certificate'])
//     );
//    }
// }

// class SuiCertifiedTransactionEffects {
//   TransactionEffects effects;

//   SuiCertifiedTransactionEffects(this.effects);

//   factory SuiCertifiedTransactionEffects.fromJson(dynamic data) {
//     return SuiCertifiedTransactionEffects(
//       TransactionEffects.fromJson(data['effects'])
//     );
//   }
// }

class PaginatedTransactionResponse {
  List<SuiTransactionBlockResponse> data;
  String? nextCursor;
  bool hasNextPage;

  PaginatedTransactionResponse(
    this.data,
    this.nextCursor,
    this.hasNextPage,
  );

  factory PaginatedTransactionResponse.fromJson(dynamic data) {
    List<SuiTransactionBlockResponse> list = [];
    for (var response in data['data']) {
      list.add(SuiTransactionBlockResponse.fromJson(response));
    }

    return PaginatedTransactionResponse(
      list,
      data['nextCursor'],
      data['hasNextPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'nextCursor': nextCursor,
      'hasNextPage': hasNextPage,
    };
  }
}

class SuiTransactionBlock {
  List<dynamic> txSignatures;
  SuiTransactionBlockData data;

  SuiTransactionBlock(
    this.data,
    this.txSignatures,
  );

  factory SuiTransactionBlock.fromJson(dynamic data) {
    return SuiTransactionBlock(
      SuiTransactionBlockData.fromJson(data['data']),
      data['txSignatures'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'txSignatures': txSignatures,
    };
  }
}

typedef SuiTransactionBlockResponse = SuiExecuteTransactionResponse;

class SuiExecuteTransactionResponse {
  TransactionDigest digest;
  TransactionEffects? effects;
  String? timestampMs;
  String? checkpoint;
  TransactionEvents events;
  SuiTransactionBlock? transaction;
  bool? confirmedLocalExecution;
  List<dynamic>? objectChanges;
  List<BalanceChange> balanceChanges;
  /* Errors that occurred in fetching/serializing the transaction. */
  List<dynamic>? errors;

  Map<String, dynamic> json;

  SuiExecuteTransactionResponse(
    this.digest,
    this.effects,
    this.timestampMs,
    this.checkpoint,
    this.events,
    this.transaction,
    this.confirmedLocalExecution,
    this.objectChanges,
    this.balanceChanges,
    this.errors,
    this.json,
  );

  factory SuiExecuteTransactionResponse.fromJson(dynamic data) {
    TransactionEffects? effects;
    if (data['effects'] != null) {
      effects = TransactionEffects.fromJson(data['effects']);
    }

    final events = data['events'];
    List<SuiEvent> eventsList = [];
    if (events != null) {
      for (var event in events) {
        eventsList.add(SuiEvent.fromJson(event));
      }
    }
    SuiTransactionBlock? transaction;
    if (data['transaction'] != null) {
      transaction = SuiTransactionBlock.fromJson(data['transaction']);
    }

    final balanceChanges = data['balanceChanges'];
    List<BalanceChange> balanceChangesList = [];
    if (balanceChanges != null) {
      for (var balance in balanceChanges) {
        balanceChangesList.add(BalanceChange.fromJson(balance));
      }
    }

    return SuiTransactionBlockResponse(
      data['digest'],
      effects,
      data['timestampMs'],
      data['checkpoint'],
      eventsList,
      transaction,
      data['confirmedLocalExecution'],
      data['objectChanges'],
      balanceChangesList,
      data['errors'],
      data,
    );
  }

  Map<String, dynamic> toJson() {
    return json;
  }
}

class EffectsCert {
  String transactionEffectsDigest;
  TransactionEffects effects;
  dynamic finalityInfo;

  EffectsCert(this.transactionEffectsDigest, this.effects, this.finalityInfo);

  factory EffectsCert.fromJson(dynamic data) {
    return EffectsCert(
      data['transactionEffectsDigest'],
      TransactionEffects.fromJson(data['effects']),
      data['finalityInfo']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionEffectsDigest': transactionEffectsDigest,
      'effects': effects.toJson(),
      'finalityInfo': finalityInfo
    };
  }
}

class AuthorityQuorumSignInfo {
  int epoch;
  List<String> signature;
  List<int> signersMap;

  AuthorityQuorumSignInfo(this.epoch, this.signature, this.signersMap);

  factory AuthorityQuorumSignInfo.fromJson(dynamic data) {
    final signatureData = data['signature'];
    final signatureList = <String>[];
    if (signatureData is String) {
      signatureList.add(signatureData);
    } else if (signatureData is Iterable) {
      for (var signature in signatureData) {
        signatureList.add(signature);
      }
    }

    return AuthorityQuorumSignInfo(
      data['epoch'],
      signatureList,
      (data['signers_map'] as List).cast<int>()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'epoch': epoch,
      'signature': signature,
      'signersMap': signersMap,
    };
  }
}

class TransferObject {
  SuiAddress recipient;
  SuiObjectRef objectRef;

  TransferObject(this.recipient, this.objectRef);

  factory TransferObject.fromJson(dynamic data) {
    return TransferObject(
      data['recipient'],
      SuiObjectRef.fromJson(['objectRef'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipient': recipient,
      'objectRef': objectRef.toJson(),
    };
  }
}

class SuiTransferSui {
  SuiAddress recipient;
  int? amount;

  SuiTransferSui(this.recipient, this.amount);

  factory SuiTransferSui.fromJson(dynamic data) {
    return SuiTransferSui(
      data['recipient'],
      data['amount']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipient': recipient,
      'amount': amount,
    };
  }
}

class SuiChangeEpoch {
  int epoch;
  int storageCharge;
  int computationCharge;

  SuiChangeEpoch(this.epoch, this.storageCharge, this.computationCharge);

  factory SuiChangeEpoch.fromJson(dynamic data) {
    return SuiChangeEpoch(
      data['epoch'],
      data['storage_charge'],
      data['computation_charge']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'epoch': epoch,
      'storage_charge': storageCharge,
      'computation_charge': computationCharge,
    };
  }
}

class Pay {
  List<SuiObjectRef> coins;
  List<SuiAddress> recipients;
  List<int> amounts;

  Pay(this.coins, this.recipients, this.amounts);

  factory Pay.fromJson(dynamic data) {
    final coinsList = (data['coins'] as List).map((e) => SuiObjectRef.fromJson(e)).toList();
    final recipientsList = data['recipients'].cast<String>();
    final amountsList = data['amounts'].cast<int>();
    return Pay(
      coinsList,
      recipientsList,
      amountsList
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coins': coins.map((e) => e.toJson()).toList(),
      'recipients': recipients,
      'amounts': amounts,
    };
  }
}

class PaySui {
  List<SuiObjectRef> coins;
  List<SuiAddress> recipients;
  List<int> amounts;

  PaySui(this.coins, this.recipients, this.amounts);

  factory PaySui.fromJson(dynamic data) {
    final coinsData = data['coins'];
    final coinsList = <SuiObjectRef>[];
    for (var coin in coinsData) {
      coinsList.add(SuiObjectRef.fromJson(coin));
    }

    final recipientsData = data['recipients'];
    final recipientsList = <SuiAddress>[];
    for (var recipient in recipientsData) {
      recipientsList.add(recipient);
    }

    final amountsData = data['amounts'];
    final amountsList = <int>[];
    for (var amount in amountsData) {
      amountsList.add(amount);
    }

    return PaySui(
      coinsList,
      recipientsList,
      amountsList
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coins': coins.map((e) => e.toJson()).toList(),
      'recipients': recipients,
      'amounts': amounts,
    };
  }
}

class PayAllSui {
  List<SuiObjectRef> coins;
  SuiAddress recipient;

  PayAllSui(this.coins, this.recipient);

  factory PayAllSui.fromJson(dynamic data) {
    final coinsList = (data['coins'] as List)
      .map((x) => SuiObjectRef.fromJson(x))
      .toList();

    return PayAllSui(
      coinsList,
      data['recipient']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'coins': coins.map((e) => e.toJson()).toList(),
      'recipients': recipient,
    };
  }
}

class MoveCall {
  dynamic package;
  String module;
  String function;
  List<String>? typeArguments;
  List<SuiJsonValue>? arguments;

  MoveCall(
    this.package,
    this.module,
    this.function,
    this.typeArguments,
    this.arguments
  );

  factory MoveCall.fromJson(dynamic data) {
    dynamic pkg;
    if (data['package'] is String) {
      pkg = data['package'];
    } else {
      pkg = SuiObjectRef.fromJson(data['package']);
    }
    return MoveCall(
      pkg,
      data['module'],
      data['function'],
      data['typeArguments'],
      data['arguments']
    );
  }
}

class SuiTransactionKind {
  TransferObject? transferObject;
  SuiMovePackage? publish;
  MoveCall? call;
  SuiTransferSui? transferSui;
  SuiChangeEpoch? changeEpoch;
  Pay? pay;
  PaySui? paySui;
  PayAllSui? payAllSui;

  SuiTransactionKind(
    this.transferObject,
    this.publish,
    this.call,
    this.transferSui,
    this.changeEpoch,
    this.pay,
    this.paySui,
    this.payAllSui
  );

  factory SuiTransactionKind.fromJson(dynamic data) {
    return SuiTransactionKind(
      data['TransferObject'] != null ? TransferObject.fromJson(data['TransferObject']) : null,
      data['Publish'] != null ? SuiMovePackage.fromJson(data['Publish']) : null,
      data['Call'] != null ? MoveCall.fromJson(data['Call']) : null,
      data['TransferSui'] != null ? SuiTransferSui.fromJson(data['TransferSui']) : null,
      data['ChangeEpoch'] != null ? SuiChangeEpoch.fromJson(data['ChangeEpoch']) : null,
      data['Pay'] != null ? Pay.fromJson(data['Pay']) : null,
      data['PaySui'] != null ? PaySui.fromJson(data['PaySui']) : null,
      data['PayAllSui'] != null ? PayAllSui.fromJson(data['PayAllSui']) : null
    );
  }
}

class SuiGasData {
  SuiObjectRef payment;
  int price;
  int budget;

  SuiGasData(this.payment, this.price, this.budget);

  factory SuiGasData.fromJson(dynamic data) {
    return SuiGasData(
      SuiObjectRef.fromJson(data['payment']),
      data['price'],
      data['budget']
    );
  }
}

class SuiTransactionData {
  List<SuiTransactionKind> transactions;
  SuiAddress sender;
  SuiGasData gasData;

  SuiTransactionData(
    this.transactions,
    this.sender,
    this.gasData
  );

  factory SuiTransactionData.fromJson(dynamic data) {

    final txnsKind = <SuiTransactionKind>[];
    final txns = data['transactions'];
    for (var txn in txns) {
      txnsKind.add(SuiTransactionKind.fromJson(txn));
    }

    return SuiTransactionData(
      txnsKind,
      data['sender'],
      SuiGasData.fromJson(data['gasData'])
    );
  }
}

class CertifiedTransaction {
  TransactionDigest transactionDigest;
  SuiTransactionData data;
  List<String> txSignatures;
  AuthorityQuorumSignInfo authSignInfo;

  CertifiedTransaction(
    this.transactionDigest,
    this.data,
    this.txSignatures,
    this.authSignInfo
  );

  factory CertifiedTransaction.fromJson(dynamic data) {
    return CertifiedTransaction(
      data['transactionDigest'],
      SuiTransactionData.fromJson(data['data']),
      List<String>.from(data['txSignatures']),
      AuthorityQuorumSignInfo.fromJson(data['authSignInfo'])
    );
  }

}

enum ExecutionStatusType{
  success, failure
}

class GasCostSummary {
  int computationCost;
  int storageCost;
  int storageRebate;
  int nonRefundableStorageFee;

  GasCostSummary(
    this.computationCost,
    this.storageCost,
    this.storageRebate,
    this.nonRefundableStorageFee
  );

  factory GasCostSummary.fromJson(dynamic data) {
    return GasCostSummary(
      int.parse(data['computationCost']??'0'),
      int.parse(data['storageCost']??'0'),
      int.parse(data['storageRebate']??'0'),
      int.parse(data['nonRefundableStorageFee']??'0'),
    );
  }
}

class ExecutionStatus {
  ExecutionStatusType status;
  String? error;

  ExecutionStatus(this.status, this.error);

  factory ExecutionStatus.fromJson(dynamic data) {
    return ExecutionStatus(
      ExecutionStatusType.values.byName(data['status']),
      data['error']
    );
  }
}

class OwnedObjectRef {
  ObjectOwner owner;
  SuiObjectRef reference;

  OwnedObjectRef(this.owner, this.reference);

  factory OwnedObjectRef.fromJson(dynamic data) {
    return OwnedObjectRef(
      ObjectOwner.fromJson(data['owner']),
      SuiObjectRef.fromJson(data['reference'])
    );
  }
}

class TransactionEffects {
  /// The status of the execution
  ExecutionStatus status;
  GasCostSummary gasUsed;
  /// The object references of the shared objects used in this transaction. Empty if no shared objects were used.
  List<SuiObjectRef>? sharedObjects;
  /// The transaction digest
  TransactionDigest transactionDigest;
  /// ObjectRef and owner of new objects created
  List<OwnedObjectRef>? created;
  /// ObjectRef and owner of mutated objects, including gas object
  List<OwnedObjectRef> mutated;
  /// ObjectRef and owner of objects that are unwrapped in this transaction.
  /// Unwrapped objects are objects that were wrapped into other objects in the past,
  /// and just got extracted out.
  List<OwnedObjectRef>? unwrapped;
  /// Object Refs of objects now deleted (the old refs)
  List<SuiObjectRef>? deleted;
  /// Object refs of objects now wrapped in other objects
  List<SuiObjectRef>? wrapped;
  /// The updated gas object reference. Have a dedicated field for convenient access.
  /// It's also included in mutated.
  OwnedObjectRef gasObject;
  /// The events emitted during execution. Note that only successful transactions emit events
  List<dynamic>? events;
  /// The set of transaction digests this transaction depends on
  List<TransactionDigest> dependencies;

  Map<String, dynamic> json;

  TransactionEffects(
    this.status,
    this.gasUsed,
    this.sharedObjects,
    this.transactionDigest,
    this.created,
    this.mutated,
    this.unwrapped,
    this.deleted,
    this.wrapped,
    this.gasObject,
    this.events,
    this.dependencies,
    this.json,
  );

  factory TransactionEffects.fromJson(dynamic data) {
    final sharedObjectsData = data['sharedObjects'];
    final sharedObjectList = <SuiObjectRef>[];
    if (sharedObjectsData != null) {
      for (var sharedObject in sharedObjectsData) {
        sharedObjectList.add(SuiObjectRef.fromJson(sharedObject));
      }
    }

    final createdData = data['created'];
    final createdList = <OwnedObjectRef>[];
    if (createdData != null) {
      for (var created in createdData) {
        createdList.add(OwnedObjectRef.fromJson(created));
      }
    }

    final mutatedData = data['mutated'];
    final mutatedList = <OwnedObjectRef>[];
    if (mutatedData != null) {
      for (var mutated in mutatedData) {
        mutatedList.add(OwnedObjectRef.fromJson(mutated));
      }
    }

    final unwrappedData = data['unwrapped'];
    final unwrappedList = <OwnedObjectRef>[];
    if (unwrappedData != null) {
      for (var unwrapped in unwrappedData) {
        unwrappedList.add(OwnedObjectRef.fromJson(unwrapped));
      }
    }

    final deletedData = data['deleted'];
    final deletedList = <SuiObjectRef>[];
    if (deletedData != null) {
      for (var deleted in deletedData) {
        deletedList.add(SuiObjectRef.fromJson(deleted));
      }
    }

    final wrappedData = data['wrapped'];
    final wrappedList = <SuiObjectRef>[];
    if (wrappedData != null) {
      for (var wrapped in wrappedData) {
        wrappedList.add(SuiObjectRef.fromJson(wrapped));
      }
    }

    final dependenciesData = data['dependencies'];
    final dependenciesList = <TransactionDigest>[];
    if (dependenciesData != null) {
      for (var dependency in dependenciesData) {
        dependenciesList.add(dependency);
      }
    }

    return TransactionEffects(
      ExecutionStatus.fromJson(data['status']),
      GasCostSummary.fromJson(data['gasUsed']),
      sharedObjectList,
      data['transactionDigest'],
      createdList,
      mutatedList,
      unwrappedList,
      deletedList,
      wrappedList,
      OwnedObjectRef.fromJson(data['gasObject']),
      data['events'],
      dependenciesList,
      data,
    );
  }

  Map<String, dynamic> toJson() {
    return json;
  }
}

class BalanceChange {
  ObjectOwner owner;
  String coinType;
  String amount;

  BalanceChange(this.owner, this.coinType, this.amount);

  factory BalanceChange.fromJson(dynamic data) {
    return BalanceChange(
      ObjectOwner.fromJson(data['owner']),
      data['coinType'],
      data['amount'],
    );
  }
}

class SuiTransactionBlockData {
  String messageVersion;
  Map<String,dynamic> transaction;
  SuiAddress sender;
  Map<String,dynamic> gasData;

  SuiTransactionBlockData(this.messageVersion,this.transaction, this.sender,this.gasData);

  factory SuiTransactionBlockData.fromJson(dynamic data) {
    return SuiTransactionBlockData(
      data['messageVersion'],
      data['transaction'],
      data['sender'],
      data['gasData'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messageVersion': messageVersion,
      'transaction': transaction,
      'sender': sender,
      'gasData': gasData,
    };
  }
}

class DryRunTransactionBlockResponse {
  /// The status of the execution
  TransactionEffects effects;

  List<SuiEvent> events;

  List<BalanceChange> balanceChanges;

  dynamic objectChanges;

  SuiTransactionBlockData? input;

  DryRunTransactionBlockResponse(
    this.effects,
    this.events,
    this.balanceChanges,
    this.objectChanges,
    this.input,
  );

  factory DryRunTransactionBlockResponse.fromJson(dynamic data) {
    final events = data['events'];
    final eventsList = <SuiEvent>[];
    if (events != null) {
      for (var event in events) {
        eventsList.add(SuiEvent.fromJson(event));
      }
    }

    final balanceChanges = data['balanceChanges'];
    final balanceChangesList = <BalanceChange>[];
    if (balanceChanges != null) {
      for (var balanceChange in balanceChanges) {
        balanceChangesList.add(BalanceChange.fromJson(balanceChange));
      }
    }

    return DryRunTransactionBlockResponse(
      TransactionEffects.fromJson(data['effects']),
      eventsList,
      balanceChangesList,
      data['objectChanges'],
      data['input'] != null
          ? SuiTransactionBlockData.fromJson(data['input'])
          : null,
    );
  }
}

class SuiParsedMergeCoinResponse {
  SuiObject updatedCoin;
  SuiObject updatedGas;

  SuiParsedMergeCoinResponse(this.updatedCoin, this.updatedGas);

  factory SuiParsedMergeCoinResponse.fromJson(dynamic data) {
    return SuiParsedMergeCoinResponse(
      data['updatedCoin'],
      data['updatedGas']
    );
  }
}

class SuiParsedSplitCoinResponse {
  SuiObject updatedCoin;
  List<SuiObject> newCoins;
  SuiObject updatedGas;

  SuiParsedSplitCoinResponse(
    this.updatedCoin,
    this.newCoins,
    this.updatedGas
  );

  factory SuiParsedSplitCoinResponse.fromJson(dynamic data) {
    return SuiParsedSplitCoinResponse(
      SuiObject.fromJson(data['updatedCoin']),
      data['newCoins'],
      SuiObject.fromJson(data['updatedGas'])
    );
  }
}

class SuiParsedPublishResponse {
  List<SuiObject> createdObjects;
  SuiPackage package;
  SuiObject updatedGas;

  SuiParsedPublishResponse(
    this.createdObjects,
    this.package,
    this.updatedGas
  );

  factory SuiParsedPublishResponse.fromJson(dynamic data) {
    return SuiParsedPublishResponse(
      data['createdObjects'],
      data['package'],
      data['updatedGas']
    );
  }
}

class SuiPackage {
  String digest;
  String objectId;
  int version;

  SuiPackage(this.digest, this.objectId, this.version);

  factory SuiPackage.fromJson(dynamic data) {
    return SuiPackage(
      data['digest'],
      data['objectId'],
      data['version']
    );
  }
}

class SuiParsedTransactionResponse {
  SuiParsedSplitCoinResponse splitCoin;
  SuiParsedMergeCoinResponse mergeCoin;
  SuiParsedPublishResponse publish;

  SuiParsedTransactionResponse(
    this.splitCoin,
    this.mergeCoin,
    this.publish
  );

  factory SuiParsedTransactionResponse.fromJson(dynamic data) {
    return SuiParsedTransactionResponse(
      SuiParsedSplitCoinResponse.fromJson(data['SplitCoin']),
      SuiParsedMergeCoinResponse.fromJson(data['MergeCoin']),
      SuiParsedPublishResponse.fromJson(data['Publish'])
    );
  }
}

class SuiTransactionResponse {
  CertifiedTransaction certificate;
  TransactionEffects effects;
  int? timestampMillisecond;
  SuiParsedTransactionResponse? parsedData;

  SuiTransactionResponse(
    this.certificate,
    this.effects,
    this.timestampMillisecond,
    this.parsedData
  );

  factory SuiTransactionResponse.fromJson(dynamic data) {
    return SuiTransactionResponse(
      CertifiedTransaction.fromJson(data['certificate']),
      TransactionEffects.fromJson(data['effects']),
      data['timestamp_ms'],
      data['parsed_data'] != null ? SuiParsedTransactionResponse.fromJson(data['parsed_data']) : null
    );
  }
}


class SuiTransactionBlockResponseOptions {
  /* Whether to show transaction input data. Default to be false. */
  bool showInput;

  /* Whether to show transaction effects. Default to be false. */
  bool showEffects;

  /* Whether to show transaction events. Default to be false. */
  bool showEvents;

  /* Whether to show object changes. Default to be false. */
  bool showObjectChanges;

  /* Whether to show coin balance changes. Default to be false. */
  bool showBalanceChanges;

  SuiTransactionBlockResponseOptions({
    this.showInput = false,
    this.showEffects= false,
    this.showEvents= false,
    this.showObjectChanges= false,
    this.showBalanceChanges= false,
  });

  Map<String, bool> toJson() {
    return {
      'showInput':showInput,
      'showEffects':showEffects,
      'showEvents':showEvents,
      'showObjectChanges':showObjectChanges,
      'showBalanceChanges':showBalanceChanges,
    };
  }
}