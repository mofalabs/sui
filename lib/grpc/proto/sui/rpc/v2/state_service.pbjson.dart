// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/state_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import '../../../google/protobuf/field_mask.pbjson.dart' as $0;
import '../../../google/protobuf/struct.pbjson.dart' as $5;
import 'bcs.pbjson.dart' as $2;
import 'move_package.pbjson.dart' as $4;
import 'object.pbjson.dart' as $1;
import 'owner.pbjson.dart' as $3;

@$core.Deprecated('Use getCoinInfoRequestDescriptor instead')
const GetCoinInfoRequest$json = {
  '1': 'GetCoinInfoRequest',
  '2': [
    {
      '1': 'coin_type',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'coinType',
      '17': true
    },
  ],
  '8': [
    {'1': '_coin_type'},
  ],
};

/// Descriptor for `GetCoinInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCoinInfoRequestDescriptor = $convert.base64Decode(
    'ChJHZXRDb2luSW5mb1JlcXVlc3QSIAoJY29pbl90eXBlGAEgASgJSABSCGNvaW5UeXBliAEBQg'
    'wKCl9jb2luX3R5cGU=');

@$core.Deprecated('Use getCoinInfoResponseDescriptor instead')
const GetCoinInfoResponse$json = {
  '1': 'GetCoinInfoResponse',
  '2': [
    {
      '1': 'coin_type',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'coinType',
      '17': true
    },
    {
      '1': 'metadata',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CoinMetadata',
      '9': 1,
      '10': 'metadata',
      '17': true
    },
    {
      '1': 'treasury',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CoinTreasury',
      '9': 2,
      '10': 'treasury',
      '17': true
    },
    {
      '1': 'regulated_metadata',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.RegulatedCoinMetadata',
      '9': 3,
      '10': 'regulatedMetadata',
      '17': true
    },
  ],
  '8': [
    {'1': '_coin_type'},
    {'1': '_metadata'},
    {'1': '_treasury'},
    {'1': '_regulated_metadata'},
  ],
};

/// Descriptor for `GetCoinInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCoinInfoResponseDescriptor = $convert.base64Decode(
    'ChNHZXRDb2luSW5mb1Jlc3BvbnNlEiAKCWNvaW5fdHlwZRgBIAEoCUgAUghjb2luVHlwZYgBAR'
    'I5CghtZXRhZGF0YRgCIAEoCzIYLnN1aS5ycGMudjIuQ29pbk1ldGFkYXRhSAFSCG1ldGFkYXRh'
    'iAEBEjkKCHRyZWFzdXJ5GAMgASgLMhguc3VpLnJwYy52Mi5Db2luVHJlYXN1cnlIAlIIdHJlYX'
    'N1cnmIAQESVQoScmVndWxhdGVkX21ldGFkYXRhGAQgASgLMiEuc3VpLnJwYy52Mi5SZWd1bGF0'
    'ZWRDb2luTWV0YWRhdGFIA1IRcmVndWxhdGVkTWV0YWRhdGGIAQFCDAoKX2NvaW5fdHlwZUILCg'
    'lfbWV0YWRhdGFCCwoJX3RyZWFzdXJ5QhUKE19yZWd1bGF0ZWRfbWV0YWRhdGE=');

@$core.Deprecated('Use coinMetadataDescriptor instead')
const CoinMetadata$json = {
  '1': 'CoinMetadata',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {
      '1': 'decimals',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'decimals',
      '17': true
    },
    {'1': 'name', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'name', '17': true},
    {'1': 'symbol', '3': 4, '4': 1, '5': 9, '9': 3, '10': 'symbol', '17': true},
    {
      '1': 'description',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'description',
      '17': true
    },
    {
      '1': 'icon_url',
      '3': 6,
      '4': 1,
      '5': 9,
      '9': 5,
      '10': 'iconUrl',
      '17': true
    },
    {
      '1': 'metadata_cap_id',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'metadataCapId',
      '17': true
    },
    {
      '1': 'metadata_cap_state',
      '3': 8,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.CoinMetadata.MetadataCapState',
      '9': 7,
      '10': 'metadataCapState',
      '17': true
    },
  ],
  '4': [CoinMetadata_MetadataCapState$json],
  '8': [
    {'1': '_id'},
    {'1': '_decimals'},
    {'1': '_name'},
    {'1': '_symbol'},
    {'1': '_description'},
    {'1': '_icon_url'},
    {'1': '_metadata_cap_id'},
    {'1': '_metadata_cap_state'},
  ],
};

