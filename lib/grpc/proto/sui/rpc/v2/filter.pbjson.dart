// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/filter.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use transactionFilterDescriptor instead')
const TransactionFilter$json = {
  '1': 'TransactionFilter',
  '2': [
    {
      '1': 'terms',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.TransactionTerm',
      '10': 'terms'
    },
  ],
};

/// Descriptor for `TransactionFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionFilterDescriptor = $convert.base64Decode(
    'ChFUcmFuc2FjdGlvbkZpbHRlchIxCgV0ZXJtcxgBIAMoCzIbLnN1aS5ycGMudjIuVHJhbnNhY3'
    'Rpb25UZXJtUgV0ZXJtcw==');

@$core.Deprecated('Use transactionTermDescriptor instead')
const TransactionTerm$json = {
  '1': 'TransactionTerm',
  '2': [
    {
      '1': 'literals',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.TransactionLiteral',
      '10': 'literals'
    },
  ],
};

/// Descriptor for `TransactionTerm`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionTermDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2FjdGlvblRlcm0SOgoIbGl0ZXJhbHMYASADKAsyHi5zdWkucnBjLnYyLlRyYW5zYW'
    'N0aW9uTGl0ZXJhbFIIbGl0ZXJhbHM=');

@$core.Deprecated('Use transactionLiteralDescriptor instead')
const TransactionLiteral$json = {
  '1': 'TransactionLiteral',
  '2': [
    {'1': 'negated', '3': 1, '4': 1, '5': 8, '10': 'negated'},
    {
      '1': 'sender',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.SenderFilter',
      '9': 0,
      '10': 'sender'
    },
    {
      '1': 'affected_address',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.AffectedAddressFilter',
      '9': 0,
      '10': 'affectedAddress'
    },
    {
      '1': 'affected_object',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.AffectedObjectFilter',
      '9': 0,
      '10': 'affectedObject'
    },
    {
      '1': 'move_call',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveCallFilter',
      '9': 0,
      '10': 'moveCall'
    },
    {
      '1': 'emit_module',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.EmitModuleFilter',
      '9': 0,
      '10': 'emitModule'
    },
    {
      '1': 'event_type',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.EventTypeFilter',
      '9': 0,
      '10': 'eventType'
    },
    {
      '1': 'event_stream_head',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.EventStreamHeadFilter',
      '9': 0,
      '10': 'eventStreamHead'
    },
    {
      '1': 'package_write',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.PackageWriteFilter',
      '9': 0,
      '10': 'packageWrite'
    },
  ],
  '8': [
    {'1': 'predicate'},
  ],
};

/// Descriptor for `TransactionLiteral`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionLiteralDescriptor = $convert.base64Decode(
    'ChJUcmFuc2FjdGlvbkxpdGVyYWwSGAoHbmVnYXRlZBgBIAEoCFIHbmVnYXRlZBIyCgZzZW5kZX'
    'IYAiABKAsyGC5zdWkucnBjLnYyLlNlbmRlckZpbHRlckgAUgZzZW5kZXISTgoQYWZmZWN0ZWRf'
    'YWRkcmVzcxgDIAEoCzIhLnN1aS5ycGMudjIuQWZmZWN0ZWRBZGRyZXNzRmlsdGVySABSD2FmZm'
    'VjdGVkQWRkcmVzcxJLCg9hZmZlY3RlZF9vYmplY3QYBCABKAsyIC5zdWkucnBjLnYyLkFmZmVj'
    'dGVkT2JqZWN0RmlsdGVySABSDmFmZmVjdGVkT2JqZWN0EjkKCW1vdmVfY2FsbBgFIAEoCzIaLn'
    'N1aS5ycGMudjIuTW92ZUNhbGxGaWx0ZXJIAFIIbW92ZUNhbGwSPwoLZW1pdF9tb2R1bGUYBiAB'
    'KAsyHC5zdWkucnBjLnYyLkVtaXRNb2R1bGVGaWx0ZXJIAFIKZW1pdE1vZHVsZRI8CgpldmVudF'
    '90eXBlGAcgASgLMhsuc3VpLnJwYy52Mi5FdmVudFR5cGVGaWx0ZXJIAFIJZXZlbnRUeXBlEk8K'
    'EWV2ZW50X3N0cmVhbV9oZWFkGAggASgLMiEuc3VpLnJwYy52Mi5FdmVudFN0cmVhbUhlYWRGaW'
    'x0ZXJIAFIPZXZlbnRTdHJlYW1IZWFkEkUKDXBhY2thZ2Vfd3JpdGUYCSABKAsyHi5zdWkucnBj'
    'LnYyLlBhY2thZ2VXcml0ZUZpbHRlckgAUgxwYWNrYWdlV3JpdGVCCwoJcHJlZGljYXRl');

