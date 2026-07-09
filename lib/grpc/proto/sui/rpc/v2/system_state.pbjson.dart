// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/system_state.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use systemStateDescriptor instead')
const SystemState$json = {
  '1': 'SystemState',
  '2': [
    {
      '1': 'version',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'version',
      '17': true
    },
    {'1': 'epoch', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'epoch', '17': true},
    {
      '1': 'protocol_version',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'protocolVersion',
      '17': true
    },
    {
      '1': 'validators',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ValidatorSet',
      '9': 3,
      '10': 'validators',
      '17': true
    },
    {
      '1': 'storage_fund',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.StorageFund',
      '9': 4,
      '10': 'storageFund',
      '17': true
    },
    {
      '1': 'parameters',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.SystemParameters',
      '9': 5,
      '10': 'parameters',
      '17': true
    },
    {
      '1': 'reference_gas_price',
      '3': 7,
      '4': 1,
      '5': 4,
      '9': 6,
      '10': 'referenceGasPrice',
      '17': true
    },
    {
      '1': 'validator_report_records',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ValidatorReportRecord',
      '10': 'validatorReportRecords'
    },
    {
      '1': 'stake_subsidy',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.StakeSubsidy',
      '9': 7,
      '10': 'stakeSubsidy',
      '17': true
    },
    {
      '1': 'safe_mode',
      '3': 10,
      '4': 1,
      '5': 8,
      '9': 8,
      '10': 'safeMode',
      '17': true
    },
    {
      '1': 'safe_mode_storage_rewards',
      '3': 11,
      '4': 1,
      '5': 4,
      '9': 9,
      '10': 'safeModeStorageRewards',
      '17': true
    },
    {
      '1': 'safe_mode_computation_rewards',
      '3': 12,
      '4': 1,
      '5': 4,
      '9': 10,
      '10': 'safeModeComputationRewards',
      '17': true
    },
    {
      '1': 'safe_mode_storage_rebates',
      '3': 13,
      '4': 1,
      '5': 4,
      '9': 11,
      '10': 'safeModeStorageRebates',
      '17': true
    },
    {
      '1': 'safe_mode_non_refundable_storage_fee',
      '3': 14,
      '4': 1,
      '5': 4,
      '9': 12,
      '10': 'safeModeNonRefundableStorageFee',
      '17': true
    },
    {
      '1': 'epoch_start_timestamp_ms',
      '3': 15,
      '4': 1,
      '5': 4,
      '9': 13,
      '10': 'epochStartTimestampMs',
      '17': true
    },
    {
      '1': 'extra_fields',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 14,
      '10': 'extraFields',
      '17': true
    },
  ],
  '8': [
    {'1': '_version'},
    {'1': '_epoch'},
    {'1': '_protocol_version'},
    {'1': '_validators'},
    {'1': '_storage_fund'},
    {'1': '_parameters'},
    {'1': '_reference_gas_price'},
    {'1': '_stake_subsidy'},
    {'1': '_safe_mode'},
    {'1': '_safe_mode_storage_rewards'},
    {'1': '_safe_mode_computation_rewards'},
    {'1': '_safe_mode_storage_rebates'},
    {'1': '_safe_mode_non_refundable_storage_fee'},
    {'1': '_epoch_start_timestamp_ms'},
    {'1': '_extra_fields'},
  ],
};

