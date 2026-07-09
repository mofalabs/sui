// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/checkpoint.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'checkpoint_contents.pb.dart' as $2;
import 'checkpoint_summary.pb.dart' as $0;
import 'executed_transaction.pb.dart' as $3;
import 'object.pb.dart' as $4;
import 'signature.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class Checkpoint extends $pb.GeneratedMessage {
  factory Checkpoint({
    $fixnum.Int64? sequenceNumber,
    $core.String? digest,
    $0.CheckpointSummary? summary,
    $1.ValidatorAggregatedSignature? signature,
    $2.CheckpointContents? contents,
    $core.Iterable<$3.ExecutedTransaction>? transactions,
    $4.ObjectSet? objects,
  }) {
    final result = create();
    if (sequenceNumber != null) result.sequenceNumber = sequenceNumber;
    if (digest != null) result.digest = digest;
    if (summary != null) result.summary = summary;
    if (signature != null) result.signature = signature;
    if (contents != null) result.contents = contents;
    if (transactions != null) result.transactions.addAll(transactions);
    if (objects != null) result.objects = objects;
    return result;
  }

  Checkpoint._();

  factory Checkpoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Checkpoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Checkpoint',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'sequenceNumber', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'digest')
    ..aOM<$0.CheckpointSummary>(3, _omitFieldNames ? '' : 'summary',
        subBuilder: $0.CheckpointSummary.create)
    ..aOM<$1.ValidatorAggregatedSignature>(
        4, _omitFieldNames ? '' : 'signature',
        subBuilder: $1.ValidatorAggregatedSignature.create)
    ..aOM<$2.CheckpointContents>(5, _omitFieldNames ? '' : 'contents',
        subBuilder: $2.CheckpointContents.create)
    ..pc<$3.ExecutedTransaction>(
        6, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM,
        subBuilder: $3.ExecutedTransaction.create)
    ..aOM<$4.ObjectSet>(7, _omitFieldNames ? '' : 'objects',
        subBuilder: $4.ObjectSet.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Checkpoint clone() => Checkpoint()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Checkpoint copyWith(void Function(Checkpoint) updates) =>
      super.copyWith((message) => updates(message as Checkpoint)) as Checkpoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Checkpoint create() => Checkpoint._();
  @$core.override
  Checkpoint createEmptyInstance() => create();
  static $pb.PbList<Checkpoint> createRepeated() => $pb.PbList<Checkpoint>();
  @$core.pragma('dart2js:noInline')
  static Checkpoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Checkpoint>(create);
  static Checkpoint? _defaultInstance;

  /// The height of this checkpoint.
  @$pb.TagNumber(1)
  $fixnum.Int64 get sequenceNumber => $_getI64(0);
  @$pb.TagNumber(1)
  set sequenceNumber($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSequenceNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearSequenceNumber() => $_clearField(1);

  /// The digest of this Checkpoint's CheckpointSummary.
  @$pb.TagNumber(2)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(2)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => $_clearField(2);

  /// The `CheckpointSummary` for this checkpoint.
  @$pb.TagNumber(3)
  $0.CheckpointSummary get summary => $_getN(2);
  @$pb.TagNumber(3)
  set summary($0.CheckpointSummary value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSummary() => $_has(2);
  @$pb.TagNumber(3)
  void clearSummary() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.CheckpointSummary ensureSummary() => $_ensure(2);

  /// An aggregated quorum signature from the validator committee that
  /// certified this checkpoint.
  @$pb.TagNumber(4)
  $1.ValidatorAggregatedSignature get signature => $_getN(3);
  @$pb.TagNumber(4)
  set signature($1.ValidatorAggregatedSignature value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasSignature() => $_has(3);
  @$pb.TagNumber(4)
  void clearSignature() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.ValidatorAggregatedSignature ensureSignature() => $_ensure(3);

  /// The `CheckpointContents` for this checkpoint.
  @$pb.TagNumber(5)
  $2.CheckpointContents get contents => $_getN(4);
  @$pb.TagNumber(5)
  set contents($2.CheckpointContents value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasContents() => $_has(4);
  @$pb.TagNumber(5)
  void clearContents() => $_clearField(5);
  @$pb.TagNumber(5)
  $2.CheckpointContents ensureContents() => $_ensure(4);

  /// List of transactions included in this checkpoint.
  @$pb.TagNumber(6)
  $pb.PbList<$3.ExecutedTransaction> get transactions => $_getList(5);

  /// Set of objects either referenced as inputs or produced as
  /// outputs by transactions included in this checkpoint.
  ///
  /// In order to benefit from deduplication of objects that
  /// appear in multiple transactions in this checkpoint, objects
  /// will only be present here and the `transactions.objects`
  /// field will not be populated.
  @$pb.TagNumber(7)
  $4.ObjectSet get objects => $_getN(6);
  @$pb.TagNumber(7)
  set objects($4.ObjectSet value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasObjects() => $_has(6);
  @$pb.TagNumber(7)
  void clearObjects() => $_clearField(7);
  @$pb.TagNumber(7)
  $4.ObjectSet ensureObjects() => $_ensure(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
