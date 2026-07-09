// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/epoch.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use epochDescriptor instead')
const Epoch$json = {
  '1': 'Epoch',
  '2': [
    {'1': 'epoch', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'epoch', '17': true},
    {
      '1': 'committee',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ValidatorCommittee',
      '9': 1,
      '10': 'committee',
      '17': true
    },
    {
      '1': 'system_state',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.SystemState',
      '9': 2,
      '10': 'systemState',
      '17': true
    },
    {
      '1': 'first_checkpoint',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'firstCheckpoint',
      '17': true
    },
    {
      '1': 'last_checkpoint',
      '3': 5,
      '4': 1,
      '5': 4,
      '9': 4,
      '10': 'lastCheckpoint',
      '17': true
    },
    {
      '1': 'start',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 5,
      '10': 'start',
      '17': true
    },
    {
      '1': 'end',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 6,
      '10': 'end',
      '17': true
    },
    {
      '1': 'reference_gas_price',
      '3': 8,
      '4': 1,
      '5': 4,
      '9': 7,
      '10': 'referenceGasPrice',
      '17': true
    },
    {
      '1': 'protocol_config',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ProtocolConfig',
      '9': 8,
      '10': 'protocolConfig',
      '17': true
    },
  ],
  '8': [
    {'1': '_epoch'},
    {'1': '_committee'},
    {'1': '_system_state'},
    {'1': '_first_checkpoint'},
    {'1': '_last_checkpoint'},
    {'1': '_start'},
    {'1': '_end'},
    {'1': '_reference_gas_price'},
    {'1': '_protocol_config'},
  ],
};

/// Descriptor for `Epoch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List epochDescriptor = $convert.base64Decode(
    'CgVFcG9jaBIZCgVlcG9jaBgBIAEoBEgAUgVlcG9jaIgBARJBCgljb21taXR0ZWUYAiABKAsyHi'
    '5zdWkucnBjLnYyLlZhbGlkYXRvckNvbW1pdHRlZUgBUgljb21taXR0ZWWIAQESPwoMc3lzdGVt'
    'X3N0YXRlGAMgASgLMhcuc3VpLnJwYy52Mi5TeXN0ZW1TdGF0ZUgCUgtzeXN0ZW1TdGF0ZYgBAR'
    'IuChBmaXJzdF9jaGVja3BvaW50GAQgASgESANSD2ZpcnN0Q2hlY2twb2ludIgBARIsCg9sYXN0'
    'X2NoZWNrcG9pbnQYBSABKARIBFIObGFzdENoZWNrcG9pbnSIAQESNQoFc3RhcnQYBiABKAsyGi'
    '5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wSAVSBXN0YXJ0iAEBEjEKA2VuZBgHIAEoCzIaLmdv'
    'b2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBIBlIDZW5kiAEBEjMKE3JlZmVyZW5jZV9nYXNfcHJpY2'
    'UYCCABKARIB1IRcmVmZXJlbmNlR2FzUHJpY2WIAQESSAoPcHJvdG9jb2xfY29uZmlnGAkgASgL'
    'Mhouc3VpLnJwYy52Mi5Qcm90b2NvbENvbmZpZ0gIUg5wcm90b2NvbENvbmZpZ4gBAUIICgZfZX'
    'BvY2hCDAoKX2NvbW1pdHRlZUIPCg1fc3lzdGVtX3N0YXRlQhMKEV9maXJzdF9jaGVja3BvaW50'
    'QhIKEF9sYXN0X2NoZWNrcG9pbnRCCAoGX3N0YXJ0QgYKBF9lbmRCFgoUX3JlZmVyZW5jZV9nYX'
    'NfcHJpY2VCEgoQX3Byb3RvY29sX2NvbmZpZw==');
