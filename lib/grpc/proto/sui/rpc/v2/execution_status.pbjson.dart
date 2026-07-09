// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/execution_status.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use executionStatusDescriptor instead')
const ExecutionStatus$json = {
  '1': 'ExecutionStatus',
  '2': [
    {
      '1': 'success',
      '3': 1,
      '4': 1,
      '5': 8,
      '9': 0,
      '10': 'success',
      '17': true
    },
    {
      '1': 'error',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ExecutionError',
      '9': 1,
      '10': 'error',
      '17': true
    },
  ],
  '8': [
    {'1': '_success'},
    {'1': '_error'},
  ],
};

/// Descriptor for `ExecutionStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executionStatusDescriptor = $convert.base64Decode(
    'Cg9FeGVjdXRpb25TdGF0dXMSHQoHc3VjY2VzcxgBIAEoCEgAUgdzdWNjZXNziAEBEjUKBWVycm'
    '9yGAIgASgLMhouc3VpLnJwYy52Mi5FeGVjdXRpb25FcnJvckgBUgVlcnJvcogBAUIKCghfc3Vj'
    'Y2Vzc0IICgZfZXJyb3I=');

@$core.Deprecated('Use executionErrorDescriptor instead')
const ExecutionError$json = {
  '1': 'ExecutionError',
  '2': [
    {
      '1': 'description',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'description',
      '17': true
    },
    {
      '1': 'command',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'command',
      '17': true
    },
    {
      '1': 'kind',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.ExecutionError.ExecutionErrorKind',
      '9': 3,
      '10': 'kind',
      '17': true
    },
    {
      '1': 'abort',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveAbort',
      '9': 0,
      '10': 'abort'
    },
    {
      '1': 'size_error',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.SizeError',
      '9': 0,
      '10': 'sizeError'
    },
    {
      '1': 'command_argument_error',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CommandArgumentError',
      '9': 0,
      '10': 'commandArgumentError'
    },
    {
      '1': 'type_argument_error',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.TypeArgumentError',
      '9': 0,
      '10': 'typeArgumentError'
    },
    {
      '1': 'package_upgrade_error',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.PackageUpgradeError',
      '9': 0,
      '10': 'packageUpgradeError'
    },
    {
      '1': 'index_error',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.IndexError',
      '9': 0,
      '10': 'indexError'
    },
    {'1': 'object_id', '3': 10, '4': 1, '5': 9, '9': 0, '10': 'objectId'},
    {
      '1': 'coin_deny_list_error',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CoinDenyListError',
      '9': 0,
      '10': 'coinDenyListError'
    },
    {
      '1': 'congested_objects',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CongestedObjects',
      '9': 0,
      '10': 'congestedObjects'
    },
  ],
  '4': [ExecutionError_ExecutionErrorKind$json],
  '8': [
    {'1': 'error_details'},
    {'1': '_description'},
    {'1': '_command'},
    {'1': '_kind'},
  ],
};

