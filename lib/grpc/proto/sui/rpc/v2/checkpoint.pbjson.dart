// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/checkpoint.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use checkpointDescriptor instead')
const Checkpoint$json = {
  '1': 'Checkpoint',
  '2': [
    {
      '1': 'sequence_number',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'sequenceNumber',
      '17': true
    },
    {'1': 'digest', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'digest', '17': true},
    {
      '1': 'summary',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CheckpointSummary',
      '9': 2,
      '10': 'summary',
      '17': true
    },
    {
      '1': 'signature',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ValidatorAggregatedSignature',
      '9': 3,
      '10': 'signature',
      '17': true
    },
    {
      '1': 'contents',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CheckpointContents',
      '9': 4,
      '10': 'contents',
      '17': true
    },
    {
      '1': 'transactions',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ExecutedTransaction',
      '10': 'transactions'
    },
    {
      '1': 'objects',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ObjectSet',
      '9': 5,
      '10': 'objects',
      '17': true
    },
  ],
  '8': [
    {'1': '_sequence_number'},
    {'1': '_digest'},
    {'1': '_summary'},
    {'1': '_signature'},
    {'1': '_contents'},
    {'1': '_objects'},
  ],
};

/// Descriptor for `Checkpoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkpointDescriptor = $convert.base64Decode(
    'CgpDaGVja3BvaW50EiwKD3NlcXVlbmNlX251bWJlchgBIAEoBEgAUg5zZXF1ZW5jZU51bWJlco'
    'gBARIbCgZkaWdlc3QYAiABKAlIAVIGZGlnZXN0iAEBEjwKB3N1bW1hcnkYAyABKAsyHS5zdWku'
    'cnBjLnYyLkNoZWNrcG9pbnRTdW1tYXJ5SAJSB3N1bW1hcnmIAQESSwoJc2lnbmF0dXJlGAQgAS'
    'gLMiguc3VpLnJwYy52Mi5WYWxpZGF0b3JBZ2dyZWdhdGVkU2lnbmF0dXJlSANSCXNpZ25hdHVy'
    'ZYgBARI/Cghjb250ZW50cxgFIAEoCzIeLnN1aS5ycGMudjIuQ2hlY2twb2ludENvbnRlbnRzSA'
    'RSCGNvbnRlbnRziAEBEkMKDHRyYW5zYWN0aW9ucxgGIAMoCzIfLnN1aS5ycGMudjIuRXhlY3V0'
    'ZWRUcmFuc2FjdGlvblIMdHJhbnNhY3Rpb25zEjQKB29iamVjdHMYByABKAsyFS5zdWkucnBjLn'
    'YyLk9iamVjdFNldEgFUgdvYmplY3RziAEBQhIKEF9zZXF1ZW5jZV9udW1iZXJCCQoHX2RpZ2Vz'
    'dEIKCghfc3VtbWFyeUIMCgpfc2lnbmF0dXJlQgsKCV9jb250ZW50c0IKCghfb2JqZWN0cw==');
