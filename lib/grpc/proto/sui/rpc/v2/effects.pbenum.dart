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

import 'package:protobuf/protobuf.dart' as $pb;

class ChangedObject_InputObjectState extends $pb.ProtobufEnum {
  static const ChangedObject_InputObjectState INPUT_OBJECT_STATE_UNKNOWN = ChangedObject_InputObjectState._(0, _omitEnumNames ? '' : 'INPUT_OBJECT_STATE_UNKNOWN');
  static const ChangedObject_InputObjectState INPUT_OBJECT_STATE_DOES_NOT_EXIST = ChangedObject_InputObjectState._(1, _omitEnumNames ? '' : 'INPUT_OBJECT_STATE_DOES_NOT_EXIST');
  static const ChangedObject_InputObjectState INPUT_OBJECT_STATE_EXISTS = ChangedObject_InputObjectState._(2, _omitEnumNames ? '' : 'INPUT_OBJECT_STATE_EXISTS');

  static const $core.List<ChangedObject_InputObjectState> values = <ChangedObject_InputObjectState> [
    INPUT_OBJECT_STATE_UNKNOWN,
    INPUT_OBJECT_STATE_DOES_NOT_EXIST,
    INPUT_OBJECT_STATE_EXISTS,
  ];

  static final $core.List<ChangedObject_InputObjectState?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ChangedObject_InputObjectState? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ChangedObject_InputObjectState._(super.value, super.name);
}

class ChangedObject_OutputObjectState extends $pb.ProtobufEnum {
  static const ChangedObject_OutputObjectState OUTPUT_OBJECT_STATE_UNKNOWN = ChangedObject_OutputObjectState._(0, _omitEnumNames ? '' : 'OUTPUT_OBJECT_STATE_UNKNOWN');
  static const ChangedObject_OutputObjectState OUTPUT_OBJECT_STATE_DOES_NOT_EXIST = ChangedObject_OutputObjectState._(1, _omitEnumNames ? '' : 'OUTPUT_OBJECT_STATE_DOES_NOT_EXIST');
  static const ChangedObject_OutputObjectState OUTPUT_OBJECT_STATE_OBJECT_WRITE = ChangedObject_OutputObjectState._(2, _omitEnumNames ? '' : 'OUTPUT_OBJECT_STATE_OBJECT_WRITE');
  static const ChangedObject_OutputObjectState OUTPUT_OBJECT_STATE_PACKAGE_WRITE = ChangedObject_OutputObjectState._(3, _omitEnumNames ? '' : 'OUTPUT_OBJECT_STATE_PACKAGE_WRITE');
  static const ChangedObject_OutputObjectState OUTPUT_OBJECT_STATE_ACCUMULATOR_WRITE = ChangedObject_OutputObjectState._(4, _omitEnumNames ? '' : 'OUTPUT_OBJECT_STATE_ACCUMULATOR_WRITE');

  static const $core.List<ChangedObject_OutputObjectState> values = <ChangedObject_OutputObjectState> [
    OUTPUT_OBJECT_STATE_UNKNOWN,
    OUTPUT_OBJECT_STATE_DOES_NOT_EXIST,
    OUTPUT_OBJECT_STATE_OBJECT_WRITE,
    OUTPUT_OBJECT_STATE_PACKAGE_WRITE,
    OUTPUT_OBJECT_STATE_ACCUMULATOR_WRITE,
  ];

  static final $core.List<ChangedObject_OutputObjectState?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 4);
  static ChangedObject_OutputObjectState? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ChangedObject_OutputObjectState._(super.value, super.name);
}

class ChangedObject_IdOperation extends $pb.ProtobufEnum {
  static const ChangedObject_IdOperation ID_OPERATION_UNKNOWN = ChangedObject_IdOperation._(0, _omitEnumNames ? '' : 'ID_OPERATION_UNKNOWN');
  static const ChangedObject_IdOperation NONE = ChangedObject_IdOperation._(1, _omitEnumNames ? '' : 'NONE');
  static const ChangedObject_IdOperation CREATED = ChangedObject_IdOperation._(2, _omitEnumNames ? '' : 'CREATED');
  static const ChangedObject_IdOperation DELETED = ChangedObject_IdOperation._(3, _omitEnumNames ? '' : 'DELETED');

  static const $core.List<ChangedObject_IdOperation> values = <ChangedObject_IdOperation> [
    ID_OPERATION_UNKNOWN,
    NONE,
    CREATED,
    DELETED,
  ];

  static final $core.List<ChangedObject_IdOperation?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ChangedObject_IdOperation? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ChangedObject_IdOperation._(super.value, super.name);
}

class AccumulatorWrite_AccumulatorOperation extends $pb.ProtobufEnum {
  static const AccumulatorWrite_AccumulatorOperation ACCUMULATOR_OPERATION_UNKNOWN = AccumulatorWrite_AccumulatorOperation._(0, _omitEnumNames ? '' : 'ACCUMULATOR_OPERATION_UNKNOWN');
  static const AccumulatorWrite_AccumulatorOperation MERGE = AccumulatorWrite_AccumulatorOperation._(1, _omitEnumNames ? '' : 'MERGE');
  static const AccumulatorWrite_AccumulatorOperation SPLIT = AccumulatorWrite_AccumulatorOperation._(2, _omitEnumNames ? '' : 'SPLIT');

