// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/filter.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// DNF filter for transactions: any term may match, and each term is an AND
/// of signed literals.
/// An absent filter matches everything. A present filter must have at least one
/// term.
class TransactionFilter extends $pb.GeneratedMessage {
  factory TransactionFilter({
    $core.Iterable<TransactionTerm>? terms,
  }) {
    final result = create();
    if (terms != null) result.terms.addAll(terms);
    return result;
  }

  TransactionFilter._();

  factory TransactionFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransactionFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<TransactionTerm>(1, _omitFieldNames ? '' : 'terms', $pb.PbFieldType.PM,
        subBuilder: TransactionTerm.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionFilter clone() => TransactionFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionFilter copyWith(void Function(TransactionFilter) updates) =>
      super.copyWith((message) => updates(message as TransactionFilter))
          as TransactionFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionFilter create() => TransactionFilter._();
  @$core.override
  TransactionFilter createEmptyInstance() => create();
  static $pb.PbList<TransactionFilter> createRepeated() =>
      $pb.PbList<TransactionFilter>();
  @$core.pragma('dart2js:noInline')
  static TransactionFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionFilter>(create);
  static TransactionFilter? _defaultInstance;

  /// Terms are ORed together.
  @$pb.TagNumber(1)
  $pb.PbList<TransactionTerm> get terms => $_getList(0);
}

/// One conjunction in a transaction DNF filter.
class TransactionTerm extends $pb.GeneratedMessage {
  factory TransactionTerm({
    $core.Iterable<TransactionLiteral>? literals,
  }) {
    final result = create();
    if (literals != null) result.literals.addAll(literals);
    return result;
  }

  TransactionTerm._();

  factory TransactionTerm.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransactionTerm.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionTerm',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<TransactionLiteral>(
        1, _omitFieldNames ? '' : 'literals', $pb.PbFieldType.PM,
        subBuilder: TransactionLiteral.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionTerm clone() => TransactionTerm()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionTerm copyWith(void Function(TransactionTerm) updates) =>
      super.copyWith((message) => updates(message as TransactionTerm))
          as TransactionTerm;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionTerm create() => TransactionTerm._();
  @$core.override
  TransactionTerm createEmptyInstance() => create();
  static $pb.PbList<TransactionTerm> createRepeated() =>
      $pb.PbList<TransactionTerm>();
  @$core.pragma('dart2js:noInline')
  static TransactionTerm getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionTerm>(create);
  static TransactionTerm? _defaultInstance;

  /// Literals are ANDed together.
  @$pb.TagNumber(1)
  $pb.PbList<TransactionLiteral> get literals => $_getList(0);
}

enum TransactionLiteral_Predicate {
  sender,
  affectedAddress,
  affectedObject,
  moveCall,
  emitModule,
  eventType,
  eventStreamHead,
  packageWrite,
  notSet
}

/// One signed transaction predicate literal: a predicate, optionally negated.
class TransactionLiteral extends $pb.GeneratedMessage {
  factory TransactionLiteral({
    $core.bool? negated,
    SenderFilter? sender,
    AffectedAddressFilter? affectedAddress,
    AffectedObjectFilter? affectedObject,
    MoveCallFilter? moveCall,
    EmitModuleFilter? emitModule,
    EventTypeFilter? eventType,
    EventStreamHeadFilter? eventStreamHead,
    PackageWriteFilter? packageWrite,
  }) {
    final result = create();
    if (negated != null) result.negated = negated;
    if (sender != null) result.sender = sender;
    if (affectedAddress != null) result.affectedAddress = affectedAddress;
    if (affectedObject != null) result.affectedObject = affectedObject;
    if (moveCall != null) result.moveCall = moveCall;
    if (emitModule != null) result.emitModule = emitModule;
    if (eventType != null) result.eventType = eventType;
    if (eventStreamHead != null) result.eventStreamHead = eventStreamHead;
    if (packageWrite != null) result.packageWrite = packageWrite;
    return result;
  }

  TransactionLiteral._();