/// Descriptor for `SystemState`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List systemStateDescriptor = $convert.base64Decode(
    'CgtTeXN0ZW1TdGF0ZRIdCgd2ZXJzaW9uGAEgASgESABSB3ZlcnNpb26IAQESGQoFZXBvY2gYAi'
    'ABKARIAVIFZXBvY2iIAQESLgoQcHJvdG9jb2xfdmVyc2lvbhgDIAEoBEgCUg9wcm90b2NvbFZl'
    'cnNpb26IAQESPQoKdmFsaWRhdG9ycxgEIAEoCzIYLnN1aS5ycGMudjIuVmFsaWRhdG9yU2V0SA'
    'NSCnZhbGlkYXRvcnOIAQESPwoMc3RvcmFnZV9mdW5kGAUgASgLMhcuc3VpLnJwYy52Mi5TdG9y'
    'YWdlRnVuZEgEUgtzdG9yYWdlRnVuZIgBARJBCgpwYXJhbWV0ZXJzGAYgASgLMhwuc3VpLnJwYy'
    '52Mi5TeXN0ZW1QYXJhbWV0ZXJzSAVSCnBhcmFtZXRlcnOIAQESMwoTcmVmZXJlbmNlX2dhc19w'
    'cmljZRgHIAEoBEgGUhFyZWZlcmVuY2VHYXNQcmljZYgBARJbChh2YWxpZGF0b3JfcmVwb3J0X3'
    'JlY29yZHMYCCADKAsyIS5zdWkucnBjLnYyLlZhbGlkYXRvclJlcG9ydFJlY29yZFIWdmFsaWRh'
    'dG9yUmVwb3J0UmVjb3JkcxJCCg1zdGFrZV9zdWJzaWR5GAkgASgLMhguc3VpLnJwYy52Mi5TdG'
    'FrZVN1YnNpZHlIB1IMc3Rha2VTdWJzaWR5iAEBEiAKCXNhZmVfbW9kZRgKIAEoCEgIUghzYWZl'
    'TW9kZYgBARI+ChlzYWZlX21vZGVfc3RvcmFnZV9yZXdhcmRzGAsgASgESAlSFnNhZmVNb2RlU3'
    'RvcmFnZVJld2FyZHOIAQESRgodc2FmZV9tb2RlX2NvbXB1dGF0aW9uX3Jld2FyZHMYDCABKARI'
    'ClIac2FmZU1vZGVDb21wdXRhdGlvblJld2FyZHOIAQESPgoZc2FmZV9tb2RlX3N0b3JhZ2Vfcm'
    'ViYXRlcxgNIAEoBEgLUhZzYWZlTW9kZVN0b3JhZ2VSZWJhdGVziAEBElIKJHNhZmVfbW9kZV9u'
    'b25fcmVmdW5kYWJsZV9zdG9yYWdlX2ZlZRgOIAEoBEgMUh9zYWZlTW9kZU5vblJlZnVuZGFibG'
    'VTdG9yYWdlRmVliAEBEjwKGGVwb2NoX3N0YXJ0X3RpbWVzdGFtcF9tcxgPIAEoBEgNUhVlcG9j'
    'aFN0YXJ0VGltZXN0YW1wTXOIAQESPQoMZXh0cmFfZmllbGRzGBAgASgLMhUuc3VpLnJwYy52Mi'
    '5Nb3ZlVGFibGVIDlILZXh0cmFGaWVsZHOIAQFCCgoIX3ZlcnNpb25CCAoGX2Vwb2NoQhMKEV9w'
    'cm90b2NvbF92ZXJzaW9uQg0KC192YWxpZGF0b3JzQg8KDV9zdG9yYWdlX2Z1bmRCDQoLX3Bhcm'
    'FtZXRlcnNCFgoUX3JlZmVyZW5jZV9nYXNfcHJpY2VCEAoOX3N0YWtlX3N1YnNpZHlCDAoKX3Nh'
    'ZmVfbW9kZUIcChpfc2FmZV9tb2RlX3N0b3JhZ2VfcmV3YXJkc0IgCh5fc2FmZV9tb2RlX2NvbX'
    'B1dGF0aW9uX3Jld2FyZHNCHAoaX3NhZmVfbW9kZV9zdG9yYWdlX3JlYmF0ZXNCJwolX3NhZmVf'
    'bW9kZV9ub25fcmVmdW5kYWJsZV9zdG9yYWdlX2ZlZUIbChlfZXBvY2hfc3RhcnRfdGltZXN0YW'
    '1wX21zQg8KDV9leHRyYV9maWVsZHM=');

@$core.Deprecated('Use validatorReportRecordDescriptor instead')
const ValidatorReportRecord$json = {
  '1': 'ValidatorReportRecord',
  '2': [
    {
      '1': 'reported',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'reported',
      '17': true
    },
    {'1': 'reporters', '3': 2, '4': 3, '5': 9, '10': 'reporters'},
  ],
  '8': [
    {'1': '_reported'},
  ],
};

/// Descriptor for `ValidatorReportRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatorReportRecordDescriptor = $convert.base64Decode(
    'ChVWYWxpZGF0b3JSZXBvcnRSZWNvcmQSHwoIcmVwb3J0ZWQYASABKAlIAFIIcmVwb3J0ZWSIAQ'
    'ESHAoJcmVwb3J0ZXJzGAIgAygJUglyZXBvcnRlcnNCCwoJX3JlcG9ydGVk');

@$core.Deprecated('Use systemParametersDescriptor instead')
const SystemParameters$json = {
  '1': 'SystemParameters',
  '2': [
    {
      '1': 'epoch_duration_ms',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'epochDurationMs',
      '17': true
    },
    {
      '1': 'stake_subsidy_start_epoch',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'stakeSubsidyStartEpoch',
      '17': true
    },
    {
      '1': 'min_validator_count',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'minValidatorCount',
      '17': true
    },
    {
      '1': 'max_validator_count',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'maxValidatorCount',
      '17': true
    },
    {
      '1': 'min_validator_joining_stake',
      '3': 5,
      '4': 1,
      '5': 4,
      '9': 4,
      '10': 'minValidatorJoiningStake',
      '17': true
    },
    {
      '1': 'validator_low_stake_threshold',
      '3': 6,
      '4': 1,
      '5': 4,
      '9': 5,
      '10': 'validatorLowStakeThreshold',
      '17': true
    },
    {
      '1': 'validator_very_low_stake_threshold',
      '3': 7,
      '4': 1,
      '5': 4,
      '9': 6,
      '10': 'validatorVeryLowStakeThreshold',
      '17': true
    },
    {
      '1': 'validator_low_stake_grace_period',
      '3': 8,
      '4': 1,
      '5': 4,
      '9': 7,
      '10': 'validatorLowStakeGracePeriod',
      '17': true
    },
    {
      '1': 'extra_fields',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 8,
      '10': 'extraFields',
      '17': true
    },
  ],
  '8': [
    {'1': '_epoch_duration_ms'},
    {'1': '_stake_subsidy_start_epoch'},
    {'1': '_min_validator_count'},
    {'1': '_max_validator_count'},
    {'1': '_min_validator_joining_stake'},
    {'1': '_validator_low_stake_threshold'},
    {'1': '_validator_very_low_stake_threshold'},
    {'1': '_validator_low_stake_grace_period'},
    {'1': '_extra_fields'},
  ],
};

