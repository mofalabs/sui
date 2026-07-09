// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/balance_change.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use balanceChangeDescriptor instead')
const BalanceChange$json = {
  '1': 'BalanceChange',
  '2': [
    {
      '1': 'address',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'address',
      '17': true
    },
    {
      '1': 'coin_type',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'coinType',
      '17': true
    },
    {'1': 'amount', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'amount', '17': true},
  ],
  '8': [
    {'1': '_address'},
    {'1': '_coin_type'},
    {'1': '_amount'},
  ],
};

/// Descriptor for `BalanceChange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List balanceChangeDescriptor = $convert.base64Decode(
    'Cg1CYWxhbmNlQ2hhbmdlEh0KB2FkZHJlc3MYASABKAlIAFIHYWRkcmVzc4gBARIgCgljb2luX3'
    'R5cGUYAiABKAlIAVIIY29pblR5cGWIAQESGwoGYW1vdW50GAMgASgJSAJSBmFtb3VudIgBAUIK'
    'CghfYWRkcmVzc0IMCgpfY29pbl90eXBlQgkKB19hbW91bnQ=');
