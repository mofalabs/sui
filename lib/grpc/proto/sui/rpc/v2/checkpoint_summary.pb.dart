// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/checkpoint_summary.proto.

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
import 'bcs.pb.dart' as $0;
import 'checkpoint_summary.pbenum.dart';
import 'gas_cost_summary.pb.dart' as $1;
import 'signature.pb.dart' as $3;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'checkpoint_summary.pbenum.dart';

/// A header for a checkpoint on the Sui blockchain.
///
/// On the Sui network, checkpoints define the history of the blockchain. They are quite similar to
/// the concept of blocks used by other blockchains like Bitcoin or Ethereum. The Sui blockchain,
/// however, forms checkpoints after transaction execution has already happened to provide a
/// certified history of the chain, instead of being formed before execution.
///
/// Checkpoints commit to a variety of state, including but not limited to:
/// - The hash of the previous checkpoint.
/// - The set of transaction digests, their corresponding effects digests, as well as the set of
///   user signatures that authorized its execution.
/// - The objects produced by a transaction.
/// - The set of live objects that make up the current state of the chain.
/// - On epoch transitions, the next validator committee.
///
/// `CheckpointSummary`s themselves don't directly include all of the previous information but they
/// are the top-level type by which all the information is committed to transitively via cryptographic
/// hashes included in the summary. `CheckpointSummary`s are signed and certified by a quorum of
/// the validator committee in a given epoch to allow verification of the chain's state.
class CheckpointSummary extends $pb.GeneratedMessage {
  factory CheckpointSummary({
    $0.Bcs? bcs,
    $core.String? digest,
    $fixnum.Int64? epoch,
    $fixnum.Int64? sequenceNumber,
    $fixnum.Int64? totalNetworkTransactions,
    $core.String? contentDigest,
    $core.String? previousDigest,
    $1.GasCostSummary? epochRollingGasCostSummary,
    $2.Timestamp? timestamp,
    $core.Iterable<CheckpointCommitment>? commitments,
    EndOfEpochData? endOfEpochData,
    $core.List<$core.int>? versionSpecificData,
  }) {
    final result = create();
    if (bcs != null) result.bcs = bcs;
    if (digest != null) result.digest = digest;
    if (epoch != null) result.epoch = epoch;
    if (sequenceNumber != null) result.sequenceNumber = sequenceNumber;
    if (totalNetworkTransactions != null)
      result.totalNetworkTransactions = totalNetworkTransactions;
    if (contentDigest != null) result.contentDigest = contentDigest;
    if (previousDigest != null) result.previousDigest = previousDigest;
    if (epochRollingGasCostSummary != null)
      result.epochRollingGasCostSummary = epochRollingGasCostSummary;
    if (timestamp != null) result.timestamp = timestamp;
    if (commitments != null) result.commitments.addAll(commitments);
    if (endOfEpochData != null) result.endOfEpochData = endOfEpochData;
    if (versionSpecificData != null)
      result.versionSpecificData = versionSpecificData;
    return result;
  }

  CheckpointSummary._();

