// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/effects.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use transactionEffectsDescriptor instead')
const TransactionEffects$json = {
  '1': 'TransactionEffects',
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
      '1': 'status',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ExecutionStatus',
      '9': 3,
      '10': 'status',
      '17': true
    },
    {'1': 'epoch', '3': 5, '4': 1, '5': 4, '9': 4, '10': 'epoch', '17': true},
    {
      '1': 'gas_used',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.GasCostSummary',
      '9': 5,
      '10': 'gasUsed',
      '17': true
    },
    {
      '1': 'transaction_digest',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'transactionDigest',
      '17': true
    },
    {
      '1': 'gas_object',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ChangedObject',
      '9': 7,
      '10': 'gasObject',
      '17': true
    },
    {
      '1': 'events_digest',
      '3': 9,
      '4': 1,
      '5': 9,
      '9': 8,
      '10': 'eventsDigest',
      '17': true
    },
    {'1': 'dependencies', '3': 10, '4': 3, '5': 9, '10': 'dependencies'},
    {
      '1': 'lamport_version',
      '3': 11,
      '4': 1,
      '5': 4,
      '9': 9,
      '10': 'lamportVersion',
      '17': true
    },
    {
      '1': 'changed_objects',
      '3': 12,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ChangedObject',
      '10': 'changedObjects'
    },
    {
      '1': 'unchanged_consensus_objects',
      '3': 13,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.UnchangedConsensusObject',
      '10': 'unchangedConsensusObjects'
    },
    {
      '1': 'auxiliary_data_digest',
      '3': 14,
      '4': 1,
      '5': 9,
      '9': 10,
      '10': 'auxiliaryDataDigest',
      '17': true
    },
    {
      '1': 'unchanged_loaded_runtime_objects',
      '3': 15,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ObjectReference',
      '10': 'unchangedLoadedRuntimeObjects'
    },
  ],
  '8': [
    {'1': '_bcs'},
    {'1': '_digest'},
    {'1': '_version'},
    {'1': '_status'},
    {'1': '_epoch'},
    {'1': '_gas_used'},
    {'1': '_transaction_digest'},
    {'1': '_gas_object'},
    {'1': '_events_digest'},
    {'1': '_lamport_version'},
    {'1': '_auxiliary_data_digest'},
  ],
};