@$core.Deprecated('Use executionErrorDescriptor instead')
const ExecutionError_ExecutionErrorKind$json = {
  '1': 'ExecutionErrorKind',
  '2': [
    {'1': 'EXECUTION_ERROR_KIND_UNKNOWN', '2': 0},
    {'1': 'INSUFFICIENT_GAS', '2': 1},
    {'1': 'INVALID_GAS_OBJECT', '2': 2},
    {'1': 'INVARIANT_VIOLATION', '2': 3},
    {'1': 'FEATURE_NOT_YET_SUPPORTED', '2': 4},
    {'1': 'OBJECT_TOO_BIG', '2': 5},
    {'1': 'PACKAGE_TOO_BIG', '2': 6},
    {'1': 'CIRCULAR_OBJECT_OWNERSHIP', '2': 7},
    {'1': 'INSUFFICIENT_COIN_BALANCE', '2': 8},
    {'1': 'COIN_BALANCE_OVERFLOW', '2': 9},
    {'1': 'PUBLISH_ERROR_NON_ZERO_ADDRESS', '2': 10},
    {'1': 'SUI_MOVE_VERIFICATION_ERROR', '2': 11},
    {'1': 'MOVE_PRIMITIVE_RUNTIME_ERROR', '2': 12},
    {'1': 'MOVE_ABORT', '2': 13},
    {'1': 'VM_VERIFICATION_OR_DESERIALIZATION_ERROR', '2': 14},
    {'1': 'VM_INVARIANT_VIOLATION', '2': 15},
    {'1': 'FUNCTION_NOT_FOUND', '2': 16},
    {'1': 'ARITY_MISMATCH', '2': 17},
    {'1': 'TYPE_ARITY_MISMATCH', '2': 18},
    {'1': 'NON_ENTRY_FUNCTION_INVOKED', '2': 19},
    {'1': 'COMMAND_ARGUMENT_ERROR', '2': 20},
    {'1': 'TYPE_ARGUMENT_ERROR', '2': 21},
    {'1': 'UNUSED_VALUE_WITHOUT_DROP', '2': 22},
    {'1': 'INVALID_PUBLIC_FUNCTION_RETURN_TYPE', '2': 23},
    {'1': 'INVALID_TRANSFER_OBJECT', '2': 24},
    {'1': 'EFFECTS_TOO_LARGE', '2': 25},
    {'1': 'PUBLISH_UPGRADE_MISSING_DEPENDENCY', '2': 26},
    {'1': 'PUBLISH_UPGRADE_DEPENDENCY_DOWNGRADE', '2': 27},
    {'1': 'PACKAGE_UPGRADE_ERROR', '2': 28},
    {'1': 'WRITTEN_OBJECTS_TOO_LARGE', '2': 29},
    {'1': 'CERTIFICATE_DENIED', '2': 30},
    {'1': 'SUI_MOVE_VERIFICATION_TIMEDOUT', '2': 31},
    {'1': 'CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED', '2': 32},
    {'1': 'INPUT_OBJECT_DELETED', '2': 33},
    {'1': 'EXECUTION_CANCELED_DUE_TO_CONSENSUS_OBJECT_CONGESTION', '2': 34},
    {'1': 'ADDRESS_DENIED_FOR_COIN', '2': 35},
    {'1': 'COIN_TYPE_GLOBAL_PAUSE', '2': 36},
    {'1': 'EXECUTION_CANCELED_DUE_TO_RANDOMNESS_UNAVAILABLE', '2': 37},
    {'1': 'MOVE_VECTOR_ELEM_TOO_BIG', '2': 38},
    {'1': 'MOVE_RAW_VALUE_TOO_BIG', '2': 39},
    {'1': 'INVALID_LINKAGE', '2': 40},
    {'1': 'INSUFFICIENT_FUNDS_FOR_WITHDRAW', '2': 41},
    {'1': 'NON_EXCLUSIVE_WRITE_INPUT_OBJECT_MODIFIED', '2': 42},
  ],
};

