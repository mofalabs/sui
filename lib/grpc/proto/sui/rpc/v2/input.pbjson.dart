// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/input.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use inputDescriptor instead')
const Input$json = {
  '1': 'Input',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.Input.InputKind',
      '9': 0,
      '10': 'kind',
      '17': true
    },
    {'1': 'pure', '3': 2, '4': 1, '5': 12, '9': 1, '10': 'pure', '17': true},
    {
      '1': 'object_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'objectId',
      '17': true
    },
    {
      '1': 'version',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'version',
      '17': true
    },
    {'1': 'digest', '3': 5, '4': 1, '5': 9, '9': 4, '10': 'digest', '17': true},
    {
      '1': 'mutable',
      '3': 6,
      '4': 1,
      '5': 8,
      '9': 5,
      '10': 'mutable',
      '17': true
    },
    {
      '1': 'mutability',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.Input.Mutability',
      '9': 6,
      '10': 'mutability',
      '17': true
    },
    {
      '1': 'funds_withdrawal',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.FundsWithdrawal',
      '9': 7,
      '10': 'fundsWithdrawal',
      '17': true
    },
    {
      '1': 'literal',
      '3': 1000,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Value',
      '9': 8,
      '10': 'literal',
      '17': true
    },
  ],
  '4': [Input_InputKind$json, Input_Mutability$json],
  '8': [
    {'1': '_kind'},
    {'1': '_pure'},
    {'1': '_object_id'},
    {'1': '_version'},
    {'1': '_digest'},
    {'1': '_mutable'},
    {'1': '_mutability'},
    {'1': '_funds_withdrawal'},
    {'1': '_literal'},
  ],
};

@$core.Deprecated('Use inputDescriptor instead')
const Input_InputKind$json = {
  '1': 'InputKind',
  '2': [
    {'1': 'INPUT_KIND_UNKNOWN', '2': 0},
    {'1': 'PURE', '2': 1},
    {'1': 'IMMUTABLE_OR_OWNED', '2': 2},
    {'1': 'SHARED', '2': 3},
    {'1': 'RECEIVING', '2': 4},
    {'1': 'FUNDS_WITHDRAWAL', '2': 5},
  ],
};

@$core.Deprecated('Use inputDescriptor instead')
const Input_Mutability$json = {
  '1': 'Mutability',
  '2': [
    {'1': 'MUTABILITY_UNKNOWN', '2': 0},
    {'1': 'IMMUTABLE', '2': 1},
    {'1': 'MUTABLE', '2': 2},
    {'1': 'NON_EXCLUSIVE_WRITE', '2': 3},
  ],
};

/// Descriptor for `Input`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputDescriptor = $convert.base64Decode(
    'CgVJbnB1dBI0CgRraW5kGAEgASgOMhsuc3VpLnJwYy52Mi5JbnB1dC5JbnB1dEtpbmRIAFIEa2'
    'luZIgBARIXCgRwdXJlGAIgASgMSAFSBHB1cmWIAQESIAoJb2JqZWN0X2lkGAMgASgJSAJSCG9i'
    'amVjdElkiAEBEh0KB3ZlcnNpb24YBCABKARIA1IHdmVyc2lvbogBARIbCgZkaWdlc3QYBSABKA'
    'lIBFIGZGlnZXN0iAEBEh0KB211dGFibGUYBiABKAhIBVIHbXV0YWJsZYgBARJBCgptdXRhYmls'
    'aXR5GAcgASgOMhwuc3VpLnJwYy52Mi5JbnB1dC5NdXRhYmlsaXR5SAZSCm11dGFiaWxpdHmIAQ'
    'ESSwoQZnVuZHNfd2l0aGRyYXdhbBgIIAEoCzIbLnN1aS5ycGMudjIuRnVuZHNXaXRoZHJhd2Fs'
    'SAdSD2Z1bmRzV2l0aGRyYXdhbIgBARI2CgdsaXRlcmFsGOgHIAEoCzIWLmdvb2dsZS5wcm90b2'
    'J1Zi5WYWx1ZUgIUgdsaXRlcmFsiAEBInYKCUlucHV0S2luZBIWChJJTlBVVF9LSU5EX1VOS05P'
    'V04QABIICgRQVVJFEAESFgoSSU1NVVRBQkxFX09SX09XTkVEEAISCgoGU0hBUkVEEAMSDQoJUk'
    'VDRUlWSU5HEAQSFAoQRlVORFNfV0lUSERSQVdBTBAFIlkKCk11dGFiaWxpdHkSFgoSTVVUQUJJ'
    'TElUWV9VTktOT1dOEAASDQoJSU1NVVRBQkxFEAESCwoHTVVUQUJMRRACEhcKE05PTl9FWENMVV'
    'NJVkVfV1JJVEUQA0IHCgVfa2luZEIHCgVfcHVyZUIMCgpfb2JqZWN0X2lkQgoKCF92ZXJzaW9u'
    'QgkKB19kaWdlc3RCCgoIX211dGFibGVCDQoLX211dGFiaWxpdHlCEwoRX2Z1bmRzX3dpdGhkcm'
    'F3YWxCCgoIX2xpdGVyYWw=');

@$core.Deprecated('Use fundsWithdrawalDescriptor instead')
const FundsWithdrawal$json = {
  '1': 'FundsWithdrawal',
  '2': [
    {'1': 'amount', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'amount', '17': true},
    {
      '1': 'coin_type',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'coinType',
      '17': true
    },
    {
      '1': 'source',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.FundsWithdrawal.Source',
      '9': 2,
      '10': 'source',
      '17': true
    },
  ],
  '4': [FundsWithdrawal_Source$json],
  '8': [
    {'1': '_amount'},
    {'1': '_coin_type'},
    {'1': '_source'},
  ],
};

@$core.Deprecated('Use fundsWithdrawalDescriptor instead')
const FundsWithdrawal_Source$json = {
  '1': 'Source',
  '2': [
    {'1': 'SOURCE_UNKNOWN', '2': 0},
    {'1': 'SENDER', '2': 1},
    {'1': 'SPONSOR', '2': 2},
  ],
};

/// Descriptor for `FundsWithdrawal`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fundsWithdrawalDescriptor = $convert.base64Decode(
    'Cg9GdW5kc1dpdGhkcmF3YWwSGwoGYW1vdW50GAEgASgESABSBmFtb3VudIgBARIgCgljb2luX3'
    'R5cGUYAiABKAlIAVIIY29pblR5cGWIAQESPwoGc291cmNlGAMgASgOMiIuc3VpLnJwYy52Mi5G'
    'dW5kc1dpdGhkcmF3YWwuU291cmNlSAJSBnNvdXJjZYgBASI1CgZTb3VyY2USEgoOU09VUkNFX1'
    'VOS05PV04QABIKCgZTRU5ERVIQARILCgdTUE9OU09SEAJCCQoHX2Ftb3VudEIMCgpfY29pbl90'
    'eXBlQgkKB19zb3VyY2U=');
