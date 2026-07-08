// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/move_package_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'move_package.pbjson.dart' as $0;

@$core.Deprecated('Use getPackageRequestDescriptor instead')
const GetPackageRequest$json = {
  '1': 'GetPackageRequest',
  '2': [
    {'1': 'package_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'packageId', '17': true},
  ],
  '8': [
    {'1': '_package_id'},
  ],
};

/// Descriptor for `GetPackageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPackageRequestDescriptor = $convert.base64Decode(
    'ChFHZXRQYWNrYWdlUmVxdWVzdBIiCgpwYWNrYWdlX2lkGAEgASgJSABSCXBhY2thZ2VJZIgBAU'
    'INCgtfcGFja2FnZV9pZA==');

@$core.Deprecated('Use getPackageResponseDescriptor instead')
const GetPackageResponse$json = {
  '1': 'GetPackageResponse',
  '2': [
    {'1': 'package', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.Package', '9': 0, '10': 'package', '17': true},
  ],
  '8': [
    {'1': '_package'},
  ],
};

/// Descriptor for `GetPackageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPackageResponseDescriptor = $convert.base64Decode(
    'ChJHZXRQYWNrYWdlUmVzcG9uc2USMgoHcGFja2FnZRgBIAEoCzITLnN1aS5ycGMudjIuUGFja2'
    'FnZUgAUgdwYWNrYWdliAEBQgoKCF9wYWNrYWdl');

@$core.Deprecated('Use getDatatypeRequestDescriptor instead')
const GetDatatypeRequest$json = {
  '1': 'GetDatatypeRequest',
  '2': [
    {'1': 'package_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'packageId', '17': true},
    {'1': 'module_name', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'moduleName', '17': true},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'name', '17': true},
  ],
  '8': [
    {'1': '_package_id'},
    {'1': '_module_name'},
    {'1': '_name'},
  ],
};

/// Descriptor for `GetDatatypeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDatatypeRequestDescriptor = $convert.base64Decode(
    'ChJHZXREYXRhdHlwZVJlcXVlc3QSIgoKcGFja2FnZV9pZBgBIAEoCUgAUglwYWNrYWdlSWSIAQ'
    'ESJAoLbW9kdWxlX25hbWUYAiABKAlIAVIKbW9kdWxlTmFtZYgBARIXCgRuYW1lGAMgASgJSAJS'
    'BG5hbWWIAQFCDQoLX3BhY2thZ2VfaWRCDgoMX21vZHVsZV9uYW1lQgcKBV9uYW1l');

@$core.Deprecated('Use getDatatypeResponseDescriptor instead')
const GetDatatypeResponse$json = {
  '1': 'GetDatatypeResponse',
  '2': [
    {'1': 'datatype', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.DatatypeDescriptor', '9': 0, '10': 'datatype', '17': true},
  ],
  '8': [
    {'1': '_datatype'},
  ],
};

/// Descriptor for `GetDatatypeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDatatypeResponseDescriptor = $convert.base64Decode(
    'ChNHZXREYXRhdHlwZVJlc3BvbnNlEj8KCGRhdGF0eXBlGAEgASgLMh4uc3VpLnJwYy52Mi5EYX'
    'RhdHlwZURlc2NyaXB0b3JIAFIIZGF0YXR5cGWIAQFCCwoJX2RhdGF0eXBl');

@$core.Deprecated('Use getFunctionRequestDescriptor instead')
const GetFunctionRequest$json = {
  '1': 'GetFunctionRequest',
  '2': [
    {'1': 'package_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'packageId', '17': true},
    {'1': 'module_name', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'moduleName', '17': true},
    {'1': 'name', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'name', '17': true},
  ],
  '8': [
    {'1': '_package_id'},
    {'1': '_module_name'},
    {'1': '_name'},
  ],
};

/// Descriptor for `GetFunctionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFunctionRequestDescriptor = $convert.base64Decode(
    'ChJHZXRGdW5jdGlvblJlcXVlc3QSIgoKcGFja2FnZV9pZBgBIAEoCUgAUglwYWNrYWdlSWSIAQ'
    'ESJAoLbW9kdWxlX25hbWUYAiABKAlIAVIKbW9kdWxlTmFtZYgBARIXCgRuYW1lGAMgASgJSAJS'
    'BG5hbWWIAQFCDQoLX3BhY2thZ2VfaWRCDgoMX21vZHVsZV9uYW1lQgcKBV9uYW1l');