@$core.Deprecated('Use eventFilterDescriptor instead')
const EventFilter$json = {
  '1': 'EventFilter',
  '2': [
    {
      '1': 'terms',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.EventTerm',
      '10': 'terms'
    },
  ],
};

/// Descriptor for `EventFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventFilterDescriptor = $convert.base64Decode(
    'CgtFdmVudEZpbHRlchIrCgV0ZXJtcxgBIAMoCzIVLnN1aS5ycGMudjIuRXZlbnRUZXJtUgV0ZX'
    'Jtcw==');

@$core.Deprecated('Use eventTermDescriptor instead')
const EventTerm$json = {
  '1': 'EventTerm',
  '2': [
    {
      '1': 'literals',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.EventLiteral',
      '10': 'literals'
    },
  ],
};

/// Descriptor for `EventTerm`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventTermDescriptor = $convert.base64Decode(
    'CglFdmVudFRlcm0SNAoIbGl0ZXJhbHMYASADKAsyGC5zdWkucnBjLnYyLkV2ZW50TGl0ZXJhbF'
    'IIbGl0ZXJhbHM=');

@$core.Deprecated('Use eventLiteralDescriptor instead')
const EventLiteral$json = {
  '1': 'EventLiteral',
  '2': [
    {'1': 'negated', '3': 1, '4': 1, '5': 8, '10': 'negated'},
    {
      '1': 'sender',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.SenderFilter',
      '9': 0,
      '10': 'sender'
    },
    {
      '1': 'emit_module',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.EmitModuleFilter',
      '9': 0,
      '10': 'emitModule'
    },
    {
      '1': 'event_type',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.EventTypeFilter',
      '9': 0,
      '10': 'eventType'
    },
    {
      '1': 'event_stream_head',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.EventStreamHeadFilter',
      '9': 0,
      '10': 'eventStreamHead'
    },
  ],
  '8': [
    {'1': 'predicate'},
  ],
};

/// Descriptor for `EventLiteral`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventLiteralDescriptor = $convert.base64Decode(
    'CgxFdmVudExpdGVyYWwSGAoHbmVnYXRlZBgBIAEoCFIHbmVnYXRlZBIyCgZzZW5kZXIYAiABKA'
    'syGC5zdWkucnBjLnYyLlNlbmRlckZpbHRlckgAUgZzZW5kZXISPwoLZW1pdF9tb2R1bGUYAyAB'
    'KAsyHC5zdWkucnBjLnYyLkVtaXRNb2R1bGVGaWx0ZXJIAFIKZW1pdE1vZHVsZRI8CgpldmVudF'
    '90eXBlGAQgASgLMhsuc3VpLnJwYy52Mi5FdmVudFR5cGVGaWx0ZXJIAFIJZXZlbnRUeXBlEk8K'
    'EWV2ZW50X3N0cmVhbV9oZWFkGAUgASgLMiEuc3VpLnJwYy52Mi5FdmVudFN0cmVhbUhlYWRGaW'
    'x0ZXJIAFIPZXZlbnRTdHJlYW1IZWFkQgsKCXByZWRpY2F0ZQ==');

@$core.Deprecated('Use senderFilterDescriptor instead')
const SenderFilter$json = {
  '1': 'SenderFilter',
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
  ],
  '8': [
    {'1': '_address'},
  ],
};

/// Descriptor for `SenderFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List senderFilterDescriptor = $convert.base64Decode(
    'CgxTZW5kZXJGaWx0ZXISHQoHYWRkcmVzcxgBIAEoCUgAUgdhZGRyZXNziAEBQgoKCF9hZGRyZX'
    'Nz');

