// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/signature.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use userSignatureDescriptor instead')
const UserSignature$json = {
  '1': 'UserSignature',
  '2': [
    {
      '1': 'bcs',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Bcs',
      '9': 1,
      '10': 'bcs',
      '17': true
    },
    {
      '1': 'scheme',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.SignatureScheme',
      '9': 2,
      '10': 'scheme',
      '17': true
    },
    {
      '1': 'simple',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.SimpleSignature',
      '9': 0,
      '10': 'simple'
    },
    {
      '1': 'multisig',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MultisigAggregatedSignature',
      '9': 0,
      '10': 'multisig'
    },
    {
      '1': 'zklogin',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ZkLoginAuthenticator',
      '9': 0,
      '10': 'zklogin'
    },
    {
      '1': 'passkey',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.PasskeyAuthenticator',
      '9': 0,
      '10': 'passkey'
    },
  ],
  '8': [
    {'1': 'signature'},
    {'1': '_bcs'},
    {'1': '_scheme'},
  ],
};

/// Descriptor for `UserSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userSignatureDescriptor = $convert.base64Decode(
    'Cg1Vc2VyU2lnbmF0dXJlEiYKA2JjcxgBIAEoCzIPLnN1aS5ycGMudjIuQmNzSAFSA2Jjc4gBAR'
    'I4CgZzY2hlbWUYAiABKA4yGy5zdWkucnBjLnYyLlNpZ25hdHVyZVNjaGVtZUgCUgZzY2hlbWWI'
    'AQESNQoGc2ltcGxlGAMgASgLMhsuc3VpLnJwYy52Mi5TaW1wbGVTaWduYXR1cmVIAFIGc2ltcG'
    'xlEkUKCG11bHRpc2lnGAQgASgLMicuc3VpLnJwYy52Mi5NdWx0aXNpZ0FnZ3JlZ2F0ZWRTaWdu'
    'YXR1cmVIAFIIbXVsdGlzaWcSPAoHemtsb2dpbhgFIAEoCzIgLnN1aS5ycGMudjIuWmtMb2dpbk'
    'F1dGhlbnRpY2F0b3JIAFIHemtsb2dpbhI8CgdwYXNza2V5GAYgASgLMiAuc3VpLnJwYy52Mi5Q'
    'YXNza2V5QXV0aGVudGljYXRvckgAUgdwYXNza2V5QgsKCXNpZ25hdHVyZUIGCgRfYmNzQgkKB1'
    '9zY2hlbWU=');

@$core.Deprecated('Use simpleSignatureDescriptor instead')
const SimpleSignature$json = {
  '1': 'SimpleSignature',
  '2': [
    {
      '1': 'scheme',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.SignatureScheme',
      '9': 0,
      '10': 'scheme',
      '17': true
    },
    {
      '1': 'signature',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 1,
      '10': 'signature',
      '17': true
    },
    {
      '1': 'public_key',
      '3': 3,
      '4': 1,
      '5': 12,
      '9': 2,
      '10': 'publicKey',
      '17': true
    },
  ],
  '8': [
    {'1': '_scheme'},
    {'1': '_signature'},
    {'1': '_public_key'},
  ],
};

/// Descriptor for `SimpleSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simpleSignatureDescriptor = $convert.base64Decode(
    'Cg9TaW1wbGVTaWduYXR1cmUSOAoGc2NoZW1lGAEgASgOMhsuc3VpLnJwYy52Mi5TaWduYXR1cm'
    'VTY2hlbWVIAFIGc2NoZW1liAEBEiEKCXNpZ25hdHVyZRgCIAEoDEgBUglzaWduYXR1cmWIAQES'
    'IgoKcHVibGljX2tleRgDIAEoDEgCUglwdWJsaWNLZXmIAQFCCQoHX3NjaGVtZUIMCgpfc2lnbm'
    'F0dXJlQg0KC19wdWJsaWNfa2V5');

@$core.Deprecated('Use zkLoginPublicIdentifierDescriptor instead')
const ZkLoginPublicIdentifier$json = {
  '1': 'ZkLoginPublicIdentifier',
  '2': [
    {'1': 'iss', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'iss', '17': true},
    {
      '1': 'address_seed',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'addressSeed',
      '17': true
    },
  ],
  '8': [
    {'1': '_iss'},
    {'1': '_address_seed'},
  ],
};

