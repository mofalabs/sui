// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/move_package.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use abilityDescriptor instead')
const Ability$json = {
  '1': 'Ability',
  '2': [
    {'1': 'ABILITY_UNKNOWN', '2': 0},
    {'1': 'COPY', '2': 1},
    {'1': 'DROP', '2': 2},
    {'1': 'STORE', '2': 3},
    {'1': 'KEY', '2': 4},
  ],
};

/// Descriptor for `Ability`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List abilityDescriptor = $convert.base64Decode(
    'CgdBYmlsaXR5EhMKD0FCSUxJVFlfVU5LTk9XThAAEggKBENPUFkQARIICgREUk9QEAISCQoFU1'
    'RPUkUQAxIHCgNLRVkQBA==');

@$core.Deprecated('Use packageDescriptor instead')
const Package$json = {
  '1': 'Package',
  '2': [
    {
      '1': 'storage_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'storageId',
      '17': true
    },
    {
      '1': 'original_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'originalId',
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
    {
      '1': 'modules',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Module',
      '10': 'modules'
    },
    {
      '1': 'type_origins',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.TypeOrigin',
      '10': 'typeOrigins'
    },
    {
      '1': 'linkage',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Linkage',
      '10': 'linkage'
    },
  ],
  '8': [
    {'1': '_storage_id'},
    {'1': '_original_id'},
    {'1': '_version'},
  ],
};

/// Descriptor for `Package`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageDescriptor = $convert.base64Decode(
    'CgdQYWNrYWdlEiIKCnN0b3JhZ2VfaWQYASABKAlIAFIJc3RvcmFnZUlkiAEBEiQKC29yaWdpbm'
    'FsX2lkGAIgASgJSAFSCm9yaWdpbmFsSWSIAQESHQoHdmVyc2lvbhgDIAEoBEgCUgd2ZXJzaW9u'
    'iAEBEiwKB21vZHVsZXMYBCADKAsyEi5zdWkucnBjLnYyLk1vZHVsZVIHbW9kdWxlcxI5Cgx0eX'
    'BlX29yaWdpbnMYBSADKAsyFi5zdWkucnBjLnYyLlR5cGVPcmlnaW5SC3R5cGVPcmlnaW5zEi0K'
    'B2xpbmthZ2UYBiADKAsyEy5zdWkucnBjLnYyLkxpbmthZ2VSB2xpbmthZ2VCDQoLX3N0b3JhZ2'
    'VfaWRCDgoMX29yaWdpbmFsX2lkQgoKCF92ZXJzaW9u');

@$core.Deprecated('Use moduleDescriptor instead')
const Module$json = {
  '1': 'Module',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
    {
      '1': 'contents',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 1,
      '10': 'contents',
      '17': true
    },
    {
      '1': 'datatypes',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.DatatypeDescriptor',
      '10': 'datatypes'
    },
    {
      '1': 'functions',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.FunctionDescriptor',
      '10': 'functions'
    },
  ],
  '8': [
    {'1': '_name'},
    {'1': '_contents'},
  ],
};

/// Descriptor for `Module`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moduleDescriptor = $convert.base64Decode(
    'CgZNb2R1bGUSFwoEbmFtZRgBIAEoCUgAUgRuYW1liAEBEh8KCGNvbnRlbnRzGAIgASgMSAFSCG'
    'NvbnRlbnRziAEBEjwKCWRhdGF0eXBlcxgDIAMoCzIeLnN1aS5ycGMudjIuRGF0YXR5cGVEZXNj'
    'cmlwdG9yUglkYXRhdHlwZXMSPAoJZnVuY3Rpb25zGAQgAygLMh4uc3VpLnJwYy52Mi5GdW5jdG'
    'lvbkRlc2NyaXB0b3JSCWZ1bmN0aW9uc0IHCgVfbmFtZUILCglfY29udGVudHM=');