@$core.Deprecated('Use affectedAddressFilterDescriptor instead')
const AffectedAddressFilter$json = {
  '1': 'AffectedAddressFilter',
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
  ],
  '8': [
    {'1': '_address'},
  ],
};

/// Descriptor for `AffectedAddressFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List affectedAddressFilterDescriptor = $convert.base64Decode(
    'ChVBZmZlY3RlZEFkZHJlc3NGaWx0ZXISHQoHYWRkcmVzcxgBIAEoCUgAUgdhZGRyZXNziAEBQg'
    'oKCF9hZGRyZXNz');

@$core.Deprecated('Use affectedObjectFilterDescriptor instead')
const AffectedObjectFilter$json = {
  '1': 'AffectedObjectFilter',
  '2': [
    {
      '1': 'object_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'objectId',
      '17': true
    },
  ],
  '8': [
    {'1': '_object_id'},
  ],
};

/// Descriptor for `AffectedObjectFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List affectedObjectFilterDescriptor = $convert.base64Decode(
    'ChRBZmZlY3RlZE9iamVjdEZpbHRlchIgCglvYmplY3RfaWQYASABKAlIAFIIb2JqZWN0SWSIAQ'
    'FCDAoKX29iamVjdF9pZA==');

@$core.Deprecated('Use moveCallFilterDescriptor instead')
const MoveCallFilter$json = {
  '1': 'MoveCallFilter',
  '2': [
    {
      '1': 'function',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'function',
      '17': true
    },
  ],
  '8': [
    {'1': '_function'},
  ],
};

/// Descriptor for `MoveCallFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveCallFilterDescriptor = $convert.base64Decode(
    'Cg5Nb3ZlQ2FsbEZpbHRlchIfCghmdW5jdGlvbhgBIAEoCUgAUghmdW5jdGlvbogBAUILCglfZn'
    'VuY3Rpb24=');

@$core.Deprecated('Use emitModuleFilterDescriptor instead')
const EmitModuleFilter$json = {
  '1': 'EmitModuleFilter',
  '2': [
    {'1': 'module', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'module', '17': true},
  ],
  '8': [
    {'1': '_module'},
  ],
};

/// Descriptor for `EmitModuleFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emitModuleFilterDescriptor = $convert.base64Decode(
    'ChBFbWl0TW9kdWxlRmlsdGVyEhsKBm1vZHVsZRgBIAEoCUgAUgZtb2R1bGWIAQFCCQoHX21vZH'
    'VsZQ==');

@$core.Deprecated('Use eventTypeFilterDescriptor instead')
const EventTypeFilter$json = {
  '1': 'EventTypeFilter',
  '2': [
    {
      '1': 'event_type',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'eventType',
      '17': true
    },
  ],
  '8': [
    {'1': '_event_type'},
  ],
};

/// Descriptor for `EventTypeFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventTypeFilterDescriptor = $convert.base64Decode(
    'Cg9FdmVudFR5cGVGaWx0ZXISIgoKZXZlbnRfdHlwZRgBIAEoCUgAUglldmVudFR5cGWIAQFCDQ'
    'oLX2V2ZW50X3R5cGU=');

@$core.Deprecated('Use eventStreamHeadFilterDescriptor instead')
const EventStreamHeadFilter$json = {
  '1': 'EventStreamHeadFilter',
  '2': [
    {
      '1': 'stream_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'streamId',
      '17': true
    },
  ],
  '8': [
    {'1': '_stream_id'},
  ],
};

/// Descriptor for `EventStreamHeadFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventStreamHeadFilterDescriptor = $convert.base64Decode(
    'ChVFdmVudFN0cmVhbUhlYWRGaWx0ZXISIAoJc3RyZWFtX2lkGAEgASgJSABSCHN0cmVhbUlkiA'
    'EBQgwKCl9zdHJlYW1faWQ=');

@$core.Deprecated('Use packageWriteFilterDescriptor instead')
const PackageWriteFilter$json = {
  '1': 'PackageWriteFilter',
};

/// Descriptor for `PackageWriteFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageWriteFilterDescriptor =
    $convert.base64Decode('ChJQYWNrYWdlV3JpdGVGaWx0ZXI=');
