// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/signature_scheme.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use signatureSchemeDescriptor instead')
const SignatureScheme$json = {
  '1': 'SignatureScheme',
  '2': [
    {'1': 'ED25519', '2': 0},
    {'1': 'SECP256K1', '2': 1},
    {'1': 'SECP256R1', '2': 2},
    {'1': 'MULTISIG', '2': 3},
    {'1': 'BLS12381', '2': 4},
    {'1': 'ZKLOGIN', '2': 5},
    {'1': 'PASSKEY', '2': 6},
  ],
};

/// Descriptor for `SignatureScheme`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List signatureSchemeDescriptor = $convert.base64Decode(
    'Cg9TaWduYXR1cmVTY2hlbWUSCwoHRUQyNTUxORAAEg0KCVNFQ1AyNTZLMRABEg0KCVNFQ1AyNT'
    'ZSMRACEgwKCE1VTFRJU0lHEAMSDAoIQkxTMTIzODEQBBILCgdaS0xPR0lOEAUSCwoHUEFTU0tF'
    'WRAG');