/// Descriptor for `ZkLoginPublicIdentifier`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zkLoginPublicIdentifierDescriptor = $convert.base64Decode(
    'Chdaa0xvZ2luUHVibGljSWRlbnRpZmllchIVCgNpc3MYASABKAlIAFIDaXNziAEBEiYKDGFkZH'
    'Jlc3Nfc2VlZBgCIAEoCUgBUgthZGRyZXNzU2VlZIgBAUIGCgRfaXNzQg8KDV9hZGRyZXNzX3Nl'
    'ZWQ=');

@$core.Deprecated('Use multisigMemberPublicKeyDescriptor instead')
const MultisigMemberPublicKey$json = {
  '1': 'MultisigMemberPublicKey',
  '2': [
    {
      '1': 'scheme',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.SignatureScheme',
      '9': 0,
      '10': 'scheme',
      '17': true
    },
    {
      '1': 'public_key',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 1,
      '10': 'publicKey',
      '17': true
    },
    {
      '1': 'zklogin',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ZkLoginPublicIdentifier',
      '9': 2,
      '10': 'zklogin',
      '17': true
    },
  ],
  '8': [
    {'1': '_scheme'},
    {'1': '_public_key'},
    {'1': '_zklogin'},
  ],
};

/// Descriptor for `MultisigMemberPublicKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List multisigMemberPublicKeyDescriptor = $convert.base64Decode(
    'ChdNdWx0aXNpZ01lbWJlclB1YmxpY0tleRI4CgZzY2hlbWUYASABKA4yGy5zdWkucnBjLnYyLl'
    'NpZ25hdHVyZVNjaGVtZUgAUgZzY2hlbWWIAQESIgoKcHVibGljX2tleRgCIAEoDEgBUglwdWJs'
    'aWNLZXmIAQESQgoHemtsb2dpbhgDIAEoCzIjLnN1aS5ycGMudjIuWmtMb2dpblB1YmxpY0lkZW'
    '50aWZpZXJIAlIHemtsb2dpbogBAUIJCgdfc2NoZW1lQg0KC19wdWJsaWNfa2V5QgoKCF96a2xv'
    'Z2lu');

@$core.Deprecated('Use multisigMemberDescriptor instead')
const MultisigMember$json = {
  '1': 'MultisigMember',
  '2': [
    {
      '1': 'public_key',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MultisigMemberPublicKey',
      '9': 0,
      '10': 'publicKey',
      '17': true
    },
    {
      '1': 'weight',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'weight',
      '17': true
    },
  ],
  '8': [
    {'1': '_public_key'},
    {'1': '_weight'},
  ],
};

/// Descriptor for `MultisigMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List multisigMemberDescriptor = $convert.base64Decode(
    'Cg5NdWx0aXNpZ01lbWJlchJHCgpwdWJsaWNfa2V5GAEgASgLMiMuc3VpLnJwYy52Mi5NdWx0aX'
    'NpZ01lbWJlclB1YmxpY0tleUgAUglwdWJsaWNLZXmIAQESGwoGd2VpZ2h0GAIgASgNSAFSBndl'
    'aWdodIgBAUINCgtfcHVibGljX2tleUIJCgdfd2VpZ2h0');

@$core.Deprecated('Use multisigCommitteeDescriptor instead')
const MultisigCommittee$json = {
  '1': 'MultisigCommittee',
  '2': [
    {
      '1': 'members',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.MultisigMember',
      '10': 'members'
    },
    {
      '1': 'threshold',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'threshold',
      '17': true
    },
  ],
  '8': [
    {'1': '_threshold'},
  ],
};

/// Descriptor for `MultisigCommittee`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List multisigCommitteeDescriptor = $convert.base64Decode(
    'ChFNdWx0aXNpZ0NvbW1pdHRlZRI0CgdtZW1iZXJzGAEgAygLMhouc3VpLnJwYy52Mi5NdWx0aX'
    'NpZ01lbWJlclIHbWVtYmVycxIhCgl0aHJlc2hvbGQYAiABKA1IAFIJdGhyZXNob2xkiAEBQgwK'
    'Cl90aHJlc2hvbGQ=');