/// Descriptor for `TransactionEffects`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionEffectsDescriptor = $convert.base64Decode(
    'ChJUcmFuc2FjdGlvbkVmZmVjdHMSJgoDYmNzGAEgASgLMg8uc3VpLnJwYy52Mi5CY3NIAFIDYm'
    'NziAEBEhsKBmRpZ2VzdBgCIAEoCUgBUgZkaWdlc3SIAQESHQoHdmVyc2lvbhgDIAEoBUgCUgd2'
    'ZXJzaW9uiAEBEjgKBnN0YXR1cxgEIAEoCzIbLnN1aS5ycGMudjIuRXhlY3V0aW9uU3RhdHVzSA'
    'NSBnN0YXR1c4gBARIZCgVlcG9jaBgFIAEoBEgEUgVlcG9jaIgBARI6CghnYXNfdXNlZBgGIAEo'
    'CzIaLnN1aS5ycGMudjIuR2FzQ29zdFN1bW1hcnlIBVIHZ2FzVXNlZIgBARIyChJ0cmFuc2FjdG'
    'lvbl9kaWdlc3QYByABKAlIBlIRdHJhbnNhY3Rpb25EaWdlc3SIAQESPQoKZ2FzX29iamVjdBgI'
    'IAEoCzIZLnN1aS5ycGMudjIuQ2hhbmdlZE9iamVjdEgHUglnYXNPYmplY3SIAQESKAoNZXZlbn'
    'RzX2RpZ2VzdBgJIAEoCUgIUgxldmVudHNEaWdlc3SIAQESIgoMZGVwZW5kZW5jaWVzGAogAygJ'
    'UgxkZXBlbmRlbmNpZXMSLAoPbGFtcG9ydF92ZXJzaW9uGAsgASgESAlSDmxhbXBvcnRWZXJzaW'
    '9uiAEBEkIKD2NoYW5nZWRfb2JqZWN0cxgMIAMoCzIZLnN1aS5ycGMudjIuQ2hhbmdlZE9iamVj'
    'dFIOY2hhbmdlZE9iamVjdHMSZAobdW5jaGFuZ2VkX2NvbnNlbnN1c19vYmplY3RzGA0gAygLMi'
    'Quc3VpLnJwYy52Mi5VbmNoYW5nZWRDb25zZW5zdXNPYmplY3RSGXVuY2hhbmdlZENvbnNlbnN1'
    'c09iamVjdHMSNwoVYXV4aWxpYXJ5X2RhdGFfZGlnZXN0GA4gASgJSApSE2F1eGlsaWFyeURhdG'
    'FEaWdlc3SIAQESZAogdW5jaGFuZ2VkX2xvYWRlZF9ydW50aW1lX29iamVjdHMYDyADKAsyGy5z'
    'dWkucnBjLnYyLk9iamVjdFJlZmVyZW5jZVIddW5jaGFuZ2VkTG9hZGVkUnVudGltZU9iamVjdH'
    'NCBgoEX2Jjc0IJCgdfZGlnZXN0QgoKCF92ZXJzaW9uQgkKB19zdGF0dXNCCAoGX2Vwb2NoQgsK'
    'CV9nYXNfdXNlZEIVChNfdHJhbnNhY3Rpb25fZGlnZXN0Qg0KC19nYXNfb2JqZWN0QhAKDl9ldm'
    'VudHNfZGlnZXN0QhIKEF9sYW1wb3J0X3ZlcnNpb25CGAoWX2F1eGlsaWFyeV9kYXRhX2RpZ2Vz'
    'dA==');

@$core.Deprecated('Use changedObjectDescriptor instead')
const ChangedObject$json = {
  '1': 'ChangedObject',
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
    {
      '1': 'input_state',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.ChangedObject.InputObjectState',
      '9': 1,
      '10': 'inputState',
      '17': true
    },
    {
      '1': 'input_version',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'inputVersion',
      '17': true
    },
    {
      '1': 'input_digest',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'inputDigest',
      '17': true
    },
    {
      '1': 'input_owner',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Owner',
      '9': 4,
      '10': 'inputOwner',
      '17': true
    },
    {
      '1': 'output_state',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.ChangedObject.OutputObjectState',
      '9': 5,
      '10': 'outputState',
      '17': true
    },
    {
      '1': 'output_version',
      '3': 7,
      '4': 1,
      '5': 4,
      '9': 6,
      '10': 'outputVersion',
      '17': true
    },
    {
      '1': 'output_digest',
      '3': 8,
      '4': 1,
      '5': 9,
      '9': 7,
      '10': 'outputDigest',
      '17': true
    },
    {
      '1': 'output_owner',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Owner',
      '9': 8,
      '10': 'outputOwner',
      '17': true
    },
    {
      '1': 'accumulator_write',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.AccumulatorWrite',
      '9': 9,
      '10': 'accumulatorWrite',
      '17': true
    },
    {
      '1': 'id_operation',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.ChangedObject.IdOperation',
      '9': 10,
      '10': 'idOperation',
      '17': true
    },
    {
      '1': 'object_type',
      '3': 11,
      '4': 1,
      '5': 9,
      '9': 11,
      '10': 'objectType',
      '17': true
    },
  ],
  '4': [
    ChangedObject_InputObjectState$json,
    ChangedObject_OutputObjectState$json,
    ChangedObject_IdOperation$json
  ],
  '8': [
    {'1': '_object_id'},
    {'1': '_input_state'},
    {'1': '_input_version'},
    {'1': '_input_digest'},
    {'1': '_input_owner'},
    {'1': '_output_state'},
    {'1': '_output_version'},
    {'1': '_output_digest'},
    {'1': '_output_owner'},
    {'1': '_accumulator_write'},
    {'1': '_id_operation'},
    {'1': '_object_type'},
  ],
};

