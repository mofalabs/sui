// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/jwk.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use jwkIdDescriptor instead')
const JwkId$json = {
  '1': 'JwkId',
  '2': [
    {'1': 'iss', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'iss', '17': true},
    {'1': 'kid', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'kid', '17': true},
  ],
  '8': [
    {'1': '_iss'},
    {'1': '_kid'},
  ],
};

/// Descriptor for `JwkId`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jwkIdDescriptor = $convert.base64Decode(
    'CgVKd2tJZBIVCgNpc3MYASABKAlIAFIDaXNziAEBEhUKA2tpZBgCIAEoCUgBUgNraWSIAQFCBg'
    'oEX2lzc0IGCgRfa2lk');

@$core.Deprecated('Use jwkDescriptor instead')
const Jwk$json = {
  '1': 'Jwk',
  '2': [
    {'1': 'kty', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'kty', '17': true},
    {'1': 'e', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'e', '17': true},
    {'1': 'n', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'n', '17': true},
    {'1': 'alg', '3': 4, '4': 1, '5': 9, '9': 3, '10': 'alg', '17': true},
  ],
  '8': [
    {'1': '_kty'},
    {'1': '_e'},
    {'1': '_n'},
    {'1': '_alg'},
  ],
};

/// Descriptor for `Jwk`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jwkDescriptor = $convert.base64Decode(
    'CgNKd2sSFQoDa3R5GAEgASgJSABSA2t0eYgBARIRCgFlGAIgASgJSAFSAWWIAQESEQoBbhgDIA'
    'EoCUgCUgFuiAEBEhUKA2FsZxgEIAEoCUgDUgNhbGeIAQFCBgoEX2t0eUIECgJfZUIECgJfbkIG'
    'CgRfYWxn');