  static const $core.List<AccumulatorWrite_AccumulatorOperation> values = <AccumulatorWrite_AccumulatorOperation> [
    ACCUMULATOR_OPERATION_UNKNOWN,
    MERGE,
    SPLIT,
  ];

  static final $core.List<AccumulatorWrite_AccumulatorOperation?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 2);
  static AccumulatorWrite_AccumulatorOperation? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AccumulatorWrite_AccumulatorOperation._(super.value, super.name);
}

class AccumulatorWrite_AccumulatorValue extends $pb.ProtobufEnum {
  static const AccumulatorWrite_AccumulatorValue ACCUMULATOR_VALUE_UNKNOWN = AccumulatorWrite_AccumulatorValue._(0, _omitEnumNames ? '' : 'ACCUMULATOR_VALUE_UNKNOWN');
  static const AccumulatorWrite_AccumulatorValue INTEGER = AccumulatorWrite_AccumulatorValue._(1, _omitEnumNames ? '' : 'INTEGER');
  static const AccumulatorWrite_AccumulatorValue INTEGER_TUPLE = AccumulatorWrite_AccumulatorValue._(2, _omitEnumNames ? '' : 'INTEGER_TUPLE');
  static const AccumulatorWrite_AccumulatorValue EVENT_DIGEST = AccumulatorWrite_AccumulatorValue._(3, _omitEnumNames ? '' : 'EVENT_DIGEST');

  static const $core.List<AccumulatorWrite_AccumulatorValue> values = <AccumulatorWrite_AccumulatorValue> [
    ACCUMULATOR_VALUE_UNKNOWN,
    INTEGER,
    INTEGER_TUPLE,
    EVENT_DIGEST,
  ];

  static final $core.List<AccumulatorWrite_AccumulatorValue?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static AccumulatorWrite_AccumulatorValue? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const AccumulatorWrite_AccumulatorValue._(super.value, super.name);
}

class UnchangedConsensusObject_UnchangedConsensusObjectKind extends $pb.ProtobufEnum {
  static const UnchangedConsensusObject_UnchangedConsensusObjectKind UNCHANGED_CONSENSUS_OBJECT_KIND_UNKNOWN = UnchangedConsensusObject_UnchangedConsensusObjectKind._(0, _omitEnumNames ? '' : 'UNCHANGED_CONSENSUS_OBJECT_KIND_UNKNOWN');
  /// Read-only consensus object from the input.
  static const UnchangedConsensusObject_UnchangedConsensusObjectKind READ_ONLY_ROOT = UnchangedConsensusObject_UnchangedConsensusObjectKind._(1, _omitEnumNames ? '' : 'READ_ONLY_ROOT');
  /// Objects with ended consensus streams that appear mutably/owned in the input.
  static const UnchangedConsensusObject_UnchangedConsensusObjectKind MUTATE_CONSENSUS_STREAM_ENDED = UnchangedConsensusObject_UnchangedConsensusObjectKind._(2, _omitEnumNames ? '' : 'MUTATE_CONSENSUS_STREAM_ENDED');
  /// Objects with ended consensus streams objects that appear as read-only in the input.
  static const UnchangedConsensusObject_UnchangedConsensusObjectKind READ_CONSENSUS_STREAM_ENDED = UnchangedConsensusObject_UnchangedConsensusObjectKind._(3, _omitEnumNames ? '' : 'READ_CONSENSUS_STREAM_ENDED');
  /// Consensus objects that were congested and resulted in this transaction being
  /// canceled.
  static const UnchangedConsensusObject_UnchangedConsensusObjectKind CANCELED = UnchangedConsensusObject_UnchangedConsensusObjectKind._(4, _omitEnumNames ? '' : 'CANCELED');
  /// Read of a per-epoch config object that should remain the same during an
  /// epoch. This optionally will indicate the sequence number of the config
  /// object at the start of the epoch.
  static const UnchangedConsensusObject_UnchangedConsensusObjectKind PER_EPOCH_CONFIG = UnchangedConsensusObject_UnchangedConsensusObjectKind._(5, _omitEnumNames ? '' : 'PER_EPOCH_CONFIG');

  static const $core.List<UnchangedConsensusObject_UnchangedConsensusObjectKind> values = <UnchangedConsensusObject_UnchangedConsensusObjectKind> [
    UNCHANGED_CONSENSUS_OBJECT_KIND_UNKNOWN,
    READ_ONLY_ROOT,
    MUTATE_CONSENSUS_STREAM_ENDED,
    READ_CONSENSUS_STREAM_ENDED,
    CANCELED,
    PER_EPOCH_CONFIG,
  ];

  static final $core.List<UnchangedConsensusObject_UnchangedConsensusObjectKind?> _byValue = $pb.ProtobufEnum.$_initByValueList(values, 5);
  static UnchangedConsensusObject_UnchangedConsensusObjectKind? valueOf($core.int value) =>  value < 0 || value >= _byValue.length ? null : _byValue[value];

  const UnchangedConsensusObject_UnchangedConsensusObjectKind._(super.value, super.name);
}


const $core.bool _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