@$core.Deprecated('Use multisigAggregatedSignatureDescriptor instead')
const MultisigAggregatedSignature$json = {
  '1': 'MultisigAggregatedSignature',
  '2': [
    {
      '1': 'signatures',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.MultisigMemberSignature',
      '10': 'signatures'
    },
    {
      '1': 'bitmap',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 0,
      '10': 'bitmap',
      '17': true
    },
    {
      '1': 'legacy_bitmap',
      '3': 3,
      '4': 1,
      '5': 12,
      '9': 1,
      '10': 'legacyBitmap',
      '17': true
    },
    {
      '1': 'committee',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MultisigCommittee',
      '9': 2,
      '10': 'committee',
      '17': true
    },
  ],
  '8': [
    {'1': '_bitmap'},
    {'1': '_legacy_bitmap'},
    {'1': '_committee'},
  ],
};

/// Descriptor for `MultisigAggregatedSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List multisigAggregatedSignatureDescriptor = $convert.base64Decode(
    'ChtNdWx0aXNpZ0FnZ3JlZ2F0ZWRTaWduYXR1cmUSQwoKc2lnbmF0dXJlcxgBIAMoCzIjLnN1aS'
    '5ycGMudjIuTXVsdGlzaWdNZW1iZXJTaWduYXR1cmVSCnNpZ25hdHVyZXMSGwoGYml0bWFwGAIg'
    'ASgNSABSBmJpdG1hcIgBARIoCg1sZWdhY3lfYml0bWFwGAMgASgMSAFSDGxlZ2FjeUJpdG1hcI'
    'gBARJACgljb21taXR0ZWUYBCABKAsyHS5zdWkucnBjLnYyLk11bHRpc2lnQ29tbWl0dGVlSAJS'
    'CWNvbW1pdHRlZYgBAUIJCgdfYml0bWFwQhAKDl9sZWdhY3lfYml0bWFwQgwKCl9jb21taXR0ZW'
    'U=');

@$core.Deprecated('Use multisigMemberSignatureDescriptor instead')
const MultisigMemberSignature$json = {
  '1': 'MultisigMemberSignature',
  '2': [
    {
      '1': 'scheme',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.SignatureScheme',
      '9': 0,
      '10': 'scheme',
      '17': true
    },
    {
      '1': 'signature',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 1,
      '10': 'signature',
      '17': true
    },
    {
      '1': 'zklogin',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ZkLoginAuthenticator',
      '9': 2,
      '10': 'zklogin',
      '17': true
    },
    {
      '1': 'passkey',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.PasskeyAuthenticator',
      '9': 3,
      '10': 'passkey',
      '17': true
    },
  ],
  '8': [
    {'1': '_scheme'},
    {'1': '_signature'},
    {'1': '_zklogin'},
    {'1': '_passkey'},
  ],
};

/// Descriptor for `MultisigMemberSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List multisigMemberSignatureDescriptor = $convert.base64Decode(
    'ChdNdWx0aXNpZ01lbWJlclNpZ25hdHVyZRI4CgZzY2hlbWUYASABKA4yGy5zdWkucnBjLnYyLl'
    'NpZ25hdHVyZVNjaGVtZUgAUgZzY2hlbWWIAQESIQoJc2lnbmF0dXJlGAIgASgMSAFSCXNpZ25h'
    'dHVyZYgBARI/Cgd6a2xvZ2luGAMgASgLMiAuc3VpLnJwYy52Mi5aa0xvZ2luQXV0aGVudGljYX'
    'RvckgCUgd6a2xvZ2luiAEBEj8KB3Bhc3NrZXkYBCABKAsyIC5zdWkucnBjLnYyLlBhc3NrZXlB'
    'dXRoZW50aWNhdG9ySANSB3Bhc3NrZXmIAQFCCQoHX3NjaGVtZUIMCgpfc2lnbmF0dXJlQgoKCF'
    '96a2xvZ2luQgoKCF9wYXNza2V5');

@$core.Deprecated('Use zkLoginAuthenticatorDescriptor instead')
const ZkLoginAuthenticator$json = {
  '1': 'ZkLoginAuthenticator',
  '2': [
    {
      '1': 'inputs',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ZkLoginInputs',
      '9': 0,
      '10': 'inputs',
      '17': true
    },
    {
      '1': 'max_epoch',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'maxEpoch',
      '17': true
    },
    {
      '1': 'signature',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.SimpleSignature',
      '9': 2,
      '10': 'signature',
      '17': true
    },
    {
      '1': 'public_identifier',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ZkLoginPublicIdentifier',
      '9': 3,
      '10': 'publicIdentifier',
      '17': true
    },
    {
      '1': 'jwk_id',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.JwkId',
      '9': 4,
      '10': 'jwkId',
      '17': true
    },
  ],
  '8': [
    {'1': '_inputs'},
    {'1': '_max_epoch'},
    {'1': '_signature'},
    {'1': '_public_identifier'},
    {'1': '_jwk_id'},
  ],
};

