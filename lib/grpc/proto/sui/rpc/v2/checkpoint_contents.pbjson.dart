// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/checkpoint_contents.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use checkpointContentsDescriptor instead')
const CheckpointContents$json = {
  '1': 'CheckpointContents',
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
    {
      '1': 'version',
      '3': 3,
      '4': 1,
      '5': 5,
      '9': 2,
      '10': 'version',
      '17': true
    },
    {
      '1': 'transactions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.CheckpointedTransactionInfo',
      '10': 'transactions'
    },
  ],
  '8': [
    {'1': '_bcs'},
    {'1': '_digest'},
    {'1': '_version'},
  ],
};

/// Descriptor for `CheckpointContents`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkpointContentsDescriptor = $convert.base64Decode(
    'ChJDaGVja3BvaW50Q29udGVudHMSJgoDYmNzGAEgASgLMg8uc3VpLnJwYy52Mi5CY3NIAFIDYm'
    'NziAEBEhsKBmRpZ2VzdBgCIAEoCUgBUgZkaWdlc3SIAQESHQoHdmVyc2lvbhgDIAEoBUgCUgd2'
    'ZXJzaW9uiAEBEksKDHRyYW5zYWN0aW9ucxgEIAMoCzInLnN1aS5ycGMudjIuQ2hlY2twb2ludG'
    'VkVHJhbnNhY3Rpb25JbmZvUgx0cmFuc2FjdGlvbnNCBgoEX2Jjc0IJCgdfZGlnZXN0QgoKCF92'
    'ZXJzaW9u');

@$core.Deprecated('Use checkpointedTransactionInfoDescriptor instead')
const CheckpointedTransactionInfo$json = {
  '1': 'CheckpointedTransactionInfo',
  '2': [
    {
      '1': 'transaction',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'transaction',
      '17': true
    },
    {
      '1': 'effects',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'effects',
      '17': true
    },
    {
      '1': 'signatures',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.UserSignature',
      '10': 'signatures'
    },
    {
      '1': 'address_aliases_versions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.AddressAliasesVersion',
      '10': 'addressAliasesVersions'
    },
  ],
  '8': [
    {'1': '_transaction'},
    {'1': '_effects'},
  ],
};

/// Descriptor for `CheckpointedTransactionInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkpointedTransactionInfoDescriptor = $convert.base64Decode(
    'ChtDaGVja3BvaW50ZWRUcmFuc2FjdGlvbkluZm8SJQoLdHJhbnNhY3Rpb24YASABKAlIAFILdH'
    'JhbnNhY3Rpb26IAQESHQoHZWZmZWN0cxgCIAEoCUgBUgdlZmZlY3RziAEBEjkKCnNpZ25hdHVy'
    'ZXMYAyADKAsyGS5zdWkucnBjLnYyLlVzZXJTaWduYXR1cmVSCnNpZ25hdHVyZXMSWwoYYWRkcm'
    'Vzc19hbGlhc2VzX3ZlcnNpb25zGAQgAygLMiEuc3VpLnJwYy52Mi5BZGRyZXNzQWxpYXNlc1Zl'
    'cnNpb25SFmFkZHJlc3NBbGlhc2VzVmVyc2lvbnNCDgoMX3RyYW5zYWN0aW9uQgoKCF9lZmZlY3'
    'Rz');

@$core.Deprecated('Use addressAliasesVersionDescriptor instead')
const AddressAliasesVersion$json = {
  '1': 'AddressAliasesVersion',
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
  ],
  '8': [
    {'1': '_version'},
  ],
};

/// Descriptor for `AddressAliasesVersion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addressAliasesVersionDescriptor = $convert.base64Decode(
    'ChVBZGRyZXNzQWxpYXNlc1ZlcnNpb24SHQoHdmVyc2lvbhgBIAEoBEgAUgd2ZXJzaW9uiAEBQg'
    'oKCF92ZXJzaW9u');
