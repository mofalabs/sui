// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/checkpoint_summary.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use checkpointSummaryDescriptor instead')
const CheckpointSummary$json = {
  '1': 'CheckpointSummary',
  '2': [
    {
      '1': 'bcs',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Bcs',
      '9': 0,
      '10': 'bcs',
      '17': true
    },
    {'1': 'digest', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'digest', '17': true},
    {'1': 'epoch', '3': 3, '4': 1, '5': 4, '9': 2, '10': 'epoch', '17': true},
    {
      '1': 'sequence_number',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'sequenceNumber',
      '17': true
    },
    {
      '1': 'total_network_transactions',
      '3': 5,
      '4': 1,
      '5': 4,
      '9': 4,
      '10': 'totalNetworkTransactions',
      '17': true
    },
    {
      '1': 'content_digest',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 5,
      '10': 'contentDigest',
      '17': true
    },
    {
      '1': 'previous_digest',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'previousDigest',
      '17': true
    },
    {
      '1': 'epoch_rolling_gas_cost_summary',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.GasCostSummary',
      '9': 7,
      '10': 'epochRollingGasCostSummary',
      '17': true
    },
    {
      '1': 'timestamp',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 8,
      '10': 'timestamp',
      '17': true
    },
    {
      '1': 'commitments',
      '3': 10,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.CheckpointCommitment',
      '10': 'commitments'
    },
    {
      '1': 'end_of_epoch_data',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.EndOfEpochData',
      '9': 9,
      '10': 'endOfEpochData',
      '17': true
    },
    {
      '1': 'version_specific_data',
      '3': 12,
      '4': 1,
      '5': 12,
      '9': 10,
      '10': 'versionSpecificData',
      '17': true
    },
  ],
  '8': [
    {'1': '_bcs'},
    {'1': '_digest'},
    {'1': '_epoch'},
    {'1': '_sequence_number'},
    {'1': '_total_network_transactions'},
    {'1': '_content_digest'},
    {'1': '_previous_digest'},
    {'1': '_epoch_rolling_gas_cost_summary'},
    {'1': '_timestamp'},
    {'1': '_end_of_epoch_data'},
    {'1': '_version_specific_data'},
  ],
};

/// Descriptor for `CheckpointSummary`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkpointSummaryDescriptor = $convert.base64Decode(
    'ChFDaGVja3BvaW50U3VtbWFyeRImCgNiY3MYASABKAsyDy5zdWkucnBjLnYyLkJjc0gAUgNiY3'
    'OIAQESGwoGZGlnZXN0GAIgASgJSAFSBmRpZ2VzdIgBARIZCgVlcG9jaBgDIAEoBEgCUgVlcG9j'
    'aIgBARIsCg9zZXF1ZW5jZV9udW1iZXIYBCABKARIA1IOc2VxdWVuY2VOdW1iZXKIAQESQQoadG'
    '90YWxfbmV0d29ya190cmFuc2FjdGlvbnMYBSABKARIBFIYdG90YWxOZXR3b3JrVHJhbnNhY3Rp'
    'b25ziAEBEioKDmNvbnRlbnRfZGlnZXN0GAYgASgJSAVSDWNvbnRlbnREaWdlc3SIAQESLAoPcH'
    'JldmlvdXNfZGlnZXN0GAcgASgJSAZSDnByZXZpb3VzRGlnZXN0iAEBEmMKHmVwb2NoX3JvbGxp'
    'bmdfZ2FzX2Nvc3Rfc3VtbWFyeRgIIAEoCzIaLnN1aS5ycGMudjIuR2FzQ29zdFN1bW1hcnlIB1'
    'IaZXBvY2hSb2xsaW5nR2FzQ29zdFN1bW1hcnmIAQESPQoJdGltZXN0YW1wGAkgASgLMhouZ29v'
    'Z2xlLnByb3RvYnVmLlRpbWVzdGFtcEgIUgl0aW1lc3RhbXCIAQESQgoLY29tbWl0bWVudHMYCi'
    'ADKAsyIC5zdWkucnBjLnYyLkNoZWNrcG9pbnRDb21taXRtZW50Ugtjb21taXRtZW50cxJKChFl'
    'bmRfb2ZfZXBvY2hfZGF0YRgLIAEoCzIaLnN1aS5ycGMudjIuRW5kT2ZFcG9jaERhdGFICVIOZW'
    '5kT2ZFcG9jaERhdGGIAQESNwoVdmVyc2lvbl9zcGVjaWZpY19kYXRhGAwgASgMSApSE3ZlcnNp'
    'b25TcGVjaWZpY0RhdGGIAQFCBgoEX2Jjc0IJCgdfZGlnZXN0QggKBl9lcG9jaEISChBfc2VxdW'
    'VuY2VfbnVtYmVyQh0KG190b3RhbF9uZXR3b3JrX3RyYW5zYWN0aW9uc0IRCg9fY29udGVudF9k'
    'aWdlc3RCEgoQX3ByZXZpb3VzX2RpZ2VzdEIhCh9fZXBvY2hfcm9sbGluZ19nYXNfY29zdF9zdW'
    '1tYXJ5QgwKCl90aW1lc3RhbXBCFAoSX2VuZF9vZl9lcG9jaF9kYXRhQhgKFl92ZXJzaW9uX3Nw'
    'ZWNpZmljX2RhdGE=');

