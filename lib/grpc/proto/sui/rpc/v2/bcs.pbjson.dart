// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/bcs.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use bcsDescriptor instead')
const Bcs$json = {
  '1': 'Bcs',
  '2': [
    {'1': 'name', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'name', '17': true},
    {'1': 'value', '3': 2, '4': 1, '5': 12, '9': 1, '10': 'value', '17': true},
  ],
  '8': [
    {'1': '_name'},
    {'1': '_value'},
  ],
};

/// Descriptor for `Bcs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List bcsDescriptor = $convert.base64Decode(
    'CgNCY3MSFwoEbmFtZRgBIAEoCUgAUgRuYW1liAEBEhkKBXZhbHVlGAIgASgMSAFSBXZhbHVliA'
    'EBQgcKBV9uYW1lQggKBl92YWx1ZQ==');