/// Descriptor for `SystemParameters`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List systemParametersDescriptor = $convert.base64Decode(
    'ChBTeXN0ZW1QYXJhbWV0ZXJzEi8KEWVwb2NoX2R1cmF0aW9uX21zGAEgASgESABSD2Vwb2NoRH'
    'VyYXRpb25Nc4gBARI+ChlzdGFrZV9zdWJzaWR5X3N0YXJ0X2Vwb2NoGAIgASgESAFSFnN0YWtl'
    'U3Vic2lkeVN0YXJ0RXBvY2iIAQESMwoTbWluX3ZhbGlkYXRvcl9jb3VudBgDIAEoBEgCUhFtaW'
    '5WYWxpZGF0b3JDb3VudIgBARIzChNtYXhfdmFsaWRhdG9yX2NvdW50GAQgASgESANSEW1heFZh'
    'bGlkYXRvckNvdW50iAEBEkIKG21pbl92YWxpZGF0b3Jfam9pbmluZ19zdGFrZRgFIAEoBEgEUh'
    'htaW5WYWxpZGF0b3JKb2luaW5nU3Rha2WIAQESRgoddmFsaWRhdG9yX2xvd19zdGFrZV90aHJl'
    'c2hvbGQYBiABKARIBVIadmFsaWRhdG9yTG93U3Rha2VUaHJlc2hvbGSIAQESTwoidmFsaWRhdG'
    '9yX3ZlcnlfbG93X3N0YWtlX3RocmVzaG9sZBgHIAEoBEgGUh52YWxpZGF0b3JWZXJ5TG93U3Rh'
    'a2VUaHJlc2hvbGSIAQESSwogdmFsaWRhdG9yX2xvd19zdGFrZV9ncmFjZV9wZXJpb2QYCCABKA'
    'RIB1IcdmFsaWRhdG9yTG93U3Rha2VHcmFjZVBlcmlvZIgBARI9CgxleHRyYV9maWVsZHMYCSAB'
    'KAsyFS5zdWkucnBjLnYyLk1vdmVUYWJsZUgIUgtleHRyYUZpZWxkc4gBAUIUChJfZXBvY2hfZH'
    'VyYXRpb25fbXNCHAoaX3N0YWtlX3N1YnNpZHlfc3RhcnRfZXBvY2hCFgoUX21pbl92YWxpZGF0'
    'b3JfY291bnRCFgoUX21heF92YWxpZGF0b3JfY291bnRCHgocX21pbl92YWxpZGF0b3Jfam9pbm'
    'luZ19zdGFrZUIgCh5fdmFsaWRhdG9yX2xvd19zdGFrZV90aHJlc2hvbGRCJQojX3ZhbGlkYXRv'
    'cl92ZXJ5X2xvd19zdGFrZV90aHJlc2hvbGRCIwohX3ZhbGlkYXRvcl9sb3dfc3Rha2VfZ3JhY2'
    'VfcGVyaW9kQg8KDV9leHRyYV9maWVsZHM=');

@$core.Deprecated('Use moveTableDescriptor instead')
const MoveTable$json = {
  '1': 'MoveTable',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {'1': 'size', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'size', '17': true},
  ],
  '8': [
    {'1': '_id'},
    {'1': '_size'},
  ],
};

/// Descriptor for `MoveTable`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveTableDescriptor = $convert.base64Decode(
    'CglNb3ZlVGFibGUSEwoCaWQYASABKAlIAFICaWSIAQESFwoEc2l6ZRgCIAEoBEgBUgRzaXpliA'
    'EBQgUKA19pZEIHCgVfc2l6ZQ==');

@$core.Deprecated('Use stakeSubsidyDescriptor instead')
const StakeSubsidy$json = {
  '1': 'StakeSubsidy',
  '2': [
    {
      '1': 'balance',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'balance',
      '17': true
    },
    {
      '1': 'distribution_counter',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'distributionCounter',
      '17': true
    },
    {
      '1': 'current_distribution_amount',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'currentDistributionAmount',
      '17': true
    },
    {
      '1': 'stake_subsidy_period_length',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'stakeSubsidyPeriodLength',
      '17': true
    },
    {
      '1': 'stake_subsidy_decrease_rate',
      '3': 5,
      '4': 1,
      '5': 13,
      '9': 4,
      '10': 'stakeSubsidyDecreaseRate',
      '17': true
    },
    {
      '1': 'extra_fields',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 5,
      '10': 'extraFields',
      '17': true
    },
  ],
  '8': [
    {'1': '_balance'},
    {'1': '_distribution_counter'},
    {'1': '_current_distribution_amount'},
    {'1': '_stake_subsidy_period_length'},
    {'1': '_stake_subsidy_decrease_rate'},
    {'1': '_extra_fields'},
  ],
};

