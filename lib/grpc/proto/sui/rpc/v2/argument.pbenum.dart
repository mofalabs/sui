// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/argument.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Argument_ArgumentKind extends $pb.ProtobufEnum {
  static const Argument_ArgumentKind ARGUMENT_KIND_UNKNOWN =
      Argument_ArgumentKind._(0, _omitEnumNames ? '' : 'ARGUMENT_KIND_UNKNOWN');

  /// The gas coin.
  static const Argument_ArgumentKind GAS =
      Argument_ArgumentKind._(1, _omitEnumNames ? '' : 'GAS');

  /// One of the input objects or primitive values (from
  /// `ProgrammableTransaction` inputs).
  static const Argument_ArgumentKind INPUT =
      Argument_ArgumentKind._(2, _omitEnumNames ? '' : 'INPUT');

  /// The result of another command (from `ProgrammableTransaction` commands).
  static const Argument_ArgumentKind RESULT =
      Argument_ArgumentKind._(3, _omitEnumNames ? '' : 'RESULT');

  static const $core.List<Argument_ArgumentKind> values =
      <Argument_ArgumentKind>[
    ARGUMENT_KIND_UNKNOWN,
    GAS,
    INPUT,
    RESULT,
  ];

  static final $core.List<Argument_ArgumentKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static Argument_ArgumentKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Argument_ArgumentKind._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