@$core.Deprecated('Use coinMetadataDescriptor instead')
const CoinMetadata_MetadataCapState$json = {
  '1': 'MetadataCapState',
  '2': [
    {'1': 'METADATA_CAP_STATE_UNKNOWN', '2': 0},
    {'1': 'CLAIMED', '2': 1},
    {'1': 'UNCLAIMED', '2': 2},
    {'1': 'DELETED', '2': 3},
  ],
};

/// Descriptor for `CoinMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List coinMetadataDescriptor = $convert.base64Decode(
    'CgxDb2luTWV0YWRhdGESEwoCaWQYASABKAlIAFICaWSIAQESHwoIZGVjaW1hbHMYAiABKA1IAV'
    'IIZGVjaW1hbHOIAQESFwoEbmFtZRgDIAEoCUgCUgRuYW1liAEBEhsKBnN5bWJvbBgEIAEoCUgD'
    'UgZzeW1ib2yIAQESJQoLZGVzY3JpcHRpb24YBSABKAlIBFILZGVzY3JpcHRpb26IAQESHgoIaW'
    'Nvbl91cmwYBiABKAlIBVIHaWNvblVybIgBARIrCg9tZXRhZGF0YV9jYXBfaWQYByABKAlIBlIN'
    'bWV0YWRhdGFDYXBJZIgBARJcChJtZXRhZGF0YV9jYXBfc3RhdGUYCCABKA4yKS5zdWkucnBjLn'
    'YyLkNvaW5NZXRhZGF0YS5NZXRhZGF0YUNhcFN0YXRlSAdSEG1ldGFkYXRhQ2FwU3RhdGWIAQEi'
    'WwoQTWV0YWRhdGFDYXBTdGF0ZRIeChpNRVRBREFUQV9DQVBfU1RBVEVfVU5LTk9XThAAEgsKB0'
    'NMQUlNRUQQARINCglVTkNMQUlNRUQQAhILCgdERUxFVEVEEANCBQoDX2lkQgsKCV9kZWNpbWFs'
    'c0IHCgVfbmFtZUIJCgdfc3ltYm9sQg4KDF9kZXNjcmlwdGlvbkILCglfaWNvbl91cmxCEgoQX2'
    '1ldGFkYXRhX2NhcF9pZEIVChNfbWV0YWRhdGFfY2FwX3N0YXRl');

@$core.Deprecated('Use coinTreasuryDescriptor instead')
const CoinTreasury$json = {
  '1': 'CoinTreasury',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {
      '1': 'total_supply',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'totalSupply',
      '17': true
    },
    {
      '1': 'supply_state',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.CoinTreasury.SupplyState',
      '9': 2,
      '10': 'supplyState',
      '17': true
    },
  ],
  '4': [CoinTreasury_SupplyState$json],
  '8': [
    {'1': '_id'},
    {'1': '_total_supply'},
    {'1': '_supply_state'},
  ],
};

@$core.Deprecated('Use coinTreasuryDescriptor instead')
const CoinTreasury_SupplyState$json = {
  '1': 'SupplyState',
  '2': [
    {'1': 'SUPPLY_STATE_UNKNOWN', '2': 0},
    {'1': 'FIXED', '2': 1},
    {'1': 'BURN_ONLY', '2': 2},
  ],
};