/// Descriptor for `ZkLoginAuthenticator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zkLoginAuthenticatorDescriptor = $convert.base64Decode(
    'ChRaa0xvZ2luQXV0aGVudGljYXRvchI2CgZpbnB1dHMYASABKAsyGS5zdWkucnBjLnYyLlprTG'
    '9naW5JbnB1dHNIAFIGaW5wdXRziAEBEiAKCW1heF9lcG9jaBgCIAEoBEgBUghtYXhFcG9jaIgB'
    'ARI+CglzaWduYXR1cmUYAyABKAsyGy5zdWkucnBjLnYyLlNpbXBsZVNpZ25hdHVyZUgCUglzaW'
    'duYXR1cmWIAQESVQoRcHVibGljX2lkZW50aWZpZXIYBCABKAsyIy5zdWkucnBjLnYyLlprTG9n'
    'aW5QdWJsaWNJZGVudGlmaWVySANSEHB1YmxpY0lkZW50aWZpZXKIAQESLQoGandrX2lkGAUgAS'
    'gLMhEuc3VpLnJwYy52Mi5Kd2tJZEgEUgVqd2tJZIgBAUIJCgdfaW5wdXRzQgwKCl9tYXhfZXBv'
    'Y2hCDAoKX3NpZ25hdHVyZUIUChJfcHVibGljX2lkZW50aWZpZXJCCQoHX2p3a19pZA==');

@$core.Deprecated('Use zkLoginInputsDescriptor instead')
const ZkLoginInputs$json = {
  '1': 'ZkLoginInputs',
  '2': [
    {
      '1': 'proof_points',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ZkLoginProof',
      '9': 0,
      '10': 'proofPoints',
      '17': true
    },
    {
      '1': 'iss_base64_details',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ZkLoginClaim',
      '9': 1,
      '10': 'issBase64Details',
      '17': true
    },
    {
      '1': 'header_base64',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 2,
      '10': 'headerBase64',
      '17': true
    },
    {
      '1': 'address_seed',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'addressSeed',
      '17': true
    },
  ],
  '8': [
    {'1': '_proof_points'},
    {'1': '_iss_base64_details'},
    {'1': '_header_base64'},
    {'1': '_address_seed'},
  ],
};

/// Descriptor for `ZkLoginInputs`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zkLoginInputsDescriptor = $convert.base64Decode(
    'Cg1aa0xvZ2luSW5wdXRzEkAKDHByb29mX3BvaW50cxgBIAEoCzIYLnN1aS5ycGMudjIuWmtMb2'
    'dpblByb29mSABSC3Byb29mUG9pbnRziAEBEksKEmlzc19iYXNlNjRfZGV0YWlscxgCIAEoCzIY'
    'LnN1aS5ycGMudjIuWmtMb2dpbkNsYWltSAFSEGlzc0Jhc2U2NERldGFpbHOIAQESKAoNaGVhZG'
    'VyX2Jhc2U2NBgDIAEoCUgCUgxoZWFkZXJCYXNlNjSIAQESJgoMYWRkcmVzc19zZWVkGAQgASgJ'
    'SANSC2FkZHJlc3NTZWVkiAEBQg8KDV9wcm9vZl9wb2ludHNCFQoTX2lzc19iYXNlNjRfZGV0YW'
    'lsc0IQCg5faGVhZGVyX2Jhc2U2NEIPCg1fYWRkcmVzc19zZWVk');

@$core.Deprecated('Use zkLoginProofDescriptor instead')
const ZkLoginProof$json = {
  '1': 'ZkLoginProof',
  '2': [
    {
      '1': 'a',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CircomG1',
      '9': 0,
      '10': 'a',
      '17': true
    },
    {
      '1': 'b',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CircomG2',
      '9': 1,
      '10': 'b',
      '17': true
    },
    {
      '1': 'c',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.CircomG1',
      '9': 2,
      '10': 'c',
      '17': true
    },
  ],
  '8': [
    {'1': '_a'},
    {'1': '_b'},
    {'1': '_c'},
  ],
};

