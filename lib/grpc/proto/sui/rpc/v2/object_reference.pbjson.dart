// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/object_reference.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use objectReferenceDescriptor instead')
const ObjectReference$json = {
  '1': 'ObjectReference',
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
      '1': 'version',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'version',
      '17': true
    },
    {'1': 'digest', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'digest', '17': true},
  ],
  '8': [
    {'1': '_object_id'},
    {'1': '_version'},
    {'1': '_digest'},
  ],
};

/// Descriptor for `ObjectReference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List objectReferenceDescriptor = $convert.base64Decode(
    'Cg9PYmplY3RSZWZlcmVuY2USIAoJb2JqZWN0X2lkGAEgASgJSABSCG9iamVjdElkiAEBEh0KB3'
    'ZlcnNpb24YAiABKARIAVIHdmVyc2lvbogBARIbCgZkaWdlc3QYAyABKAlIAlIGZGlnZXN0iAEB'
    'QgwKCl9vYmplY3RfaWRCCgoIX3ZlcnNpb25CCQoHX2RpZ2VzdA==');
