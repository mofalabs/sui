// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/input.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Input_InputKind extends $pb.ProtobufEnum {
  static const Input_InputKind INPUT_KIND_UNKNOWN =
      Input_InputKind._(0, _omitEnumNames ? '' : 'INPUT_KIND_UNKNOWN');

  /// A move value serialized as BCS.
  static const Input_InputKind PURE =
      Input_InputKind._(1, _omitEnumNames ? '' : 'PURE');

  /// A Move object that is either immutable or address owned.
  static const Input_InputKind IMMUTABLE_OR_OWNED =
      Input_InputKind._(2, _omitEnumNames ? '' : 'IMMUTABLE_OR_OWNED');

  /// A Move object whose owner is "Shared".
  static const Input_InputKind SHARED =
      Input_InputKind._(3, _omitEnumNames ? '' : 'SHARED');

  /// A Move object that is attempted to be received in this transaction.
  static const Input_InputKind RECEIVING =
      Input_InputKind._(4, _omitEnumNames ? '' : 'RECEIVING');

  /// Reservation to withdraw balance from a funds accumulator
  static const Input_InputKind FUNDS_WITHDRAWAL =
      Input_InputKind._(5, _omitEnumNames ? '' : 'FUNDS_WITHDRAWAL');

  static const $core.List<Input_InputKind> values = <Input_InputKind>[
    INPUT_KIND_UNKNOWN,
    PURE,
    IMMUTABLE_OR_OWNED,
    SHARED,
    RECEIVING,
    FUNDS_WITHDRAWAL,
  ];

  static final $core.List<Input_InputKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static Input_InputKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Input_InputKind._(super.value, super.name);
}

class Input_Mutability extends $pb.ProtobufEnum {
  static const Input_Mutability MUTABILITY_UNKNOWN =
      Input_Mutability._(0, _omitEnumNames ? '' : 'MUTABILITY_UNKNOWN');
  static const Input_Mutability IMMUTABLE =
      Input_Mutability._(1, _omitEnumNames ? '' : 'IMMUTABLE');
  static const Input_Mutability MUTABLE =
      Input_Mutability._(2, _omitEnumNames ? '' : 'MUTABLE');

  /// Non-exclusive write is used to allow multiple transactions to
  /// simultaneously add disjoint dynamic fields to an object.
  /// (Currently only used by settlement transactions).
  static const Input_Mutability NON_EXCLUSIVE_WRITE =
      Input_Mutability._(3, _omitEnumNames ? '' : 'NON_EXCLUSIVE_WRITE');

  static const $core.List<Input_Mutability> values = <Input_Mutability>[
    MUTABILITY_UNKNOWN,
    IMMUTABLE,
    MUTABLE,
    NON_EXCLUSIVE_WRITE,
  ];

  static final $core.List<Input_Mutability?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static Input_Mutability? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Input_Mutability._(super.value, super.name);
}

class FundsWithdrawal_Source extends $pb.ProtobufEnum {
  static const FundsWithdrawal_Source SOURCE_UNKNOWN =
      FundsWithdrawal_Source._(0, _omitEnumNames ? '' : 'SOURCE_UNKNOWN');
  static const FundsWithdrawal_Source SENDER =
      FundsWithdrawal_Source._(1, _omitEnumNames ? '' : 'SENDER');
  static const FundsWithdrawal_Source SPONSOR =
      FundsWithdrawal_Source._(2, _omitEnumNames ? '' : 'SPONSOR');

  static const $core.List<FundsWithdrawal_Source> values =
      <FundsWithdrawal_Source>[
    SOURCE_UNKNOWN,
    SENDER,
    SPONSOR,
  ];

  static final $core.List<FundsWithdrawal_Source?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static FundsWithdrawal_Source? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FundsWithdrawal_Source._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