/// Descriptor for `ZkLoginProof`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zkLoginProofDescriptor = $convert.base64Decode(
    'Cgxaa0xvZ2luUHJvb2YSJwoBYRgBIAEoCzIULnN1aS5ycGMudjIuQ2lyY29tRzFIAFIBYYgBAR'
    'InCgFiGAIgASgLMhQuc3VpLnJwYy52Mi5DaXJjb21HMkgBUgFiiAEBEicKAWMYAyABKAsyFC5z'
    'dWkucnBjLnYyLkNpcmNvbUcxSAJSAWOIAQFCBAoCX2FCBAoCX2JCBAoCX2M=');

@$core.Deprecated('Use zkLoginClaimDescriptor instead')
const ZkLoginClaim$json = {
  '1': 'ZkLoginClaim',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'value', '17': true},
    {
      '1': 'index_mod_4',
      '3': 2,
      '4': 1,
      '5': 13,
      '9': 1,
      '10': 'indexMod4',
      '17': true
    },
  ],
  '8': [
    {'1': '_value'},
    {'1': '_index_mod_4'},
  ],
};

/// Descriptor for `ZkLoginClaim`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List zkLoginClaimDescriptor = $convert.base64Decode(
    'Cgxaa0xvZ2luQ2xhaW0SGQoFdmFsdWUYASABKAlIAFIFdmFsdWWIAQESIwoLaW5kZXhfbW9kXz'
    'QYAiABKA1IAVIJaW5kZXhNb2Q0iAEBQggKBl92YWx1ZUIOCgxfaW5kZXhfbW9kXzQ=');

@$core.Deprecated('Use circomG1Descriptor instead')
const CircomG1$json = {
  '1': 'CircomG1',
  '2': [
    {'1': 'e0', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'e0', '17': true},
    {'1': 'e1', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'e1', '17': true},
    {'1': 'e2', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'e2', '17': true},
  ],
  '8': [
    {'1': '_e0'},
    {'1': '_e1'},
    {'1': '_e2'},
  ],
};

/// Descriptor for `CircomG1`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List circomG1Descriptor = $convert.base64Decode(
    'CghDaXJjb21HMRITCgJlMBgBIAEoCUgAUgJlMIgBARITCgJlMRgCIAEoCUgBUgJlMYgBARITCg'
    'JlMhgDIAEoCUgCUgJlMogBAUIFCgNfZTBCBQoDX2UxQgUKA19lMg==');

@$core.Deprecated('Use circomG2Descriptor instead')
const CircomG2$json = {
  '1': 'CircomG2',
  '2': [
    {'1': 'e00', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'e00', '17': true},
    {'1': 'e01', '3': 2, '4': 1, '5': 9, '9': 1, '10': 'e01', '17': true},
    {'1': 'e10', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'e10', '17': true},
    {'1': 'e11', '3': 4, '4': 1, '5': 9, '9': 3, '10': 'e11', '17': true},
    {'1': 'e20', '3': 5, '4': 1, '5': 9, '9': 4, '10': 'e20', '17': true},
    {'1': 'e21', '3': 6, '4': 1, '5': 9, '9': 5, '10': 'e21', '17': true},
  ],
  '8': [
    {'1': '_e00'},
    {'1': '_e01'},
    {'1': '_e10'},
    {'1': '_e11'},
    {'1': '_e20'},
    {'1': '_e21'},
  ],
};

/// Descriptor for `CircomG2`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List circomG2Descriptor = $convert.base64Decode(
    'CghDaXJjb21HMhIVCgNlMDAYASABKAlIAFIDZTAwiAEBEhUKA2UwMRgCIAEoCUgBUgNlMDGIAQ'
    'ESFQoDZTEwGAMgASgJSAJSA2UxMIgBARIVCgNlMTEYBCABKAlIA1IDZTExiAEBEhUKA2UyMBgF'
    'IAEoCUgEUgNlMjCIAQESFQoDZTIxGAYgASgJSAVSA2UyMYgBAUIGCgRfZTAwQgYKBF9lMDFCBg'
    'oEX2UxMEIGCgRfZTExQgYKBF9lMjBCBgoEX2UyMQ==');

@$core.Deprecated('Use passkeyAuthenticatorDescriptor instead')
const PasskeyAuthenticator$json = {
  '1': 'PasskeyAuthenticator',
  '2': [
    {
      '1': 'authenticator_data',
      '3': 1,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'authenticatorData',
      '17': true
    },
    {
      '1': 'client_data_json',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'clientDataJson',
      '17': true
    },
    {
      '1': 'signature',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.SimpleSignature',
      '9': 2,
      '10': 'signature',
      '17': true
    },
  ],
  '8': [
    {'1': '_authenticator_data'},
    {'1': '_client_data_json'},
    {'1': '_signature'},
  ],
};