@$core.Deprecated('Use getFunctionResponseDescriptor instead')
const GetFunctionResponse$json = {
  '1': 'GetFunctionResponse',
  '2': [
    {'1': 'function', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.FunctionDescriptor', '9': 0, '10': 'function', '17': true},
  ],
  '8': [
    {'1': '_function'},
  ],
};

/// Descriptor for `GetFunctionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getFunctionResponseDescriptor = $convert.base64Decode(
    'ChNHZXRGdW5jdGlvblJlc3BvbnNlEj8KCGZ1bmN0aW9uGAEgASgLMh4uc3VpLnJwYy52Mi5GdW'
    '5jdGlvbkRlc2NyaXB0b3JIAFIIZnVuY3Rpb26IAQFCCwoJX2Z1bmN0aW9u');

@$core.Deprecated('Use listPackageVersionsRequestDescriptor instead')
const ListPackageVersionsRequest$json = {
  '1': 'ListPackageVersionsRequest',
  '2': [
    {'1': 'package_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'packageId', '17': true},
    {'1': 'page_size', '3': 2, '4': 1, '5': 13, '9': 1, '10': 'pageSize', '17': true},
    {'1': 'page_token', '3': 3, '4': 1, '5': 12, '9': 2, '10': 'pageToken', '17': true},
  ],
  '8': [
    {'1': '_package_id'},
    {'1': '_page_size'},
    {'1': '_page_token'},
  ],
};

/// Descriptor for `ListPackageVersionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPackageVersionsRequestDescriptor = $convert.base64Decode(
    'ChpMaXN0UGFja2FnZVZlcnNpb25zUmVxdWVzdBIiCgpwYWNrYWdlX2lkGAEgASgJSABSCXBhY2'
    'thZ2VJZIgBARIgCglwYWdlX3NpemUYAiABKA1IAVIIcGFnZVNpemWIAQESIgoKcGFnZV90b2tl'
    'bhgDIAEoDEgCUglwYWdlVG9rZW6IAQFCDQoLX3BhY2thZ2VfaWRCDAoKX3BhZ2Vfc2l6ZUINCg'
    'tfcGFnZV90b2tlbg==');

@$core.Deprecated('Use listPackageVersionsResponseDescriptor instead')
const ListPackageVersionsResponse$json = {
  '1': 'ListPackageVersionsResponse',
  '2': [
    {'1': 'versions', '3': 1, '4': 3, '5': 11, '6': '.sui.rpc.v2.PackageVersion', '10': 'versions'},
    {'1': 'next_page_token', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'nextPageToken', '17': true},
  ],
  '8': [
    {'1': '_next_page_token'},
  ],
};

/// Descriptor for `ListPackageVersionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listPackageVersionsResponseDescriptor = $convert.base64Decode(
    'ChtMaXN0UGFja2FnZVZlcnNpb25zUmVzcG9uc2USNgoIdmVyc2lvbnMYASADKAsyGi5zdWkucn'
    'BjLnYyLlBhY2thZ2VWZXJzaW9uUgh2ZXJzaW9ucxIrCg9uZXh0X3BhZ2VfdG9rZW4YAiABKAxI'
    'AFINbmV4dFBhZ2VUb2tlbogBAUISChBfbmV4dF9wYWdlX3Rva2Vu');

@$core.Deprecated('Use packageVersionDescriptor instead')
const PackageVersion$json = {
  '1': 'PackageVersion',
  '2': [
    {'1': 'package_id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'packageId', '17': true},
    {'1': 'version', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'version', '17': true},
  ],
  '8': [
    {'1': '_package_id'},
    {'1': '_version'},
  ],
};

/// Descriptor for `PackageVersion`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List packageVersionDescriptor = $convert.base64Decode(
    'Cg5QYWNrYWdlVmVyc2lvbhIiCgpwYWNrYWdlX2lkGAEgASgJSABSCXBhY2thZ2VJZIgBARIdCg'
    'd2ZXJzaW9uGAIgASgESAFSB3ZlcnNpb26IAQFCDQoLX3BhY2thZ2VfaWRCCgoIX3ZlcnNpb24=');