@$core.Deprecated('Use datatypeDescriptorDescriptor instead')
const DatatypeDescriptor$json = {
  '1': 'DatatypeDescriptor',
  '2': [
    {
      '1': 'type_name',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'typeName',
      '17': true
    },
    {
      '1': 'defining_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'definingId',
      '17': true
    },
    {'1': 'module', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'module', '17': true},
    {'1': 'name', '3': 4, '4': 1, '5': 9, '9': 3, '10': 'name', '17': true},
    {
      '1': 'abilities',
      '3': 5,
      '4': 3,
      '5': 14,
      '6': '.sui.rpc.v2.Ability',
      '10': 'abilities'
    },
    {
      '1': 'type_parameters',
      '3': 6,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.TypeParameter',
      '10': 'typeParameters'
    },
    {
      '1': 'kind',
      '3': 7,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.DatatypeDescriptor.DatatypeKind',
      '9': 4,
      '10': 'kind',
      '17': true
    },
    {
      '1': 'fields',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.FieldDescriptor',
      '10': 'fields'
    },
    {
      '1': 'variants',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.VariantDescriptor',
      '10': 'variants'
    },
  ],
  '4': [DatatypeDescriptor_DatatypeKind$json],
  '8': [
    {'1': '_type_name'},
    {'1': '_defining_id'},
    {'1': '_module'},
    {'1': '_name'},
    {'1': '_kind'},
  ],
};

@$core.Deprecated('Use datatypeDescriptorDescriptor instead')
const DatatypeDescriptor_DatatypeKind$json = {
  '1': 'DatatypeKind',
  '2': [
    {'1': 'DATATYPE_KIND_UNKNOWN', '2': 0},
    {'1': 'STRUCT', '2': 1},
    {'1': 'ENUM', '2': 2},
  ],
};

/// Descriptor for `DatatypeDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List datatypeDescriptorDescriptor = $convert.base64Decode(
    'ChJEYXRhdHlwZURlc2NyaXB0b3ISIAoJdHlwZV9uYW1lGAEgASgJSABSCHR5cGVOYW1liAEBEi'
    'QKC2RlZmluaW5nX2lkGAIgASgJSAFSCmRlZmluaW5nSWSIAQESGwoGbW9kdWxlGAMgASgJSAJS'
    'Bm1vZHVsZYgBARIXCgRuYW1lGAQgASgJSANSBG5hbWWIAQESMQoJYWJpbGl0aWVzGAUgAygOMh'
    'Muc3VpLnJwYy52Mi5BYmlsaXR5UglhYmlsaXRpZXMSQgoPdHlwZV9wYXJhbWV0ZXJzGAYgAygL'
    'Mhkuc3VpLnJwYy52Mi5UeXBlUGFyYW1ldGVyUg50eXBlUGFyYW1ldGVycxJECgRraW5kGAcgAS'
    'gOMisuc3VpLnJwYy52Mi5EYXRhdHlwZURlc2NyaXB0b3IuRGF0YXR5cGVLaW5kSARSBGtpbmSI'
    'AQESMwoGZmllbGRzGAggAygLMhsuc3VpLnJwYy52Mi5GaWVsZERlc2NyaXB0b3JSBmZpZWxkcx'
    'I5Cgh2YXJpYW50cxgJIAMoCzIdLnN1aS5ycGMudjIuVmFyaWFudERlc2NyaXB0b3JSCHZhcmlh'
    'bnRzIj8KDERhdGF0eXBlS2luZBIZChVEQVRBVFlQRV9LSU5EX1VOS05PV04QABIKCgZTVFJVQ1'
    'QQARIICgRFTlVNEAJCDAoKX3R5cGVfbmFtZUIOCgxfZGVmaW5pbmdfaWRCCQoHX21vZHVsZUIH'
    'CgVfbmFtZUIHCgVfa2luZA==');

@$core.Deprecated('Use typeParameterDescriptor instead')
const TypeParameter$json = {
  '1': 'TypeParameter',
  '2': [
    {
      '1': 'constraints',
      '3': 1,
      '4': 3,
      '5': 14,
      '6': '.sui.rpc.v2.Ability',
      '10': 'constraints'
    },
    {
      '1': 'is_phantom',
      '3': 2,
      '4': 1,
      '5': 8,
      '9': 0,
      '10': 'isPhantom',
      '17': true
    },
  ],
  '8': [
    {'1': '_is_phantom'},
  ],
};

/// Descriptor for `TypeParameter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typeParameterDescriptor = $convert.base64Decode(
    'Cg1UeXBlUGFyYW1ldGVyEjUKC2NvbnN0cmFpbnRzGAEgAygOMhMuc3VpLnJwYy52Mi5BYmlsaX'
    'R5Ugtjb25zdHJhaW50cxIiCgppc19waGFudG9tGAIgASgISABSCWlzUGhhbnRvbYgBAUINCgtf'
    'aXNfcGhhbnRvbQ==');