/// Descriptor for `ExecutionError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executionErrorDescriptor = $convert.base64Decode(
    'Cg5FeGVjdXRpb25FcnJvchIlCgtkZXNjcmlwdGlvbhgBIAEoCUgBUgtkZXNjcmlwdGlvbogBAR'
    'IdCgdjb21tYW5kGAIgASgESAJSB2NvbW1hbmSIAQESRgoEa2luZBgDIAEoDjItLnN1aS5ycGMu'
    'djIuRXhlY3V0aW9uRXJyb3IuRXhlY3V0aW9uRXJyb3JLaW5kSANSBGtpbmSIAQESLQoFYWJvcn'
    'QYBCABKAsyFS5zdWkucnBjLnYyLk1vdmVBYm9ydEgAUgVhYm9ydBI2CgpzaXplX2Vycm9yGAUg'
    'ASgLMhUuc3VpLnJwYy52Mi5TaXplRXJyb3JIAFIJc2l6ZUVycm9yElgKFmNvbW1hbmRfYXJndW'
    '1lbnRfZXJyb3IYBiABKAsyIC5zdWkucnBjLnYyLkNvbW1hbmRBcmd1bWVudEVycm9ySABSFGNv'
    'bW1hbmRBcmd1bWVudEVycm9yEk8KE3R5cGVfYXJndW1lbnRfZXJyb3IYByABKAsyHS5zdWkucn'
    'BjLnYyLlR5cGVBcmd1bWVudEVycm9ySABSEXR5cGVBcmd1bWVudEVycm9yElUKFXBhY2thZ2Vf'
    'dXBncmFkZV9lcnJvchgIIAEoCzIfLnN1aS5ycGMudjIuUGFja2FnZVVwZ3JhZGVFcnJvckgAUh'
    'NwYWNrYWdlVXBncmFkZUVycm9yEjkKC2luZGV4X2Vycm9yGAkgASgLMhYuc3VpLnJwYy52Mi5J'
    'bmRleEVycm9ySABSCmluZGV4RXJyb3ISHQoJb2JqZWN0X2lkGAogASgJSABSCG9iamVjdElkEl'
    'AKFGNvaW5fZGVueV9saXN0X2Vycm9yGAsgASgLMh0uc3VpLnJwYy52Mi5Db2luRGVueUxpc3RF'
    'cnJvckgAUhFjb2luRGVueUxpc3RFcnJvchJLChFjb25nZXN0ZWRfb2JqZWN0cxgMIAEoCzIcLn'
    'N1aS5ycGMudjIuQ29uZ2VzdGVkT2JqZWN0c0gAUhBjb25nZXN0ZWRPYmplY3RzItAKChJFeGVj'
    'dXRpb25FcnJvcktpbmQSIAocRVhFQ1VUSU9OX0VSUk9SX0tJTkRfVU5LTk9XThAAEhQKEElOU1'
    'VGRklDSUVOVF9HQVMQARIWChJJTlZBTElEX0dBU19PQkpFQ1QQAhIXChNJTlZBUklBTlRfVklP'
    'TEFUSU9OEAMSHQoZRkVBVFVSRV9OT1RfWUVUX1NVUFBPUlRFRBAEEhIKDk9CSkVDVF9UT09fQk'
    'lHEAUSEwoPUEFDS0FHRV9UT09fQklHEAYSHQoZQ0lSQ1VMQVJfT0JKRUNUX09XTkVSU0hJUBAH'
    'Eh0KGUlOU1VGRklDSUVOVF9DT0lOX0JBTEFOQ0UQCBIZChVDT0lOX0JBTEFOQ0VfT1ZFUkZMT1'
    'cQCRIiCh5QVUJMSVNIX0VSUk9SX05PTl9aRVJPX0FERFJFU1MQChIfChtTVUlfTU9WRV9WRVJJ'
    'RklDQVRJT05fRVJST1IQCxIgChxNT1ZFX1BSSU1JVElWRV9SVU5USU1FX0VSUk9SEAwSDgoKTU'
    '9WRV9BQk9SVBANEiwKKFZNX1ZFUklGSUNBVElPTl9PUl9ERVNFUklBTElaQVRJT05fRVJST1IQ'
    'DhIaChZWTV9JTlZBUklBTlRfVklPTEFUSU9OEA8SFgoSRlVOQ1RJT05fTk9UX0ZPVU5EEBASEg'
    'oOQVJJVFlfTUlTTUFUQ0gQERIXChNUWVBFX0FSSVRZX01JU01BVENIEBISHgoaTk9OX0VOVFJZ'
    'X0ZVTkNUSU9OX0lOVk9LRUQQExIaChZDT01NQU5EX0FSR1VNRU5UX0VSUk9SEBQSFwoTVFlQRV'
    '9BUkdVTUVOVF9FUlJPUhAVEh0KGVVOVVNFRF9WQUxVRV9XSVRIT1VUX0RST1AQFhInCiNJTlZB'
    'TElEX1BVQkxJQ19GVU5DVElPTl9SRVRVUk5fVFlQRRAXEhsKF0lOVkFMSURfVFJBTlNGRVJfT0'
    'JKRUNUEBgSFQoRRUZGRUNUU19UT09fTEFSR0UQGRImCiJQVUJMSVNIX1VQR1JBREVfTUlTU0lO'
    'R19ERVBFTkRFTkNZEBoSKAokUFVCTElTSF9VUEdSQURFX0RFUEVOREVOQ1lfRE9XTkdSQURFEB'
    'sSGQoVUEFDS0FHRV9VUEdSQURFX0VSUk9SEBwSHQoZV1JJVFRFTl9PQkpFQ1RTX1RPT19MQVJH'
    'RRAdEhYKEkNFUlRJRklDQVRFX0RFTklFRBAeEiIKHlNVSV9NT1ZFX1ZFUklGSUNBVElPTl9USU'
    '1FRE9VVBAfEioKJkNPTlNFTlNVU19PQkpFQ1RfT1BFUkFUSU9OX05PVF9BTExPV0VEECASGAoU'
    'SU5QVVRfT0JKRUNUX0RFTEVURUQQIRI5CjVFWEVDVVRJT05fQ0FOQ0VMRURfRFVFX1RPX0NPTl'
    'NFTlNVU19PQkpFQ1RfQ09OR0VTVElPThAiEhsKF0FERFJFU1NfREVOSUVEX0ZPUl9DT0lOECMS'
    'GgoWQ09JTl9UWVBFX0dMT0JBTF9QQVVTRRAkEjQKMEVYRUNVVElPTl9DQU5DRUxFRF9EVUVfVE'
    '9fUkFORE9NTkVTU19VTkFWQUlMQUJMRRAlEhwKGE1PVkVfVkVDVE9SX0VMRU1fVE9PX0JJRxAm'
    'EhoKFk1PVkVfUkFXX1ZBTFVFX1RPT19CSUcQJxITCg9JTlZBTElEX0xJTktBR0UQKBIjCh9JTl'
    'NVRkZJQ0lFTlRfRlVORFNfRk9SX1dJVEhEUkFXECkSLQopTk9OX0VYQ0xVU0lWRV9XUklURV9J'
    'TlBVVF9PQkpFQ1RfTU9ESUZJRUQQKkIPCg1lcnJvcl9kZXRhaWxzQg4KDF9kZXNjcmlwdGlvbk'
    'IKCghfY29tbWFuZEIHCgVfa2luZA==');