/// Descriptor for `CoinTreasury`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List coinTreasuryDescriptor = $convert.base64Decode(
    'CgxDb2luVHJlYXN1cnkSEwoCaWQYASABKAlIAFICaWSIAQESJgoMdG90YWxfc3VwcGx5GAIgAS'
    'gESAFSC3RvdGFsU3VwcGx5iAEBEkwKDHN1cHBseV9zdGF0ZRgDIAEoDjIkLnN1aS5ycGMudjIu'
    'Q29pblRyZWFzdXJ5LlN1cHBseVN0YXRlSAJSC3N1cHBseVN0YXRliAEBIkEKC1N1cHBseVN0YX'
    'RlEhgKFFNVUFBMWV9TVEFURV9VTktOT1dOEAASCQoFRklYRUQQARINCglCVVJOX09OTFkQAkIF'
    'CgNfaWRCDwoNX3RvdGFsX3N1cHBseUIPCg1fc3VwcGx5X3N0YXRl');

@$core.Deprecated('Use regulatedCoinMetadataDescriptor instead')
const RegulatedCoinMetadata$json = {
  '1': 'RegulatedCoinMetadata',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {
      '1': 'coin_metadata_object',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'coinMetadataObject',
      '17': true
    },
    {
      '1': 'deny_cap_object',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'denyCapObject',
      '17': true
    },
    {
      '1': 'allow_global_pause',
      '3': 4,
      '4': 1,
      '5': 8,
      '9': 3,
      '10': 'allowGlobalPause',
      '17': true
    },
    {
      '1': 'variant',
      '3': 5,
      '4': 1,
      '5': 13,
      '9': 4,
      '10': 'variant',
      '17': true
    },
    {
      '1': 'coin_regulated_state',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.RegulatedCoinMetadata.CoinRegulatedState',
      '9': 5,
      '10': 'coinRegulatedState',
      '17': true
    },
  ],
  '4': [RegulatedCoinMetadata_CoinRegulatedState$json],
  '8': [
    {'1': '_id'},
    {'1': '_coin_metadata_object'},
    {'1': '_deny_cap_object'},
    {'1': '_allow_global_pause'},
    {'1': '_variant'},
    {'1': '_coin_regulated_state'},
  ],
};

@$core.Deprecated('Use regulatedCoinMetadataDescriptor instead')
const RegulatedCoinMetadata_CoinRegulatedState$json = {
  '1': 'CoinRegulatedState',
  '2': [
    {'1': 'COIN_REGULATED_STATE_UNKNOWN', '2': 0},
    {'1': 'REGULATED', '2': 1},
    {'1': 'UNREGULATED', '2': 2},
  ],
};

/// Descriptor for `RegulatedCoinMetadata`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List regulatedCoinMetadataDescriptor = $convert.base64Decode(
    'ChVSZWd1bGF0ZWRDb2luTWV0YWRhdGESEwoCaWQYASABKAlIAFICaWSIAQESNQoUY29pbl9tZX'
    'RhZGF0YV9vYmplY3QYAiABKAlIAVISY29pbk1ldGFkYXRhT2JqZWN0iAEBEisKD2RlbnlfY2Fw'
    'X29iamVjdBgDIAEoCUgCUg1kZW55Q2FwT2JqZWN0iAEBEjEKEmFsbG93X2dsb2JhbF9wYXVzZR'
    'gEIAEoCEgDUhBhbGxvd0dsb2JhbFBhdXNliAEBEh0KB3ZhcmlhbnQYBSABKA1IBFIHdmFyaWFu'
    'dIgBARJrChRjb2luX3JlZ3VsYXRlZF9zdGF0ZRgGIAEoDjI0LnN1aS5ycGMudjIuUmVndWxhdG'
    'VkQ29pbk1ldGFkYXRhLkNvaW5SZWd1bGF0ZWRTdGF0ZUgFUhJjb2luUmVndWxhdGVkU3RhdGWI'
    'AQEiVgoSQ29pblJlZ3VsYXRlZFN0YXRlEiAKHENPSU5fUkVHVUxBVEVEX1NUQVRFX1VOS05PV0'
    '4QABINCglSRUdVTEFURUQQARIPCgtVTlJFR1VMQVRFRBACQgUKA19pZEIXChVfY29pbl9tZXRh'
    'ZGF0YV9vYmplY3RCEgoQX2RlbnlfY2FwX29iamVjdEIVChNfYWxsb3dfZ2xvYmFsX3BhdXNlQg'
    'oKCF92YXJpYW50QhcKFV9jb2luX3JlZ3VsYXRlZF9zdGF0ZQ==');