@$core.Deprecated('Use fieldDescriptorDescriptor instead')
const FieldDescriptor$json = {
  '1': 'FieldDescriptor',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
    {
      '1': 'position',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'position',
      '17': true
    },
    {
      '1': 'type',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.OpenSignatureBody',
      '9': 2,
      '10': 'type',
      '17': true
    },
  ],
  '8': [
    {'1': '_name'},
    {'1': '_position'},
    {'1': '_type'},
  ],
};

/// Descriptor for `FieldDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List fieldDescriptorDescriptor = $convert.base64Decode(
    'Cg9GaWVsZERlc2NyaXB0b3ISFwoEbmFtZRgBIAEoCUgAUgRuYW1liAEBEh8KCHBvc2l0aW9uGA'
    'IgASgNSAFSCHBvc2l0aW9uiAEBEjYKBHR5cGUYAyABKAsyHS5zdWkucnBjLnYyLk9wZW5TaWdu'
    'YXR1cmVCb2R5SAJSBHR5cGWIAQFCBwoFX25hbWVCCwoJX3Bvc2l0aW9uQgcKBV90eXBl');

@$core.Deprecated('Use variantDescriptorDescriptor instead')
const VariantDescriptor$json = {
  '1': 'VariantDescriptor',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
    {
      '1': 'position',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'position',
      '17': true
    },
    {
      '1': 'fields',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.FieldDescriptor',
      '10': 'fields'
    },
  ],
  '8': [
    {'1': '_name'},
    {'1': '_position'},
  ],
};

/// Descriptor for `VariantDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List variantDescriptorDescriptor = $convert.base64Decode(
    'ChFWYXJpYW50RGVzY3JpcHRvchIXCgRuYW1lGAEgASgJSABSBG5hbWWIAQESHwoIcG9zaXRpb2'
    '4YAiABKA1IAVIIcG9zaXRpb26IAQESMwoGZmllbGRzGAMgAygLMhsuc3VpLnJwYy52Mi5GaWVs'
    'ZERlc2NyaXB0b3JSBmZpZWxkc0IHCgVfbmFtZUILCglfcG9zaXRpb24=');

@$core.Deprecated('Use openSignatureBodyDescriptor instead')
const OpenSignatureBody$json = {
  '1': 'OpenSignatureBody',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.OpenSignatureBody.Type',
      '9': 0,
      '10': 'type',
      '17': true
    },
    {
      '1': 'type_name',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'typeName',
      '17': true
    },
    {
      '1': 'type_parameter_instantiation',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.OpenSignatureBody',
      '10': 'typeParameterInstantiation'
    },
    {
      '1': 'type_parameter',
      '3': 4,
      '4': 1,
      '5': 13,
      '9': 2,
      '10': 'typeParameter',
      '17': true
    },
  ],
  '4': [OpenSignatureBody_Type$json],
  '8': [
    {'1': '_type'},
    {'1': '_type_name'},
    {'1': '_type_parameter'},
  ],
};

@$core.Deprecated('Use openSignatureBodyDescriptor instead')
const OpenSignatureBody_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'TYPE_UNKNOWN', '2': 0},
    {'1': 'ADDRESS', '2': 1},
    {'1': 'BOOL', '2': 2},
    {'1': 'U8', '2': 3},
    {'1': 'U16', '2': 4},
    {'1': 'U32', '2': 5},
    {'1': 'U64', '2': 6},
    {'1': 'U128', '2': 7},
    {'1': 'U256', '2': 8},
    {'1': 'VECTOR', '2': 9},
    {'1': 'DATATYPE', '2': 10},
    {'1': 'TYPE_PARAMETER', '2': 11},
  ],
};

