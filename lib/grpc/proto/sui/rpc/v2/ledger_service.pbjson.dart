// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/ledger_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import '../../../google/protobuf/any.pbjson.dart' as $11;
import '../../../google/protobuf/duration.pbjson.dart' as $16;
import '../../../google/protobuf/field_mask.pbjson.dart' as $1;
import '../../../google/protobuf/struct.pbjson.dart' as $10;
import '../../../google/protobuf/timestamp.pbjson.dart' as $0;
import '../../../google/rpc/status.pbjson.dart' as $3;
import 'argument.pbjson.dart' as $14;
import 'balance_change.pbjson.dart' as $23;
import 'bcs.pbjson.dart' as $7;
import 'checkpoint.pbjson.dart' as $5;
import 'checkpoint_contents.pbjson.dart' as $25;
import 'checkpoint_summary.pbjson.dart' as $24;
import 'effects.pbjson.dart' as $19;
import 'epoch.pbjson.dart' as $6;
import 'event.pbjson.dart' as $22;
import 'executed_transaction.pbjson.dart' as $4;
import 'execution_status.pbjson.dart' as $20;
import 'gas_cost_summary.pbjson.dart' as $21;
import 'input.pbjson.dart' as $13;
import 'jwk.pbjson.dart' as $15;
import 'move_package.pbjson.dart' as $9;
import 'object.pbjson.dart' as $2;
import 'object_reference.pbjson.dart' as $17;
import 'owner.pbjson.dart' as $8;
import 'protocol_config.pbjson.dart' as $27;
import 'signature.pbjson.dart' as $18;
import 'system_state.pbjson.dart' as $26;
import 'transaction.pbjson.dart' as $12;

@$core.Deprecated('Use getServiceInfoRequestDescriptor instead')
const GetServiceInfoRequest$json = {
  '1': 'GetServiceInfoRequest',
};

/// Descriptor for `GetServiceInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceInfoRequestDescriptor = $convert.base64Decode(
    'ChVHZXRTZXJ2aWNlSW5mb1JlcXVlc3Q=');

@$core.Deprecated('Use getServiceInfoResponseDescriptor instead')
const GetServiceInfoResponse$json = {
  '1': 'GetServiceInfoResponse',
  '2': [
    {'1': 'chain_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'chainId', '17': true},
    {'1': 'chain', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'chain', '17': true},
    {'1': 'epoch', '3': 3, '4': 1, '5': 4, '9': 2, '10': 'epoch', '17': true},
    {'1': 'checkpoint_height', '3': 4, '4': 1, '5': 4, '9': 3, '10': 'checkpointHeight', '17': true},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '9': 4, '10': 'timestamp', '17': true},
    {'1': 'lowest_available_checkpoint', '3': 6, '4': 1, '5': 4, '9': 5, '10': 'lowestAvailableCheckpoint', '17': true},
    {'1': 'lowest_available_checkpoint_objects', '3': 7, '4': 1, '5': 4, '9': 6, '10': 'lowestAvailableCheckpointObjects', '17': true},
    {'1': 'server', '3': 8, '4': 1, '5': 9, '9': 7, '10': 'server', '17': true},
  ],
  '8': [
    {'1': '_chain_id'},
    {'1': '_chain'},
    {'1': '_epoch'},
    {'1': '_checkpoint_height'},
    {'1': '_timestamp'},
    {'1': '_lowest_available_checkpoint'},
    {'1': '_lowest_available_checkpoint_objects'},
    {'1': '_server'},
  ],
};