@$core.Deprecated('Use moveAbortDescriptor instead')
const MoveAbort$json = {
  '1': 'MoveAbort',
  '2': [
    {
      '1': 'abort_code',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'abortCode',
      '17': true
    },
    {
      '1': 'location',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveLocation',
      '9': 1,
      '10': 'location',
      '17': true
    },
    {
      '1': 'clever_error',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CleverError',
      '9': 2,
      '10': 'cleverError',
      '17': true
    },
  ],
  '8': [
    {'1': '_abort_code'},
    {'1': '_location'},
    {'1': '_clever_error'},
  ],
};

/// Descriptor for `MoveAbort`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveAbortDescriptor = $convert.base64Decode(
    'CglNb3ZlQWJvcnQSIgoKYWJvcnRfY29kZRgBIAEoBEgAUglhYm9ydENvZGWIAQESOQoIbG9jYX'
    'Rpb24YAiABKAsyGC5zdWkucnBjLnYyLk1vdmVMb2NhdGlvbkgBUghsb2NhdGlvbogBARI/Cgxj'
    'bGV2ZXJfZXJyb3IYAyABKAsyFy5zdWkucnBjLnYyLkNsZXZlckVycm9ySAJSC2NsZXZlckVycm'
    '9yiAEBQg0KC19hYm9ydF9jb2RlQgsKCV9sb2NhdGlvbkIPCg1fY2xldmVyX2Vycm9y');

@$core.Deprecated('Use moveLocationDescriptor instead')
const MoveLocation$json = {
  '1': 'MoveLocation',
  '2': [
    {
      '1': 'package',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'package',
      '17': true
    },
    {'1': 'module', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'module', '17': true},
    {
      '1': 'function',
      '3': 3,
      '4': 1,
      '5': 13,
      '9': 2,
      '10': 'function',
      '17': true
    },
    {
      '1': 'instruction',
      '3': 4,
      '4': 1,
      '5': 13,
      '9': 3,
      '10': 'instruction',
      '17': true
    },
    {
      '1': 'function_name',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'functionName',
      '17': true
    },
  ],
  '8': [
    {'1': '_package'},
    {'1': '_module'},
    {'1': '_function'},
    {'1': '_instruction'},
    {'1': '_function_name'},
  ],
};

