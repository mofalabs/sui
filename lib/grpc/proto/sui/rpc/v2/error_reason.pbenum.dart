// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/error_reason.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ErrorReason extends $pb.ProtobufEnum {
  static const ErrorReason ERROR_REASON_UNKNOWN =
      ErrorReason._(0, _omitEnumNames ? '' : 'ERROR_REASON_UNKNOWN');
  static const ErrorReason FIELD_INVALID =
      ErrorReason._(1, _omitEnumNames ? '' : 'FIELD_INVALID');
  static const ErrorReason FIELD_MISSING =
      ErrorReason._(2, _omitEnumNames ? '' : 'FIELD_MISSING');

  static const $core.List<ErrorReason> values = <ErrorReason>[
    ERROR_REASON_UNKNOWN,
    FIELD_INVALID,
    FIELD_MISSING,
  ];

  static final $core.List<ErrorReason?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static ErrorReason? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ErrorReason._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
