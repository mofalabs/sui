
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

class SuiEvent {
  ObjectId packageId;
  String transactionModule;
  SuiAddress sender;
  String type;

  Map<String, dynamic>? parsedJson;
  String? bcs;
  int? timestampMs;

  SuiEvent(
    this.packageId,
    this.transactionModule,
    this.sender,
    this.type,
    this.parsedJson,
    this.bcs,
    this.timestampMs,
  );

  factory SuiEvent.fromJson(dynamic data) {
    return SuiEvent(
      data['packageId'],
      data['transactionModule'],
      data['sender'],
      data['type'],
      data['parsedJson'],
      data['bcs'],
      data['timestampMs'],
    );
  }
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

class SuiEventEnvelope {
  int timestamp;
  TransactionDigest txDigest;
  dynamic event;

  SuiEventEnvelope(this.timestamp, this.txDigest, this.event);

  factory SuiEventEnvelope.fromJson(dynamic data) {
    return SuiEventEnvelope(
      data['timestamp'],
      data['txDigest'],
      data['event']
    );
  }
}

typedef SuiEvents = List<SuiEventEnvelope>;

typedef SubscriptionId = int;

class EventId {
  int txSeq;
  int eventSeq;

  EventId(this.txSeq, this.eventSeq);

  factory EventId.fromJson(dynamic data) {
    return EventId(
      data['txSeq'],
      data['eventSeq']
    );
  }
}

class PaginatedEvents {
  List<SuiEventEnvelope> data;
  EventId? nextCursor;

  PaginatedEvents(this.data, this.nextCursor);

  factory PaginatedEvents.fromJson(dynamic data) {
    final eventsData = (data['data'] as List)
      .map((e) => SuiEventEnvelope.fromJson(e))
      .toList();

    return PaginatedEvents(
      eventsData,
      EventId.fromJson(data['nextCursor'])
    );
  }
}

// mirrors the value defined in https://github.com/MystenLabs/sui/blob/e12f8c58ef7ba17205c4caf5ad2c350cbb01656c/crates/sui-json-rpc/src/api.rs#L27
const EVENT_QUERY_MAX_LIMIT = 100;
const DEFAULT_START_TIME = 0;
final DEFAULT_END_TIME = MAX_U32_NUMBER;
