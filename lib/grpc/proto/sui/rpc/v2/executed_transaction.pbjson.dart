// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/executed_transaction.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use executedTransactionDescriptor instead')
const ExecutedTransaction$json = {
  '1': 'ExecutedTransaction',
  '2': [
    {'1': 'digest', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'digest', '17': true},
    {
      '1': 'transaction',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Transaction',
      '9': 1,
      '10': 'transaction',
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
      '1': 'effects',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.TransactionEffects',
      '9': 2,
      '10': 'effects',
      '17': true
    },
    {
      '1': 'events',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.TransactionEvents',
      '9': 3,
      '10': 'events',
      '17': true
    },
    {
      '1': 'checkpoint',
      '3': 6,
      '4': 1,
      '5': 4,
      '9': 4,
      '10': 'checkpoint',
      '17': true
    },
    {
      '1': 'timestamp',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 5,
      '10': 'timestamp',
      '17': true
    },
    {
      '1': 'balance_changes',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.BalanceChange',
      '10': 'balanceChanges'
    },
    {
      '1': 'objects',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ObjectSet',
      '9': 6,
      '10': 'objects',
      '17': true
    },
  ],
  '8': [
    {'1': '_digest'},
    {'1': '_transaction'},
    {'1': '_effects'},
    {'1': '_events'},
    {'1': '_checkpoint'},
    {'1': '_timestamp'},
    {'1': '_objects'},
  ],
};

/// Descriptor for `ExecutedTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executedTransactionDescriptor = $convert.base64Decode(
    'ChNFeGVjdXRlZFRyYW5zYWN0aW9uEhsKBmRpZ2VzdBgBIAEoCUgAUgZkaWdlc3SIAQESPgoLdH'
    'JhbnNhY3Rpb24YAiABKAsyFy5zdWkucnBjLnYyLlRyYW5zYWN0aW9uSAFSC3RyYW5zYWN0aW9u'
    'iAEBEjkKCnNpZ25hdHVyZXMYAyADKAsyGS5zdWkucnBjLnYyLlVzZXJTaWduYXR1cmVSCnNpZ2'
    '5hdHVyZXMSPQoHZWZmZWN0cxgEIAEoCzIeLnN1aS5ycGMudjIuVHJhbnNhY3Rpb25FZmZlY3Rz'
    'SAJSB2VmZmVjdHOIAQESOgoGZXZlbnRzGAUgASgLMh0uc3VpLnJwYy52Mi5UcmFuc2FjdGlvbk'
    'V2ZW50c0gDUgZldmVudHOIAQESIwoKY2hlY2twb2ludBgGIAEoBEgEUgpjaGVja3BvaW50iAEB'
    'Ej0KCXRpbWVzdGFtcBgHIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBIBVIJdGltZX'
    'N0YW1wiAEBEkIKD2JhbGFuY2VfY2hhbmdlcxgIIAMoCzIZLnN1aS5ycGMudjIuQmFsYW5jZUNo'
    'YW5nZVIOYmFsYW5jZUNoYW5nZXMSNAoHb2JqZWN0cxgJIAEoCzIVLnN1aS5ycGMudjIuT2JqZW'
    'N0U2V0SAZSB29iamVjdHOIAQFCCQoHX2RpZ2VzdEIOCgxfdHJhbnNhY3Rpb25CCgoIX2VmZmVj'
    'dHNCCQoHX2V2ZW50c0INCgtfY2hlY2twb2ludEIMCgpfdGltZXN0YW1wQgoKCF9vYmplY3Rz');