/// Descriptor for `GetServiceInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getServiceInfoResponseDescriptor = $convert.base64Decode(
    'ChZHZXRTZXJ2aWNlSW5mb1Jlc3BvbnNlEh4KCGNoYWluX2lkGAEgASgJSABSB2NoYWluSWSIAQ'
    'ESGQoFY2hhaW4YAiABKAlIAVIFY2hhaW6IAQESGQoFZXBvY2gYAyABKARIAlIFZXBvY2iIAQES'
    'MAoRY2hlY2twb2ludF9oZWlnaHQYBCABKARIA1IQY2hlY2twb2ludEhlaWdodIgBARI9Cgl0aW'
    '1lc3RhbXAYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wSARSCXRpbWVzdGFtcIgB'
    'ARJDChtsb3dlc3RfYXZhaWxhYmxlX2NoZWNrcG9pbnQYBiABKARIBVIZbG93ZXN0QXZhaWxhYm'
    'xlQ2hlY2twb2ludIgBARJSCiNsb3dlc3RfYXZhaWxhYmxlX2NoZWNrcG9pbnRfb2JqZWN0cxgH'
    'IAEoBEgGUiBsb3dlc3RBdmFpbGFibGVDaGVja3BvaW50T2JqZWN0c4gBARIbCgZzZXJ2ZXIYCC'
    'ABKAlIB1IGc2VydmVyiAEBQgsKCV9jaGFpbl9pZEIICgZfY2hhaW5CCAoGX2Vwb2NoQhQKEl9j'
    'aGVja3BvaW50X2hlaWdodEIMCgpfdGltZXN0YW1wQh4KHF9sb3dlc3RfYXZhaWxhYmxlX2NoZW'
    'NrcG9pbnRCJgokX2xvd2VzdF9hdmFpbGFibGVfY2hlY2twb2ludF9vYmplY3RzQgkKB19zZXJ2'
    'ZXI=');

@$core.Deprecated('Use getObjectRequestDescriptor instead')
const GetObjectRequest$json = {
  '1': 'GetObjectRequest',
  '2': [
    {'1': 'object_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'objectId', '17': true},
    {'1': 'version', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'version', '17': true},
    {'1': 'read_mask', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '9': 2, '10': 'readMask', '17': true},
  ],
  '8': [
    {'1': '_object_id'},
    {'1': '_version'},
    {'1': '_read_mask'},
  ],
};

/// Descriptor for `GetObjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getObjectRequestDescriptor = $convert.base64Decode(
    'ChBHZXRPYmplY3RSZXF1ZXN0EiAKCW9iamVjdF9pZBgBIAEoCUgAUghvYmplY3RJZIgBARIdCg'
    'd2ZXJzaW9uGAIgASgESAFSB3ZlcnNpb26IAQESPAoJcmVhZF9tYXNrGAMgASgLMhouZ29vZ2xl'
    'LnByb3RvYnVmLkZpZWxkTWFza0gCUghyZWFkTWFza4gBAUIMCgpfb2JqZWN0X2lkQgoKCF92ZX'
    'JzaW9uQgwKCl9yZWFkX21hc2s=');

@$core.Deprecated('Use getObjectResponseDescriptor instead')
const GetObjectResponse$json = {
  '1': 'GetObjectResponse',
  '2': [
    {'1': 'object', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.Object', '9': 0, '10': 'object', '17': true},
  ],
  '8': [
    {'1': '_object'},
  ],
};

/// Descriptor for `GetObjectResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getObjectResponseDescriptor = $convert.base64Decode(
    'ChFHZXRPYmplY3RSZXNwb25zZRIvCgZvYmplY3QYASABKAsyEi5zdWkucnBjLnYyLk9iamVjdE'
    'gAUgZvYmplY3SIAQFCCQoHX29iamVjdA==');

@$core.Deprecated('Use batchGetObjectsRequestDescriptor instead')
const BatchGetObjectsRequest$json = {
  '1': 'BatchGetObjectsRequest',
  '2': [
    {'1': 'requests', '3': 1, '4': 3, '5': 11, '6': '.sui.rpc.v2.GetObjectRequest', '10': 'requests'},
    {'1': 'read_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '9': 0, '10': 'readMask', '17': true},
  ],
  '8': [
    {'1': '_read_mask'},
  ],
};

/// Descriptor for `BatchGetObjectsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchGetObjectsRequestDescriptor = $convert.base64Decode(
    'ChZCYXRjaEdldE9iamVjdHNSZXF1ZXN0EjgKCHJlcXVlc3RzGAEgAygLMhwuc3VpLnJwYy52Mi'
    '5HZXRPYmplY3RSZXF1ZXN0UghyZXF1ZXN0cxI8CglyZWFkX21hc2sYAiABKAsyGi5nb29nbGUu'
    'cHJvdG9idWYuRmllbGRNYXNrSABSCHJlYWRNYXNriAEBQgwKCl9yZWFkX21hc2s=');