@$core.Deprecated('Use getBalanceRequestDescriptor instead')
const GetBalanceRequest$json = {
  '1': 'GetBalanceRequest',
  '2': [
    {'1': 'owner', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'owner', '17': true},
    {
      '1': 'coin_type',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'coinType',
      '17': true
    },
  ],
  '8': [
    {'1': '_owner'},
    {'1': '_coin_type'},
  ],
};

/// Descriptor for `GetBalanceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBalanceRequestDescriptor = $convert.base64Decode(
    'ChFHZXRCYWxhbmNlUmVxdWVzdBIZCgVvd25lchgBIAEoCUgAUgVvd25lcogBARIgCgljb2luX3'
    'R5cGUYAiABKAlIAVIIY29pblR5cGWIAQFCCAoGX293bmVyQgwKCl9jb2luX3R5cGU=');

@$core.Deprecated('Use getBalanceResponseDescriptor instead')
const GetBalanceResponse$json = {
  '1': 'GetBalanceResponse',
  '2': [
    {
      '1': 'balance',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Balance',
      '9': 0,
      '10': 'balance',
      '17': true
    },
  ],
  '8': [
    {'1': '_balance'},
  ],
};

/// Descriptor for `GetBalanceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getBalanceResponseDescriptor = $convert.base64Decode(
    'ChJHZXRCYWxhbmNlUmVzcG9uc2USMgoHYmFsYW5jZRgBIAEoCzITLnN1aS5ycGMudjIuQmFsYW'
    '5jZUgAUgdiYWxhbmNliAEBQgoKCF9iYWxhbmNl');

@$core.Deprecated('Use listBalancesRequestDescriptor instead')
const ListBalancesRequest$json = {
  '1': 'ListBalancesRequest',
  '2': [
    {'1': 'owner', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'owner', '17': true},
    {
      '1': 'page_size',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'pageSize',
      '17': true
    },
    {
      '1': 'page_token',
      '3': 3,
      '4': 1,
      '5': 12,
      '9': 2,
      '10': 'pageToken',
      '17': true
    },
  ],
  '8': [
    {'1': '_owner'},
    {'1': '_page_size'},
    {'1': '_page_token'},
  ],
};

/// Descriptor for `ListBalancesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBalancesRequestDescriptor = $convert.base64Decode(
    'ChNMaXN0QmFsYW5jZXNSZXF1ZXN0EhkKBW93bmVyGAEgASgJSABSBW93bmVyiAEBEiAKCXBhZ2'
    'Vfc2l6ZRgCIAEoDUgBUghwYWdlU2l6ZYgBARIiCgpwYWdlX3Rva2VuGAMgASgMSAJSCXBhZ2VU'
    'b2tlbogBAUIICgZfb3duZXJCDAoKX3BhZ2Vfc2l6ZUINCgtfcGFnZV90b2tlbg==');

@$core.Deprecated('Use listBalancesResponseDescriptor instead')
const ListBalancesResponse$json = {
  '1': 'ListBalancesResponse',
  '2': [
    {
      '1': 'balances',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Balance',
      '10': 'balances'
    },
    {
      '1': 'next_page_token',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'nextPageToken',
      '17': true
    },
  ],
  '8': [
    {'1': '_next_page_token'},
  ],
};

/// Descriptor for `ListBalancesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBalancesResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0QmFsYW5jZXNSZXNwb25zZRIvCghiYWxhbmNlcxgBIAMoCzITLnN1aS5ycGMudjIuQm'
    'FsYW5jZVIIYmFsYW5jZXMSKwoPbmV4dF9wYWdlX3Rva2VuGAIgASgMSABSDW5leHRQYWdlVG9r'
    'ZW6IAQFCEgoQX25leHRfcGFnZV90b2tlbg==');

@$core.Deprecated('Use balanceDescriptor instead')
const Balance$json = {
  '1': 'Balance',
  '2': [
    {
      '1': 'coin_type',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'coinType',
      '17': true
    },
    {
      '1': 'balance',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'balance',
      '17': true
    },
    {
      '1': 'address_balance',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'addressBalance',
      '17': true
    },
    {
      '1': 'coin_balance',
      '3': 5,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'coinBalance',
      '17': true
    },
  ],
  '8': [
    {'1': '_coin_type'},
    {'1': '_balance'},
    {'1': '_address_balance'},
    {'1': '_coin_balance'},
  ],
};

