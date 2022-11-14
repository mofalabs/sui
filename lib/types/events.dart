
import 'package:bcs/consts.dart';
import 'package:sui/types/common.dart';
import 'package:sui/types/objects.dart';
import 'package:sui/types/transactions.dart';

class MoveEvent {
  ObjectId packageId;
  String transactionModule;
  SuiAddress sender;
  String type;
  Map<String, dynamic>? fields;
  String bcs;

  MoveEvent(
    this.packageId,
    this.transactionModule,
    this.sender,
    this.type,
    this.fields,
    this.bcs
  );
}

class PublishEvent {
  SuiAddress sender;
  ObjectId packageId;

  PublishEvent(this.sender, this.packageId);
}

class CoinBalanceChangeEvent {
  ObjectId packageId;
  String transactionModule;
  SuiAddress sender;
  ObjectOwner owner;
  BalanceChangeType changeType;
  String coinType;
  ObjectId coinObjectId;
  SequenceNumber version;
  int amount;

  CoinBalanceChangeEvent(
    this.packageId,
    this.transactionModule,
    this.sender,
    this.owner,
    this.changeType,
    this.coinType,
    this.coinObjectId,
    this.version,
    this.amount
  );
}

class TransferObjectEvent {
  ObjectId packageId;
  String transactionModule;
  SuiAddress sender;
  ObjectOwner recipient;
  String objectType;
  ObjectId objectId;
  SequenceNumber version;

  TransferObjectEvent(
    this.packageId,
    this.transactionModule,
    this.sender,
    this.recipient,
    this.objectType,
    this.objectId,
    this.version
  );
}

class MutateObjectEvent {
  ObjectId packageId;
  String transactionModule;
  SuiAddress sender;
  String objectType;
  ObjectId objectId;
  SequenceNumber version;

  MutateObjectEvent(
    this.packageId,
    this.transactionModule,
    this.sender,
    this.objectType,
    this.objectId,
    this.version
  );
}

class DeleteObjectEvent {
  ObjectId packageId;
  String transactionModule;
  SuiAddress sender;
  ObjectId objectId;
  SequenceNumber version;

  DeleteObjectEvent(
    this.packageId,
    this.transactionModule,
    this.sender,
    this.objectId,
    this.version
  );
}

class NewObjectEvent {
  ObjectId packageId;
  String transactionModule;
  SuiAddress sender;
  ObjectOwner recipient;
  String objectType;
  ObjectId objectId;
  SequenceNumber version;

  NewObjectEvent(
    this.packageId,
    this.transactionModule,
    this.sender,
    this.recipient,
    this.objectType,
    this.objectId,
    this.version
  );
}

// export type SuiEvent =
//   | { moveEvent: MoveEvent }
//   | { publish: PublishEvent }
//   | { coinBalanceChange: CoinBalanceChangeEvent }
//   | { transferObject: TransferObjectEvent }
//   | { mutateObject: MutateObjectEvent }
//   | { deleteObject: DeleteObjectEvent }
//   | { newObject: NewObjectEvent }
//   | { epochChange: bigint }
//   | { checkpoint: bigint };

class MoveEventField {
  String path;
  SuiJsonValue value;

  MoveEventField(this.path, this.value);
}

enum EventType {
  MoveEvent,
  Publish,
  TransferObject,
  MutateObject,
  CoinBalanceChange,
  DeleteObject,
  NewObject,
  EpochChange,
  Checkpoint
}

enum BalanceChangeType {
  Gas, Pay, Receive
}

// mirrors sui_json_rpc_types::SuiEventFilter
// export type SuiEventFilter =
//   | { Package: ObjectId }
//   | { Module: string }
//   | { MoveEventType: string }
//   | { MoveEventField: MoveEventField }
//   | { SenderAddress: SuiAddress }
//   | { EventType: EventType }
//   | { All: SuiEventFilter[] }
//   | { Any: SuiEventFilter[] }
//   | { And: [SuiEventFilter, SuiEventFilter] }
//   | { Or: [SuiEventFilter, SuiEventFilter] };

class SuiEventEnvelope {
  int timestamp;
  TransactionDigest txDigest;
  dynamic event;

  SuiEventEnvelope(this.timestamp, this.txDigest, this.event);
}

typedef SuiEvents = List<SuiEventEnvelope>;

typedef SubscriptionId = int;

class SubscriptionEvent {
  SubscriptionId subscription;
  SuiEventEnvelope result;

  SubscriptionEvent(this.subscription, this.result);
}

// mirrors the value defined in https://github.com/MystenLabs/sui/blob/e12f8c58ef7ba17205c4caf5ad2c350cbb01656c/crates/sui-json-rpc/src/api.rs#L27
const EVENT_QUERY_MAX_LIMIT = 100;
const DEFAULT_START_TIME = 0;
final DEFAULT_END_TIME = MAX_U32_NUMBER;
