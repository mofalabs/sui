// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/query_options.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use orderingDescriptor instead')
const Ordering$json = {
  '1': 'Ordering',
  '2': [
    {'1': 'ORDERING_ASCENDING', '2': 0},
    {'1': 'ORDERING_DESCENDING', '2': 1},
  ],
};

/// Descriptor for `Ordering`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List orderingDescriptor = $convert.base64Decode(
    'CghPcmRlcmluZxIWChJPUkRFUklOR19BU0NFTkRJTkcQABIXChNPUkRFUklOR19ERVNDRU5ESU'
    '5HEAE=');

@$core.Deprecated('Use queryEndReasonDescriptor instead')
const QueryEndReason$json = {
  '1': 'QueryEndReason',
  '2': [
    {'1': 'QUERY_END_REASON_UNKNOWN', '2': 0},
    {'1': 'QUERY_END_REASON_ITEM_LIMIT', '2': 1},
    {'1': 'QUERY_END_REASON_SCAN_LIMIT', '2': 2},
    {'1': 'QUERY_END_REASON_CHECKPOINT_BOUND', '2': 3},
    {'1': 'QUERY_END_REASON_CURSOR_BOUND', '2': 4},
    {'1': 'QUERY_END_REASON_LEDGER_TIP', '2': 5},
  ],
};

/// Descriptor for `QueryEndReason`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List queryEndReasonDescriptor = $convert.base64Decode(
    'Cg5RdWVyeUVuZFJlYXNvbhIcChhRVUVSWV9FTkRfUkVBU09OX1VOS05PV04QABIfChtRVUVSWV'
    '9FTkRfUkVBU09OX0lURU1fTElNSVQQARIfChtRVUVSWV9FTkRfUkVBU09OX1NDQU5fTElNSVQQ'
    'AhIlCiFRVUVSWV9FTkRfUkVBU09OX0NIRUNLUE9JTlRfQk9VTkQQAxIhCh1RVUVSWV9FTkRfUk'
    'VBU09OX0NVUlNPUl9CT1VORBAEEh8KG1FVRVJZX0VORF9SRUFTT05fTEVER0VSX1RJUBAF');

@$core.Deprecated('Use queryOptionsDescriptor instead')
const QueryOptions$json = {
  '1': 'QueryOptions',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 13, '9': 0, '10': 'limit', '17': true},
    {'1': 'after', '3': 2, '4': 1, '5': 12, '9': 1, '10': 'after', '17': true},
    {
      '1': 'before',
      '3': 3,
      '4': 1,
      '5': 12,
      '9': 2,
      '10': 'before',
      '17': true
    },
    {
      '1': 'ordering',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.Ordering',
      '9': 3,
      '10': 'ordering',
      '17': true
    },
  ],
  '8': [
    {'1': '_limit'},
    {'1': '_after'},
    {'1': '_before'},
    {'1': '_ordering'},
  ],
};

/// Descriptor for `QueryOptions`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryOptionsDescriptor = $convert.base64Decode(
    'CgxRdWVyeU9wdGlvbnMSGQoFbGltaXQYASABKA1IAFIFbGltaXSIAQESGQoFYWZ0ZXIYAiABKA'
    'xIAVIFYWZ0ZXKIAQESGwoGYmVmb3JlGAMgASgMSAJSBmJlZm9yZYgBARI1CghvcmRlcmluZxgE'
    'IAEoDjIULnN1aS5ycGMudjIuT3JkZXJpbmdIA1IIb3JkZXJpbmeIAQFCCAoGX2xpbWl0QggKBl'
    '9hZnRlckIJCgdfYmVmb3JlQgsKCV9vcmRlcmluZw==');

@$core.Deprecated('Use watermarkDescriptor instead')
const Watermark$json = {
  '1': 'Watermark',
  '2': [
    {
      '1': 'cursor',
      '3': 1,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'cursor',
      '17': true
    },
    {
      '1': 'checkpoint',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'checkpoint',
      '17': true
    },
  ],
  '8': [
    {'1': '_cursor'},
    {'1': '_checkpoint'},
  ],
};

/// Descriptor for `Watermark`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List watermarkDescriptor = $convert.base64Decode(
    'CglXYXRlcm1hcmsSGwoGY3Vyc29yGAEgASgMSABSBmN1cnNvcogBARIjCgpjaGVja3BvaW50GA'
    'IgASgESAFSCmNoZWNrcG9pbnSIAQFCCQoHX2N1cnNvckINCgtfY2hlY2twb2ludA==');

@$core.Deprecated('Use queryEndDescriptor instead')
const QueryEnd$json = {
  '1': 'QueryEnd',
  '2': [
    {
      '1': 'reason',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.QueryEndReason',
      '9': 0,
      '10': 'reason',
      '17': true
    },
  ],
  '8': [
    {'1': '_reason'},
  ],
};

/// Descriptor for `QueryEnd`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryEndDescriptor = $convert.base64Decode(
    'CghRdWVyeUVuZBI3CgZyZWFzb24YASABKA4yGi5zdWkucnBjLnYyLlF1ZXJ5RW5kUmVhc29uSA'
    'BSBnJlYXNvbogBAUIJCgdfcmVhc29u');
