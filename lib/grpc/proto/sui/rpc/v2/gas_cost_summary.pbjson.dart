// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/gas_cost_summary.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use gasCostSummaryDescriptor instead')
const GasCostSummary$json = {
  '1': 'GasCostSummary',
  '2': [
    {
      '1': 'computation_cost',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'computationCost',
      '17': true
    },
    {
      '1': 'storage_cost',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'storageCost',
      '17': true
    },
    {
      '1': 'storage_rebate',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'storageRebate',
      '17': true
    },
    {
      '1': 'non_refundable_storage_fee',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'nonRefundableStorageFee',
      '17': true
    },
  ],
  '8': [
    {'1': '_computation_cost'},
    {'1': '_storage_cost'},
    {'1': '_storage_rebate'},
    {'1': '_non_refundable_storage_fee'},
  ],
};

/// Descriptor for `GasCostSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gasCostSummaryDescriptor = $convert.base64Decode(
    'Cg5HYXNDb3N0U3VtbWFyeRIuChBjb21wdXRhdGlvbl9jb3N0GAEgASgESABSD2NvbXB1dGF0aW'
    '9uQ29zdIgBARImCgxzdG9yYWdlX2Nvc3QYAiABKARIAVILc3RvcmFnZUNvc3SIAQESKgoOc3Rv'
    'cmFnZV9yZWJhdGUYAyABKARIAlINc3RvcmFnZVJlYmF0ZYgBARJAChpub25fcmVmdW5kYWJsZV'
    '9zdG9yYWdlX2ZlZRgEIAEoBEgDUhdub25SZWZ1bmRhYmxlU3RvcmFnZUZlZYgBAUITChFfY29t'
    'cHV0YXRpb25fY29zdEIPCg1fc3RvcmFnZV9jb3N0QhEKD19zdG9yYWdlX3JlYmF0ZUIdChtfbm'
    '9uX3JlZnVuZGFibGVfc3RvcmFnZV9mZWU=');