@$core.Deprecated('Use changedObjectDescriptor instead')
const ChangedObject_InputObjectState$json = {
  '1': 'InputObjectState',
  '2': [
    {'1': 'INPUT_OBJECT_STATE_UNKNOWN', '2': 0},
    {'1': 'INPUT_OBJECT_STATE_DOES_NOT_EXIST', '2': 1},
    {'1': 'INPUT_OBJECT_STATE_EXISTS', '2': 2},
  ],
};

@$core.Deprecated('Use changedObjectDescriptor instead')
const ChangedObject_OutputObjectState$json = {
  '1': 'OutputObjectState',
  '2': [
    {'1': 'OUTPUT_OBJECT_STATE_UNKNOWN', '2': 0},
    {'1': 'OUTPUT_OBJECT_STATE_DOES_NOT_EXIST', '2': 1},
    {'1': 'OUTPUT_OBJECT_STATE_OBJECT_WRITE', '2': 2},
    {'1': 'OUTPUT_OBJECT_STATE_PACKAGE_WRITE', '2': 3},
    {'1': 'OUTPUT_OBJECT_STATE_ACCUMULATOR_WRITE', '2': 4},
  ],
};

@$core.Deprecated('Use changedObjectDescriptor instead')
const ChangedObject_IdOperation$json = {
  '1': 'IdOperation',
  '2': [
    {'1': 'ID_OPERATION_UNKNOWN', '2': 0},
    {'1': 'NONE', '2': 1},
    {'1': 'CREATED', '2': 2},
    {'1': 'DELETED', '2': 3},
  ],
};