@$core.Deprecated('Use batchGetObjectsResponseDescriptor instead')
const BatchGetObjectsResponse$json = {
  '1': 'BatchGetObjectsResponse',
  '2': [
    {'1': 'objects', '3': 1, '4': 3, '5': 11, '6': '.sui.rpc.v2.GetObjectResult', '10': 'objects'},
  ],
};

/// Descriptor for `BatchGetObjectsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchGetObjectsResponseDescriptor = $convert.base64Decode(
    'ChdCYXRjaEdldE9iamVjdHNSZXNwb25zZRI1CgdvYmplY3RzGAEgAygLMhsuc3VpLnJwYy52Mi'
    '5HZXRPYmplY3RSZXN1bHRSB29iamVjdHM=');

@$core.Deprecated('Use getObjectResultDescriptor instead')
const GetObjectResult$json = {
  '1': 'GetObjectResult',
  '2': [
    {'1': 'object', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.Object', '9': 0, '10': 'object'},
    {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.google.rpc.Status', '9': 0, '10': 'error'},
  ],
  '8': [
    {'1': 'result'},
  ],
};

/// Descriptor for `GetObjectResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getObjectResultDescriptor = $convert.base64Decode(
    'Cg9HZXRPYmplY3RSZXN1bHQSLAoGb2JqZWN0GAEgASgLMhIuc3VpLnJwYy52Mi5PYmplY3RIAF'
    'IGb2JqZWN0EioKBWVycm9yGAIgASgLMhIuZ29vZ2xlLnJwYy5TdGF0dXNIAFIFZXJyb3JCCAoG'
    'cmVzdWx0');

@$core.Deprecated('Use getTransactionRequestDescriptor instead')
const GetTransactionRequest$json = {
  '1': 'GetTransactionRequest',
  '2': [
    {'1': 'digest', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'digest', '17': true},
    {'1': 'read_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '9': 1, '10': 'readMask', '17': true},
  ],
  '8': [
    {'1': '_digest'},
    {'1': '_read_mask'},
  ],
};

/// Descriptor for `GetTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionRequestDescriptor = $convert.base64Decode(
    'ChVHZXRUcmFuc2FjdGlvblJlcXVlc3QSGwoGZGlnZXN0GAEgASgJSABSBmRpZ2VzdIgBARI8Cg'
    'lyZWFkX21hc2sYAiABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrSAFSCHJlYWRNYXNr'
    'iAEBQgkKB19kaWdlc3RCDAoKX3JlYWRfbWFzaw==');

@$core.Deprecated('Use getTransactionResponseDescriptor instead')
const GetTransactionResponse$json = {
  '1': 'GetTransactionResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.ExecutedTransaction', '9': 0, '10': 'transaction', '17': true},
  ],
  '8': [
    {'1': '_transaction'},
  ],
};

/// Descriptor for `GetTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionResponseDescriptor = $convert.base64Decode(
    'ChZHZXRUcmFuc2FjdGlvblJlc3BvbnNlEkYKC3RyYW5zYWN0aW9uGAEgASgLMh8uc3VpLnJwYy'
    '52Mi5FeGVjdXRlZFRyYW5zYWN0aW9uSABSC3RyYW5zYWN0aW9uiAEBQg4KDF90cmFuc2FjdGlv'
    'bg==');

@$core.Deprecated('Use batchGetTransactionsRequestDescriptor instead')
const BatchGetTransactionsRequest$json = {
  '1': 'BatchGetTransactionsRequest',
  '2': [
    {'1': 'digests', '3': 1, '4': 3, '5': 9, '10': 'digests'},
    {'1': 'read_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '9': 0, '10': 'readMask', '17': true},
  ],
  '8': [
    {'1': '_read_mask'},
  ],
};

/// Descriptor for `BatchGetTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchGetTransactionsRequestDescriptor = $convert.base64Decode(
    'ChtCYXRjaEdldFRyYW5zYWN0aW9uc1JlcXVlc3QSGAoHZGlnZXN0cxgBIAMoCVIHZGlnZXN0cx'
    'I8CglyZWFkX21hc2sYAiABKAsyGi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrSABSCHJlYWRN'
    'YXNriAEBQgwKCl9yZWFkX21hc2s=');