/// Descriptor for `MoveLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveLocationDescriptor = $convert.base64Decode(
    'CgxNb3ZlTG9jYXRpb24SHQoHcGFja2FnZRgBIAEoCUgAUgdwYWNrYWdliAEBEhsKBm1vZHVsZR'
    'gCIAEoCUgBUgZtb2R1bGWIAQESHwoIZnVuY3Rpb24YAyABKA1IAlIIZnVuY3Rpb26IAQESJQoL'
    'aW5zdHJ1Y3Rpb24YBCABKA1IA1ILaW5zdHJ1Y3Rpb26IAQESKAoNZnVuY3Rpb25fbmFtZRgFIA'
    'EoCUgEUgxmdW5jdGlvbk5hbWWIAQFCCgoIX3BhY2thZ2VCCQoHX21vZHVsZUILCglfZnVuY3Rp'
    'b25CDgoMX2luc3RydWN0aW9uQhAKDl9mdW5jdGlvbl9uYW1l');

@$core.Deprecated('Use cleverErrorDescriptor instead')
const CleverError$json = {
  '1': 'CleverError',
  '2': [
    {
      '1': 'error_code',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'errorCode',
      '17': true
    },
    {
      '1': 'line_number',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'lineNumber',
      '17': true
    },
    {
      '1': 'constant_name',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'constantName',
      '17': true
    },
    {
      '1': 'constant_type',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'constantType',
      '17': true
    },
    {'1': 'rendered', '3': 5, '4': 1, '5': 9, '9': 0, '10': 'rendered'},
    {'1': 'raw', '3': 6, '4': 1, '5': 12, '9': 0, '10': 'raw'},
  ],
  '8': [
    {'1': 'value'},
    {'1': '_error_code'},
    {'1': '_line_number'},
    {'1': '_constant_name'},
    {'1': '_constant_type'},
  ],
};

/// Descriptor for `CleverError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cleverErrorDescriptor = $convert.base64Decode(
    'CgtDbGV2ZXJFcnJvchIiCgplcnJvcl9jb2RlGAEgASgESAFSCWVycm9yQ29kZYgBARIkCgtsaW'
    '5lX251bWJlchgCIAEoBEgCUgpsaW5lTnVtYmVyiAEBEigKDWNvbnN0YW50X25hbWUYAyABKAlI'
    'A1IMY29uc3RhbnROYW1liAEBEigKDWNvbnN0YW50X3R5cGUYBCABKAlIBFIMY29uc3RhbnRUeX'
    'BliAEBEhwKCHJlbmRlcmVkGAUgASgJSABSCHJlbmRlcmVkEhIKA3JhdxgGIAEoDEgAUgNyYXdC'
    'BwoFdmFsdWVCDQoLX2Vycm9yX2NvZGVCDgoMX2xpbmVfbnVtYmVyQhAKDl9jb25zdGFudF9uYW'
    '1lQhAKDl9jb25zdGFudF90eXBl');

@$core.Deprecated('Use sizeErrorDescriptor instead')
const SizeError$json = {
  '1': 'SizeError',
  '2': [
    {'1': 'size', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'size', '17': true},
    {
      '1': 'max_size',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'maxSize',
      '17': true
    },
  ],
  '8': [
    {'1': '_size'},
    {'1': '_max_size'},
  ],
};

/// Descriptor for `SizeError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sizeErrorDescriptor = $convert.base64Decode(
    'CglTaXplRXJyb3ISFwoEc2l6ZRgBIAEoBEgAUgRzaXpliAEBEh4KCG1heF9zaXplGAIgASgESA'
    'FSB21heFNpemWIAQFCBwoFX3NpemVCCwoJX21heF9zaXpl');

@$core.Deprecated('Use indexErrorDescriptor instead')
const IndexError$json = {
  '1': 'IndexError',
  '2': [
    {'1': 'index', '3': 1, '4': 1, '5': 13, '9': 0, '10': 'index', '17': true},
    {
      '1': 'subresult',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'subresult',
      '17': true
    },
  ],
  '8': [
    {'1': '_index'},
    {'1': '_subresult'},
  ],
};

/// Descriptor for `IndexError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List indexErrorDescriptor = $convert.base64Decode(
    'CgpJbmRleEVycm9yEhkKBWluZGV4GAEgASgNSABSBWluZGV4iAEBEiEKCXN1YnJlc3VsdBgCIA'
    'EoDUgBUglzdWJyZXN1bHSIAQFCCAoGX2luZGV4QgwKCl9zdWJyZXN1bHQ=');

@$core.Deprecated('Use coinDenyListErrorDescriptor instead')
const CoinDenyListError$json = {
  '1': 'CoinDenyListError',
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
  ],
  '8': [
    {'1': '_address'},
    {'1': '_coin_type'},
  ],
};