/// Descriptor for `ChangedObject`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changedObjectDescriptor = $convert.base64Decode(
    'Cg1DaGFuZ2VkT2JqZWN0EiAKCW9iamVjdF9pZBgBIAEoCUgAUghvYmplY3RJZIgBARJQCgtpbn'
    'B1dF9zdGF0ZRgCIAEoDjIqLnN1aS5ycGMudjIuQ2hhbmdlZE9iamVjdC5JbnB1dE9iamVjdFN0'
    'YXRlSAFSCmlucHV0U3RhdGWIAQESKAoNaW5wdXRfdmVyc2lvbhgDIAEoBEgCUgxpbnB1dFZlcn'
    'Npb26IAQESJgoMaW5wdXRfZGlnZXN0GAQgASgJSANSC2lucHV0RGlnZXN0iAEBEjcKC2lucHV0'
    'X293bmVyGAUgASgLMhEuc3VpLnJwYy52Mi5Pd25lckgEUgppbnB1dE93bmVyiAEBElMKDG91dH'
    'B1dF9zdGF0ZRgGIAEoDjIrLnN1aS5ycGMudjIuQ2hhbmdlZE9iamVjdC5PdXRwdXRPYmplY3RT'
    'dGF0ZUgFUgtvdXRwdXRTdGF0ZYgBARIqCg5vdXRwdXRfdmVyc2lvbhgHIAEoBEgGUg1vdXRwdX'
    'RWZXJzaW9uiAEBEigKDW91dHB1dF9kaWdlc3QYCCABKAlIB1IMb3V0cHV0RGlnZXN0iAEBEjkK'
    'DG91dHB1dF9vd25lchgJIAEoCzIRLnN1aS5ycGMudjIuT3duZXJICFILb3V0cHV0T3duZXKIAQ'
    'ESTgoRYWNjdW11bGF0b3Jfd3JpdGUYDCABKAsyHC5zdWkucnBjLnYyLkFjY3VtdWxhdG9yV3Jp'
    'dGVICVIQYWNjdW11bGF0b3JXcml0ZYgBARJNCgxpZF9vcGVyYXRpb24YCiABKA4yJS5zdWkucn'
    'BjLnYyLkNoYW5nZWRPYmplY3QuSWRPcGVyYXRpb25IClILaWRPcGVyYXRpb26IAQESJAoLb2Jq'
    'ZWN0X3R5cGUYCyABKAlIC1IKb2JqZWN0VHlwZYgBASJ4ChBJbnB1dE9iamVjdFN0YXRlEh4KGk'
    'lOUFVUX09CSkVDVF9TVEFURV9VTktOT1dOEAASJQohSU5QVVRfT0JKRUNUX1NUQVRFX0RPRVNf'
    'Tk9UX0VYSVNUEAESHQoZSU5QVVRfT0JKRUNUX1NUQVRFX0VYSVNUUxACItQBChFPdXRwdXRPYm'
    'plY3RTdGF0ZRIfChtPVVRQVVRfT0JKRUNUX1NUQVRFX1VOS05PV04QABImCiJPVVRQVVRfT0JK'
    'RUNUX1NUQVRFX0RPRVNfTk9UX0VYSVNUEAESJAogT1VUUFVUX09CSkVDVF9TVEFURV9PQkpFQ1'
    'RfV1JJVEUQAhIlCiFPVVRQVVRfT0JKRUNUX1NUQVRFX1BBQ0tBR0VfV1JJVEUQAxIpCiVPVVRQ'
    'VVRfT0JKRUNUX1NUQVRFX0FDQ1VNVUxBVE9SX1dSSVRFEAQiSwoLSWRPcGVyYXRpb24SGAoUSU'
    'RfT1BFUkFUSU9OX1VOS05PV04QABIICgROT05FEAESCwoHQ1JFQVRFRBACEgsKB0RFTEVURUQQ'
    'A0IMCgpfb2JqZWN0X2lkQg4KDF9pbnB1dF9zdGF0ZUIQCg5faW5wdXRfdmVyc2lvbkIPCg1faW'
    '5wdXRfZGlnZXN0Qg4KDF9pbnB1dF9vd25lckIPCg1fb3V0cHV0X3N0YXRlQhEKD19vdXRwdXRf'
    'dmVyc2lvbkIQCg5fb3V0cHV0X2RpZ2VzdEIPCg1fb3V0cHV0X293bmVyQhQKEl9hY2N1bXVsYX'
    'Rvcl93cml0ZUIPCg1faWRfb3BlcmF0aW9uQg4KDF9vYmplY3RfdHlwZQ==');

@$core.Deprecated('Use eventDigestEntryDescriptor instead')
const EventDigestEntry$json = {
  '1': 'EventDigestEntry',
  '2': [
    {
      '1': 'event_index',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'eventIndex',
      '17': true
    },
    {'1': 'digest', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'digest', '17': true},
  ],
  '8': [
    {'1': '_event_index'},
    {'1': '_digest'},
  ],
};

/// Descriptor for `EventDigestEntry`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventDigestEntryDescriptor = $convert.base64Decode(
    'ChBFdmVudERpZ2VzdEVudHJ5EiQKC2V2ZW50X2luZGV4GAEgASgESABSCmV2ZW50SW5kZXiIAQ'
    'ESGwoGZGlnZXN0GAIgASgJSAFSBmRpZ2VzdIgBAUIOCgxfZXZlbnRfaW5kZXhCCQoHX2RpZ2Vz'
    'dA==');

