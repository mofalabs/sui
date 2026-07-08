// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/name_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import '../../../google/protobuf/timestamp.pbjson.dart' as $0;

@$core.Deprecated('Use lookupNameRequestDescriptor instead')
const LookupNameRequest$json = {
  '1': 'LookupNameRequest',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
  ],
  '8': [
    {'1': '_name'},
  ],
};

/// Descriptor for `LookupNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupNameRequestDescriptor = $convert.base64Decode(
    'ChFMb29rdXBOYW1lUmVxdWVzdBIXCgRuYW1lGAEgASgJSABSBG5hbWWIAQFCBwoFX25hbWU=');

@$core.Deprecated('Use lookupNameResponseDescriptor instead')
const LookupNameResponse$json = {
  '1': 'LookupNameResponse',
  '2': [
    {'1': 'record', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.NameRecord', '9': 0, '10': 'record', '17': true},
  ],
  '8': [
    {'1': '_record'},
  ],
};

/// Descriptor for `LookupNameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List lookupNameResponseDescriptor = $convert.base64Decode(
    'ChJMb29rdXBOYW1lUmVzcG9uc2USMwoGcmVjb3JkGAEgASgLMhYuc3VpLnJwYy52Mi5OYW1lUm'
    'Vjb3JkSABSBnJlY29yZIgBAUIJCgdfcmVjb3Jk');

@$core.Deprecated('Use reverseLookupNameRequestDescriptor instead')
const ReverseLookupNameRequest$json = {
  '1': 'ReverseLookupNameRequest',
  '2': [
    {'1': 'address', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'address', '17': true},
  ],
  '8': [
    {'1': '_address'},
  ],
};

/// Descriptor for `ReverseLookupNameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reverseLookupNameRequestDescriptor = $convert.base64Decode(
    'ChhSZXZlcnNlTG9va3VwTmFtZVJlcXVlc3QSHQoHYWRkcmVzcxgBIAEoCUgAUgdhZGRyZXNziA'
    'EBQgoKCF9hZGRyZXNz');

@$core.Deprecated('Use reverseLookupNameResponseDescriptor instead')
const ReverseLookupNameResponse$json = {
  '1': 'ReverseLookupNameResponse',
  '2': [
    {'1': 'record', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.NameRecord', '9': 0, '10': 'record', '17': true},
  ],
  '8': [
    {'1': '_record'},
  ],
};

/// Descriptor for `ReverseLookupNameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reverseLookupNameResponseDescriptor = $convert.base64Decode(
    'ChlSZXZlcnNlTG9va3VwTmFtZVJlc3BvbnNlEjMKBnJlY29yZBgBIAEoCzIWLnN1aS5ycGMudj'
    'IuTmFtZVJlY29yZEgAUgZyZWNvcmSIAQFCCQoHX3JlY29yZA==');

@$core.Deprecated('Use nameRecordDescriptor instead')
const NameRecord$json = {
  '1': 'NameRecord',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {'1': 'name', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'name', '17': true},
    {'1': 'registration_nft_id', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'registrationNftId', '17': true},
    {'1': 'expiration_timestamp', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '9': 3, '10': 'expirationTimestamp', '17': true},
    {'1': 'target_address', '3': 5, '4': 1, '5': 9, '9': 4, '10': 'targetAddress', '17': true},
    {'1': 'data', '3': 6, '4': 3, '5': 11, '6': '.sui.rpc.v2.NameRecord.DataEntry', '10': 'data'},
  ],
  '3': [NameRecord_DataEntry$json],
  '8': [
    {'1': '_id'},
    {'1': '_name'},
    {'1': '_registration_nft_id'},
    {'1': '_expiration_timestamp'},
    {'1': '_target_address'},
  ],
};

@$core.Deprecated('Use nameRecordDescriptor instead')
const NameRecord_DataEntry$json = {
  '1': 'DataEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `NameRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nameRecordDescriptor = $convert.base64Decode(
    'CgpOYW1lUmVjb3JkEhMKAmlkGAEgASgJSABSAmlkiAEBEhcKBG5hbWUYAiABKAlIAVIEbmFtZY'
    'gBARIzChNyZWdpc3RyYXRpb25fbmZ0X2lkGAMgASgJSAJSEXJlZ2lzdHJhdGlvbk5mdElkiAEB'
    'ElIKFGV4cGlyYXRpb25fdGltZXN0YW1wGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdG'
    'FtcEgDUhNleHBpcmF0aW9uVGltZXN0YW1wiAEBEioKDnRhcmdldF9hZGRyZXNzGAUgASgJSARS'
    'DXRhcmdldEFkZHJlc3OIAQESNAoEZGF0YRgGIAMoCzIgLnN1aS5ycGMudjIuTmFtZVJlY29yZC'
    '5EYXRhRW50cnlSBGRhdGEaNwoJRGF0YUVudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVl'
    'GAIgASgJUgV2YWx1ZToCOAFCBQoDX2lkQgcKBV9uYW1lQhYKFF9yZWdpc3RyYXRpb25fbmZ0X2'
    'lkQhcKFV9leHBpcmF0aW9uX3RpbWVzdGFtcEIRCg9fdGFyZ2V0X2FkZHJlc3M=');

const $core.Map<$core.String, $core.dynamic> NameServiceBase$json = {
  '1': 'NameService',
  '2': [
    {'1': 'LookupName', '2': '.sui.rpc.v2.LookupNameRequest', '3': '.sui.rpc.v2.LookupNameResponse'},
    {'1': 'ReverseLookupName', '2': '.sui.rpc.v2.ReverseLookupNameRequest', '3': '.sui.rpc.v2.ReverseLookupNameResponse'},
  ],
};

@$core.Deprecated('Use nameServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> NameServiceBase$messageJson = {
  '.sui.rpc.v2.LookupNameRequest': LookupNameRequest$json,
  '.sui.rpc.v2.LookupNameResponse': LookupNameResponse$json,
  '.sui.rpc.v2.NameRecord': NameRecord$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
  '.sui.rpc.v2.NameRecord.DataEntry': NameRecord_DataEntry$json,
  '.sui.rpc.v2.ReverseLookupNameRequest': ReverseLookupNameRequest$json,
  '.sui.rpc.v2.ReverseLookupNameResponse': ReverseLookupNameResponse$json,
};

/// Descriptor for `NameService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List nameServiceDescriptor = $convert.base64Decode(
    'CgtOYW1lU2VydmljZRJLCgpMb29rdXBOYW1lEh0uc3VpLnJwYy52Mi5Mb29rdXBOYW1lUmVxdW'
    'VzdBoeLnN1aS5ycGMudjIuTG9va3VwTmFtZVJlc3BvbnNlEmAKEVJldmVyc2VMb29rdXBOYW1l'
    'EiQuc3VpLnJwYy52Mi5SZXZlcnNlTG9va3VwTmFtZVJlcXVlc3QaJS5zdWkucnBjLnYyLlJldm'
    'Vyc2VMb29rdXBOYW1lUmVzcG9uc2U=');