/// Descriptor for `CoinDenyListError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List coinDenyListErrorDescriptor = $convert.base64Decode(
    'ChFDb2luRGVueUxpc3RFcnJvchIdCgdhZGRyZXNzGAEgASgJSABSB2FkZHJlc3OIAQESIAoJY2'
    '9pbl90eXBlGAIgASgJSAFSCGNvaW5UeXBliAEBQgoKCF9hZGRyZXNzQgwKCl9jb2luX3R5cGU=');

@$core.Deprecated('Use congestedObjectsDescriptor instead')
const CongestedObjects$json = {
  '1': 'CongestedObjects',
  '2': [
    {'1': 'objects', '3': 1, '4': 3, '5': 9, '10': 'objects'},
  ],
};

/// Descriptor for `CongestedObjects`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List congestedObjectsDescriptor = $convert.base64Decode(
    'ChBDb25nZXN0ZWRPYmplY3RzEhgKB29iamVjdHMYASADKAlSB29iamVjdHM=');

@$core.Deprecated('Use commandArgumentErrorDescriptor instead')
const CommandArgumentError$json = {
  '1': 'CommandArgumentError',
  '2': [
    {
      '1': 'argument',
      '3': 1,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'argument',
      '17': true
    },
    {
      '1': 'kind',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.CommandArgumentError.CommandArgumentErrorKind',
      '9': 1,
      '10': 'kind',
      '17': true
    },
    {
      '1': 'index_error',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.IndexError',
      '9': 2,
      '10': 'indexError',
      '17': true
    },
  ],
  '4': [CommandArgumentError_CommandArgumentErrorKind$json],
  '8': [
    {'1': '_argument'},
    {'1': '_kind'},
    {'1': '_index_error'},
  ],
};

@$core.Deprecated('Use commandArgumentErrorDescriptor instead')
const CommandArgumentError_CommandArgumentErrorKind$json = {
  '1': 'CommandArgumentErrorKind',
  '2': [
    {'1': 'COMMAND_ARGUMENT_ERROR_KIND_UNKNOWN', '2': 0},
    {'1': 'TYPE_MISMATCH', '2': 1},
    {'1': 'INVALID_BCS_BYTES', '2': 2},
    {'1': 'INVALID_USAGE_OF_PURE_ARGUMENT', '2': 3},
    {'1': 'INVALID_ARGUMENT_TO_PRIVATE_ENTRY_FUNCTION', '2': 4},
    {'1': 'INDEX_OUT_OF_BOUNDS', '2': 5},
    {'1': 'SECONDARY_INDEX_OUT_OF_BOUNDS', '2': 6},
    {'1': 'INVALID_RESULT_ARITY', '2': 7},
    {'1': 'INVALID_GAS_COIN_USAGE', '2': 8},
    {'1': 'INVALID_VALUE_USAGE', '2': 9},
    {'1': 'INVALID_OBJECT_BY_VALUE', '2': 10},
    {'1': 'INVALID_OBJECT_BY_MUT_REF', '2': 11},
    {'1': 'CONSENSUS_OBJECT_OPERATION_NOT_ALLOWED', '2': 12},
    {'1': 'INVALID_ARGUMENT_ARITY', '2': 13},
    {'1': 'INVALID_TRANSFER_OBJECT', '2': 14},
    {'1': 'INVALID_MAKE_MOVE_VEC_NON_OBJECT_ARGUMENT', '2': 15},
    {'1': 'ARGUMENT_WITHOUT_VALUE', '2': 16},
    {'1': 'CANNOT_MOVE_BORROWED_VALUE', '2': 17},
    {'1': 'CANNOT_WRITE_TO_EXTENDED_REFERENCE', '2': 18},
    {'1': 'INVALID_REFERENCE_ARGUMENT', '2': 19},
  ],
};