@$core.Deprecated('Use accumulatorWriteDescriptor instead')
const AccumulatorWrite$json = {
  '1': 'AccumulatorWrite',
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
      '1': 'accumulator_type',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'accumulatorType',
      '17': true
    },
    {
      '1': 'operation',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.AccumulatorWrite.AccumulatorOperation',
      '9': 2,
      '10': 'operation',
      '17': true
    },
    {
      '1': 'value_kind',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.AccumulatorWrite.AccumulatorValue',
      '9': 3,
      '10': 'valueKind',
      '17': true
    },
    {
      '1': 'integer_value',
      '3': 5,
      '4': 1,
      '5': 4,
      '9': 4,
      '10': 'integerValue',
      '17': true
    },
    {'1': 'integer_tuple', '3': 6, '4': 3, '5': 4, '10': 'integerTuple'},
    {
      '1': 'event_digest_value',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.EventDigestEntry',
      '10': 'eventDigestValue'
    },
  ],
  '4': [
    AccumulatorWrite_AccumulatorOperation$json,
    AccumulatorWrite_AccumulatorValue$json
  ],
  '8': [
    {'1': '_address'},
    {'1': '_accumulator_type'},
    {'1': '_operation'},
    {'1': '_value_kind'},
    {'1': '_integer_value'},
  ],
};

@$core.Deprecated('Use accumulatorWriteDescriptor instead')
const AccumulatorWrite_AccumulatorOperation$json = {
  '1': 'AccumulatorOperation',
  '2': [
    {'1': 'ACCUMULATOR_OPERATION_UNKNOWN', '2': 0},
    {'1': 'MERGE', '2': 1},
    {'1': 'SPLIT', '2': 2},
  ],
};

@$core.Deprecated('Use accumulatorWriteDescriptor instead')
const AccumulatorWrite_AccumulatorValue$json = {
  '1': 'AccumulatorValue',
  '2': [
    {'1': 'ACCUMULATOR_VALUE_UNKNOWN', '2': 0},
    {'1': 'INTEGER', '2': 1},
    {'1': 'INTEGER_TUPLE', '2': 2},
    {'1': 'EVENT_DIGEST', '2': 3},
  ],
};

/// Descriptor for `AccumulatorWrite`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List accumulatorWriteDescriptor = $convert.base64Decode(
    'ChBBY2N1bXVsYXRvcldyaXRlEh0KB2FkZHJlc3MYASABKAlIAFIHYWRkcmVzc4gBARIuChBhY2'
    'N1bXVsYXRvcl90eXBlGAIgASgJSAFSD2FjY3VtdWxhdG9yVHlwZYgBARJUCglvcGVyYXRpb24Y'
    'AyABKA4yMS5zdWkucnBjLnYyLkFjY3VtdWxhdG9yV3JpdGUuQWNjdW11bGF0b3JPcGVyYXRpb2'
    '5IAlIJb3BlcmF0aW9uiAEBElEKCnZhbHVlX2tpbmQYBCABKA4yLS5zdWkucnBjLnYyLkFjY3Vt'
    'dWxhdG9yV3JpdGUuQWNjdW11bGF0b3JWYWx1ZUgDUgl2YWx1ZUtpbmSIAQESKAoNaW50ZWdlcl'
    '92YWx1ZRgFIAEoBEgEUgxpbnRlZ2VyVmFsdWWIAQESIwoNaW50ZWdlcl90dXBsZRgGIAMoBFIM'
    'aW50ZWdlclR1cGxlEkoKEmV2ZW50X2RpZ2VzdF92YWx1ZRgHIAMoCzIcLnN1aS5ycGMudjIuRX'
    'ZlbnREaWdlc3RFbnRyeVIQZXZlbnREaWdlc3RWYWx1ZSJPChRBY2N1bXVsYXRvck9wZXJhdGlv'
    'bhIhCh1BQ0NVTVVMQVRPUl9PUEVSQVRJT05fVU5LTk9XThAAEgkKBU1FUkdFEAESCQoFU1BMSV'
    'QQAiJjChBBY2N1bXVsYXRvclZhbHVlEh0KGUFDQ1VNVUxBVE9SX1ZBTFVFX1VOS05PV04QABIL'
    'CgdJTlRFR0VSEAESEQoNSU5URUdFUl9UVVBMRRACEhAKDEVWRU5UX0RJR0VTVBADQgoKCF9hZG'
    'RyZXNzQhMKEV9hY2N1bXVsYXRvcl90eXBlQgwKCl9vcGVyYXRpb25CDQoLX3ZhbHVlX2tpbmRC'
    'EAoOX2ludGVnZXJfdmFsdWU=');