/// Descriptor for `OpenSignatureBody`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openSignatureBodyDescriptor = $convert.base64Decode(
    'ChFPcGVuU2lnbmF0dXJlQm9keRI7CgR0eXBlGAEgASgOMiIuc3VpLnJwYy52Mi5PcGVuU2lnbm'
    'F0dXJlQm9keS5UeXBlSABSBHR5cGWIAQESIAoJdHlwZV9uYW1lGAIgASgJSAFSCHR5cGVOYW1l'
    'iAEBEl8KHHR5cGVfcGFyYW1ldGVyX2luc3RhbnRpYXRpb24YAyADKAsyHS5zdWkucnBjLnYyLk'
    '9wZW5TaWduYXR1cmVCb2R5Uhp0eXBlUGFyYW1ldGVySW5zdGFudGlhdGlvbhIqCg50eXBlX3Bh'
    'cmFtZXRlchgEIAEoDUgCUg10eXBlUGFyYW1ldGVyiAEBIpQBCgRUeXBlEhAKDFRZUEVfVU5LTk'
    '9XThAAEgsKB0FERFJFU1MQARIICgRCT09MEAISBgoCVTgQAxIHCgNVMTYQBBIHCgNVMzIQBRIH'
    'CgNVNjQQBhIICgRVMTI4EAcSCAoEVTI1NhAIEgoKBlZFQ1RPUhAJEgwKCERBVEFUWVBFEAoSEg'
    'oOVFlQRV9QQVJBTUVURVIQC0IHCgVfdHlwZUIMCgpfdHlwZV9uYW1lQhEKD190eXBlX3BhcmFt'
    'ZXRlcg==');

@$core.Deprecated('Use functionDescriptorDescriptor instead')
const FunctionDescriptor$json = {
  '1': 'FunctionDescriptor',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
    {
      '1': 'visibility',
      '3': 5,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.FunctionDescriptor.Visibility',
      '9': 1,
      '10': 'visibility',
      '17': true
    },
    {
      '1': 'is_entry',
      '3': 6,
      '4': 1,
      '5': 8,
      '9': 2,
      '10': 'isEntry',
      '17': true
    },
    {
      '1': 'type_parameters',
      '3': 7,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.TypeParameter',
      '10': 'typeParameters'
    },
    {
      '1': 'parameters',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.OpenSignature',
      '10': 'parameters'
    },
    {
      '1': 'returns',
      '3': 9,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.OpenSignature',
      '10': 'returns'
    },
  ],
  '4': [FunctionDescriptor_Visibility$json],
  '8': [
    {'1': '_name'},
    {'1': '_visibility'},
    {'1': '_is_entry'},
  ],
};

@$core.Deprecated('Use functionDescriptorDescriptor instead')
const FunctionDescriptor_Visibility$json = {
  '1': 'Visibility',
  '2': [
    {'1': 'VISIBILITY_UNKNOWN', '2': 0},
    {'1': 'PRIVATE', '2': 1},
    {'1': 'PUBLIC', '2': 2},
    {'1': 'FRIEND', '2': 3},
  ],
};

/// Descriptor for `FunctionDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List functionDescriptorDescriptor = $convert.base64Decode(
    'ChJGdW5jdGlvbkRlc2NyaXB0b3ISFwoEbmFtZRgBIAEoCUgAUgRuYW1liAEBEk4KCnZpc2liaW'
    'xpdHkYBSABKA4yKS5zdWkucnBjLnYyLkZ1bmN0aW9uRGVzY3JpcHRvci5WaXNpYmlsaXR5SAFS'
    'CnZpc2liaWxpdHmIAQESHgoIaXNfZW50cnkYBiABKAhIAlIHaXNFbnRyeYgBARJCCg90eXBlX3'
    'BhcmFtZXRlcnMYByADKAsyGS5zdWkucnBjLnYyLlR5cGVQYXJhbWV0ZXJSDnR5cGVQYXJhbWV0'
    'ZXJzEjkKCnBhcmFtZXRlcnMYCCADKAsyGS5zdWkucnBjLnYyLk9wZW5TaWduYXR1cmVSCnBhcm'
    'FtZXRlcnMSMwoHcmV0dXJucxgJIAMoCzIZLnN1aS5ycGMudjIuT3BlblNpZ25hdHVyZVIHcmV0'
    'dXJucyJJCgpWaXNpYmlsaXR5EhYKElZJU0lCSUxJVFlfVU5LTk9XThAAEgsKB1BSSVZBVEUQAR'
    'IKCgZQVUJMSUMQAhIKCgZGUklFTkQQA0IHCgVfbmFtZUINCgtfdmlzaWJpbGl0eUILCglfaXNf'
    'ZW50cnk=');