/// Descriptor for `StakeSubsidy`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stakeSubsidyDescriptor = $convert.base64Decode(
    'CgxTdGFrZVN1YnNpZHkSHQoHYmFsYW5jZRgBIAEoBEgAUgdiYWxhbmNliAEBEjYKFGRpc3RyaW'
    'J1dGlvbl9jb3VudGVyGAIgASgESAFSE2Rpc3RyaWJ1dGlvbkNvdW50ZXKIAQESQwobY3VycmVu'
    'dF9kaXN0cmlidXRpb25fYW1vdW50GAMgASgESAJSGWN1cnJlbnREaXN0cmlidXRpb25BbW91bn'
    'SIAQESQgobc3Rha2Vfc3Vic2lkeV9wZXJpb2RfbGVuZ3RoGAQgASgESANSGHN0YWtlU3Vic2lk'
    'eVBlcmlvZExlbmd0aIgBARJCChtzdGFrZV9zdWJzaWR5X2RlY3JlYXNlX3JhdGUYBSABKA1IBF'
    'IYc3Rha2VTdWJzaWR5RGVjcmVhc2VSYXRliAEBEj0KDGV4dHJhX2ZpZWxkcxgGIAEoCzIVLnN1'
    'aS5ycGMudjIuTW92ZVRhYmxlSAVSC2V4dHJhRmllbGRziAEBQgoKCF9iYWxhbmNlQhcKFV9kaX'
    'N0cmlidXRpb25fY291bnRlckIeChxfY3VycmVudF9kaXN0cmlidXRpb25fYW1vdW50Qh4KHF9z'
    'dGFrZV9zdWJzaWR5X3BlcmlvZF9sZW5ndGhCHgocX3N0YWtlX3N1YnNpZHlfZGVjcmVhc2Vfcm'
    'F0ZUIPCg1fZXh0cmFfZmllbGRz');

@$core.Deprecated('Use storageFundDescriptor instead')
const StorageFund$json = {
  '1': 'StorageFund',
  '2': [
    {
      '1': 'total_object_storage_rebates',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'totalObjectStorageRebates',
      '17': true
    },
    {
      '1': 'non_refundable_balance',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'nonRefundableBalance',
      '17': true
    },
  ],
  '8': [
    {'1': '_total_object_storage_rebates'},
    {'1': '_non_refundable_balance'},
  ],
};

/// Descriptor for `StorageFund`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List storageFundDescriptor = $convert.base64Decode(
    'CgtTdG9yYWdlRnVuZBJEChx0b3RhbF9vYmplY3Rfc3RvcmFnZV9yZWJhdGVzGAEgASgESABSGX'
    'RvdGFsT2JqZWN0U3RvcmFnZVJlYmF0ZXOIAQESOQoWbm9uX3JlZnVuZGFibGVfYmFsYW5jZRgC'
    'IAEoBEgBUhRub25SZWZ1bmRhYmxlQmFsYW5jZYgBAUIfCh1fdG90YWxfb2JqZWN0X3N0b3JhZ2'
    'VfcmViYXRlc0IZChdfbm9uX3JlZnVuZGFibGVfYmFsYW5jZQ==');

@$core.Deprecated('Use validatorSetDescriptor instead')
const ValidatorSet$json = {
  '1': 'ValidatorSet',
  '2': [
    {
      '1': 'total_stake',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'totalStake',
      '17': true
    },
    {
      '1': 'active_validators',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Validator',
      '10': 'activeValidators'
    },
    {
      '1': 'pending_active_validators',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 1,
      '10': 'pendingActiveValidators',
      '17': true
    },
    {'1': 'pending_removals', '3': 4, '4': 3, '5': 4, '10': 'pendingRemovals'},
    {
      '1': 'staking_pool_mappings',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 2,
      '10': 'stakingPoolMappings',
      '17': true
    },
    {
      '1': 'inactive_validators',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 3,
      '10': 'inactiveValidators',
      '17': true
    },
    {
      '1': 'validator_candidates',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 4,
      '10': 'validatorCandidates',
      '17': true
    },
    {
      '1': 'at_risk_validators',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ValidatorSet.AtRiskValidatorsEntry',
      '10': 'atRiskValidators'
    },
    {
      '1': 'extra_fields',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 5,
      '10': 'extraFields',
      '17': true
    },
  ],
  '3': [ValidatorSet_AtRiskValidatorsEntry$json],
  '8': [
    {'1': '_total_stake'},
    {'1': '_pending_active_validators'},
    {'1': '_staking_pool_mappings'},
    {'1': '_inactive_validators'},
    {'1': '_validator_candidates'},
    {'1': '_extra_fields'},
  ],
};

