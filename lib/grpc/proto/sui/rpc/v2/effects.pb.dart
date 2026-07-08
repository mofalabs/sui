// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/effects.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'bcs.pb.dart' as $0;
import 'effects.pbenum.dart';
import 'execution_status.pb.dart' as $1;
import 'gas_cost_summary.pb.dart' as $2;
import 'object_reference.pb.dart' as $3;
import 'owner.pb.dart' as $4;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'effects.pbenum.dart';

/// The effects of executing a transaction.
class TransactionEffects extends $pb.GeneratedMessage {
  factory TransactionEffects({
    $0.Bcs? bcs,
    $core.String? digest,
    $core.int? version,
    $1.ExecutionStatus? status,
    $fixnum.Int64? epoch,
    $2.GasCostSummary? gasUsed,
    $core.String? transactionDigest,
    ChangedObject? gasObject,
    $core.String? eventsDigest,
    $core.Iterable<$core.String>? dependencies,
    $fixnum.Int64? lamportVersion,
    $core.Iterable<ChangedObject>? changedObjects,
    $core.Iterable<UnchangedConsensusObject>? unchangedConsensusObjects,
    $core.String? auxiliaryDataDigest,
    $core.Iterable<$3.ObjectReference>? unchangedLoadedRuntimeObjects,
  }) {
    final result = create();
    if (bcs != null) result.bcs = bcs;
    if (digest != null) result.digest = digest;
    if (version != null) result.version = version;
    if (status != null) result.status = status;
    if (epoch != null) result.epoch = epoch;
    if (gasUsed != null) result.gasUsed = gasUsed;
    if (transactionDigest != null) result.transactionDigest = transactionDigest;
    if (gasObject != null) result.gasObject = gasObject;
    if (eventsDigest != null) result.eventsDigest = eventsDigest;
    if (dependencies != null) result.dependencies.addAll(dependencies);
    if (lamportVersion != null) result.lamportVersion = lamportVersion;
    if (changedObjects != null) result.changedObjects.addAll(changedObjects);
    if (unchangedConsensusObjects != null) result.unchangedConsensusObjects.addAll(unchangedConsensusObjects);
    if (auxiliaryDataDigest != null) result.auxiliaryDataDigest = auxiliaryDataDigest;
    if (unchangedLoadedRuntimeObjects != null) result.unchangedLoadedRuntimeObjects.addAll(unchangedLoadedRuntimeObjects);
    return result;
  }

  TransactionEffects._();