  factory CheckpointSummary.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckpointSummary.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckpointSummary',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<$0.Bcs>(1, _omitFieldNames ? '' : 'bcs', subBuilder: $0.Bcs.create)
    ..aOS(2, _omitFieldNames ? '' : 'digest')
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'sequenceNumber', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'totalNetworkTransactions',
        $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(6, _omitFieldNames ? '' : 'contentDigest')
    ..aOS(7, _omitFieldNames ? '' : 'previousDigest')
    ..aOM<$1.GasCostSummary>(
        8, _omitFieldNames ? '' : 'epochRollingGasCostSummary',
        subBuilder: $1.GasCostSummary.create)
    ..aOM<$2.Timestamp>(9, _omitFieldNames ? '' : 'timestamp',
        subBuilder: $2.Timestamp.create)
    ..pc<CheckpointCommitment>(
        10, _omitFieldNames ? '' : 'commitments', $pb.PbFieldType.PM,
        subBuilder: CheckpointCommitment.create)
    ..aOM<EndOfEpochData>(11, _omitFieldNames ? '' : 'endOfEpochData',
        subBuilder: EndOfEpochData.create)
    ..a<$core.List<$core.int>>(
        12, _omitFieldNames ? '' : 'versionSpecificData', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckpointSummary clone() => CheckpointSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckpointSummary copyWith(void Function(CheckpointSummary) updates) =>
      super.copyWith((message) => updates(message as CheckpointSummary))
          as CheckpointSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckpointSummary create() => CheckpointSummary._();
  @$core.override
  CheckpointSummary createEmptyInstance() => create();
  static $pb.PbList<CheckpointSummary> createRepeated() =>
      $pb.PbList<CheckpointSummary>();
  @$core.pragma('dart2js:noInline')
  static CheckpointSummary getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckpointSummary>(create);
  static CheckpointSummary? _defaultInstance;

  /// This CheckpointSummary serialized as BCS.
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

  /// The digest of this CheckpointSummary.
  @$pb.TagNumber(2)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(2)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => $_clearField(2);

  /// Epoch that this checkpoint belongs to.
  @$pb.TagNumber(3)
  $fixnum.Int64 get epoch => $_getI64(2);
  @$pb.TagNumber(3)
  set epoch($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasEpoch() => $_has(2);
  @$pb.TagNumber(3)
  void clearEpoch() => $_clearField(3);

  /// The height of this checkpoint.
  @$pb.TagNumber(4)
  $fixnum.Int64 get sequenceNumber => $_getI64(3);
  @$pb.TagNumber(4)
  set sequenceNumber($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSequenceNumber() => $_has(3);
  @$pb.TagNumber(4)
  void clearSequenceNumber() => $_clearField(4);

  /// Total number of transactions committed since genesis, including those in this
  /// checkpoint.
  @$pb.TagNumber(5)
  $fixnum.Int64 get totalNetworkTransactions => $_getI64(4);
  @$pb.TagNumber(5)
  set totalNetworkTransactions($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTotalNetworkTransactions() => $_has(4);
  @$pb.TagNumber(5)
  void clearTotalNetworkTransactions() => $_clearField(5);

  /// The hash of the `CheckpointContents` for this checkpoint.
  @$pb.TagNumber(6)
  $core.String get contentDigest => $_getSZ(5);
  @$pb.TagNumber(6)
  set contentDigest($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasContentDigest() => $_has(5);
  @$pb.TagNumber(6)
  void clearContentDigest() => $_clearField(6);

  /// The hash of the previous `CheckpointSummary`.
  ///
  /// This will be `None` only for the first, or genesis, checkpoint.
  @$pb.TagNumber(7)
  $core.String get previousDigest => $_getSZ(6);
  @$pb.TagNumber(7)
  set previousDigest($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasPreviousDigest() => $_has(6);
  @$pb.TagNumber(7)
  void clearPreviousDigest() => $_clearField(7);

  /// The running total gas costs of all transactions included in the current epoch so far
  /// until this checkpoint.
  @$pb.TagNumber(8)
  $1.GasCostSummary get epochRollingGasCostSummary => $_getN(7);
  @$pb.TagNumber(8)
  set epochRollingGasCostSummary($1.GasCostSummary value) =>
      $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasEpochRollingGasCostSummary() => $_has(7);
  @$pb.TagNumber(8)
  void clearEpochRollingGasCostSummary() => $_clearField(8);
  @$pb.TagNumber(8)
  $1.GasCostSummary ensureEpochRollingGasCostSummary() => $_ensure(7);

  /// Timestamp of the checkpoint - number of milliseconds from the Unix epoch
  /// Checkpoint timestamps are monotonic, but not strongly monotonic - subsequent
  /// checkpoints can have the same timestamp if they originate from the same underlining consensus commit.
  @$pb.TagNumber(9)
  $2.Timestamp get timestamp => $_getN(8);
  @$pb.TagNumber(9)
  set timestamp($2.Timestamp value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasTimestamp() => $_has(8);
  @$pb.TagNumber(9)
  void clearTimestamp() => $_clearField(9);
  @$pb.TagNumber(9)
  $2.Timestamp ensureTimestamp() => $_ensure(8);

  /// Commitments to checkpoint-specific state.
  @$pb.TagNumber(10)
  $pb.PbList<CheckpointCommitment> get commitments => $_getList(9);

  /// Extra data only present in the final checkpoint of an epoch.
  @$pb.TagNumber(11)
  EndOfEpochData get endOfEpochData => $_getN(10);
  @$pb.TagNumber(11)
  set endOfEpochData(EndOfEpochData value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasEndOfEpochData() => $_has(10);
  @$pb.TagNumber(11)
  void clearEndOfEpochData() => $_clearField(11);
  @$pb.TagNumber(11)
  EndOfEpochData ensureEndOfEpochData() => $_ensure(10);

  /// `CheckpointSummary` is not an evolvable structure - it must be readable by any version of
  /// the code. Therefore, to allow extensions to be added to `CheckpointSummary`,
  /// opaque data can be added to checkpoints, which can be deserialized based on the current
  /// protocol version.
  @$pb.TagNumber(12)
  $core.List<$core.int> get versionSpecificData => $_getN(11);
  @$pb.TagNumber(12)
  set versionSpecificData($core.List<$core.int> value) => $_setBytes(11, value);
  @$pb.TagNumber(12)
  $core.bool hasVersionSpecificData() => $_has(11);
  @$pb.TagNumber(12)
  void clearVersionSpecificData() => $_clearField(12);
}

/// Data, which when included in a `CheckpointSummary`, signals the end of an `Epoch`.
class EndOfEpochData extends $pb.GeneratedMessage {
  factory EndOfEpochData({
    $core.Iterable<$3.ValidatorCommitteeMember>? nextEpochCommittee,
    $fixnum.Int64? nextEpochProtocolVersion,
    $core.Iterable<CheckpointCommitment>? epochCommitments,
  }) {
    final result = create();
    if (nextEpochCommittee != null)
      result.nextEpochCommittee.addAll(nextEpochCommittee);
    if (nextEpochProtocolVersion != null)
      result.nextEpochProtocolVersion = nextEpochProtocolVersion;
    if (epochCommitments != null)
      result.epochCommitments.addAll(epochCommitments);
    return result;
  }

  EndOfEpochData._();

  factory EndOfEpochData.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EndOfEpochData.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EndOfEpochData',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<$3.ValidatorCommitteeMember>(
        1, _omitFieldNames ? '' : 'nextEpochCommittee', $pb.PbFieldType.PM,
        subBuilder: $3.ValidatorCommitteeMember.create)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'nextEpochProtocolVersion',
        $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<CheckpointCommitment>(
        3, _omitFieldNames ? '' : 'epochCommitments', $pb.PbFieldType.PM,
        subBuilder: CheckpointCommitment.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndOfEpochData clone() => EndOfEpochData()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EndOfEpochData copyWith(void Function(EndOfEpochData) updates) =>
      super.copyWith((message) => updates(message as EndOfEpochData))
          as EndOfEpochData;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EndOfEpochData create() => EndOfEpochData._();
  @$core.override
  EndOfEpochData createEmptyInstance() => create();
  static $pb.PbList<EndOfEpochData> createRepeated() =>
      $pb.PbList<EndOfEpochData>();
  @$core.pragma('dart2js:noInline')
  static EndOfEpochData getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EndOfEpochData>(create);
  static EndOfEpochData? _defaultInstance;

  /// The set of validators that will be in the `ValidatorCommittee` for the next epoch.
  @$pb.TagNumber(1)
  $pb.PbList<$3.ValidatorCommitteeMember> get nextEpochCommittee =>
      $_getList(0);

  /// The protocol version that is in effect during the next epoch.
  @$pb.TagNumber(2)
  $fixnum.Int64 get nextEpochProtocolVersion => $_getI64(1);
  @$pb.TagNumber(2)
  set nextEpochProtocolVersion($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextEpochProtocolVersion() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextEpochProtocolVersion() => $_clearField(2);

  /// Commitments to epoch specific state (live object set)
  @$pb.TagNumber(3)
  $pb.PbList<CheckpointCommitment> get epochCommitments => $_getList(2);
}

/// A commitment made by a checkpoint.
class CheckpointCommitment extends $pb.GeneratedMessage {
  factory CheckpointCommitment({
    CheckpointCommitment_CheckpointCommitmentKind? kind,
    $core.String? digest,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (digest != null) result.digest = digest;
    return result;
  }

  CheckpointCommitment._();

  factory CheckpointCommitment.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CheckpointCommitment.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckpointCommitment',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..e<CheckpointCommitment_CheckpointCommitmentKind>(
        1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: CheckpointCommitment_CheckpointCommitmentKind
            .CHECKPOINT_COMMITMENT_KIND_UNKNOWN,
        valueOf: CheckpointCommitment_CheckpointCommitmentKind.valueOf,
        enumValues: CheckpointCommitment_CheckpointCommitmentKind.values)
    ..aOS(2, _omitFieldNames ? '' : 'digest')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckpointCommitment clone() =>
      CheckpointCommitment()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckpointCommitment copyWith(void Function(CheckpointCommitment) updates) =>
      super.copyWith((message) => updates(message as CheckpointCommitment))
          as CheckpointCommitment;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckpointCommitment create() => CheckpointCommitment._();
  @$core.override
  CheckpointCommitment createEmptyInstance() => create();
  static $pb.PbList<CheckpointCommitment> createRepeated() =>
      $pb.PbList<CheckpointCommitment>();
  @$core.pragma('dart2js:noInline')
  static CheckpointCommitment getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckpointCommitment>(create);
  static CheckpointCommitment? _defaultInstance;

  @$pb.TagNumber(1)
  CheckpointCommitment_CheckpointCommitmentKind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(CheckpointCommitment_CheckpointCommitmentKind value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(2)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