/// Descriptor for `Balance`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balanceDescriptor = $convert.base64Decode(
    'CgdCYWxhbmNlEiAKCWNvaW5fdHlwZRgBIAEoCUgAUghjb2luVHlwZYgBARIdCgdiYWxhbmNlGA'
    'MgASgESAFSB2JhbGFuY2WIAQESLAoPYWRkcmVzc19iYWxhbmNlGAQgASgESAJSDmFkZHJlc3NC'
    'YWxhbmNliAEBEiYKDGNvaW5fYmFsYW5jZRgFIAEoBEgDUgtjb2luQmFsYW5jZYgBAUIMCgpfY2'
    '9pbl90eXBlQgoKCF9iYWxhbmNlQhIKEF9hZGRyZXNzX2JhbGFuY2VCDwoNX2NvaW5fYmFsYW5j'
    'ZQ==');

@$core.Deprecated('Use listDynamicFieldsRequestDescriptor instead')
const ListDynamicFieldsRequest$json = {
  '1': 'ListDynamicFieldsRequest',
  '2': [
    {'1': 'parent', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'parent', '17': true},
    {
      '1': 'page_size',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'pageSize',
      '17': true
    },
    {
      '1': 'page_token',
      '3': 3,
      '4': 1,
      '5': 12,
      '9': 2,
      '10': 'pageToken',
      '17': true
    },
    {
      '1': 'read_mask',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '9': 3,
      '10': 'readMask',
      '17': true
    },
  ],
  '8': [
    {'1': '_parent'},
    {'1': '_page_size'},
    {'1': '_page_token'},
    {'1': '_read_mask'},
  ],
};

/// Descriptor for `ListDynamicFieldsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDynamicFieldsRequestDescriptor = $convert.base64Decode(
    'ChhMaXN0RHluYW1pY0ZpZWxkc1JlcXVlc3QSGwoGcGFyZW50GAEgASgJSABSBnBhcmVudIgBAR'
    'IgCglwYWdlX3NpemUYAiABKA1IAVIIcGFnZVNpemWIAQESIgoKcGFnZV90b2tlbhgDIAEoDEgC'
    'UglwYWdlVG9rZW6IAQESPAoJcmVhZF9tYXNrGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZW'
    'xkTWFza0gDUghyZWFkTWFza4gBAUIJCgdfcGFyZW50QgwKCl9wYWdlX3NpemVCDQoLX3BhZ2Vf'
    'dG9rZW5CDAoKX3JlYWRfbWFzaw==');

@$core.Deprecated('Use listDynamicFieldsResponseDescriptor instead')
const ListDynamicFieldsResponse$json = {
  '1': 'ListDynamicFieldsResponse',
  '2': [
    {
      '1': 'dynamic_fields',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.DynamicField',
      '10': 'dynamicFields'
    },
    {
      '1': 'next_page_token',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'nextPageToken',
      '17': true
    },
  ],
  '8': [
    {'1': '_next_page_token'},
  ],
};

/// Descriptor for `ListDynamicFieldsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDynamicFieldsResponseDescriptor = $convert.base64Decode(
    'ChlMaXN0RHluYW1pY0ZpZWxkc1Jlc3BvbnNlEj8KDmR5bmFtaWNfZmllbGRzGAEgAygLMhguc3'
    'VpLnJwYy52Mi5EeW5hbWljRmllbGRSDWR5bmFtaWNGaWVsZHMSKwoPbmV4dF9wYWdlX3Rva2Vu'
    'GAIgASgMSABSDW5leHRQYWdlVG9rZW6IAQFCEgoQX25leHRfcGFnZV90b2tlbg==');