const $core.Map<$core.String, $core.dynamic> MovePackageServiceBase$json = {
  '1': 'MovePackageService',
  '2': [
    {'1': 'GetPackage', '2': '.sui.rpc.v2.GetPackageRequest', '3': '.sui.rpc.v2.GetPackageResponse'},
    {'1': 'GetDatatype', '2': '.sui.rpc.v2.GetDatatypeRequest', '3': '.sui.rpc.v2.GetDatatypeResponse'},
    {'1': 'GetFunction', '2': '.sui.rpc.v2.GetFunctionRequest', '3': '.sui.rpc.v2.GetFunctionResponse'},
    {'1': 'ListPackageVersions', '2': '.sui.rpc.v2.ListPackageVersionsRequest', '3': '.sui.rpc.v2.ListPackageVersionsResponse'},
  ],
};

@$core.Deprecated('Use movePackageServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> MovePackageServiceBase$messageJson = {
  '.sui.rpc.v2.GetPackageRequest': GetPackageRequest$json,
  '.sui.rpc.v2.GetPackageResponse': GetPackageResponse$json,
  '.sui.rpc.v2.Package': $0.Package$json,
  '.sui.rpc.v2.Module': $0.Module$json,
  '.sui.rpc.v2.DatatypeDescriptor': $0.DatatypeDescriptor$json,
  '.sui.rpc.v2.TypeParameter': $0.TypeParameter$json,
  '.sui.rpc.v2.FieldDescriptor': $0.FieldDescriptor$json,
  '.sui.rpc.v2.OpenSignatureBody': $0.OpenSignatureBody$json,
  '.sui.rpc.v2.VariantDescriptor': $0.VariantDescriptor$json,
  '.sui.rpc.v2.FunctionDescriptor': $0.FunctionDescriptor$json,
  '.sui.rpc.v2.OpenSignature': $0.OpenSignature$json,
  '.sui.rpc.v2.TypeOrigin': $0.TypeOrigin$json,
  '.sui.rpc.v2.Linkage': $0.Linkage$json,
  '.sui.rpc.v2.GetDatatypeRequest': GetDatatypeRequest$json,
  '.sui.rpc.v2.GetDatatypeResponse': GetDatatypeResponse$json,
  '.sui.rpc.v2.GetFunctionRequest': GetFunctionRequest$json,
  '.sui.rpc.v2.GetFunctionResponse': GetFunctionResponse$json,
  '.sui.rpc.v2.ListPackageVersionsRequest': ListPackageVersionsRequest$json,
  '.sui.rpc.v2.ListPackageVersionsResponse': ListPackageVersionsResponse$json,
  '.sui.rpc.v2.PackageVersion': PackageVersion$json,
};

/// Descriptor for `MovePackageService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List movePackageServiceDescriptor = $convert.base64Decode(
    'ChJNb3ZlUGFja2FnZVNlcnZpY2USSwoKR2V0UGFja2FnZRIdLnN1aS5ycGMudjIuR2V0UGFja2'
    'FnZVJlcXVlc3QaHi5zdWkucnBjLnYyLkdldFBhY2thZ2VSZXNwb25zZRJOCgtHZXREYXRhdHlw'
    'ZRIeLnN1aS5ycGMudjIuR2V0RGF0YXR5cGVSZXF1ZXN0Gh8uc3VpLnJwYy52Mi5HZXREYXRhdH'
    'lwZVJlc3BvbnNlEk4KC0dldEZ1bmN0aW9uEh4uc3VpLnJwYy52Mi5HZXRGdW5jdGlvblJlcXVl'
    'c3QaHy5zdWkucnBjLnYyLkdldEZ1bmN0aW9uUmVzcG9uc2USZgoTTGlzdFBhY2thZ2VWZXJzaW'
    '9ucxImLnN1aS5ycGMudjIuTGlzdFBhY2thZ2VWZXJzaW9uc1JlcXVlc3QaJy5zdWkucnBjLnYy'
    'Lkxpc3RQYWNrYWdlVmVyc2lvbnNSZXNwb25zZQ==');