@$core.Deprecated('Use batchGetTransactionsResponseDescriptor instead')
const BatchGetTransactionsResponse$json = {
  '1': 'BatchGetTransactionsResponse',
  '2': [
    {'1': 'transactions', '3': 1, '4': 3, '5': 11, '6': '.sui.rpc.v2.GetTransactionResult', '10': 'transactions'},
  ],
};

/// Descriptor for `BatchGetTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List batchGetTransactionsResponseDescriptor = $convert.base64Decode(
    'ChxCYXRjaEdldFRyYW5zYWN0aW9uc1Jlc3BvbnNlEkQKDHRyYW5zYWN0aW9ucxgBIAMoCzIgLn'
    'N1aS5ycGMudjIuR2V0VHJhbnNhY3Rpb25SZXN1bHRSDHRyYW5zYWN0aW9ucw==');

@$core.Deprecated('Use getTransactionResultDescriptor instead')
const GetTransactionResult$json = {
  '1': 'GetTransactionResult',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.ExecutedTransaction', '9': 0, '10': 'transaction'},
    {'1': 'error', '3': 2, '4': 1, '5': 11, '6': '.google.rpc.Status', '9': 0, '10': 'error'},
  ],
  '8': [
    {'1': 'result'},
  ],
};

/// Descriptor for `GetTransactionResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getTransactionResultDescriptor = $convert.base64Decode(
    'ChRHZXRUcmFuc2FjdGlvblJlc3VsdBJDCgt0cmFuc2FjdGlvbhgBIAEoCzIfLnN1aS5ycGMudj'
    'IuRXhlY3V0ZWRUcmFuc2FjdGlvbkgAUgt0cmFuc2FjdGlvbhIqCgVlcnJvchgCIAEoCzISLmdv'
    'b2dsZS5ycGMuU3RhdHVzSABSBWVycm9yQggKBnJlc3VsdA==');

@$core.Deprecated('Use getCheckpointRequestDescriptor instead')
const GetCheckpointRequest$json = {
  '1': 'GetCheckpointRequest',
  '2': [
    {'1': 'sequence_number', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'sequenceNumber'},
    {'1': 'digest', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'digest'},
    {'1': 'read_mask', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '9': 1, '10': 'readMask', '17': true},
  ],
  '8': [
    {'1': 'checkpoint_id'},
    {'1': '_read_mask'},
  ],
};

/// Descriptor for `GetCheckpointRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCheckpointRequestDescriptor = $convert.base64Decode(
    'ChRHZXRDaGVja3BvaW50UmVxdWVzdBIpCg9zZXF1ZW5jZV9udW1iZXIYASABKARIAFIOc2VxdW'
    'VuY2VOdW1iZXISGAoGZGlnZXN0GAIgASgJSABSBmRpZ2VzdBI8CglyZWFkX21hc2sYAyABKAsy'
    'Gi5nb29nbGUucHJvdG9idWYuRmllbGRNYXNrSAFSCHJlYWRNYXNriAEBQg8KDWNoZWNrcG9pbn'
    'RfaWRCDAoKX3JlYWRfbWFzaw==');

@$core.Deprecated('Use getCheckpointResponseDescriptor instead')
const GetCheckpointResponse$json = {
  '1': 'GetCheckpointResponse',
  '2': [
    {'1': 'checkpoint', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.Checkpoint', '9': 0, '10': 'checkpoint', '17': true},
  ],
  '8': [
    {'1': '_checkpoint'},
  ],
};

/// Descriptor for `GetCheckpointResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getCheckpointResponseDescriptor = $convert.base64Decode(
    'ChVHZXRDaGVja3BvaW50UmVzcG9uc2USOwoKY2hlY2twb2ludBgBIAEoCzIWLnN1aS5ycGMudj'
    'IuQ2hlY2twb2ludEgAUgpjaGVja3BvaW50iAEBQg0KC19jaGVja3BvaW50');

@$core.Deprecated('Use getEpochRequestDescriptor instead')
const GetEpochRequest$json = {
  '1': 'GetEpochRequest',
  '2': [
    {'1': 'epoch', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'epoch', '17': true},
    {'1': 'read_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '9': 1, '10': 'readMask', '17': true},
  ],
  '8': [
    {'1': '_epoch'},
    {'1': '_read_mask'},
  ],
};

/// Descriptor for `GetEpochRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEpochRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRFcG9jaFJlcXVlc3QSGQoFZXBvY2gYASABKARIAFIFZXBvY2iIAQESPAoJcmVhZF9tYX'
    'NrGAIgASgLMhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza0gBUghyZWFkTWFza4gBAUIICgZf'
    'ZXBvY2hCDAoKX3JlYWRfbWFzaw==');