@$core.Deprecated('Use unchangedConsensusObjectDescriptor instead')
const UnchangedConsensusObject$json = {
  '1': 'UnchangedConsensusObject',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.UnchangedConsensusObject.UnchangedConsensusObjectKind',
      '9': 0,
      '10': 'kind',
      '17': true
    },
    {
      '1': 'object_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'objectId',
      '17': true
    },
    {
      '1': 'version',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'version',
      '17': true
    },
    {'1': 'digest', '3': 4, '4': 1, '5': 9, '9': 3, '10': 'digest', '17': true},
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
  '4': [UnchangedConsensusObject_UnchangedConsensusObjectKind$json],
  '8': [
    {'1': '_kind'},
    {'1': '_object_id'},
    {'1': '_version'},
    {'1': '_digest'},
    {'1': '_object_type'},
  ],
};

@$core.Deprecated('Use unchangedConsensusObjectDescriptor instead')
const UnchangedConsensusObject_UnchangedConsensusObjectKind$json = {
  '1': 'UnchangedConsensusObjectKind',
  '2': [
    {'1': 'UNCHANGED_CONSENSUS_OBJECT_KIND_UNKNOWN', '2': 0},
    {'1': 'READ_ONLY_ROOT', '2': 1},
    {'1': 'MUTATE_CONSENSUS_STREAM_ENDED', '2': 2},
    {'1': 'READ_CONSENSUS_STREAM_ENDED', '2': 3},
    {'1': 'CANCELED', '2': 4},
    {'1': 'PER_EPOCH_CONFIG', '2': 5},
  ],
};

/// Descriptor for `UnchangedConsensusObject`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unchangedConsensusObjectDescriptor = $convert.base64Decode(
    'ChhVbmNoYW5nZWRDb25zZW5zdXNPYmplY3QSWgoEa2luZBgBIAEoDjJBLnN1aS5ycGMudjIuVW'
    '5jaGFuZ2VkQ29uc2Vuc3VzT2JqZWN0LlVuY2hhbmdlZENvbnNlbnN1c09iamVjdEtpbmRIAFIE'
    'a2luZIgBARIgCglvYmplY3RfaWQYAiABKAlIAVIIb2JqZWN0SWSIAQESHQoHdmVyc2lvbhgDIA'
    'EoBEgCUgd2ZXJzaW9uiAEBEhsKBmRpZ2VzdBgEIAEoCUgDUgZkaWdlc3SIAQESJAoLb2JqZWN0'
    'X3R5cGUYBSABKAlIBFIKb2JqZWN0VHlwZYgBASLHAQocVW5jaGFuZ2VkQ29uc2Vuc3VzT2JqZW'
    'N0S2luZBIrCidVTkNIQU5HRURfQ09OU0VOU1VTX09CSkVDVF9LSU5EX1VOS05PV04QABISCg5S'
    'RUFEX09OTFlfUk9PVBABEiEKHU1VVEFURV9DT05TRU5TVVNfU1RSRUFNX0VOREVEEAISHwobUk'
    'VBRF9DT05TRU5TVVNfU1RSRUFNX0VOREVEEAMSDAoIQ0FOQ0VMRUQQBBIUChBQRVJfRVBPQ0hf'
    'Q09ORklHEAVCBwoFX2tpbmRCDAoKX29iamVjdF9pZEIKCghfdmVyc2lvbkIJCgdfZGlnZXN0Qg'
    '4KDF9vYmplY3RfdHlwZQ==');