@$core.Deprecated('Use dynamicFieldDescriptor instead')
const DynamicField$json = {
  '1': 'DynamicField',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.DynamicField.DynamicFieldKind',
      '9': 0,
      '10': 'kind',
      '17': true
    },
    {'1': 'parent', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'parent', '17': true},
    {
      '1': 'field_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'fieldId',
      '17': true
    },
    {
      '1': 'field_object',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Object',
      '9': 3,
      '10': 'fieldObject',
      '17': true
    },
    {
      '1': 'name',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Bcs',
      '9': 4,
      '10': 'name',
      '17': true
    },
    {
      '1': 'value',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Bcs',
      '9': 5,
      '10': 'value',
      '17': true
    },
    {
      '1': 'value_type',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'valueType',
      '17': true
    },
    {
      '1': 'child_id',
      '3': 8,
      '4': 1,
      '5': 9,
      '9': 7,
      '10': 'childId',
      '17': true
    },
    {
      '1': 'child_object',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Object',
      '9': 8,
      '10': 'childObject',
      '17': true
    },
  ],
  '4': [DynamicField_DynamicFieldKind$json],
  '8': [
    {'1': '_kind'},
    {'1': '_parent'},
    {'1': '_field_id'},
    {'1': '_field_object'},
    {'1': '_name'},
    {'1': '_value'},
    {'1': '_value_type'},
    {'1': '_child_id'},
    {'1': '_child_object'},
  ],
};

@$core.Deprecated('Use dynamicFieldDescriptor instead')
const DynamicField_DynamicFieldKind$json = {
  '1': 'DynamicFieldKind',
  '2': [
    {'1': 'DYNAMIC_FIELD_KIND_UNKNOWN', '2': 0},
    {'1': 'FIELD', '2': 1},
    {'1': 'OBJECT', '2': 2},
  ],
};

/// Descriptor for `DynamicField`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dynamicFieldDescriptor = $convert.base64Decode(
    'CgxEeW5hbWljRmllbGQSQgoEa2luZBgBIAEoDjIpLnN1aS5ycGMudjIuRHluYW1pY0ZpZWxkLk'
    'R5bmFtaWNGaWVsZEtpbmRIAFIEa2luZIgBARIbCgZwYXJlbnQYAiABKAlIAVIGcGFyZW50iAEB'
    'Eh4KCGZpZWxkX2lkGAMgASgJSAJSB2ZpZWxkSWSIAQESOgoMZmllbGRfb2JqZWN0GAQgASgLMh'
    'Iuc3VpLnJwYy52Mi5PYmplY3RIA1ILZmllbGRPYmplY3SIAQESKAoEbmFtZRgFIAEoCzIPLnN1'
    'aS5ycGMudjIuQmNzSARSBG5hbWWIAQESKgoFdmFsdWUYBiABKAsyDy5zdWkucnBjLnYyLkJjc0'
    'gFUgV2YWx1ZYgBARIiCgp2YWx1ZV90eXBlGAcgASgJSAZSCXZhbHVlVHlwZYgBARIeCghjaGls'
    'ZF9pZBgIIAEoCUgHUgdjaGlsZElkiAEBEjoKDGNoaWxkX29iamVjdBgJIAEoCzISLnN1aS5ycG'
    'MudjIuT2JqZWN0SAhSC2NoaWxkT2JqZWN0iAEBIkkKEER5bmFtaWNGaWVsZEtpbmQSHgoaRFlO'
    'QU1JQ19GSUVMRF9LSU5EX1VOS05PV04QABIJCgVGSUVMRBABEgoKBk9CSkVDVBACQgcKBV9raW'
    '5kQgkKB19wYXJlbnRCCwoJX2ZpZWxkX2lkQg8KDV9maWVsZF9vYmplY3RCBwoFX25hbWVCCAoG'
    'X3ZhbHVlQg0KC192YWx1ZV90eXBlQgsKCV9jaGlsZF9pZEIPCg1fY2hpbGRfb2JqZWN0');