@$core.Deprecated('Use getEpochResponseDescriptor instead')
const GetEpochResponse$json = {
  '1': 'GetEpochResponse',
  '2': [
    {'1': 'epoch', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.Epoch', '9': 0, '10': 'epoch', '17': true},
  ],
  '8': [
    {'1': '_epoch'},
  ],
};

/// Descriptor for `GetEpochResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getEpochResponseDescriptor = $convert.base64Decode(
    'ChBHZXRFcG9jaFJlc3BvbnNlEiwKBWVwb2NoGAEgASgLMhEuc3VpLnJwYy52Mi5FcG9jaEgAUg'
    'VlcG9jaIgBAUIICgZfZXBvY2g=');

const $core.Map<$core.String, $core.dynamic> LedgerServiceBase$json = {
  '1': 'LedgerService',
  '2': [
    {'1': 'GetServiceInfo', '2': '.sui.rpc.v2.GetServiceInfoRequest', '3': '.sui.rpc.v2.GetServiceInfoResponse'},
    {'1': 'GetObject', '2': '.sui.rpc.v2.GetObjectRequest', '3': '.sui.rpc.v2.GetObjectResponse'},
    {'1': 'BatchGetObjects', '2': '.sui.rpc.v2.BatchGetObjectsRequest', '3': '.sui.rpc.v2.BatchGetObjectsResponse'},
    {'1': 'GetTransaction', '2': '.sui.rpc.v2.GetTransactionRequest', '3': '.sui.rpc.v2.GetTransactionResponse'},
    {'1': 'BatchGetTransactions', '2': '.sui.rpc.v2.BatchGetTransactionsRequest', '3': '.sui.rpc.v2.BatchGetTransactionsResponse'},
    {'1': 'GetCheckpoint', '2': '.sui.rpc.v2.GetCheckpointRequest', '3': '.sui.rpc.v2.GetCheckpointResponse'},
    {'1': 'GetEpoch', '2': '.sui.rpc.v2.GetEpochRequest', '3': '.sui.rpc.v2.GetEpochResponse'},
  ],
};

