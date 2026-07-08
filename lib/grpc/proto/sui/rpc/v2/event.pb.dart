// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/event.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/struct.pb.dart' as $1;
import 'bcs.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Events emitted during the successful execution of a transaction.
class TransactionEvents extends $pb.GeneratedMessage {
  factory TransactionEvents({
    $0.Bcs? bcs,
    $core.String? digest,
    $core.Iterable<Event>? events,
  }) {
    final result = create();
    if (bcs != null) result.bcs = bcs;
    if (digest != null) result.digest = digest;
    if (events != null) result.events.addAll(events);
    return result;
  }

  TransactionEvents._();

  factory TransactionEvents.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory TransactionEvents.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TransactionEvents', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$0.Bcs>(1, _omitFieldNames ? '' : 'bcs', subBuilder: $0.Bcs.create)
    ..aOS(2, _omitFieldNames ? '' : 'digest')
    ..pc<Event>(3, _omitFieldNames ? '' : 'events', $pb.PbFieldType.PM, subBuilder: Event.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionEvents clone() => TransactionEvents()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TransactionEvents copyWith(void Function(TransactionEvents) updates) => super.copyWith((message) => updates(message as TransactionEvents)) as TransactionEvents;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TransactionEvents create() => TransactionEvents._();
  @$core.override
  TransactionEvents createEmptyInstance() => create();
  static $pb.PbList<TransactionEvents> createRepeated() => $pb.PbList<TransactionEvents>();
  @$core.pragma('dart2js:noInline')
  static TransactionEvents getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TransactionEvents>(create);
  static TransactionEvents? _defaultInstance;

  /// This TransactionEvents serialized as BCS.
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

  /// The digest of this TransactionEvents.
  @$pb.TagNumber(2)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(2)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => $_clearField(2);

  /// Set of events emitted by a transaction.
  @$pb.TagNumber(3)
  $pb.PbList<Event> get events => $_getList(2);
}

/// An event.
class Event extends $pb.GeneratedMessage {
  factory Event({
    $core.String? packageId,
    $core.String? module,
    $core.String? sender,
    $core.String? eventType,
    $0.Bcs? contents,
    $1.Value? json,
  }) {
    final result = create();
    if (packageId != null) result.packageId = packageId;
    if (module != null) result.module = module;
    if (sender != null) result.sender = sender;
    if (eventType != null) result.eventType = eventType;
    if (contents != null) result.contents = contents;
    if (json != null) result.json = json;
    return result;
  }

  Event._();

  factory Event.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Event.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Event', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'packageId')
    ..aOS(2, _omitFieldNames ? '' : 'module')
    ..aOS(3, _omitFieldNames ? '' : 'sender')
    ..aOS(4, _omitFieldNames ? '' : 'eventType')
    ..aOM<$0.Bcs>(5, _omitFieldNames ? '' : 'contents', subBuilder: $0.Bcs.create)
    ..aOM<$1.Value>(6, _omitFieldNames ? '' : 'json', subBuilder: $1.Value.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Event clone() => Event()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Event copyWith(void Function(Event) updates) => super.copyWith((message) => updates(message as Event)) as Event;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Event create() => Event._();
  @$core.override
  Event createEmptyInstance() => create();
  static $pb.PbList<Event> createRepeated() => $pb.PbList<Event>();
  @$core.pragma('dart2js:noInline')
  static Event getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Event>(create);
  static Event? _defaultInstance;

  /// Package ID of the top-level function invoked by a `MoveCall` command that triggered this
  /// event to be emitted.
  @$pb.TagNumber(1)
  $core.String get packageId => $_getSZ(0);
  @$pb.TagNumber(1)
  set packageId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackageId() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackageId() => $_clearField(1);

  /// Module name of the top-level function invoked by a `MoveCall` command that triggered this
  /// event to be emitted.
  @$pb.TagNumber(2)
  $core.String get module => $_getSZ(1);
  @$pb.TagNumber(2)
  set module($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasModule() => $_has(1);
  @$pb.TagNumber(2)
  void clearModule() => $_clearField(2);

  /// Address of the account that sent the transaction where this event was emitted.
  @$pb.TagNumber(3)
  $core.String get sender => $_getSZ(2);
  @$pb.TagNumber(3)
  set sender($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSender() => $_has(2);
  @$pb.TagNumber(3)
  void clearSender() => $_clearField(3);

  /// The type of the event emitted.
  @$pb.TagNumber(4)
  $core.String get eventType => $_getSZ(3);
  @$pb.TagNumber(4)
  set eventType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasEventType() => $_has(3);
  @$pb.TagNumber(4)
  void clearEventType() => $_clearField(4);

  /// BCS serialized bytes of the event.
  @$pb.TagNumber(5)
  $0.Bcs get contents => $_getN(4);
  @$pb.TagNumber(5)
  set contents($0.Bcs value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasContents() => $_has(4);
  @$pb.TagNumber(5)
  void clearContents() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Bcs ensureContents() => $_ensure(4);

  /// JSON rendering of the event.
  @$pb.TagNumber(6)
  $1.Value get json => $_getN(5);
  @$pb.TagNumber(6)
  set json($1.Value value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasJson() => $_has(5);
  @$pb.TagNumber(6)
  void clearJson() => $_clearField(6);
  @$pb.TagNumber(6)
  $1.Value ensureJson() => $_ensure(5);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