@$core.Deprecated('Use validatorSetDescriptor instead')
const ValidatorSet_AtRiskValidatorsEntry$json = {
  '1': 'AtRiskValidatorsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 4, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `ValidatorSet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatorSetDescriptor = $convert.base64Decode(
    'CgxWYWxpZGF0b3JTZXQSJAoLdG90YWxfc3Rha2UYASABKARIAFIKdG90YWxTdGFrZYgBARJCCh'
    'FhY3RpdmVfdmFsaWRhdG9ycxgCIAMoCzIVLnN1aS5ycGMudjIuVmFsaWRhdG9yUhBhY3RpdmVW'
    'YWxpZGF0b3JzElYKGXBlbmRpbmdfYWN0aXZlX3ZhbGlkYXRvcnMYAyABKAsyFS5zdWkucnBjLn'
    'YyLk1vdmVUYWJsZUgBUhdwZW5kaW5nQWN0aXZlVmFsaWRhdG9yc4gBARIpChBwZW5kaW5nX3Jl'
    'bW92YWxzGAQgAygEUg9wZW5kaW5nUmVtb3ZhbHMSTgoVc3Rha2luZ19wb29sX21hcHBpbmdzGA'
    'UgASgLMhUuc3VpLnJwYy52Mi5Nb3ZlVGFibGVIAlITc3Rha2luZ1Bvb2xNYXBwaW5nc4gBARJL'
    'ChNpbmFjdGl2ZV92YWxpZGF0b3JzGAYgASgLMhUuc3VpLnJwYy52Mi5Nb3ZlVGFibGVIA1ISaW'
    '5hY3RpdmVWYWxpZGF0b3JziAEBEk0KFHZhbGlkYXRvcl9jYW5kaWRhdGVzGAcgASgLMhUuc3Vp'
    'LnJwYy52Mi5Nb3ZlVGFibGVIBFITdmFsaWRhdG9yQ2FuZGlkYXRlc4gBARJcChJhdF9yaXNrX3'
    'ZhbGlkYXRvcnMYCCADKAsyLi5zdWkucnBjLnYyLlZhbGlkYXRvclNldC5BdFJpc2tWYWxpZGF0'
    'b3JzRW50cnlSEGF0Umlza1ZhbGlkYXRvcnMSPQoMZXh0cmFfZmllbGRzGAkgASgLMhUuc3VpLn'
    'JwYy52Mi5Nb3ZlVGFibGVIBVILZXh0cmFGaWVsZHOIAQEaQwoVQXRSaXNrVmFsaWRhdG9yc0Vu'
    'dHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgEUgV2YWx1ZToCOAFCDgoMX3RvdG'
    'FsX3N0YWtlQhwKGl9wZW5kaW5nX2FjdGl2ZV92YWxpZGF0b3JzQhgKFl9zdGFraW5nX3Bvb2xf'
    'bWFwcGluZ3NCFgoUX2luYWN0aXZlX3ZhbGlkYXRvcnNCFwoVX3ZhbGlkYXRvcl9jYW5kaWRhdG'
    'VzQg8KDV9leHRyYV9maWVsZHM=');

@$core.Deprecated('Use validatorDescriptor instead')
const Validator$json = {
  '1': 'Validator',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
    {
      '1': 'address',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'address',
      '17': true
    },
    {
      '1': 'description',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'description',
      '17': true
    },
    {
      '1': 'image_url',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'imageUrl',
      '17': true
    },
    {
      '1': 'project_url',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'projectUrl',
      '17': true
    },
    {
      '1': 'protocol_public_key',
      '3': 7,
      '4': 1,
      '5': 12,
      '9': 5,
      '10': 'protocolPublicKey',
      '17': true
    },
    {
      '1': 'proof_of_possession',
      '3': 8,
      '4': 1,
      '5': 12,
      '9': 6,
      '10': 'proofOfPossession',
      '17': true
    },
    {
      '1': 'network_public_key',
      '3': 10,
      '4': 1,
      '5': 12,
      '9': 7,
      '10': 'networkPublicKey',
      '17': true
    },
    {
      '1': 'worker_public_key',
      '3': 12,
      '4': 1,
      '5': 12,
      '9': 8,
      '10': 'workerPublicKey',
      '17': true
    },
    {
      '1': 'network_address',
      '3': 13,
      '4': 1,
      '5': 9,
      '9': 9,
      '10': 'networkAddress',
      '17': true
    },
    {
      '1': 'p2p_address',
      '3': 14,
      '4': 1,
      '5': 9,
      '9': 10,
      '10': 'p2pAddress',
      '17': true
    },
    {
      '1': 'primary_address',
      '3': 15,
      '4': 1,
      '5': 9,
      '9': 11,
      '10': 'primaryAddress',
      '17': true
    },
    {
      '1': 'worker_address',
      '3': 16,
      '4': 1,
      '5': 9,
      '9': 12,
      '10': 'workerAddress',
      '17': true
    },
    {
      '1': 'next_epoch_protocol_public_key',
      '3': 18,
      '4': 1,
      '5': 12,
      '9': 13,
      '10': 'nextEpochProtocolPublicKey',
      '17': true
    },
    {
      '1': 'next_epoch_proof_of_possession',
      '3': 19,
      '4': 1,
      '5': 12,
      '9': 14,
      '10': 'nextEpochProofOfPossession',
      '17': true
    },
    {
      '1': 'next_epoch_network_public_key',
      '3': 21,
      '4': 1,
      '5': 12,
      '9': 15,
      '10': 'nextEpochNetworkPublicKey',
      '17': true
    },
    {
      '1': 'next_epoch_worker_public_key',
      '3': 23,
      '4': 1,
      '5': 12,
      '9': 16,
      '10': 'nextEpochWorkerPublicKey',
      '17': true
    },
    {
      '1': 'next_epoch_network_address',
      '3': 24,
      '4': 1,
      '5': 9,
      '9': 17,
      '10': 'nextEpochNetworkAddress',
      '17': true
    },
    {
      '1': 'next_epoch_p2p_address',
      '3': 25,
      '4': 1,
      '5': 9,
      '9': 18,
      '10': 'nextEpochP2pAddress',
      '17': true
    },
    {
      '1': 'next_epoch_primary_address',
      '3': 26,
      '4': 1,
      '5': 9,
      '9': 19,
      '10': 'nextEpochPrimaryAddress',
      '17': true
    },
    {
      '1': 'next_epoch_worker_address',
      '3': 27,
      '4': 1,
      '5': 9,
      '9': 20,
      '10': 'nextEpochWorkerAddress',
      '17': true
    },
    {
      '1': 'metadata_extra_fields',
      '3': 28,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 21,
      '10': 'metadataExtraFields',
      '17': true
    },
    {
      '1': 'voting_power',
      '3': 29,
      '4': 1,
      '5': 4,
      '9': 22,
      '10': 'votingPower',
      '17': true
    },
    {
      '1': 'operation_cap_id',
      '3': 30,
      '4': 1,
      '5': 9,
      '9': 23,
      '10': 'operationCapId',
      '17': true
    },
    {
      '1': 'gas_price',
      '3': 31,
      '4': 1,
      '5': 4,
      '9': 24,
      '10': 'gasPrice',
      '17': true
    },
    {
      '1': 'staking_pool',
      '3': 32,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.StakingPool',
      '9': 25,
      '10': 'stakingPool',
      '17': true
    },
    {
      '1': 'commission_rate',
      '3': 33,
      '4': 1,
      '5': 4,
      '9': 26,
      '10': 'commissionRate',
      '17': true
    },
    {
      '1': 'next_epoch_stake',
      '3': 34,
      '4': 1,
      '5': 4,
      '9': 27,
      '10': 'nextEpochStake',
      '17': true
    },
    {
      '1': 'next_epoch_gas_price',
      '3': 35,
      '4': 1,
      '5': 4,
      '9': 28,
      '10': 'nextEpochGasPrice',
      '17': true
    },
    {
      '1': 'next_epoch_commission_rate',
      '3': 36,
      '4': 1,
      '5': 4,
      '9': 29,
      '10': 'nextEpochCommissionRate',
      '17': true
    },
    {
      '1': 'extra_fields',
      '3': 37,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 30,
      '10': 'extraFields',
      '17': true
    },
  ],
  '8': [
    {'1': '_name'},
    {'1': '_address'},
    {'1': '_description'},
    {'1': '_image_url'},
    {'1': '_project_url'},
    {'1': '_protocol_public_key'},
    {'1': '_proof_of_possession'},
    {'1': '_network_public_key'},
    {'1': '_worker_public_key'},
    {'1': '_network_address'},
    {'1': '_p2p_address'},
    {'1': '_primary_address'},
    {'1': '_worker_address'},
    {'1': '_next_epoch_protocol_public_key'},
    {'1': '_next_epoch_proof_of_possession'},
    {'1': '_next_epoch_network_public_key'},
    {'1': '_next_epoch_worker_public_key'},
    {'1': '_next_epoch_network_address'},
    {'1': '_next_epoch_p2p_address'},
    {'1': '_next_epoch_primary_address'},
    {'1': '_next_epoch_worker_address'},
    {'1': '_metadata_extra_fields'},
    {'1': '_voting_power'},
    {'1': '_operation_cap_id'},
    {'1': '_gas_price'},
    {'1': '_staking_pool'},
    {'1': '_commission_rate'},
    {'1': '_next_epoch_stake'},
    {'1': '_next_epoch_gas_price'},
    {'1': '_next_epoch_commission_rate'},
    {'1': '_extra_fields'},
  ],
  '9': [
    {'1': 6, '2': 7},
    {'1': 9, '2': 10},
    {'1': 11, '2': 12},
    {'1': 17, '2': 18},
    {'1': 20, '2': 21},
    {'1': 22, '2': 23},
  ],
};