  factory TransactionLiteral.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TransactionLiteral.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, TransactionLiteral_Predicate>
      _TransactionLiteral_PredicateByTag = {
    2: TransactionLiteral_Predicate.sender,
    3: TransactionLiteral_Predicate.affectedAddress,
    4: TransactionLiteral_Predicate.affectedObject,
    5: TransactionLiteral_Predicate.moveCall,
    6: TransactionLiteral_Predicate.emitModule,
    7: TransactionLiteral_Predicate.eventType,
    8: TransactionLiteral_Predicate.eventStreamHead,
    9: TransactionLiteral_Predicate.packageWrite,
    0: TransactionLiteral_Predicate.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TransactionLiteral',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6, 7, 8, 9])
    ..aOB(1, _omitFieldNames ? '' : 'negated')
    ..aOM<SenderFilter>(2, _omitFieldNames ? '' : 'sender',
        subBuilder: SenderFilter.create)
    ..aOM<AffectedAddressFilter>(3, _omitFieldNames ? '' : 'affectedAddress',
        subBuilder: AffectedAddressFilter.create)
    ..aOM<AffectedObjectFilter>(4, _omitFieldNames ? '' : 'affectedObject',
        subBuilder: AffectedObjectFilter.create)
    ..aOM<MoveCallFilter>(5, _omitFieldNames ? '' : 'moveCall',
        subBuilder: MoveCallFilter.create)
    ..aOM<EmitModuleFilter>(6, _omitFieldNames ? '' : 'emitModule',
        subBuilder: EmitModuleFilter.create)
    ..aOM<EventTypeFilter>(7, _omitFieldNames ? '' : 'eventType',
        subBuilder: EventTypeFilter.create)
    ..aOM<EventStreamHeadFilter>(8, _omitFieldNames ? '' : 'eventStreamHead',
        subBuilder: EventStreamHeadFilter.create)
    ..aOM<PackageWriteFilter>(9, _omitFieldNames ? '' : 'packageWrite',
        subBuilder: PackageWriteFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionLiteral clone() => TransactionLiteral()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionLiteral copyWith(void Function(TransactionLiteral) updates) =>
      super.copyWith((message) => updates(message as TransactionLiteral))
          as TransactionLiteral;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionLiteral create() => TransactionLiteral._();
  @$core.override
  TransactionLiteral createEmptyInstance() => create();
  static $pb.PbList<TransactionLiteral> createRepeated() =>
      $pb.PbList<TransactionLiteral>();
  @$core.pragma('dart2js:noInline')
  static TransactionLiteral getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TransactionLiteral>(create);
  static TransactionLiteral? _defaultInstance;

  TransactionLiteral_Predicate whichPredicate() =>
      _TransactionLiteral_PredicateByTag[$_whichOneof(0)]!;
  void clearPredicate() => $_clearField($_whichOneof(0));

  /// When true, the literal matches transactions that the predicate does *not*
  /// match.
  @$pb.TagNumber(1)
  $core.bool get negated => $_getBF(0);
  @$pb.TagNumber(1)
  set negated($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNegated() => $_has(0);
  @$pb.TagNumber(1)
  void clearNegated() => $_clearField(1);

  /// Match transactions sent by the specified address.
  @$pb.TagNumber(2)
  SenderFilter get sender => $_getN(1);
  @$pb.TagNumber(2)
  set sender(SenderFilter value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSender() => $_has(1);
  @$pb.TagNumber(2)
  void clearSender() => $_clearField(2);
  @$pb.TagNumber(2)
  SenderFilter ensureSender() => $_ensure(1);

  /// Match transactions where the specified address's state moved as a side
  /// effect: it owns an object after the txn, owned an object before the
  /// txn that was mutated/transferred away/deleted/wrapped, or its
  /// address-balance changed via an accumulator event.
  @$pb.TagNumber(3)
  AffectedAddressFilter get affectedAddress => $_getN(2);
  @$pb.TagNumber(3)
  set affectedAddress(AffectedAddressFilter value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAffectedAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearAffectedAddress() => $_clearField(3);
  @$pb.TagNumber(3)
  AffectedAddressFilter ensureAffectedAddress() => $_ensure(2);

  /// Match transactions whose effects include a change for the specified
  /// object.
  @$pb.TagNumber(4)
  AffectedObjectFilter get affectedObject => $_getN(3);
  @$pb.TagNumber(4)
  set affectedObject(AffectedObjectFilter value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAffectedObject() => $_has(3);
  @$pb.TagNumber(4)
  void clearAffectedObject() => $_clearField(4);
  @$pb.TagNumber(4)
  AffectedObjectFilter ensureAffectedObject() => $_ensure(3);

  /// Match transactions that made a Move call matching the specified filter.
  @$pb.TagNumber(5)
  MoveCallFilter get moveCall => $_getN(4);
  @$pb.TagNumber(5)
  set moveCall(MoveCallFilter value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasMoveCall() => $_has(4);
  @$pb.TagNumber(5)
  void clearMoveCall() => $_clearField(5);
  @$pb.TagNumber(5)
  MoveCallFilter ensureMoveCall() => $_ensure(4);

  /// Match transactions that emitted an event whose package/module fields
  /// match the specified filter.
  @$pb.TagNumber(6)
  EmitModuleFilter get emitModule => $_getN(5);
  @$pb.TagNumber(6)
  set emitModule(EmitModuleFilter value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasEmitModule() => $_has(5);
  @$pb.TagNumber(6)
  void clearEmitModule() => $_clearField(6);
  @$pb.TagNumber(6)
  EmitModuleFilter ensureEmitModule() => $_ensure(5);

  /// Match transactions that emitted an event with a type matching the
  /// specified filter.
  @$pb.TagNumber(7)
  EventTypeFilter get eventType => $_getN(6);
  @$pb.TagNumber(7)
  set eventType(EventTypeFilter value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEventType() => $_has(6);
  @$pb.TagNumber(7)
  void clearEventType() => $_clearField(7);
  @$pb.TagNumber(7)
  EventTypeFilter ensureEventType() => $_ensure(6);

  /// Match transactions that wrote to the specified authenticated event
  /// stream head.
  @$pb.TagNumber(8)
  EventStreamHeadFilter get eventStreamHead => $_getN(7);
  @$pb.TagNumber(8)
  set eventStreamHead(EventStreamHeadFilter value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasEventStreamHead() => $_has(7);
  @$pb.TagNumber(8)
  void clearEventStreamHead() => $_clearField(8);
  @$pb.TagNumber(8)
  EventStreamHeadFilter ensureEventStreamHead() => $_ensure(7);

  /// Match transactions that wrote a Move package — a first publish or an
  /// upgrade, of any package.
  @$pb.TagNumber(9)
  PackageWriteFilter get packageWrite => $_getN(8);
  @$pb.TagNumber(9)
  set packageWrite(PackageWriteFilter value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasPackageWrite() => $_has(8);
  @$pb.TagNumber(9)
  void clearPackageWrite() => $_clearField(9);
  @$pb.TagNumber(9)
  PackageWriteFilter ensurePackageWrite() => $_ensure(8);
}

/// DNF filter for events: any term may match, and each term is an AND of
/// signed literals. Sender predicates match all events from matching
/// transactions; emit-module, event-type, and event-stream-head predicates match
/// individual event-space dimensions. An absent filter matches everything. A
/// present filter must have at least one term.
class EventFilter extends $pb.GeneratedMessage {
  factory EventFilter({
    $core.Iterable<EventTerm>? terms,
  }) {
    final result = create();
    if (terms != null) result.terms.addAll(terms);
    return result;
  }

  EventFilter._();

  factory EventFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<EventTerm>(1, _omitFieldNames ? '' : 'terms', $pb.PbFieldType.PM,
        subBuilder: EventTerm.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventFilter clone() => EventFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventFilter copyWith(void Function(EventFilter) updates) =>
      super.copyWith((message) => updates(message as EventFilter))
          as EventFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventFilter create() => EventFilter._();
  @$core.override
  EventFilter createEmptyInstance() => create();
  static $pb.PbList<EventFilter> createRepeated() => $pb.PbList<EventFilter>();
  @$core.pragma('dart2js:noInline')
  static EventFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventFilter>(create);
  static EventFilter? _defaultInstance;

  /// Terms are ORed together.
  @$pb.TagNumber(1)
  $pb.PbList<EventTerm> get terms => $_getList(0);
}

/// One conjunction in an event DNF filter.
class EventTerm extends $pb.GeneratedMessage {
  factory EventTerm({
    $core.Iterable<EventLiteral>? literals,
  }) {
    final result = create();
    if (literals != null) result.literals.addAll(literals);
    return result;
  }

  EventTerm._();

  factory EventTerm.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventTerm.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventTerm',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<EventLiteral>(1, _omitFieldNames ? '' : 'literals', $pb.PbFieldType.PM,
        subBuilder: EventLiteral.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventTerm clone() => EventTerm()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventTerm copyWith(void Function(EventTerm) updates) =>
      super.copyWith((message) => updates(message as EventTerm)) as EventTerm;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventTerm create() => EventTerm._();
  @$core.override
  EventTerm createEmptyInstance() => create();
  static $pb.PbList<EventTerm> createRepeated() => $pb.PbList<EventTerm>();
  @$core.pragma('dart2js:noInline')
  static EventTerm getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventTerm>(create);
  static EventTerm? _defaultInstance;

  /// Literals are ANDed together.
  @$pb.TagNumber(1)
  $pb.PbList<EventLiteral> get literals => $_getList(0);
}

enum EventLiteral_Predicate {
  sender,
  emitModule,
  eventType,
  eventStreamHead,
  notSet
}

/// One signed event predicate literal: a predicate, optionally negated.
class EventLiteral extends $pb.GeneratedMessage {
  factory EventLiteral({
    $core.bool? negated,
    SenderFilter? sender,
    EmitModuleFilter? emitModule,
    EventTypeFilter? eventType,
    EventStreamHeadFilter? eventStreamHead,
  }) {
    final result = create();
    if (negated != null) result.negated = negated;
    if (sender != null) result.sender = sender;
    if (emitModule != null) result.emitModule = emitModule;
    if (eventType != null) result.eventType = eventType;
    if (eventStreamHead != null) result.eventStreamHead = eventStreamHead;
    return result;
  }

  EventLiteral._();

  factory EventLiteral.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventLiteral.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, EventLiteral_Predicate>
      _EventLiteral_PredicateByTag = {
    2: EventLiteral_Predicate.sender,
    3: EventLiteral_Predicate.emitModule,
    4: EventLiteral_Predicate.eventType,
    5: EventLiteral_Predicate.eventStreamHead,
    0: EventLiteral_Predicate.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventLiteral',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5])
    ..aOB(1, _omitFieldNames ? '' : 'negated')
    ..aOM<SenderFilter>(2, _omitFieldNames ? '' : 'sender',
        subBuilder: SenderFilter.create)
    ..aOM<EmitModuleFilter>(3, _omitFieldNames ? '' : 'emitModule',
        subBuilder: EmitModuleFilter.create)
    ..aOM<EventTypeFilter>(4, _omitFieldNames ? '' : 'eventType',
        subBuilder: EventTypeFilter.create)
    ..aOM<EventStreamHeadFilter>(5, _omitFieldNames ? '' : 'eventStreamHead',
        subBuilder: EventStreamHeadFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventLiteral clone() => EventLiteral()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventLiteral copyWith(void Function(EventLiteral) updates) =>
      super.copyWith((message) => updates(message as EventLiteral))
          as EventLiteral;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventLiteral create() => EventLiteral._();
  @$core.override
  EventLiteral createEmptyInstance() => create();
  static $pb.PbList<EventLiteral> createRepeated() =>
      $pb.PbList<EventLiteral>();
  @$core.pragma('dart2js:noInline')
  static EventLiteral getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventLiteral>(create);
  static EventLiteral? _defaultInstance;

  EventLiteral_Predicate whichPredicate() =>
      _EventLiteral_PredicateByTag[$_whichOneof(0)]!;
  void clearPredicate() => $_clearField($_whichOneof(0));

  /// When true, the literal matches events that the predicate does *not* match.
  @$pb.TagNumber(1)
  $core.bool get negated => $_getBF(0);
  @$pb.TagNumber(1)
  set negated($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNegated() => $_has(0);
  @$pb.TagNumber(1)
  void clearNegated() => $_clearField(1);

  /// Match events from transactions sent by the specified address.
  @$pb.TagNumber(2)
  SenderFilter get sender => $_getN(1);
  @$pb.TagNumber(2)
  set sender(SenderFilter value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSender() => $_has(1);
  @$pb.TagNumber(2)
  void clearSender() => $_clearField(2);
  @$pb.TagNumber(2)
  SenderFilter ensureSender() => $_ensure(1);

  /// Match events whose package/module fields match the specified filter.
  @$pb.TagNumber(3)
  EmitModuleFilter get emitModule => $_getN(2);
  @$pb.TagNumber(3)
  set emitModule(EmitModuleFilter value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasEmitModule() => $_has(2);
  @$pb.TagNumber(3)
  void clearEmitModule() => $_clearField(3);
  @$pb.TagNumber(3)
  EmitModuleFilter ensureEmitModule() => $_ensure(2);

  /// Match events whose type matches the specified filter.
  @$pb.TagNumber(4)
  EventTypeFilter get eventType => $_getN(3);
  @$pb.TagNumber(4)
  set eventType(EventTypeFilter value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasEventType() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventType() => $_clearField(4);
  @$pb.TagNumber(4)
  EventTypeFilter ensureEventType() => $_ensure(3);

  /// Match events committed to the specified authenticated event stream head.
  @$pb.TagNumber(5)
  EventStreamHeadFilter get eventStreamHead => $_getN(4);
  @$pb.TagNumber(5)
  set eventStreamHead(EventStreamHeadFilter value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasEventStreamHead() => $_has(4);
  @$pb.TagNumber(5)
  void clearEventStreamHead() => $_clearField(5);
  @$pb.TagNumber(5)
  EventStreamHeadFilter ensureEventStreamHead() => $_ensure(4);
}

/// Match by transaction sender address.
class SenderFilter extends $pb.GeneratedMessage {
  factory SenderFilter({
    $core.String? address,
  }) {
    final result = create();
    if (address != null) result.address = address;
    return result;
  }

  SenderFilter._();

  factory SenderFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SenderFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SenderFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SenderFilter clone() => SenderFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SenderFilter copyWith(void Function(SenderFilter) updates) =>
      super.copyWith((message) => updates(message as SenderFilter))
          as SenderFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SenderFilter create() => SenderFilter._();
  @$core.override
  SenderFilter createEmptyInstance() => create();
  static $pb.PbList<SenderFilter> createRepeated() =>
      $pb.PbList<SenderFilter>();
  @$core.pragma('dart2js:noInline')
  static SenderFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SenderFilter>(create);
  static SenderFilter? _defaultInstance;

  /// The sender address (hex-encoded).
  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);
}

/// Match by any address whose state moved as a side effect of the
/// transaction: object ownership changes (in either direction), prior
/// owners of removed/wrapped objects, and address-balance changes via
/// accumulator events.
class AffectedAddressFilter extends $pb.GeneratedMessage {
  factory AffectedAddressFilter({
    $core.String? address,
  }) {
    final result = create();
    if (address != null) result.address = address;
    return result;
  }

  AffectedAddressFilter._();

  factory AffectedAddressFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AffectedAddressFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AffectedAddressFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AffectedAddressFilter clone() =>
      AffectedAddressFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AffectedAddressFilter copyWith(
          void Function(AffectedAddressFilter) updates) =>
      super.copyWith((message) => updates(message as AffectedAddressFilter))
          as AffectedAddressFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AffectedAddressFilter create() => AffectedAddressFilter._();
  @$core.override
  AffectedAddressFilter createEmptyInstance() => create();
  static $pb.PbList<AffectedAddressFilter> createRepeated() =>
      $pb.PbList<AffectedAddressFilter>();
  @$core.pragma('dart2js:noInline')
  static AffectedAddressFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AffectedAddressFilter>(create);
  static AffectedAddressFilter? _defaultInstance;

  /// The affected address (hex-encoded).
  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);
}

/// Match by changed object ID.
class AffectedObjectFilter extends $pb.GeneratedMessage {
  factory AffectedObjectFilter({
    $core.String? objectId,
  }) {
    final result = create();
    if (objectId != null) result.objectId = objectId;
    return result;
  }

  AffectedObjectFilter._();

  factory AffectedObjectFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AffectedObjectFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AffectedObjectFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'objectId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AffectedObjectFilter clone() =>
      AffectedObjectFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AffectedObjectFilter copyWith(void Function(AffectedObjectFilter) updates) =>
      super.copyWith((message) => updates(message as AffectedObjectFilter))
          as AffectedObjectFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AffectedObjectFilter create() => AffectedObjectFilter._();
  @$core.override
  AffectedObjectFilter createEmptyInstance() => create();
  static $pb.PbList<AffectedObjectFilter> createRepeated() =>
      $pb.PbList<AffectedObjectFilter>();
  @$core.pragma('dart2js:noInline')
  static AffectedObjectFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AffectedObjectFilter>(create);
  static AffectedObjectFilter? _defaultInstance;

  /// The changed object ID (hex-encoded).
  @$pb.TagNumber(1)
  $core.String get objectId => $_getSZ(0);
  @$pb.TagNumber(1)
  set objectId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasObjectId() => $_has(0);
  @$pb.TagNumber(1)
  void clearObjectId() => $_clearField(1);
}

/// Match by Move function call, specified as a `::`-delimited Move path.
///
/// Specificity levels:
///   "0xpkg"                        -> matches any call in the package
///   "0xpkg::module"                -> matches any call in the module
///   "0xpkg::module::function"      -> matches calls to the exact function
class MoveCallFilter extends $pb.GeneratedMessage {
  factory MoveCallFilter({
    $core.String? function,
  }) {
    final result = create();
    if (function != null) result.function = function;
    return result;
  }

  MoveCallFilter._();

  factory MoveCallFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoveCallFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoveCallFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'function')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveCallFilter clone() => MoveCallFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveCallFilter copyWith(void Function(MoveCallFilter) updates) =>
      super.copyWith((message) => updates(message as MoveCallFilter))
          as MoveCallFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoveCallFilter create() => MoveCallFilter._();
  @$core.override
  MoveCallFilter createEmptyInstance() => create();
  static $pb.PbList<MoveCallFilter> createRepeated() =>
      $pb.PbList<MoveCallFilter>();
  @$core.pragma('dart2js:noInline')
  static MoveCallFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MoveCallFilter>(create);
  static MoveCallFilter? _defaultInstance;

  /// Required. Move path of the form `package[::module[::function]]`.
  @$pb.TagNumber(1)
  $core.String get function => $_getSZ(0);
  @$pb.TagNumber(1)
  set function($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFunction() => $_has(0);
  @$pb.TagNumber(1)
  void clearFunction() => $_clearField(1);
}

/// Match by an event's package/module fields, specified as a `::`-delimited
/// Move path. These identify the top-level Move call that triggered the event.
///
/// Specificity levels:
///   "0xpkg"               -> matches events with this package_id
///   "0xpkg::module"       -> matches events with this package_id and module
class EmitModuleFilter extends $pb.GeneratedMessage {
  factory EmitModuleFilter({
    $core.String? module,
  }) {
    final result = create();
    if (module != null) result.module = module;
    return result;
  }

  EmitModuleFilter._();

  factory EmitModuleFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EmitModuleFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EmitModuleFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'module')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmitModuleFilter clone() => EmitModuleFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EmitModuleFilter copyWith(void Function(EmitModuleFilter) updates) =>
      super.copyWith((message) => updates(message as EmitModuleFilter))
          as EmitModuleFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EmitModuleFilter create() => EmitModuleFilter._();
  @$core.override
  EmitModuleFilter createEmptyInstance() => create();
  static $pb.PbList<EmitModuleFilter> createRepeated() =>
      $pb.PbList<EmitModuleFilter>();
  @$core.pragma('dart2js:noInline')
  static EmitModuleFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EmitModuleFilter>(create);
  static EmitModuleFilter? _defaultInstance;

  /// Required. Move path of the form `package[::module]`.
  @$pb.TagNumber(1)
  $core.String get module => $_getSZ(0);
  @$pb.TagNumber(1)
  set module($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasModule() => $_has(0);
  @$pb.TagNumber(1)
  void clearModule() => $_clearField(1);
}

/// Match by event struct type, specified as a Move type string.
///
/// Specificity levels:
///   "0xaddr"                              -> matches events whose type is defined at this address
///   "0xaddr::module"                      -> matches events whose type is in this module
///   "0xaddr::module::Name"                -> matches events with this type name (any instantiation)
///   "0xaddr::module::Name<T1, T2>"        -> matches events with this exact generic instantiation
class EventTypeFilter extends $pb.GeneratedMessage {
  factory EventTypeFilter({
    $core.String? eventType,
  }) {
    final result = create();
    if (eventType != null) result.eventType = eventType;
    return result;
  }

  EventTypeFilter._();

  factory EventTypeFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventTypeFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventTypeFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'eventType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventTypeFilter clone() => EventTypeFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventTypeFilter copyWith(void Function(EventTypeFilter) updates) =>
      super.copyWith((message) => updates(message as EventTypeFilter))
          as EventTypeFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventTypeFilter create() => EventTypeFilter._();
  @$core.override
  EventTypeFilter createEmptyInstance() => create();
  static $pb.PbList<EventTypeFilter> createRepeated() =>
      $pb.PbList<EventTypeFilter>();
  @$core.pragma('dart2js:noInline')
  static EventTypeFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventTypeFilter>(create);
  static EventTypeFilter? _defaultInstance;

  /// Required. Move type string of the form
  /// `address[::module[::Name[<type_params>]]]`.
  @$pb.TagNumber(1)
  $core.String get eventType => $_getSZ(0);
  @$pb.TagNumber(1)
  set eventType($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEventType() => $_has(0);
  @$pb.TagNumber(1)
  void clearEventType() => $_clearField(1);
}

/// Match by authenticated event stream head.
class EventStreamHeadFilter extends $pb.GeneratedMessage {
  factory EventStreamHeadFilter({
    $core.String? streamId,
  }) {
    final result = create();
    if (streamId != null) result.streamId = streamId;
    return result;
  }

  EventStreamHeadFilter._();

  factory EventStreamHeadFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EventStreamHeadFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EventStreamHeadFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'streamId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventStreamHeadFilter clone() =>
      EventStreamHeadFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EventStreamHeadFilter copyWith(
          void Function(EventStreamHeadFilter) updates) =>
      super.copyWith((message) => updates(message as EventStreamHeadFilter))
          as EventStreamHeadFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventStreamHeadFilter create() => EventStreamHeadFilter._();
  @$core.override
  EventStreamHeadFilter createEmptyInstance() => create();
  static $pb.PbList<EventStreamHeadFilter> createRepeated() =>
      $pb.PbList<EventStreamHeadFilter>();
  @$core.pragma('dart2js:noInline')
  static EventStreamHeadFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EventStreamHeadFilter>(create);
  static EventStreamHeadFilter? _defaultInstance;

  /// The stream id address (hex-encoded).
  @$pb.TagNumber(1)
  $core.String get streamId => $_getSZ(0);
  @$pb.TagNumber(1)
  set streamId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStreamId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStreamId() => $_clearField(1);
}

/// Match transactions that wrote a Move package.
class PackageWriteFilter extends $pb.GeneratedMessage {
  factory PackageWriteFilter() => create();

  PackageWriteFilter._();

  factory PackageWriteFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PackageWriteFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PackageWriteFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PackageWriteFilter clone() => PackageWriteFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PackageWriteFilter copyWith(void Function(PackageWriteFilter) updates) =>
      super.copyWith((message) => updates(message as PackageWriteFilter))
          as PackageWriteFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PackageWriteFilter create() => PackageWriteFilter._();
  @$core.override
  PackageWriteFilter createEmptyInstance() => create();
  static $pb.PbList<PackageWriteFilter> createRepeated() =>
      $pb.PbList<PackageWriteFilter>();
  @$core.pragma('dart2js:noInline')
  static PackageWriteFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PackageWriteFilter>(create);
  static PackageWriteFilter? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