/// Descriptor for `PasskeyAuthenticator`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List passkeyAuthenticatorDescriptor = $convert.base64Decode(
    'ChRQYXNza2V5QXV0aGVudGljYXRvchIyChJhdXRoZW50aWNhdG9yX2RhdGEYASABKAxIAFIRYX'
    'V0aGVudGljYXRvckRhdGGIAQESLQoQY2xpZW50X2RhdGFfanNvbhgCIAEoCUgBUg5jbGllbnRE'
    'YXRhSnNvbogBARI+CglzaWduYXR1cmUYAyABKAsyGy5zdWkucnBjLnYyLlNpbXBsZVNpZ25hdH'
    'VyZUgCUglzaWduYXR1cmWIAQFCFQoTX2F1dGhlbnRpY2F0b3JfZGF0YUITChFfY2xpZW50X2Rh'
    'dGFfanNvbkIMCgpfc2lnbmF0dXJl');

@$core.Deprecated('Use validatorCommitteeDescriptor instead')
const ValidatorCommittee$json = {
  '1': 'ValidatorCommittee',
  '2': [
    {'1': 'epoch', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'epoch', '17': true},
    {
      '1': 'members',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ValidatorCommitteeMember',
      '10': 'members'
    },
  ],
  '8': [
    {'1': '_epoch'},
  ],
};

/// Descriptor for `ValidatorCommittee`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatorCommitteeDescriptor = $convert.base64Decode(
    'ChJWYWxpZGF0b3JDb21taXR0ZWUSGQoFZXBvY2gYASABKARIAFIFZXBvY2iIAQESPgoHbWVtYm'
    'VycxgCIAMoCzIkLnN1aS5ycGMudjIuVmFsaWRhdG9yQ29tbWl0dGVlTWVtYmVyUgdtZW1iZXJz'
    'QggKBl9lcG9jaA==');

@$core.Deprecated('Use validatorCommitteeMemberDescriptor instead')
const ValidatorCommitteeMember$json = {
  '1': 'ValidatorCommitteeMember',
  '2': [
    {
      '1': 'public_key',
      '3': 1,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'publicKey',
      '17': true
    },
    {'1': 'weight', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'weight', '17': true},
  ],
  '8': [
    {'1': '_public_key'},
    {'1': '_weight'},
  ],
};

/// Descriptor for `ValidatorCommitteeMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatorCommitteeMemberDescriptor = $convert.base64Decode(
    'ChhWYWxpZGF0b3JDb21taXR0ZWVNZW1iZXISIgoKcHVibGljX2tleRgBIAEoDEgAUglwdWJsaW'
    'NLZXmIAQESGwoGd2VpZ2h0GAIgASgESAFSBndlaWdodIgBAUINCgtfcHVibGljX2tleUIJCgdf'
    'd2VpZ2h0');

@$core.Deprecated('Use validatorAggregatedSignatureDescriptor instead')
const ValidatorAggregatedSignature$json = {
  '1': 'ValidatorAggregatedSignature',
  '2': [
    {'1': 'epoch', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'epoch', '17': true},
    {
      '1': 'signature',
      '3': 2,
      '4': 1,
      '5': 12,
      '9': 1,
      '10': 'signature',
      '17': true
    },
    {
      '1': 'bitmap',
      '3': 3,
      '4': 1,
      '5': 12,
      '9': 2,
      '10': 'bitmap',
      '17': true
    },
  ],
  '8': [
    {'1': '_epoch'},
    {'1': '_signature'},
    {'1': '_bitmap'},
  ],
};

/// Descriptor for `ValidatorAggregatedSignature`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatorAggregatedSignatureDescriptor =
    $convert.base64Decode(
        'ChxWYWxpZGF0b3JBZ2dyZWdhdGVkU2lnbmF0dXJlEhkKBWVwb2NoGAEgASgESABSBWVwb2NoiA'
        'EBEiEKCXNpZ25hdHVyZRgCIAEoDEgBUglzaWduYXR1cmWIAQESGwoGYml0bWFwGAMgASgMSAJS'
        'BmJpdG1hcIgBAUIICgZfZXBvY2hCDAoKX3NpZ25hdHVyZUIJCgdfYml0bWFw');