  factory TransactionEffects.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TransactionEffects.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransactionEffects', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$0.Bcs>(1, _omitFieldNames ? '' : 'bcs', subBuilder: $0.Bcs.create)
    ..aOS(2, _omitFieldNames ? '' : 'digest')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..aOM<$1.ExecutionStatus>(4, _omitFieldNames ? '' : 'status', subBuilder: $1.ExecutionStatus.create)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.GasCostSummary>(6, _omitFieldNames ? '' : 'gasUsed', subBuilder: $2.GasCostSummary.create)
    ..aOS(7, _omitFieldNames ? '' : 'transactionDigest')
    ..aOM<ChangedObject>(8, _omitFieldNames ? '' : 'gasObject', subBuilder: ChangedObject.create)
    ..aOS(9, _omitFieldNames ? '' : 'eventsDigest')
    ..pPS(10, _omitFieldNames ? '' : 'dependencies')
    ..a<$fixnum.Int64>(11, _omitFieldNames ? '' : 'lamportVersion', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<ChangedObject>(12, _omitFieldNames ? '' : 'changedObjects', $pb.PbFieldType.PM, subBuilder: ChangedObject.create)
    ..pc<UnchangedConsensusObject>(13, _omitFieldNames ? '' : 'unchangedConsensusObjects', $pb.PbFieldType.PM, subBuilder: UnchangedConsensusObject.create)
    ..aOS(14, _omitFieldNames ? '' : 'auxiliaryDataDigest')
    ..pc<$3.ObjectReference>(15, _omitFieldNames ? '' : 'unchangedLoadedRuntimeObjects', $pb.PbFieldType.PM, subBuilder: $3.ObjectReference.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionEffects clone() => TransactionEffects()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionEffects copyWith(void Function(TransactionEffects) updates) => super.copyWith((message) => updates(message as TransactionEffects)) as TransactionEffects;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionEffects create() => TransactionEffects._();
  @$core.override
  TransactionEffects createEmptyInstance() => create();
  static $pb.PbList<TransactionEffects> createRepeated() => $pb.PbList<TransactionEffects>();
  @$core.pragma('dart2js:noInline')
  static TransactionEffects getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionEffects>(create);
  static TransactionEffects? _defaultInstance;

  /// This TransactionEffects serialized as BCS.
  @$pb.TagNumber(1)
  $0.Bcs get bcs => $_getN(0);
  @$pb.TagNumber(1)
  set bcs($0.Bcs value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBcs() => $_has(0);
  @$pb.TagNumber(1)
  void clearBcs() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Bcs ensureBcs() => $_ensure(0);

  /// The digest of this TransactionEffects.
  @$pb.TagNumber(2)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(2)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => $_clearField(2);

  /// Version of this TransactionEffects.
  @$pb.TagNumber(3)
  $core.int get version => $_getIZ(2);
  @$pb.TagNumber(3)
  set version($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);

  /// The status of the execution.
  @$pb.TagNumber(4)
  $1.ExecutionStatus get status => $_getN(3);
  @$pb.TagNumber(4)
  set status($1.ExecutionStatus value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.ExecutionStatus ensureStatus() => $_ensure(3);

  /// The epoch when this transaction was executed.
  @$pb.TagNumber(5)
  $fixnum.Int64 get epoch => $_getI64(4);
  @$pb.TagNumber(5)
  set epoch($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEpoch() => $_has(4);
  @$pb.TagNumber(5)
  void clearEpoch() => $_clearField(5);

  /// The gas used by this transaction.
  @$pb.TagNumber(6)
  $2.GasCostSummary get gasUsed => $_getN(5);
  @$pb.TagNumber(6)
  set gasUsed($2.GasCostSummary value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasGasUsed() => $_has(5);
  @$pb.TagNumber(6)
  void clearGasUsed() => $_clearField(6);
  @$pb.TagNumber(6)
  $2.GasCostSummary ensureGasUsed() => $_ensure(5);

  /// The transaction digest.
  @$pb.TagNumber(7)
  $core.String get transactionDigest => $_getSZ(6);
  @$pb.TagNumber(7)
  set transactionDigest($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasTransactionDigest() => $_has(6);
  @$pb.TagNumber(7)
  void clearTransactionDigest() => $_clearField(7);

  /// Information about the gas object. Also present in the `changed_objects` vector.
  ///
  /// System transactions that don't require gas will leave this as `None`.
  @$pb.TagNumber(8)
  ChangedObject get gasObject => $_getN(7);
  @$pb.TagNumber(8)
  set gasObject(ChangedObject value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasGasObject() => $_has(7);
  @$pb.TagNumber(8)
  void clearGasObject() => $_clearField(8);
  @$pb.TagNumber(8)
  ChangedObject ensureGasObject() => $_ensure(7);

  /// The digest of the events emitted during execution,
  /// can be `None` if the transaction does not emit any event.
  @$pb.TagNumber(9)
  $core.String get eventsDigest => $_getSZ(8);
  @$pb.TagNumber(9)
  set eventsDigest($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasEventsDigest() => $_has(8);
  @$pb.TagNumber(9)
  void clearEventsDigest() => $_clearField(9);

  /// The set of transaction digests this transaction depends on.
  @$pb.TagNumber(10)
  $pb.PbList<$core.String> get dependencies => $_getList(9);

  /// The version number of all the written objects (excluding packages) by this transaction.
  @$pb.TagNumber(11)
  $fixnum.Int64 get lamportVersion => $_getI64(10);
  @$pb.TagNumber(11)
  set lamportVersion($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasLamportVersion() => $_has(10);
  @$pb.TagNumber(11)
  void clearLamportVersion() => $_clearField(11);

  /// Objects whose state are changed by this transaction.
  @$pb.TagNumber(12)
  $pb.PbList<ChangedObject> get changedObjects => $_getList(11);

  /// Consensus objects that are not mutated in this transaction. Unlike owned objects,
  /// read-only consensus objects' version are not committed in the transaction,
  /// and in order for a node to catch up and execute it without consensus sequencing,
  /// the version needs to be committed in the effects.
  @$pb.TagNumber(13)
  $pb.PbList<UnchangedConsensusObject> get unchangedConsensusObjects => $_getList(12);

  /// Auxiliary data that are not protocol-critical, generated as part of the effects but are stored separately.
  /// Storing it separately allows us to avoid bloating the effects with data that are not critical.
  /// It also provides more flexibility on the format and type of the data.
  @$pb.TagNumber(14)
  $core.String get auxiliaryDataDigest => $_getSZ(13);
  @$pb.TagNumber(14)
  set auxiliaryDataDigest($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasAuxiliaryDataDigest() => $_has(13);
  @$pb.TagNumber(14)
  void clearAuxiliaryDataDigest() => $_clearField(14);

  @$pb.TagNumber(15)
  $pb.PbList<$3.ObjectReference> get unchangedLoadedRuntimeObjects => $_getList(14);
}

/// Input/output state of an object that was changed during execution.
class ChangedObject extends $pb.GeneratedMessage {
  factory ChangedObject({
    $core.String? objectId,
    ChangedObject_InputObjectState? inputState,
    $fixnum.Int64? inputVersion,
    $core.String? inputDigest,
    $4.Owner? inputOwner,
    ChangedObject_OutputObjectState? outputState,
    $fixnum.Int64? outputVersion,
    $core.String? outputDigest,
    $4.Owner? outputOwner,
    ChangedObject_IdOperation? idOperation,
    $core.String? objectType,
    AccumulatorWrite? accumulatorWrite,
  }) {
    final result = create();
    if (objectId != null) result.objectId = objectId;
    if (inputState != null) result.inputState = inputState;
    if (inputVersion != null) result.inputVersion = inputVersion;
    if (inputDigest != null) result.inputDigest = inputDigest;
    if (inputOwner != null) result.inputOwner = inputOwner;
    if (outputState != null) result.outputState = outputState;
    if (outputVersion != null) result.outputVersion = outputVersion;
    if (outputDigest != null) result.outputDigest = outputDigest;
    if (outputOwner != null) result.outputOwner = outputOwner;
    if (idOperation != null) result.idOperation = idOperation;
    if (objectType != null) result.objectType = objectType;
    if (accumulatorWrite != null) result.accumulatorWrite = accumulatorWrite;
    return result;
  }

  ChangedObject._();

  factory ChangedObject.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ChangedObject.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ChangedObject', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'objectId')
    ..e<ChangedObject_InputObjectState>(2, _omitFieldNames ? '' : 'inputState', $pb.PbFieldType.OE, defaultOrMaker: ChangedObject_InputObjectState.INPUT_OBJECT_STATE_UNKNOWN, valueOf: ChangedObject_InputObjectState.valueOf, enumValues: ChangedObject_InputObjectState.values)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'inputVersion', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'inputDigest')
    ..aOM<$4.Owner>(5, _omitFieldNames ? '' : 'inputOwner', subBuilder: $4.Owner.create)
    ..e<ChangedObject_OutputObjectState>(6, _omitFieldNames ? '' : 'outputState', $pb.PbFieldType.OE, defaultOrMaker: ChangedObject_OutputObjectState.OUTPUT_OBJECT_STATE_UNKNOWN, valueOf: ChangedObject_OutputObjectState.valueOf, enumValues: ChangedObject_OutputObjectState.values)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'outputVersion', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, _omitFieldNames ? '' : 'outputDigest')
    ..aOM<$4.Owner>(9, _omitFieldNames ? '' : 'outputOwner', subBuilder: $4.Owner.create)
    ..e<ChangedObject_IdOperation>(10, _omitFieldNames ? '' : 'idOperation', $pb.PbFieldType.OE, defaultOrMaker: ChangedObject_IdOperation.ID_OPERATION_UNKNOWN, valueOf: ChangedObject_IdOperation.valueOf, enumValues: ChangedObject_IdOperation.values)
    ..aOS(11, _omitFieldNames ? '' : 'objectType')
    ..aOM<AccumulatorWrite>(12, _omitFieldNames ? '' : 'accumulatorWrite', subBuilder: AccumulatorWrite.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangedObject clone() => ChangedObject()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChangedObject copyWith(void Function(ChangedObject) updates) => super.copyWith((message) => updates(message as ChangedObject)) as ChangedObject;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ChangedObject create() => ChangedObject._();
  @$core.override
  ChangedObject createEmptyInstance() => create();
  static $pb.PbList<ChangedObject> createRepeated() => $pb.PbList<ChangedObject>();
  @$core.pragma('dart2js:noInline')
  static ChangedObject getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChangedObject>(create);
  static ChangedObject? _defaultInstance;

  /// ID of the object.
  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => $_clearField(1);

  @$pb.TagNumber(2)
  ChangedObject_InputObjectState get inputState => $_getN(1);
  @$pb.TagNumber(2)
  set inputState(ChangedObject_InputObjectState value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasInputState() => $_has(1);
  @$pb.TagNumber(2)
  void clearInputState() => $_clearField(2);

  /// Version of the object before this transaction executed.
  @$pb.TagNumber(3)
  $fixnum.Int64 get inputVersion => $_getI64(2);
  @$pb.TagNumber(3)
  set inputVersion($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInputVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearInputVersion() => $_clearField(3);

  /// Digest of the object before this transaction executed.
  @$pb.TagNumber(4)
  $core.String get inputDigest => $_getSZ(3);
  @$pb.TagNumber(4)
  set inputDigest($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInputDigest() => $_has(3);
  @$pb.TagNumber(4)
  void clearInputDigest() => $_clearField(4);

  /// Owner of the object before this transaction executed.
  @$pb.TagNumber(5)
  $4.Owner get inputOwner => $_getN(4);
  @$pb.TagNumber(5)
  set inputOwner($4.Owner value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasInputOwner() => $_has(4);
  @$pb.TagNumber(5)
  void clearInputOwner() => $_clearField(5);
  @$pb.TagNumber(5)
  $4.Owner ensureInputOwner() => $_ensure(4);

  @$pb.TagNumber(6)
  ChangedObject_OutputObjectState get outputState => $_getN(5);
  @$pb.TagNumber(6)
  set outputState(ChangedObject_OutputObjectState value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasOutputState() => $_has(5);
  @$pb.TagNumber(6)
  void clearOutputState() => $_clearField(6);

  /// Version of the object after this transaction executed.
  @$pb.TagNumber(7)
  $fixnum.Int64 get outputVersion => $_getI64(6);
  @$pb.TagNumber(7)
  set outputVersion($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasOutputVersion() => $_has(6);
  @$pb.TagNumber(7)
  void clearOutputVersion() => $_clearField(7);

  /// Digest of the object after this transaction executed.
  @$pb.TagNumber(8)
  $core.String get outputDigest => $_getSZ(7);
  @$pb.TagNumber(8)
  set outputDigest($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasOutputDigest() => $_has(7);
  @$pb.TagNumber(8)
  void clearOutputDigest() => $_clearField(8);

  /// Owner of the object after this transaction executed.
  @$pb.TagNumber(9)
  $4.Owner get outputOwner => $_getN(8);
  @$pb.TagNumber(9)
  set outputOwner($4.Owner value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasOutputOwner() => $_has(8);
  @$pb.TagNumber(9)
  void clearOutputOwner() => $_clearField(9);
  @$pb.TagNumber(9)
  $4.Owner ensureOutputOwner() => $_ensure(8);

  /// What happened to an `ObjectId` during execution.
  @$pb.TagNumber(10)
  ChangedObject_IdOperation get idOperation => $_getN(9);
  @$pb.TagNumber(10)
  set idOperation(ChangedObject_IdOperation value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasIdOperation() => $_has(9);
  @$pb.TagNumber(10)
  void clearIdOperation() => $_clearField(10);

  /// Type information is not provided by the effects structure but is instead
  /// provided by an indexing layer
  @$pb.TagNumber(11)
  $core.String get objectType => $_getSZ(10);
  @$pb.TagNumber(11)
  set objectType($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasObjectType() => $_has(10);
  @$pb.TagNumber(11)
  void clearObjectType() => $_clearField(11);

  /// The contents of the accumulator write when `output_state` is `OUTPUT_OBJECT_STATE_ACCUMULATOR_WRITE`
  @$pb.TagNumber(12)
  AccumulatorWrite get accumulatorWrite => $_getN(11);
  @$pb.TagNumber(12)
  set accumulatorWrite(AccumulatorWrite value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasAccumulatorWrite() => $_has(11);
  @$pb.TagNumber(12)
  void clearAccumulatorWrite() => $_clearField(12);
  @$pb.TagNumber(12)
  AccumulatorWrite ensureAccumulatorWrite() => $_ensure(11);
}

/// An entry in an event digest accumulator value.
class EventDigestEntry extends $pb.GeneratedMessage {
  factory EventDigestEntry({
    $fixnum.Int64? eventIndex,
    $core.String? digest,
  }) {
    final result = create();
    if (eventIndex != null) result.eventIndex = eventIndex;
    if (digest != null) result.digest = digest;
    return result;
  }

  EventDigestEntry._();

  factory EventDigestEntry.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory EventDigestEntry.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EventDigestEntry', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'eventIndex', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'digest')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventDigestEntry clone() => EventDigestEntry()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventDigestEntry copyWith(void Function(EventDigestEntry) updates) => super.copyWith((message) => updates(message as EventDigestEntry)) as EventDigestEntry;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventDigestEntry create() => EventDigestEntry._();
  @$core.override
  EventDigestEntry createEmptyInstance() => create();
  static $pb.PbList<EventDigestEntry> createRepeated() => $pb.PbList<EventDigestEntry>();
  @$core.pragma('dart2js:noInline')
  static EventDigestEntry getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventDigestEntry>(create);
  static EventDigestEntry? _defaultInstance;

  /// Index of the event within its transaction.
  @$pb.TagNumber(1)
  $fixnum.Int64 get eventIndex => $_getI64(0);
  @$pb.TagNumber(1)
  set eventIndex($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventIndex() => $_clearField(1);

  /// Digest of the event.
  @$pb.TagNumber(2)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(2)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => $_clearField(2);
}

class AccumulatorWrite extends $pb.GeneratedMessage {
  factory AccumulatorWrite({
    $core.String? address,
    $core.String? accumulatorType,
    AccumulatorWrite_AccumulatorOperation? operation,
    AccumulatorWrite_AccumulatorValue? valueKind,
    $fixnum.Int64? integerValue,
    $core.Iterable<$fixnum.Int64>? integerTuple,
    $core.Iterable<EventDigestEntry>? eventDigestValue,
  }) {
    final result = create();
    if (address != null) result.address = address;
    if (accumulatorType != null) result.accumulatorType = accumulatorType;
    if (operation != null) result.operation = operation;
    if (valueKind != null) result.valueKind = valueKind;
    if (integerValue != null) result.integerValue = integerValue;
    if (integerTuple != null) result.integerTuple.addAll(integerTuple);
    if (eventDigestValue != null) result.eventDigestValue.addAll(eventDigestValue);
    return result;
  }

  AccumulatorWrite._();

  factory AccumulatorWrite.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AccumulatorWrite.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AccumulatorWrite', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..aOS(2, _omitFieldNames ? '' : 'accumulatorType')
    ..e<AccumulatorWrite_AccumulatorOperation>(3, _omitFieldNames ? '' : 'operation', $pb.PbFieldType.OE, defaultOrMaker: AccumulatorWrite_AccumulatorOperation.ACCUMULATOR_OPERATION_UNKNOWN, valueOf: AccumulatorWrite_AccumulatorOperation.valueOf, enumValues: AccumulatorWrite_AccumulatorOperation.values)
    ..e<AccumulatorWrite_AccumulatorValue>(4, _omitFieldNames ? '' : 'valueKind', $pb.PbFieldType.OE, defaultOrMaker: AccumulatorWrite_AccumulatorValue.ACCUMULATOR_VALUE_UNKNOWN, valueOf: AccumulatorWrite_AccumulatorValue.valueOf, enumValues: AccumulatorWrite_AccumulatorValue.values)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'integerValue', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..p<$fixnum.Int64>(6, _omitFieldNames ? '' : 'integerTuple', $pb.PbFieldType.KU6)
    ..pc<EventDigestEntry>(7, _omitFieldNames ? '' : 'eventDigestValue', $pb.PbFieldType.PM, subBuilder: EventDigestEntry.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccumulatorWrite clone() => AccumulatorWrite()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AccumulatorWrite copyWith(void Function(AccumulatorWrite) updates) => super.copyWith((message) => updates(message as AccumulatorWrite)) as AccumulatorWrite;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AccumulatorWrite create() => AccumulatorWrite._();
  @$core.override
  AccumulatorWrite createEmptyInstance() => create();
  static $pb.PbList<AccumulatorWrite> createRepeated() => $pb.PbList<AccumulatorWrite>();
  @$core.pragma('dart2js:noInline')
  static AccumulatorWrite getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AccumulatorWrite>(create);
  static AccumulatorWrite? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get accumulatorType => $_getSZ(1);
  @$pb.TagNumber(2)
  set accumulatorType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAccumulatorType() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccumulatorType() => $_clearField(2);

  @$pb.TagNumber(3)
  AccumulatorWrite_AccumulatorOperation get operation => $_getN(2);
  @$pb.TagNumber(3)
  set operation(AccumulatorWrite_AccumulatorOperation value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOperation() => $_has(2);
  @$pb.TagNumber(3)
  void clearOperation() => $_clearField(3);

  @$pb.TagNumber(4)
  AccumulatorWrite_AccumulatorValue get valueKind => $_getN(3);
  @$pb.TagNumber(4)
  set valueKind(AccumulatorWrite_AccumulatorValue value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasValueKind() => $_has(3);
  @$pb.TagNumber(4)
  void clearValueKind() => $_clearField(4);

  /// Set when the accumulator value is an integer (value_kind = INTEGER).
  @$pb.TagNumber(5)
  $fixnum.Int64 get integerValue => $_getI64(4);
  @$pb.TagNumber(5)
  set integerValue($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasIntegerValue() => $_has(4);
  @$pb.TagNumber(5)
  void clearIntegerValue() => $_clearField(5);

  /// Set, with len 2, when the accumulator value is an integer tuple
  /// (value_kind = INTEGER_TUPLE).
  @$pb.TagNumber(6)
  $pb.PbList<$fixnum.Int64> get integerTuple => $_getList(5);

  /// Set when the accumulator value is an event digest list (value_kind = EVENT_DIGEST).
  /// Contains a non-empty list of (event_index, digest) pairs representing
  /// authenticated event stream entries within a transaction.
  @$pb.TagNumber(7)
  $pb.PbList<EventDigestEntry> get eventDigestValue => $_getList(6);
}

/// A consensus object that wasn't changed during execution.
class UnchangedConsensusObject extends $pb.GeneratedMessage {
  factory UnchangedConsensusObject({
    UnchangedConsensusObject_UnchangedConsensusObjectKind? kind,
    $core.String? objectId,
    $fixnum.Int64? version,
    $core.String? digest,
    $core.String? objectType,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (objectId != null) result.objectId = objectId;
    if (version != null) result.version = version;
    if (digest != null) result.digest = digest;
    if (objectType != null) result.objectType = objectType;
    return result;
  }

  UnchangedConsensusObject._();

  factory UnchangedConsensusObject.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory UnchangedConsensusObject.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UnchangedConsensusObject', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..e<UnchangedConsensusObject_UnchangedConsensusObjectKind>(1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE, defaultOrMaker: UnchangedConsensusObject_UnchangedConsensusObjectKind.UNCHANGED_CONSENSUS_OBJECT_KIND_UNKNOWN, valueOf: UnchangedConsensusObject_UnchangedConsensusObjectKind.valueOf, enumValues: UnchangedConsensusObject_UnchangedConsensusObjectKind.values)
    ..aOS(2, _omitFieldNames ? '' : 'objectId')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'digest')
    ..aOS(5, _omitFieldNames ? '' : 'objectType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnchangedConsensusObject clone() => UnchangedConsensusObject()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnchangedConsensusObject copyWith(void Function(UnchangedConsensusObject) updates) => super.copyWith((message) => updates(message as UnchangedConsensusObject)) as UnchangedConsensusObject;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UnchangedConsensusObject create() => UnchangedConsensusObject._();
  @$core.override
  UnchangedConsensusObject createEmptyInstance() => create();
  static $pb.PbList<UnchangedConsensusObject> createRepeated() => $pb.PbList<UnchangedConsensusObject>();
  @$core.pragma('dart2js:noInline')
  static UnchangedConsensusObject getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UnchangedConsensusObject>(create);
  static UnchangedConsensusObject? _defaultInstance;

  @$pb.TagNumber(1)
  UnchangedConsensusObject_UnchangedConsensusObjectKind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(UnchangedConsensusObject_UnchangedConsensusObjectKind value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  /// ObjectId of the consensus object.
  @$pb.TagNumber(2)
  $core.String get objectId => $_getSZ(1);
  @$pb.TagNumber(2)
  set objectId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasObjectId() => $_has(1);
  @$pb.TagNumber(2)
  void clearObjectId() => $_clearField(2);

  /// Version of the consensus object.
  @$pb.TagNumber(3)
  $fixnum.Int64 get version => $_getI64(2);
  @$pb.TagNumber(3)
  set version($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);

  /// Digest of the consensus object.
  @$pb.TagNumber(4)
  $core.String get digest => $_getSZ(3);
  @$pb.TagNumber(4)
  set digest($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDigest() => $_has(3);
  @$pb.TagNumber(4)
  void clearDigest() => $_clearField(4);

  /// Type information is not provided by the effects structure but is instead
  /// provided by an indexing layer
  @$pb.TagNumber(5)
  $core.String get objectType => $_getSZ(4);
  @$pb.TagNumber(5)
  set objectType($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasObjectType() => $_has(4);
  @$pb.TagNumber(5)
  void clearObjectType() => $_clearField(5);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
