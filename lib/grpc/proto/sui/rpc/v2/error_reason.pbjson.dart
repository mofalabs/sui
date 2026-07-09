// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/error_reason.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use errorReasonDescriptor instead')
const ErrorReason$json = {
  '1': 'ErrorReason',
  '2': [
    {'1': 'ERROR_REASON_UNKNOWN', '2': 0},
    {'1': 'FIELD_INVALID', '2': 1},
    {'1': 'FIELD_MISSING', '2': 2},
  ],
};

/// Descriptor for `ErrorReason`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List errorReasonDescriptor = $convert.base64Decode(
    'CgtFcnJvclJlYXNvbhIYChRFUlJPUl9SRUFTT05fVU5LTk9XThAAEhEKDUZJRUxEX0lOVkFMSU'
    'QQARIRCg1GSUVMRF9NSVNTSU5HEAI=');