@$core.Deprecated('Use listOwnedObjectsRequestDescriptor instead')
const ListOwnedObjectsRequest$json = {
  '1': 'ListOwnedObjectsRequest',
  '2': [
    {'1': 'owner', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'owner', '17': true},
    {
      '1': 'page_size',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'pageSize',
      '17': true
    },
    {
      '1': 'page_token',
      '3': 3,
      '4': 1,
      '5': 12,
      '9': 2,
      '10': 'pageToken',
      '17': true
    },
    {
      '1': 'read_mask',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '9': 3,
      '10': 'readMask',
      '17': true
    },
    {
      '1': 'object_type',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'objectType',
      '17': true
    },
  ],
  '8': [
    {'1': '_owner'},
    {'1': '_page_size'},
    {'1': '_page_token'},
    {'1': '_read_mask'},
    {'1': '_object_type'},
  ],
};

/// Descriptor for `ListOwnedObjectsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listOwnedObjectsRequestDescriptor = $convert.base64Decode(
    'ChdMaXN0T3duZWRPYmplY3RzUmVxdWVzdBIZCgVvd25lchgBIAEoCUgAUgVvd25lcogBARIgCg'
    'lwYWdlX3NpemUYAiABKA1IAVIIcGFnZVNpemWIAQESIgoKcGFnZV90b2tlbhgDIAEoDEgCUglw'
    'YWdlVG9rZW6IAQESPAoJcmVhZF9tYXNrGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTW'
    'Fza0gDUghyZWFkTWFza4gBARIkCgtvYmplY3RfdHlwZRgFIAEoCUgEUgpvYmplY3RUeXBliAEB'
    'QggKBl9vd25lckIMCgpfcGFnZV9zaXplQg0KC19wYWdlX3Rva2VuQgwKCl9yZWFkX21hc2tCDg'
    'oMX29iamVjdF90eXBl');

@$core.Deprecated('Use listOwnedObjectsResponseDescriptor instead')
const ListOwnedObjectsResponse$json = {
  '1': 'ListOwnedObjectsResponse',
  '2': [
    {
      '1': 'objects',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Object',
      '10': 'objects'
    },
    {
      '1': 'next_page_token',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'nextPageToken',
      '17': true
    },
  ],
  '8': [
    {'1': '_next_page_token'},
  ],
};

/// Descriptor for `ListOwnedObjectsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listOwnedObjectsResponseDescriptor = $convert.base64Decode(
    'ChhMaXN0T3duZWRPYmplY3RzUmVzcG9uc2USLAoHb2JqZWN0cxgBIAMoCzISLnN1aS5ycGMudj'
    'IuT2JqZWN0UgdvYmplY3RzEisKD25leHRfcGFnZV90b2tlbhgCIAEoDEgAUg1uZXh0UGFnZVRv'
    'a2VuiAEBQhIKEF9uZXh0X3BhZ2VfdG9rZW4=');

const $core.Map<$core.String, $core.dynamic> StateServiceBase$json = {
  '1': 'StateService',
  '2': [
    {
      '1': 'ListDynamicFields',
      '2': '.sui.rpc.v2.ListDynamicFieldsRequest',
      '3': '.sui.rpc.v2.ListDynamicFieldsResponse'
    },
    {
      '1': 'ListOwnedObjects',
      '2': '.sui.rpc.v2.ListOwnedObjectsRequest',
      '3': '.sui.rpc.v2.ListOwnedObjectsResponse'
    },
    {
      '1': 'GetCoinInfo',
      '2': '.sui.rpc.v2.GetCoinInfoRequest',
      '3': '.sui.rpc.v2.GetCoinInfoResponse'
    },
    {
      '1': 'GetBalance',
      '2': '.sui.rpc.v2.GetBalanceRequest',
      '3': '.sui.rpc.v2.GetBalanceResponse'
    },
    {
      '1': 'ListBalances',
      '2': '.sui.rpc.v2.ListBalancesRequest',
      '3': '.sui.rpc.v2.ListBalancesResponse'
    },
  ],
};

