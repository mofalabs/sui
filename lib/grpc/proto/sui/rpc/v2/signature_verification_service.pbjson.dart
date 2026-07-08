// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/signature_verification_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'bcs.pbjson.dart' as $0;
import 'jwk.pbjson.dart' as $3;
import 'signature.pbjson.dart' as $1;
import 'transaction.pbjson.dart' as $2;

@$core.Deprecated('Use verifySignatureRequestDescriptor instead')
const VerifySignatureRequest$json = {
  '1': 'VerifySignatureRequest',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.Bcs', '9': 0, '10': 'message', '17': true},
    {'1': 'signature', '3': 2, '4': 1, '5': 11, '6': '.sui.rpc.v2.UserSignature', '9': 1, '10': 'signature', '17': true},
    {'1': 'address', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'address', '17': true},
    {'1': 'jwks', '3': 4, '4': 3, '5': 11, '6': '.sui.rpc.v2.ActiveJwk', '10': 'jwks'},
  ],
  '8': [
    {'1': '_message'},
    {'1': '_signature'},
    {'1': '_address'},
  ],
};

/// Descriptor for `VerifySignatureRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifySignatureRequestDescriptor = $convert.base64Decode(
    'ChZWZXJpZnlTaWduYXR1cmVSZXF1ZXN0Ei4KB21lc3NhZ2UYASABKAsyDy5zdWkucnBjLnYyLk'
    'Jjc0gAUgdtZXNzYWdliAEBEjwKCXNpZ25hdHVyZRgCIAEoCzIZLnN1aS5ycGMudjIuVXNlclNp'
    'Z25hdHVyZUgBUglzaWduYXR1cmWIAQESHQoHYWRkcmVzcxgDIAEoCUgCUgdhZGRyZXNziAEBEi'
    'kKBGp3a3MYBCADKAsyFS5zdWkucnBjLnYyLkFjdGl2ZUp3a1IEandrc0IKCghfbWVzc2FnZUIM'
    'Cgpfc2lnbmF0dXJlQgoKCF9hZGRyZXNz');

@$core.Deprecated('Use verifySignatureResponseDescriptor instead')
const VerifySignatureResponse$json = {
  '1': 'VerifySignatureResponse',
  '2': [
    {'1': 'is_valid', '3': 1, '4': 1, '5': 8, '9': 0, '10': 'isValid', '17': true},
    {'1': 'reason', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'reason', '17': true},
  ],
  '8': [
    {'1': '_is_valid'},
    {'1': '_reason'},
  ],
};

/// Descriptor for `VerifySignatureResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifySignatureResponseDescriptor = $convert.base64Decode(
    'ChdWZXJpZnlTaWduYXR1cmVSZXNwb25zZRIeCghpc192YWxpZBgBIAEoCEgAUgdpc1ZhbGlkiA'
    'EBEhsKBnJlYXNvbhgCIAEoCUgBUgZyZWFzb26IAQFCCwoJX2lzX3ZhbGlkQgkKB19yZWFzb24=');

const $core.Map<$core.String, $core.dynamic> SignatureVerificationServiceBase$json = {
  '1': 'SignatureVerificationService',
  '2': [
    {'1': 'VerifySignature', '2': '.sui.rpc.v2.VerifySignatureRequest', '3': '.sui.rpc.v2.VerifySignatureResponse'},
  ],
};

@$core.Deprecated('Use signatureVerificationServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> SignatureVerificationServiceBase$messageJson = {
  '.sui.rpc.v2.VerifySignatureRequest': VerifySignatureRequest$json,
  '.sui.rpc.v2.Bcs': $0.Bcs$json,
  '.sui.rpc.v2.UserSignature': $1.UserSignature$json,
  '.sui.rpc.v2.SimpleSignature': $1.SimpleSignature$json,
  '.sui.rpc.v2.MultisigAggregatedSignature': $1.MultisigAggregatedSignature$json,
  '.sui.rpc.v2.MultisigMemberSignature': $1.MultisigMemberSignature$json,
  '.sui.rpc.v2.ZkLoginAuthenticator': $1.ZkLoginAuthenticator$json,
  '.sui.rpc.v2.ZkLoginInputs': $1.ZkLoginInputs$json,
  '.sui.rpc.v2.ZkLoginProof': $1.ZkLoginProof$json,
  '.sui.rpc.v2.CircomG1': $1.CircomG1$json,
  '.sui.rpc.v2.CircomG2': $1.CircomG2$json,
  '.sui.rpc.v2.ZkLoginClaim': $1.ZkLoginClaim$json,
  '.sui.rpc.v2.ZkLoginPublicIdentifier': $1.ZkLoginPublicIdentifier$json,
  '.sui.rpc.v2.JwkId': $3.JwkId$json,
  '.sui.rpc.v2.PasskeyAuthenticator': $1.PasskeyAuthenticator$json,
  '.sui.rpc.v2.MultisigCommittee': $1.MultisigCommittee$json,
  '.sui.rpc.v2.MultisigMember': $1.MultisigMember$json,
  '.sui.rpc.v2.MultisigMemberPublicKey': $1.MultisigMemberPublicKey$json,
  '.sui.rpc.v2.ActiveJwk': $2.ActiveJwk$json,
  '.sui.rpc.v2.Jwk': $3.Jwk$json,
  '.sui.rpc.v2.VerifySignatureResponse': VerifySignatureResponse$json,
};

/// Descriptor for `SignatureVerificationService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List signatureVerificationServiceDescriptor = $convert.base64Decode(
    'ChxTaWduYXR1cmVWZXJpZmljYXRpb25TZXJ2aWNlEloKD1ZlcmlmeVNpZ25hdHVyZRIiLnN1aS'
    '5ycGMudjIuVmVyaWZ5U2lnbmF0dXJlUmVxdWVzdBojLnN1aS5ycGMudjIuVmVyaWZ5U2lnbmF0'
    'dXJlUmVzcG9uc2U=');