@$core.Deprecated('Use endOfEpochDataDescriptor instead')
const EndOfEpochData$json = {
  '1': 'EndOfEpochData',
  '2': [
    {
      '1': 'next_epoch_committee',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ValidatorCommitteeMember',
      '10': 'nextEpochCommittee'
    },
    {
      '1': 'next_epoch_protocol_version',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'nextEpochProtocolVersion',
      '17': true
    },
    {
      '1': 'epoch_commitments',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.CheckpointCommitment',
      '10': 'epochCommitments'
    },
  ],
  '8': [
    {'1': '_next_epoch_protocol_version'},
  ],
};

/// Descriptor for `EndOfEpochData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endOfEpochDataDescriptor = $convert.base64Decode(
    'Cg5FbmRPZkVwb2NoRGF0YRJWChRuZXh0X2Vwb2NoX2NvbW1pdHRlZRgBIAMoCzIkLnN1aS5ycG'
    'MudjIuVmFsaWRhdG9yQ29tbWl0dGVlTWVtYmVyUhJuZXh0RXBvY2hDb21taXR0ZWUSQgobbmV4'
    'dF9lcG9jaF9wcm90b2NvbF92ZXJzaW9uGAIgASgESABSGG5leHRFcG9jaFByb3RvY29sVmVyc2'
    'lvbogBARJNChFlcG9jaF9jb21taXRtZW50cxgDIAMoCzIgLnN1aS5ycGMudjIuQ2hlY2twb2lu'
    'dENvbW1pdG1lbnRSEGVwb2NoQ29tbWl0bWVudHNCHgocX25leHRfZXBvY2hfcHJvdG9jb2xfdm'
    'Vyc2lvbg==');

@$core.Deprecated('Use checkpointCommitmentDescriptor instead')
const CheckpointCommitment$json = {
  '1': 'CheckpointCommitment',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.CheckpointCommitment.CheckpointCommitmentKind',
      '9': 0,
      '10': 'kind',
      '17': true
    },
    {'1': 'digest', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'digest', '17': true},
  ],
  '4': [CheckpointCommitment_CheckpointCommitmentKind$json],
  '8': [
    {'1': '_kind'},
    {'1': '_digest'},
  ],
};

@$core.Deprecated('Use checkpointCommitmentDescriptor instead')
const CheckpointCommitment_CheckpointCommitmentKind$json = {
  '1': 'CheckpointCommitmentKind',
  '2': [
    {'1': 'CHECKPOINT_COMMITMENT_KIND_UNKNOWN', '2': 0},
    {'1': 'ECMH_LIVE_OBJECT_SET', '2': 1},
    {'1': 'CHECKPOINT_ARTIFACTS', '2': 2},
  ],
};

/// Descriptor for `CheckpointCommitment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkpointCommitmentDescriptor = $convert.base64Decode(
    'ChRDaGVja3BvaW50Q29tbWl0bWVudBJSCgRraW5kGAEgASgOMjkuc3VpLnJwYy52Mi5DaGVja3'
    'BvaW50Q29tbWl0bWVudC5DaGVja3BvaW50Q29tbWl0bWVudEtpbmRIAFIEa2luZIgBARIbCgZk'
    'aWdlc3QYAiABKAlIAVIGZGlnZXN0iAEBInYKGENoZWNrcG9pbnRDb21taXRtZW50S2luZBImCi'
    'JDSEVDS1BPSU5UX0NPTU1JVE1FTlRfS0lORF9VTktOT1dOEAASGAoURUNNSF9MSVZFX09CSkVD'
    'VF9TRVQQARIYChRDSEVDS1BPSU5UX0FSVElGQUNUUxACQgcKBV9raW5kQgkKB19kaWdlc3Q=');