/// Descriptor for `CommandArgumentError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandArgumentErrorDescriptor = $convert.base64Decode(
    'ChRDb21tYW5kQXJndW1lbnRFcnJvchIfCghhcmd1bWVudBgBIAEoDUgAUghhcmd1bWVudIgBAR'
    'JSCgRraW5kGAIgASgOMjkuc3VpLnJwYy52Mi5Db21tYW5kQXJndW1lbnRFcnJvci5Db21tYW5k'
    'QXJndW1lbnRFcnJvcktpbmRIAVIEa2luZIgBARI8CgtpbmRleF9lcnJvchgDIAEoCzIWLnN1aS'
    '5ycGMudjIuSW5kZXhFcnJvckgCUgppbmRleEVycm9yiAEBIqAFChhDb21tYW5kQXJndW1lbnRF'
    'cnJvcktpbmQSJwojQ09NTUFORF9BUkdVTUVOVF9FUlJPUl9LSU5EX1VOS05PV04QABIRCg1UWV'
    'BFX01JU01BVENIEAESFQoRSU5WQUxJRF9CQ1NfQllURVMQAhIiCh5JTlZBTElEX1VTQUdFX09G'
    'X1BVUkVfQVJHVU1FTlQQAxIuCipJTlZBTElEX0FSR1VNRU5UX1RPX1BSSVZBVEVfRU5UUllfRl'
    'VOQ1RJT04QBBIXChNJTkRFWF9PVVRfT0ZfQk9VTkRTEAUSIQodU0VDT05EQVJZX0lOREVYX09V'
    'VF9PRl9CT1VORFMQBhIYChRJTlZBTElEX1JFU1VMVF9BUklUWRAHEhoKFklOVkFMSURfR0FTX0'
    'NPSU5fVVNBR0UQCBIXChNJTlZBTElEX1ZBTFVFX1VTQUdFEAkSGwoXSU5WQUxJRF9PQkpFQ1Rf'
    'QllfVkFMVUUQChIdChlJTlZBTElEX09CSkVDVF9CWV9NVVRfUkVGEAsSKgomQ09OU0VOU1VTX0'
    '9CSkVDVF9PUEVSQVRJT05fTk9UX0FMTE9XRUQQDBIaChZJTlZBTElEX0FSR1VNRU5UX0FSSVRZ'
    'EA0SGwoXSU5WQUxJRF9UUkFOU0ZFUl9PQkpFQ1QQDhItCilJTlZBTElEX01BS0VfTU9WRV9WRU'
    'NfTk9OX09CSkVDVF9BUkdVTUVOVBAPEhoKFkFSR1VNRU5UX1dJVEhPVVRfVkFMVUUQEBIeChpD'
    'QU5OT1RfTU9WRV9CT1JST1dFRF9WQUxVRRAREiYKIkNBTk5PVF9XUklURV9UT19FWFRFTkRFRF'
    '9SRUZFUkVOQ0UQEhIeChpJTlZBTElEX1JFRkVSRU5DRV9BUkdVTUVOVBATQgsKCV9hcmd1bWVu'
    'dEIHCgVfa2luZEIOCgxfaW5kZXhfZXJyb3I=');

@$core.Deprecated('Use packageUpgradeErrorDescriptor instead')
const PackageUpgradeError$json = {
  '1': 'PackageUpgradeError',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.PackageUpgradeError.PackageUpgradeErrorKind',
      '9': 0,
      '10': 'kind',
      '17': true
    },
    {
      '1': 'package_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'packageId',
      '17': true
    },
    {'1': 'digest', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'digest', '17': true},
    {
      '1': 'policy',
      '3': 4,
      '4': 1,
      '5': 13,
      '9': 3,
      '10': 'policy',
      '17': true
    },
    {
      '1': 'ticket_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 4,
      '10': 'ticketId',
      '17': true
    },
  ],
  '4': [PackageUpgradeError_PackageUpgradeErrorKind$json],
  '8': [
    {'1': '_kind'},
    {'1': '_package_id'},
    {'1': '_digest'},
    {'1': '_policy'},
    {'1': '_ticket_id'},
  ],
};

@$core.Deprecated('Use packageUpgradeErrorDescriptor instead')
const PackageUpgradeError_PackageUpgradeErrorKind$json = {
  '1': 'PackageUpgradeErrorKind',
  '2': [
    {'1': 'PACKAGE_UPGRADE_ERROR_KIND_UNKNOWN', '2': 0},
    {'1': 'UNABLE_TO_FETCH_PACKAGE', '2': 1},
    {'1': 'NOT_A_PACKAGE', '2': 2},
    {'1': 'INCOMPATIBLE_UPGRADE', '2': 3},
    {'1': 'DIGEST_DOES_NOT_MATCH', '2': 4},
    {'1': 'UNKNOWN_UPGRADE_POLICY', '2': 5},
    {'1': 'PACKAGE_ID_DOES_NOT_MATCH', '2': 6},
  ],
};

