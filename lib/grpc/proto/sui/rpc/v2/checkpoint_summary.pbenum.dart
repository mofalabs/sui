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

import 'package:protobuf/protobuf.dart' as $pb;

class CheckpointCommitment_CheckpointCommitmentKind extends $pb.ProtobufEnum {
  static const CheckpointCommitment_CheckpointCommitmentKind
      CHECKPOINT_COMMITMENT_KIND_UNKNOWN =
      CheckpointCommitment_CheckpointCommitmentKind._(
          0, _omitEnumNames ? '' : 'CHECKPOINT_COMMITMENT_KIND_UNKNOWN');

  /// An elliptic curve multiset hash attesting to the set of objects that
  /// comprise the live state of the Sui blockchain.
  static const CheckpointCommitment_CheckpointCommitmentKind
      ECMH_LIVE_OBJECT_SET = CheckpointCommitment_CheckpointCommitmentKind._(
          1, _omitEnumNames ? '' : 'ECMH_LIVE_OBJECT_SET');

  /// Digest of the checkpoint artifacts.
  static const CheckpointCommitment_CheckpointCommitmentKind
      CHECKPOINT_ARTIFACTS = CheckpointCommitment_CheckpointCommitmentKind._(
          2, _omitEnumNames ? '' : 'CHECKPOINT_ARTIFACTS');

  static const $core.List<CheckpointCommitment_CheckpointCommitmentKind>
      values = <CheckpointCommitment_CheckpointCommitmentKind>[
    CHECKPOINT_COMMITMENT_KIND_UNKNOWN,
    ECMH_LIVE_OBJECT_SET,
    CHECKPOINT_ARTIFACTS,
  ];

  static final $core.List<CheckpointCommitment_CheckpointCommitmentKind?>
      _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static CheckpointCommitment_CheckpointCommitmentKind? valueOf(
          $core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CheckpointCommitment_CheckpointCommitmentKind._(
      super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