@$core.Deprecated('Use openSignatureDescriptor instead')
const OpenSignature$json = {
  '1': 'OpenSignature',
  '2': [
    {
      '1': 'reference',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.OpenSignature.Reference',
      '9': 0,
      '10': 'reference',
      '17': true
    },
    {
      '1': 'body',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.OpenSignatureBody',
      '9': 1,
      '10': 'body',
      '17': true
    },
  ],
  '4': [OpenSignature_Reference$json],
  '8': [
    {'1': '_reference'},
    {'1': '_body'},
  ],
};

@$core.Deprecated('Use openSignatureDescriptor instead')
const OpenSignature_Reference$json = {
  '1': 'Reference',
  '2': [
    {'1': 'REFERENCE_UNKNOWN', '2': 0},
    {'1': 'IMMUTABLE', '2': 1},
    {'1': 'MUTABLE', '2': 2},
  ],
};

/// Descriptor for `OpenSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List openSignatureDescriptor = $convert.base64Decode(
    'Cg1PcGVuU2lnbmF0dXJlEkYKCXJlZmVyZW5jZRgBIAEoDjIjLnN1aS5ycGMudjIuT3BlblNpZ2'
    '5hdHVyZS5SZWZlcmVuY2VIAFIJcmVmZXJlbmNliAEBEjYKBGJvZHkYAiABKAsyHS5zdWkucnBj'
    'LnYyLk9wZW5TaWduYXR1cmVCb2R5SAFSBGJvZHmIAQEiPgoJUmVmZXJlbmNlEhUKEVJFRkVSRU'
    '5DRV9VTktOT1dOEAASDQoJSU1NVVRBQkxFEAESCwoHTVVUQUJMRRACQgwKCl9yZWZlcmVuY2VC'
    'BwoFX2JvZHk=');

@$core.Deprecated('Use typeOriginDescriptor instead')
const TypeOrigin$json = {
  '1': 'TypeOrigin',
  '2': [
    {
      '1': 'module_name',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'moduleName',
      '17': true
    },
    {
      '1': 'datatype_name',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'datatypeName',
      '17': true
    },
    {
      '1': 'package_id',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'packageId',
      '17': true
    },
  ],
  '8': [
    {'1': '_module_name'},
    {'1': '_datatype_name'},
    {'1': '_package_id'},
  ],
};

/// Descriptor for `TypeOrigin`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typeOriginDescriptor = $convert.base64Decode(
    'CgpUeXBlT3JpZ2luEiQKC21vZHVsZV9uYW1lGAEgASgJSABSCm1vZHVsZU5hbWWIAQESKAoNZG'
    'F0YXR5cGVfbmFtZRgCIAEoCUgBUgxkYXRhdHlwZU5hbWWIAQESIgoKcGFja2FnZV9pZBgDIAEo'
    'CUgCUglwYWNrYWdlSWSIAQFCDgoMX21vZHVsZV9uYW1lQhAKDl9kYXRhdHlwZV9uYW1lQg0KC1'
    '9wYWNrYWdlX2lk');

@$core.Deprecated('Use linkageDescriptor instead')
const Linkage$json = {
  '1': 'Linkage',
  '2': [
    {
      '1': 'original_id',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'originalId',
      '17': true
    },
    {
      '1': 'upgraded_id',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'upgradedId',
      '17': true
    },
    {
      '1': 'upgraded_version',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'upgradedVersion',
      '17': true
    },
  ],
  '8': [
    {'1': '_original_id'},
    {'1': '_upgraded_id'},
    {'1': '_upgraded_version'},
  ],
};

/// Descriptor for `Linkage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkageDescriptor = $convert.base64Decode(
    'CgdMaW5rYWdlEiQKC29yaWdpbmFsX2lkGAEgASgJSABSCm9yaWdpbmFsSWSIAQESJAoLdXBncm'
    'FkZWRfaWQYAiABKAlIAVIKdXBncmFkZWRJZIgBARIuChB1cGdyYWRlZF92ZXJzaW9uGAMgASgE'
    'SAJSD3VwZ3JhZGVkVmVyc2lvbogBAUIOCgxfb3JpZ2luYWxfaWRCDgoMX3VwZ3JhZGVkX2lkQh'
    'MKEV91cGdyYWRlZF92ZXJzaW9u');