/// Descriptor for `PackageUpgradeError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageUpgradeErrorDescriptor = $convert.base64Decode(
    'ChNQYWNrYWdlVXBncmFkZUVycm9yElAKBGtpbmQYASABKA4yNy5zdWkucnBjLnYyLlBhY2thZ2'
    'VVcGdyYWRlRXJyb3IuUGFja2FnZVVwZ3JhZGVFcnJvcktpbmRIAFIEa2luZIgBARIiCgpwYWNr'
    'YWdlX2lkGAIgASgJSAFSCXBhY2thZ2VJZIgBARIbCgZkaWdlc3QYAyABKAlIAlIGZGlnZXN0iA'
    'EBEhsKBnBvbGljeRgEIAEoDUgDUgZwb2xpY3mIAQESIAoJdGlja2V0X2lkGAUgASgJSARSCHRp'
    'Y2tldElkiAEBIuEBChdQYWNrYWdlVXBncmFkZUVycm9yS2luZBImCiJQQUNLQUdFX1VQR1JBRE'
    'VfRVJST1JfS0lORF9VTktOT1dOEAASGwoXVU5BQkxFX1RPX0ZFVENIX1BBQ0tBR0UQARIRCg1O'
    'T1RfQV9QQUNLQUdFEAISGAoUSU5DT01QQVRJQkxFX1VQR1JBREUQAxIZChVESUdFU1RfRE9FU1'
    '9OT1RfTUFUQ0gQBBIaChZVTktOT1dOX1VQR1JBREVfUE9MSUNZEAUSHQoZUEFDS0FHRV9JRF9E'
    'T0VTX05PVF9NQVRDSBAGQgcKBV9raW5kQg0KC19wYWNrYWdlX2lkQgkKB19kaWdlc3RCCQoHX3'
    'BvbGljeUIMCgpfdGlja2V0X2lk');

@$core.Deprecated('Use typeArgumentErrorDescriptor instead')
const TypeArgumentError$json = {
  '1': 'TypeArgumentError',
  '2': [
    {
      '1': 'type_argument',
      '3': 1,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'typeArgument',
      '17': true
    },
    {
      '1': 'kind',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.TypeArgumentError.TypeArgumentErrorKind',
      '9': 1,
      '10': 'kind',
      '17': true
    },
  ],
  '4': [TypeArgumentError_TypeArgumentErrorKind$json],
  '8': [
    {'1': '_type_argument'},
    {'1': '_kind'},
  ],
};

@$core.Deprecated('Use typeArgumentErrorDescriptor instead')
const TypeArgumentError_TypeArgumentErrorKind$json = {
  '1': 'TypeArgumentErrorKind',
  '2': [
    {'1': 'TYPE_ARGUMENT_ERROR_KIND_UNKNOWN', '2': 0},
    {'1': 'TYPE_NOT_FOUND', '2': 1},
    {'1': 'CONSTRAINT_NOT_SATISFIED', '2': 2},
  ],
};

/// Descriptor for `TypeArgumentError`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typeArgumentErrorDescriptor = $convert.base64Decode(
    'ChFUeXBlQXJndW1lbnRFcnJvchIoCg10eXBlX2FyZ3VtZW50GAEgASgNSABSDHR5cGVBcmd1bW'
    'VudIgBARJMCgRraW5kGAIgASgOMjMuc3VpLnJwYy52Mi5UeXBlQXJndW1lbnRFcnJvci5UeXBl'
    'QXJndW1lbnRFcnJvcktpbmRIAVIEa2luZIgBASJvChVUeXBlQXJndW1lbnRFcnJvcktpbmQSJA'
    'ogVFlQRV9BUkdVTUVOVF9FUlJPUl9LSU5EX1VOS05PV04QABISCg5UWVBFX05PVF9GT1VORBAB'
    'EhwKGENPTlNUUkFJTlRfTk9UX1NBVElTRklFRBACQhAKDl90eXBlX2FyZ3VtZW50QgcKBV9raW'
    '5k');