@$core.Deprecated('Use ledgerServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> LedgerServiceBase$messageJson = {
  '.sui.rpc.v2.GetServiceInfoRequest': GetServiceInfoRequest$json,
  '.sui.rpc.v2.GetServiceInfoResponse': GetServiceInfoResponse$json,
  '.google.protobuf.Timestamp': $0.Timestamp$json,
  '.sui.rpc.v2.GetObjectRequest': GetObjectRequest$json,
  '.google.protobuf.FieldMask': $1.FieldMask$json,
  '.sui.rpc.v2.GetObjectResponse': GetObjectResponse$json,
  '.sui.rpc.v2.Object': $2.Object$json,
  '.sui.rpc.v2.Bcs': $7.Bcs$json,
  '.sui.rpc.v2.Owner': $8.Owner$json,
  '.sui.rpc.v2.Package': $9.Package$json,
  '.sui.rpc.v2.Module': $9.Module$json,
  '.sui.rpc.v2.DatatypeDescriptor': $9.DatatypeDescriptor$json,
  '.sui.rpc.v2.TypeParameter': $9.TypeParameter$json,
  '.sui.rpc.v2.FieldDescriptor': $9.FieldDescriptor$json,
  '.sui.rpc.v2.OpenSignatureBody': $9.OpenSignatureBody$json,
  '.sui.rpc.v2.VariantDescriptor': $9.VariantDescriptor$json,
  '.sui.rpc.v2.FunctionDescriptor': $9.FunctionDescriptor$json,
  '.sui.rpc.v2.OpenSignature': $9.OpenSignature$json,
  '.sui.rpc.v2.TypeOrigin': $9.TypeOrigin$json,
  '.sui.rpc.v2.Linkage': $9.Linkage$json,
  '.google.protobuf.Value': $10.Value$json,
  '.google.protobuf.Struct': $10.Struct$json,
  '.google.protobuf.Struct.FieldsEntry': $10.Struct_FieldsEntry$json,
  '.google.protobuf.ListValue': $10.ListValue$json,
  '.sui.rpc.v2.Display': $2.Display$json,
  '.sui.rpc.v2.BatchGetObjectsRequest': BatchGetObjectsRequest$json,
  '.sui.rpc.v2.BatchGetObjectsResponse': BatchGetObjectsResponse$json,
  '.sui.rpc.v2.GetObjectResult': GetObjectResult$json,
  '.google.rpc.Status': $3.Status$json,
  '.google.protobuf.Any': $11.Any$json,
  '.sui.rpc.v2.GetTransactionRequest': GetTransactionRequest$json,
  '.sui.rpc.v2.GetTransactionResponse': GetTransactionResponse$json,
  '.sui.rpc.v2.ExecutedTransaction': $4.ExecutedTransaction$json,
  '.sui.rpc.v2.Transaction': $12.Transaction$json,
  '.sui.rpc.v2.TransactionKind': $12.TransactionKind$json,
  '.sui.rpc.v2.ProgrammableTransaction': $12.ProgrammableTransaction$json,
  '.sui.rpc.v2.Input': $13.Input$json,
  '.sui.rpc.v2.FundsWithdrawal': $13.FundsWithdrawal$json,
  '.sui.rpc.v2.Command': $12.Command$json,
  '.sui.rpc.v2.MoveCall': $12.MoveCall$json,
  '.sui.rpc.v2.Argument': $14.Argument$json,
  '.sui.rpc.v2.TransferObjects': $12.TransferObjects$json,
  '.sui.rpc.v2.SplitCoins': $12.SplitCoins$json,
  '.sui.rpc.v2.MergeCoins': $12.MergeCoins$json,
  '.sui.rpc.v2.Publish': $12.Publish$json,
  '.sui.rpc.v2.MakeMoveVector': $12.MakeMoveVector$json,
  '.sui.rpc.v2.Upgrade': $12.Upgrade$json,
  '.sui.rpc.v2.ChangeEpoch': $12.ChangeEpoch$json,
  '.sui.rpc.v2.SystemPackage': $12.SystemPackage$json,
  '.sui.rpc.v2.GenesisTransaction': $12.GenesisTransaction$json,
  '.sui.rpc.v2.ConsensusCommitPrologue': $12.ConsensusCommitPrologue$json,
  '.sui.rpc.v2.ConsensusDeterminedVersionAssignments': $12.ConsensusDeterminedVersionAssignments$json,
  '.sui.rpc.v2.CanceledTransaction': $12.CanceledTransaction$json,
  '.sui.rpc.v2.VersionAssignment': $12.VersionAssignment$json,
  '.sui.rpc.v2.AuthenticatorStateUpdate': $12.AuthenticatorStateUpdate$json,
  '.sui.rpc.v2.ActiveJwk': $12.ActiveJwk$json,
  '.sui.rpc.v2.JwkId': $15.JwkId$json,
  '.sui.rpc.v2.Jwk': $15.Jwk$json,
  '.sui.rpc.v2.EndOfEpochTransaction': $12.EndOfEpochTransaction$json,
  '.sui.rpc.v2.EndOfEpochTransactionKind': $12.EndOfEpochTransactionKind$json,
  '.sui.rpc.v2.AuthenticatorStateExpire': $12.AuthenticatorStateExpire$json,
  '.sui.rpc.v2.ExecutionTimeObservations': $12.ExecutionTimeObservations$json,
  '.sui.rpc.v2.ExecutionTimeObservation': $12.ExecutionTimeObservation$json,
  '.sui.rpc.v2.ValidatorExecutionTimeObservation': $12.ValidatorExecutionTimeObservation$json,
  '.google.protobuf.Duration': $16.Duration$json,
  '.sui.rpc.v2.RandomnessStateUpdate': $12.RandomnessStateUpdate$json,
  '.sui.rpc.v2.GasPayment': $12.GasPayment$json,
  '.sui.rpc.v2.ObjectReference': $17.ObjectReference$json,
  '.sui.rpc.v2.TransactionExpiration': $12.TransactionExpiration$json,
  '.sui.rpc.v2.UserSignature': $18.UserSignature$json,
  '.sui.rpc.v2.SimpleSignature': $18.SimpleSignature$json,
  '.sui.rpc.v2.MultisigAggregatedSignature': $18.MultisigAggregatedSignature$json,
  '.sui.rpc.v2.MultisigMemberSignature': $18.MultisigMemberSignature$json,
  '.sui.rpc.v2.ZkLoginAuthenticator': $18.ZkLoginAuthenticator$json,
  '.sui.rpc.v2.ZkLoginInputs': $18.ZkLoginInputs$json,
  '.sui.rpc.v2.ZkLoginProof': $18.ZkLoginProof$json,
  '.sui.rpc.v2.CircomG1': $18.CircomG1$json,
  '.sui.rpc.v2.CircomG2': $18.CircomG2$json,
  '.sui.rpc.v2.ZkLoginClaim': $18.ZkLoginClaim$json,
  '.sui.rpc.v2.ZkLoginPublicIdentifier': $18.ZkLoginPublicIdentifier$json,
  '.sui.rpc.v2.PasskeyAuthenticator': $18.PasskeyAuthenticator$json,
  '.sui.rpc.v2.MultisigCommittee': $18.MultisigCommittee$json,
  '.sui.rpc.v2.MultisigMember': $18.MultisigMember$json,
  '.sui.rpc.v2.MultisigMemberPublicKey': $18.MultisigMemberPublicKey$json,
  '.sui.rpc.v2.TransactionEffects': $19.TransactionEffects$json,
  '.sui.rpc.v2.ExecutionStatus': $20.ExecutionStatus$json,
  '.sui.rpc.v2.ExecutionError': $20.ExecutionError$json,
  '.sui.rpc.v2.MoveAbort': $20.MoveAbort$json,
  '.sui.rpc.v2.MoveLocation': $20.MoveLocation$json,
  '.sui.rpc.v2.CleverError': $20.CleverError$json,
  '.sui.rpc.v2.SizeError': $20.SizeError$json,
  '.sui.rpc.v2.CommandArgumentError': $20.CommandArgumentError$json,
  '.sui.rpc.v2.IndexError': $20.IndexError$json,
  '.sui.rpc.v2.TypeArgumentError': $20.TypeArgumentError$json,
  '.sui.rpc.v2.PackageUpgradeError': $20.PackageUpgradeError$json,
  '.sui.rpc.v2.CoinDenyListError': $20.CoinDenyListError$json,
  '.sui.rpc.v2.CongestedObjects': $20.CongestedObjects$json,
  '.sui.rpc.v2.GasCostSummary': $21.GasCostSummary$json,
  '.sui.rpc.v2.ChangedObject': $19.ChangedObject$json,
  '.sui.rpc.v2.AccumulatorWrite': $19.AccumulatorWrite$json,
  '.sui.rpc.v2.EventDigestEntry': $19.EventDigestEntry$json,
  '.sui.rpc.v2.UnchangedConsensusObject': $19.UnchangedConsensusObject$json,
  '.sui.rpc.v2.TransactionEvents': $22.TransactionEvents$json,
  '.sui.rpc.v2.Event': $22.Event$json,
  '.sui.rpc.v2.BalanceChange': $23.BalanceChange$json,
  '.sui.rpc.v2.ObjectSet': $2.ObjectSet$json,
  '.sui.rpc.v2.BatchGetTransactionsRequest': BatchGetTransactionsRequest$json,
  '.sui.rpc.v2.BatchGetTransactionsResponse': BatchGetTransactionsResponse$json,
  '.sui.rpc.v2.GetTransactionResult': GetTransactionResult$json,
  '.sui.rpc.v2.GetCheckpointRequest': GetCheckpointRequest$json,
  '.sui.rpc.v2.GetCheckpointResponse': GetCheckpointResponse$json,
  '.sui.rpc.v2.Checkpoint': $5.Checkpoint$json,
  '.sui.rpc.v2.CheckpointSummary': $24.CheckpointSummary$json,
  '.sui.rpc.v2.CheckpointCommitment': $24.CheckpointCommitment$json,
  '.sui.rpc.v2.EndOfEpochData': $24.EndOfEpochData$json,
  '.sui.rpc.v2.ValidatorCommitteeMember': $18.ValidatorCommitteeMember$json,
  '.sui.rpc.v2.ValidatorAggregatedSignature': $18.ValidatorAggregatedSignature$json,
  '.sui.rpc.v2.CheckpointContents': $25.CheckpointContents$json,
  '.sui.rpc.v2.CheckpointedTransactionInfo': $25.CheckpointedTransactionInfo$json,
  '.sui.rpc.v2.AddressAliasesVersion': $25.AddressAliasesVersion$json,
  '.sui.rpc.v2.GetEpochRequest': GetEpochRequest$json,
  '.sui.rpc.v2.GetEpochResponse': GetEpochResponse$json,
  '.sui.rpc.v2.Epoch': $6.Epoch$json,
  '.sui.rpc.v2.ValidatorCommittee': $18.ValidatorCommittee$json,
  '.sui.rpc.v2.SystemState': $26.SystemState$json,
  '.sui.rpc.v2.ValidatorSet': $26.ValidatorSet$json,
  '.sui.rpc.v2.Validator': $26.Validator$json,
  '.sui.rpc.v2.MoveTable': $26.MoveTable$json,
  '.sui.rpc.v2.StakingPool': $26.StakingPool$json,
  '.sui.rpc.v2.ValidatorSet.AtRiskValidatorsEntry': $26.ValidatorSet_AtRiskValidatorsEntry$json,
  '.sui.rpc.v2.StorageFund': $26.StorageFund$json,
  '.sui.rpc.v2.SystemParameters': $26.SystemParameters$json,
  '.sui.rpc.v2.ValidatorReportRecord': $26.ValidatorReportRecord$json,
  '.sui.rpc.v2.StakeSubsidy': $26.StakeSubsidy$json,
  '.sui.rpc.v2.ProtocolConfig': $27.ProtocolConfig$json,
  '.sui.rpc.v2.ProtocolConfig.FeatureFlagsEntry': $27.ProtocolConfig_FeatureFlagsEntry$json,
  '.sui.rpc.v2.ProtocolConfig.AttributesEntry': $27.ProtocolConfig_AttributesEntry$json,
};