/// Descriptor for `Validator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatorDescriptor = $convert.base64Decode(
    'CglWYWxpZGF0b3ISFwoEbmFtZRgBIAEoCUgAUgRuYW1liAEBEh0KB2FkZHJlc3MYAiABKAlIAV'
    'IHYWRkcmVzc4gBARIlCgtkZXNjcmlwdGlvbhgDIAEoCUgCUgtkZXNjcmlwdGlvbogBARIgCglp'
    'bWFnZV91cmwYBCABKAlIA1IIaW1hZ2VVcmyIAQESJAoLcHJvamVjdF91cmwYBSABKAlIBFIKcH'
    'JvamVjdFVybIgBARIzChNwcm90b2NvbF9wdWJsaWNfa2V5GAcgASgMSAVSEXByb3RvY29sUHVi'
    'bGljS2V5iAEBEjMKE3Byb29mX29mX3Bvc3Nlc3Npb24YCCABKAxIBlIRcHJvb2ZPZlBvc3Nlc3'
    'Npb26IAQESMQoSbmV0d29ya19wdWJsaWNfa2V5GAogASgMSAdSEG5ldHdvcmtQdWJsaWNLZXmI'
    'AQESLwoRd29ya2VyX3B1YmxpY19rZXkYDCABKAxICFIPd29ya2VyUHVibGljS2V5iAEBEiwKD2'
    '5ldHdvcmtfYWRkcmVzcxgNIAEoCUgJUg5uZXR3b3JrQWRkcmVzc4gBARIkCgtwMnBfYWRkcmVz'
    'cxgOIAEoCUgKUgpwMnBBZGRyZXNziAEBEiwKD3ByaW1hcnlfYWRkcmVzcxgPIAEoCUgLUg5wcm'
    'ltYXJ5QWRkcmVzc4gBARIqCg53b3JrZXJfYWRkcmVzcxgQIAEoCUgMUg13b3JrZXJBZGRyZXNz'
    'iAEBEkcKHm5leHRfZXBvY2hfcHJvdG9jb2xfcHVibGljX2tleRgSIAEoDEgNUhpuZXh0RXBvY2'
    'hQcm90b2NvbFB1YmxpY0tleYgBARJHCh5uZXh0X2Vwb2NoX3Byb29mX29mX3Bvc3Nlc3Npb24Y'
    'EyABKAxIDlIabmV4dEVwb2NoUHJvb2ZPZlBvc3Nlc3Npb26IAQESRQodbmV4dF9lcG9jaF9uZX'
    'R3b3JrX3B1YmxpY19rZXkYFSABKAxID1IZbmV4dEVwb2NoTmV0d29ya1B1YmxpY0tleYgBARJD'
    'ChxuZXh0X2Vwb2NoX3dvcmtlcl9wdWJsaWNfa2V5GBcgASgMSBBSGG5leHRFcG9jaFdvcmtlcl'
    'B1YmxpY0tleYgBARJAChpuZXh0X2Vwb2NoX25ldHdvcmtfYWRkcmVzcxgYIAEoCUgRUhduZXh0'
    'RXBvY2hOZXR3b3JrQWRkcmVzc4gBARI4ChZuZXh0X2Vwb2NoX3AycF9hZGRyZXNzGBkgASgJSB'
    'JSE25leHRFcG9jaFAycEFkZHJlc3OIAQESQAoabmV4dF9lcG9jaF9wcmltYXJ5X2FkZHJlc3MY'
    'GiABKAlIE1IXbmV4dEVwb2NoUHJpbWFyeUFkZHJlc3OIAQESPgoZbmV4dF9lcG9jaF93b3JrZX'
    'JfYWRkcmVzcxgbIAEoCUgUUhZuZXh0RXBvY2hXb3JrZXJBZGRyZXNziAEBEk4KFW1ldGFkYXRh'
    'X2V4dHJhX2ZpZWxkcxgcIAEoCzIVLnN1aS5ycGMudjIuTW92ZVRhYmxlSBVSE21ldGFkYXRhRX'
    'h0cmFGaWVsZHOIAQESJgoMdm90aW5nX3Bvd2VyGB0gASgESBZSC3ZvdGluZ1Bvd2VyiAEBEi0K'
    'EG9wZXJhdGlvbl9jYXBfaWQYHiABKAlIF1IOb3BlcmF0aW9uQ2FwSWSIAQESIAoJZ2FzX3ByaW'
    'NlGB8gASgESBhSCGdhc1ByaWNliAEBEj8KDHN0YWtpbmdfcG9vbBggIAEoCzIXLnN1aS5ycGMu'
    'djIuU3Rha2luZ1Bvb2xIGVILc3Rha2luZ1Bvb2yIAQESLAoPY29tbWlzc2lvbl9yYXRlGCEgAS'
    'gESBpSDmNvbW1pc3Npb25SYXRliAEBEi0KEG5leHRfZXBvY2hfc3Rha2UYIiABKARIG1IObmV4'
    'dEVwb2NoU3Rha2WIAQESNAoUbmV4dF9lcG9jaF9nYXNfcHJpY2UYIyABKARIHFIRbmV4dEVwb2'
    'NoR2FzUHJpY2WIAQESQAoabmV4dF9lcG9jaF9jb21taXNzaW9uX3JhdGUYJCABKARIHVIXbmV4'
    'dEVwb2NoQ29tbWlzc2lvblJhdGWIAQESPQoMZXh0cmFfZmllbGRzGCUgASgLMhUuc3VpLnJwYy'
    '52Mi5Nb3ZlVGFibGVIHlILZXh0cmFGaWVsZHOIAQFCBwoFX25hbWVCCgoIX2FkZHJlc3NCDgoM'
    'X2Rlc2NyaXB0aW9uQgwKCl9pbWFnZV91cmxCDgoMX3Byb2plY3RfdXJsQhYKFF9wcm90b2NvbF'
    '9wdWJsaWNfa2V5QhYKFF9wcm9vZl9vZl9wb3NzZXNzaW9uQhUKE19uZXR3b3JrX3B1YmxpY19r'
    'ZXlCFAoSX3dvcmtlcl9wdWJsaWNfa2V5QhIKEF9uZXR3b3JrX2FkZHJlc3NCDgoMX3AycF9hZG'
    'RyZXNzQhIKEF9wcmltYXJ5X2FkZHJlc3NCEQoPX3dvcmtlcl9hZGRyZXNzQiEKH19uZXh0X2Vw'
    'b2NoX3Byb3RvY29sX3B1YmxpY19rZXlCIQofX25leHRfZXBvY2hfcHJvb2Zfb2ZfcG9zc2Vzc2'
    'lvbkIgCh5fbmV4dF9lcG9jaF9uZXR3b3JrX3B1YmxpY19rZXlCHwodX25leHRfZXBvY2hfd29y'
    'a2VyX3B1YmxpY19rZXlCHQobX25leHRfZXBvY2hfbmV0d29ya19hZGRyZXNzQhkKF19uZXh0X2'
    'Vwb2NoX3AycF9hZGRyZXNzQh0KG19uZXh0X2Vwb2NoX3ByaW1hcnlfYWRkcmVzc0IcChpfbmV4'
    'dF9lcG9jaF93b3JrZXJfYWRkcmVzc0IYChZfbWV0YWRhdGFfZXh0cmFfZmllbGRzQg8KDV92b3'
    'RpbmdfcG93ZXJCEwoRX29wZXJhdGlvbl9jYXBfaWRCDAoKX2dhc19wcmljZUIPCg1fc3Rha2lu'
    'Z19wb29sQhIKEF9jb21taXNzaW9uX3JhdGVCEwoRX25leHRfZXBvY2hfc3Rha2VCFwoVX25leH'
    'RfZXBvY2hfZ2FzX3ByaWNlQh0KG19uZXh0X2Vwb2NoX2NvbW1pc3Npb25fcmF0ZUIPCg1fZXh0'
    'cmFfZmllbGRzSgQIBhAHSgQICRAKSgQICxAMSgQIERASSgQIFBAVSgQIFhAX');