@$core.Deprecated('Use stateServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    StateServiceBase$messageJson = {
  '.sui.rpc.v2.ListDynamicFieldsRequest': ListDynamicFieldsRequest$json,
  '.google.protobuf.FieldMask': $0.FieldMask$json,
  '.sui.rpc.v2.ListDynamicFieldsResponse': ListDynamicFieldsResponse$json,
  '.sui.rpc.v2.DynamicField': DynamicField$json,
  '.sui.rpc.v2.Object': $1.Object$json,
  '.sui.rpc.v2.Bcs': $2.Bcs$json,
  '.sui.rpc.v2.Owner': $3.Owner$json,
  '.sui.rpc.v2.Package': $4.Package$json,
  '.sui.rpc.v2.Module': $4.Module$json,
  '.sui.rpc.v2.DatatypeDescriptor': $4.DatatypeDescriptor$json,
  '.sui.rpc.v2.TypeParameter': $4.TypeParameter$json,
  '.sui.rpc.v2.FieldDescriptor': $4.FieldDescriptor$json,
  '.sui.rpc.v2.OpenSignatureBody': $4.OpenSignatureBody$json,
  '.sui.rpc.v2.VariantDescriptor': $4.VariantDescriptor$json,
  '.sui.rpc.v2.FunctionDescriptor': $4.FunctionDescriptor$json,
  '.sui.rpc.v2.OpenSignature': $4.OpenSignature$json,
  '.sui.rpc.v2.TypeOrigin': $4.TypeOrigin$json,
  '.sui.rpc.v2.Linkage': $4.Linkage$json,
  '.google.protobuf.Value': $5.Value$json,
  '.google.protobuf.Struct': $5.Struct$json,
  '.google.protobuf.Struct.FieldsEntry': $5.Struct_FieldsEntry$json,
  '.google.protobuf.ListValue': $5.ListValue$json,
  '.sui.rpc.v2.Display': $1.Display$json,
  '.sui.rpc.v2.ListOwnedObjectsRequest': ListOwnedObjectsRequest$json,
  '.sui.rpc.v2.ListOwnedObjectsResponse': ListOwnedObjectsResponse$json,
  '.sui.rpc.v2.GetCoinInfoRequest': GetCoinInfoRequest$json,
  '.sui.rpc.v2.GetCoinInfoResponse': GetCoinInfoResponse$json,
  '.sui.rpc.v2.CoinMetadata': CoinMetadata$json,
  '.sui.rpc.v2.CoinTreasury': CoinTreasury$json,
  '.sui.rpc.v2.RegulatedCoinMetadata': RegulatedCoinMetadata$json,
  '.sui.rpc.v2.GetBalanceRequest': GetBalanceRequest$json,
  '.sui.rpc.v2.GetBalanceResponse': GetBalanceResponse$json,
  '.sui.rpc.v2.Balance': Balance$json,
  '.sui.rpc.v2.ListBalancesRequest': ListBalancesRequest$json,
  '.sui.rpc.v2.ListBalancesResponse': ListBalancesResponse$json,
};

/// Descriptor for `StateService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List stateServiceDescriptor = $convert.base64Decode(
    'CgxTdGF0ZVNlcnZpY2USYAoRTGlzdER5bmFtaWNGaWVsZHMSJC5zdWkucnBjLnYyLkxpc3REeW'
    '5hbWljRmllbGRzUmVxdWVzdBolLnN1aS5ycGMudjIuTGlzdER5bmFtaWNGaWVsZHNSZXNwb25z'
    'ZRJdChBMaXN0T3duZWRPYmplY3RzEiMuc3VpLnJwYy52Mi5MaXN0T3duZWRPYmplY3RzUmVxdW'
    'VzdBokLnN1aS5ycGMudjIuTGlzdE93bmVkT2JqZWN0c1Jlc3BvbnNlEk4KC0dldENvaW5JbmZv'
    'Eh4uc3VpLnJwYy52Mi5HZXRDb2luSW5mb1JlcXVlc3QaHy5zdWkucnBjLnYyLkdldENvaW5Jbm'
    'ZvUmVzcG9uc2USSwoKR2V0QmFsYW5jZRIdLnN1aS5ycGMudjIuR2V0QmFsYW5jZVJlcXVlc3Qa'
    'Hi5zdWkucnBjLnYyLkdldEJhbGFuY2VSZXNwb25zZRJRCgxMaXN0QmFsYW5jZXMSHy5zdWkucn'
    'BjLnYyLkxpc3RCYWxhbmNlc1JlcXVlc3QaIC5zdWkucnBjLnYyLkxpc3RCYWxhbmNlc1Jlc3Bv'
    'bnNl');