/// Descriptor for `LedgerService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List ledgerServiceDescriptor = $convert.base64Decode(
    'Cg1MZWRnZXJTZXJ2aWNlElcKDkdldFNlcnZpY2VJbmZvEiEuc3VpLnJwYy52Mi5HZXRTZXJ2aW'
    'NlSW5mb1JlcXVlc3QaIi5zdWkucnBjLnYyLkdldFNlcnZpY2VJbmZvUmVzcG9uc2USSAoJR2V0'
    'T2JqZWN0Ehwuc3VpLnJwYy52Mi5HZXRPYmplY3RSZXF1ZXN0Gh0uc3VpLnJwYy52Mi5HZXRPYm'
    'plY3RSZXNwb25zZRJaCg9CYXRjaEdldE9iamVjdHMSIi5zdWkucnBjLnYyLkJhdGNoR2V0T2Jq'
    'ZWN0c1JlcXVlc3QaIy5zdWkucnBjLnYyLkJhdGNoR2V0T2JqZWN0c1Jlc3BvbnNlElcKDkdldF'
    'RyYW5zYWN0aW9uEiEuc3VpLnJwYy52Mi5HZXRUcmFuc2FjdGlvblJlcXVlc3QaIi5zdWkucnBj'
    'LnYyLkdldFRyYW5zYWN0aW9uUmVzcG9uc2USaQoUQmF0Y2hHZXRUcmFuc2FjdGlvbnMSJy5zdW'
    'kucnBjLnYyLkJhdGNoR2V0VHJhbnNhY3Rpb25zUmVxdWVzdBooLnN1aS5ycGMudjIuQmF0Y2hH'
    'ZXRUcmFuc2FjdGlvbnNSZXNwb25zZRJUCg1HZXRDaGVja3BvaW50EiAuc3VpLnJwYy52Mi5HZX'
    'RDaGVja3BvaW50UmVxdWVzdBohLnN1aS5ycGMudjIuR2V0Q2hlY2twb2ludFJlc3BvbnNlEkUK'
    'CEdldEVwb2NoEhsuc3VpLnJwYy52Mi5HZXRFcG9jaFJlcXVlc3QaHC5zdWkucnBjLnYyLkdldE'
    'Vwb2NoUmVzcG9uc2U=');