@$core.Deprecated('Use stakingPoolDescriptor instead')
const StakingPool$json = {
  '1': 'StakingPool',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {
      '1': 'activation_epoch',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'activationEpoch',
      '17': true
    },
    {
      '1': 'deactivation_epoch',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'deactivationEpoch',
      '17': true
    },
    {
      '1': 'sui_balance',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'suiBalance',
      '17': true
    },
    {
      '1': 'rewards_pool',
      '3': 5,
      '4': 1,
      '5': 4,
      '9': 4,
      '10': 'rewardsPool',
      '17': true
    },
    {
      '1': 'pool_token_balance',
      '3': 6,
      '4': 1,
      '5': 4,
      '9': 5,
      '10': 'poolTokenBalance',
      '17': true
    },
    {
      '1': 'exchange_rates',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 6,
      '10': 'exchangeRates',
      '17': true
    },
    {
      '1': 'pending_stake',
      '3': 8,
      '4': 1,
      '5': 4,
      '9': 7,
      '10': 'pendingStake',
      '17': true
    },
    {
      '1': 'pending_total_sui_withdraw',
      '3': 9,
      '4': 1,
      '5': 4,
      '9': 8,
      '10': 'pendingTotalSuiWithdraw',
      '17': true
    },
    {
      '1': 'pending_pool_token_withdraw',
      '3': 10,
      '4': 1,
      '5': 4,
      '9': 9,
      '10': 'pendingPoolTokenWithdraw',
      '17': true
    },
    {
      '1': 'extra_fields',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveTable',
      '9': 10,
      '10': 'extraFields',
      '17': true
    },
  ],
  '8': [
    {'1': '_id'},
    {'1': '_activation_epoch'},
    {'1': '_deactivation_epoch'},
    {'1': '_sui_balance'},
    {'1': '_rewards_pool'},
    {'1': '_pool_token_balance'},
    {'1': '_exchange_rates'},
    {'1': '_pending_stake'},
    {'1': '_pending_total_sui_withdraw'},
    {'1': '_pending_pool_token_withdraw'},
    {'1': '_extra_fields'},
  ],
};

