// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/argument.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use argumentDescriptor instead')
const Argument$json = {
  '1': 'Argument',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.Argument.ArgumentKind',
      '9': 0,
      '10': 'kind',
      '17': true
    },
    {'1': 'input', '3': 2, '4': 1, '5': 13, '9': 1, '10': 'input', '17': true},
    {
      '1': 'result',
      '3': 3,
      '4': 1,
      '5': 13,
      '9': 2,
      '10': 'result',
      '17': true
    },
    {
      '1': 'subresult',
      '3': 4,
      '4': 1,
      '5': 13,
      '9': 3,
      '10': 'subresult',
      '17': true
    },
  ],
  '4': [Argument_ArgumentKind$json],
  '8': [
    {'1': '_kind'},
    {'1': '_input'},
    {'1': '_result'},
    {'1': '_subresult'},
  ],
};

@$core.Deprecated('Use argumentDescriptor instead')
const Argument_ArgumentKind$json = {
  '1': 'ArgumentKind',
  '2': [
    {'1': 'ARGUMENT_KIND_UNKNOWN', '2': 0},
    {'1': 'GAS', '2': 1},
    {'1': 'INPUT', '2': 2},
    {'1': 'RESULT', '2': 3},
  ],
};

/// Descriptor for `Argument`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List argumentDescriptor = $convert.base64Decode(
    'CghBcmd1bWVudBI6CgRraW5kGAEgASgOMiEuc3VpLnJwYy52Mi5Bcmd1bWVudC5Bcmd1bWVudE'
    'tpbmRIAFIEa2luZIgBARIZCgVpbnB1dBgCIAEoDUgBUgVpbnB1dIgBARIbCgZyZXN1bHQYAyAB'
    'KA1IAlIGcmVzdWx0iAEBEiEKCXN1YnJlc3VsdBgEIAEoDUgDUglzdWJyZXN1bHSIAQEiSQoMQX'
    'JndW1lbnRLaW5kEhkKFUFSR1VNRU5UX0tJTkRfVU5LTk9XThAAEgcKA0dBUxABEgkKBUlOUFVU'
    'EAISCgoGUkVTVUxUEANCBwoFX2tpbmRCCAoGX2lucHV0QgkKB19yZXN1bHRCDAoKX3N1YnJlc3'
    'VsdA==');
