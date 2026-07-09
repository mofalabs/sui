// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/epoch.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import '../../../google/protobuf/timestamp.pb.dart' as $2;
import 'protocol_config.pb.dart' as $3;
import 'signature.pb.dart' as $0;
import 'system_state.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Epoch extends $pb.GeneratedMessage {
  factory Epoch({
    $fixnum.Int64? epoch,
    $0.ValidatorCommittee? committee,
    $1.SystemState? systemState,
    $fixnum.Int64? firstCheckpoint,
    $fixnum.Int64? lastCheckpoint,
    $2.Timestamp? start,
    $2.Timestamp? end,
    $fixnum.Int64? referenceGasPrice,
    $3.ProtocolConfig? protocolConfig,
  }) {
    final result = create();
    if (epoch != null) result.epoch = epoch;
    if (committee != null) result.committee = committee;
    if (systemState != null) result.systemState = systemState;
    if (firstCheckpoint != null) result.firstCheckpoint = firstCheckpoint;
    if (lastCheckpoint != null) result.lastCheckpoint = lastCheckpoint;
    if (start != null) result.start = start;
    if (end != null) result.end = end;
    if (referenceGasPrice != null) result.referenceGasPrice = referenceGasPrice;
    if (protocolConfig != null) result.protocolConfig = protocolConfig;
    return result;
  }

  Epoch._();

  factory Epoch.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Epoch.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Epoch',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$0.ValidatorCommittee>(2, _omitFieldNames ? '' : 'committee',
        subBuilder: $0.ValidatorCommittee.create)
    ..aOM<$1.SystemState>(3, _omitFieldNames ? '' : 'systemState',
        subBuilder: $1.SystemState.create)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'firstCheckpoint', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'lastCheckpoint', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$2.Timestamp>(6, _omitFieldNames ? '' : 'start',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(7, _omitFieldNames ? '' : 'end',
        subBuilder: $2.Timestamp.create)
    ..a<$fixnum.Int64>(
        8, _omitFieldNames ? '' : 'referenceGasPrice', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<$3.ProtocolConfig>(9, _omitFieldNames ? '' : 'protocolConfig',
        subBuilder: $3.ProtocolConfig.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Epoch clone() => Epoch()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Epoch copyWith(void Function(Epoch) updates) =>
      super.copyWith((message) => updates(message as Epoch)) as Epoch;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Epoch create() => Epoch._();
  @$core.override
  Epoch createEmptyInstance() => create();
  static $pb.PbList<Epoch> createRepeated() => $pb.PbList<Epoch>();
  @$core.pragma('dart2js:noInline')
  static Epoch getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Epoch>(create);
  static Epoch? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get epoch => $_getI64(0);
  @$pb.TagNumber(1)
  set epoch($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => $_clearField(1);

  /// The committee governing this epoch.
  @$pb.TagNumber(2)
  $0.ValidatorCommittee get committee => $_getN(1);
  @$pb.TagNumber(2)
  set committee($0.ValidatorCommittee value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCommittee() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommittee() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.ValidatorCommittee ensureCommittee() => $_ensure(1);

  /// Snapshot of Sui's SystemState (`0x3::sui_system::SystemState`) at the
  /// beginning of the epoch, for past epochs, or the current state for the
  /// current epoch.
  @$pb.TagNumber(3)
  $1.SystemState get systemState => $_getN(2);
  @$pb.TagNumber(3)
  set systemState($1.SystemState value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSystemState() => $_has(2);
  @$pb.TagNumber(3)
  void clearSystemState() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.SystemState ensureSystemState() => $_ensure(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get firstCheckpoint => $_getI64(3);
  @$pb.TagNumber(4)
  set firstCheckpoint($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFirstCheckpoint() => $_has(3);
  @$pb.TagNumber(4)
  void clearFirstCheckpoint() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get lastCheckpoint => $_getI64(4);
  @$pb.TagNumber(5)
  set lastCheckpoint($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasLastCheckpoint() => $_has(4);
  @$pb.TagNumber(5)
  void clearLastCheckpoint() => $_clearField(5);

  @$pb.TagNumber(6)
  $2.Timestamp get start => $_getN(5);
  @$pb.TagNumber(6)
  set start($2.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStart() => $_has(5);
  @$pb.TagNumber(6)
  void clearStart() => $_clearField(6);
  @$pb.TagNumber(6)
  $2.Timestamp ensureStart() => $_ensure(5);

  @$pb.TagNumber(7)
  $2.Timestamp get end => $_getN(6);
  @$pb.TagNumber(7)
  set end($2.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEnd() => $_has(6);
  @$pb.TagNumber(7)
  void clearEnd() => $_clearField(7);
  @$pb.TagNumber(7)
  $2.Timestamp ensureEnd() => $_ensure(6);

  /// Reference gas price denominated in MIST
  @$pb.TagNumber(8)
  $fixnum.Int64 get referenceGasPrice => $_getI64(7);
  @$pb.TagNumber(8)
  set referenceGasPrice($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasReferenceGasPrice() => $_has(7);
  @$pb.TagNumber(8)
  void clearReferenceGasPrice() => $_clearField(8);

  @$pb.TagNumber(9)
  $3.ProtocolConfig get protocolConfig => $_getN(8);
  @$pb.TagNumber(9)
  set protocolConfig($3.ProtocolConfig value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasProtocolConfig() => $_has(8);
  @$pb.TagNumber(9)
  void clearProtocolConfig() => $_clearField(9);
  @$pb.TagNumber(9)
  $3.ProtocolConfig ensureProtocolConfig() => $_ensure(8);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