/// Descriptor for `StakingPool`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stakingPoolDescriptor = $convert.base64Decode(
    'CgtTdGFraW5nUG9vbBITCgJpZBgBIAEoCUgAUgJpZIgBARIuChBhY3RpdmF0aW9uX2Vwb2NoGA'
    'IgASgESAFSD2FjdGl2YXRpb25FcG9jaIgBARIyChJkZWFjdGl2YXRpb25fZXBvY2gYAyABKARI'
    'AlIRZGVhY3RpdmF0aW9uRXBvY2iIAQESJAoLc3VpX2JhbGFuY2UYBCABKARIA1IKc3VpQmFsYW'
    '5jZYgBARImCgxyZXdhcmRzX3Bvb2wYBSABKARIBFILcmV3YXJkc1Bvb2yIAQESMQoScG9vbF90'
    'b2tlbl9iYWxhbmNlGAYgASgESAVSEHBvb2xUb2tlbkJhbGFuY2WIAQESQQoOZXhjaGFuZ2Vfcm'
    'F0ZXMYByABKAsyFS5zdWkucnBjLnYyLk1vdmVUYWJsZUgGUg1leGNoYW5nZVJhdGVziAEBEigK'
    'DXBlbmRpbmdfc3Rha2UYCCABKARIB1IMcGVuZGluZ1N0YWtliAEBEkAKGnBlbmRpbmdfdG90YW'
    'xfc3VpX3dpdGhkcmF3GAkgASgESAhSF3BlbmRpbmdUb3RhbFN1aVdpdGhkcmF3iAEBEkIKG3Bl'
    'bmRpbmdfcG9vbF90b2tlbl93aXRoZHJhdxgKIAEoBEgJUhhwZW5kaW5nUG9vbFRva2VuV2l0aG'
    'RyYXeIAQESPQoMZXh0cmFfZmllbGRzGAsgASgLMhUuc3VpLnJwYy52Mi5Nb3ZlVGFibGVIClIL'
    'ZXh0cmFGaWVsZHOIAQFCBQoDX2lkQhMKEV9hY3RpdmF0aW9uX2Vwb2NoQhUKE19kZWFjdGl2YX'
    'Rpb25fZXBvY2hCDgoMX3N1aV9iYWxhbmNlQg8KDV9yZXdhcmRzX3Bvb2xCFQoTX3Bvb2xfdG9r'
    'ZW5fYmFsYW5jZUIRCg9fZXhjaGFuZ2VfcmF0ZXNCEAoOX3BlbmRpbmdfc3Rha2VCHQobX3Blbm'
    'RpbmdfdG90YWxfc3VpX3dpdGhkcmF3Qh4KHF9wZW5kaW5nX3Bvb2xfdG9rZW5fd2l0aGRyYXdC'
    'DwoNX2V4dHJhX2ZpZWxkcw==');
