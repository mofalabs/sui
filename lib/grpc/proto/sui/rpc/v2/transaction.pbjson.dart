// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/transaction.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use transactionDescriptor instead')
const Transaction$json = {
  '1': 'Transaction',
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
      '1': 'kind',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.TransactionKind',
      '9': 3,
      '10': 'kind',
      '17': true
    },
    {'1': 'sender', '3': 5, '4': 1, '5': 9, '9': 4, '10': 'sender', '17': true},
    {
      '1': 'gas_payment',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.GasPayment',
      '9': 5,
      '10': 'gasPayment',
      '17': true
    },
    {
      '1': 'expiration',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.TransactionExpiration',
      '9': 6,
      '10': 'expiration',
      '17': true
    },
  ],
  '8': [
    {'1': '_bcs'},
    {'1': '_digest'},
    {'1': '_version'},
    {'1': '_kind'},
    {'1': '_sender'},
    {'1': '_gas_payment'},
    {'1': '_expiration'},
  ],
};

/// Descriptor for `Transaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionDescriptor = $convert.base64Decode(
    'CgtUcmFuc2FjdGlvbhImCgNiY3MYASABKAsyDy5zdWkucnBjLnYyLkJjc0gAUgNiY3OIAQESGw'
    'oGZGlnZXN0GAIgASgJSAFSBmRpZ2VzdIgBARIdCgd2ZXJzaW9uGAMgASgFSAJSB3ZlcnNpb26I'
    'AQESNAoEa2luZBgEIAEoCzIbLnN1aS5ycGMudjIuVHJhbnNhY3Rpb25LaW5kSANSBGtpbmSIAQ'
    'ESGwoGc2VuZGVyGAUgASgJSARSBnNlbmRlcogBARI8CgtnYXNfcGF5bWVudBgGIAEoCzIWLnN1'
    'aS5ycGMudjIuR2FzUGF5bWVudEgFUgpnYXNQYXltZW50iAEBEkYKCmV4cGlyYXRpb24YByABKA'
    'syIS5zdWkucnBjLnYyLlRyYW5zYWN0aW9uRXhwaXJhdGlvbkgGUgpleHBpcmF0aW9uiAEBQgYK'
    'BF9iY3NCCQoHX2RpZ2VzdEIKCghfdmVyc2lvbkIHCgVfa2luZEIJCgdfc2VuZGVyQg4KDF9nYX'
    'NfcGF5bWVudEINCgtfZXhwaXJhdGlvbg==');

@$core.Deprecated('Use gasPaymentDescriptor instead')
const GasPayment$json = {
  '1': 'GasPayment',
  '2': [
    {
      '1': 'objects',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ObjectReference',
      '10': 'objects'
    },
    {'1': 'owner', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'owner', '17': true},
    {'1': 'price', '3': 3, '4': 1, '5': 4, '9': 1, '10': 'price', '17': true},
    {'1': 'budget', '3': 4, '4': 1, '5': 4, '9': 2, '10': 'budget', '17': true},
  ],
  '8': [
    {'1': '_owner'},
    {'1': '_price'},
    {'1': '_budget'},
  ],
};

/// Descriptor for `GasPayment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List gasPaymentDescriptor = $convert.base64Decode(
    'CgpHYXNQYXltZW50EjUKB29iamVjdHMYASADKAsyGy5zdWkucnBjLnYyLk9iamVjdFJlZmVyZW'
    '5jZVIHb2JqZWN0cxIZCgVvd25lchgCIAEoCUgAUgVvd25lcogBARIZCgVwcmljZRgDIAEoBEgB'
    'UgVwcmljZYgBARIbCgZidWRnZXQYBCABKARIAlIGYnVkZ2V0iAEBQggKBl9vd25lckIICgZfcH'
    'JpY2VCCQoHX2J1ZGdldA==');

@$core.Deprecated('Use transactionExpirationDescriptor instead')
const TransactionExpiration$json = {
  '1': 'TransactionExpiration',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.TransactionExpiration.TransactionExpirationKind',
      '9': 0,
      '10': 'kind',
      '17': true
    },
    {'1': 'epoch', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'epoch', '17': true},
    {
      '1': 'min_epoch',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'minEpoch',
      '17': true
    },
    {
      '1': 'min_timestamp',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 3,
      '10': 'minTimestamp',
      '17': true
    },
    {
      '1': 'max_timestamp',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 4,
      '10': 'maxTimestamp',
      '17': true
    },
    {'1': 'chain', '3': 6, '4': 1, '5': 9, '9': 5, '10': 'chain', '17': true},
    {'1': 'nonce', '3': 7, '4': 1, '5': 13, '9': 6, '10': 'nonce', '17': true},
  ],
  '4': [TransactionExpiration_TransactionExpirationKind$json],
  '8': [
    {'1': '_kind'},
    {'1': '_epoch'},
    {'1': '_min_epoch'},
    {'1': '_min_timestamp'},
    {'1': '_max_timestamp'},
    {'1': '_chain'},
    {'1': '_nonce'},
  ],
};

@$core.Deprecated('Use transactionExpirationDescriptor instead')
const TransactionExpiration_TransactionExpirationKind$json = {
  '1': 'TransactionExpirationKind',
  '2': [
    {'1': 'TRANSACTION_EXPIRATION_KIND_UNKNOWN', '2': 0},
    {'1': 'NONE', '2': 1},
    {'1': 'EPOCH', '2': 2},
    {'1': 'VALID_DURING', '2': 3},
  ],
};

/// Descriptor for `TransactionExpiration`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionExpirationDescriptor = $convert.base64Decode(
    'ChVUcmFuc2FjdGlvbkV4cGlyYXRpb24SVAoEa2luZBgBIAEoDjI7LnN1aS5ycGMudjIuVHJhbn'
    'NhY3Rpb25FeHBpcmF0aW9uLlRyYW5zYWN0aW9uRXhwaXJhdGlvbktpbmRIAFIEa2luZIgBARIZ'
    'CgVlcG9jaBgCIAEoBEgBUgVlcG9jaIgBARIgCgltaW5fZXBvY2gYAyABKARIAlIIbWluRXBvY2'
    'iIAQESRAoNbWluX3RpbWVzdGFtcBgEIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBI'
    'A1IMbWluVGltZXN0YW1wiAEBEkQKDW1heF90aW1lc3RhbXAYBSABKAsyGi5nb29nbGUucHJvdG'
    '9idWYuVGltZXN0YW1wSARSDG1heFRpbWVzdGFtcIgBARIZCgVjaGFpbhgGIAEoCUgFUgVjaGFp'
    'bogBARIZCgVub25jZRgHIAEoDUgGUgVub25jZYgBASJrChlUcmFuc2FjdGlvbkV4cGlyYXRpb2'
    '5LaW5kEicKI1RSQU5TQUNUSU9OX0VYUElSQVRJT05fS0lORF9VTktOT1dOEAASCAoETk9ORRAB'
    'EgkKBUVQT0NIEAISEAoMVkFMSURfRFVSSU5HEANCBwoFX2tpbmRCCAoGX2Vwb2NoQgwKCl9taW'
    '5fZXBvY2hCEAoOX21pbl90aW1lc3RhbXBCEAoOX21heF90aW1lc3RhbXBCCAoGX2NoYWluQggK'
    'Bl9ub25jZQ==');

@$core.Deprecated('Use transactionKindDescriptor instead')
const TransactionKind$json = {
  '1': 'TransactionKind',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.TransactionKind.Kind',
      '9': 1,
      '10': 'kind',
      '17': true
    },
    {
      '1': 'programmable_transaction',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ProgrammableTransaction',
      '9': 0,
      '10': 'programmableTransaction'
    },
    {
      '1': 'change_epoch',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ChangeEpoch',
      '9': 0,
      '10': 'changeEpoch'
    },
    {
      '1': 'genesis',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.GenesisTransaction',
      '9': 0,
      '10': 'genesis'
    },
    {
      '1': 'consensus_commit_prologue',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ConsensusCommitPrologue',
      '9': 0,
      '10': 'consensusCommitPrologue'
    },
    {
      '1': 'authenticator_state_update',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.AuthenticatorStateUpdate',
      '9': 0,
      '10': 'authenticatorStateUpdate'
    },
    {
      '1': 'end_of_epoch',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.EndOfEpochTransaction',
      '9': 0,
      '10': 'endOfEpoch'
    },
    {
      '1': 'randomness_state_update',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.RandomnessStateUpdate',
      '9': 0,
      '10': 'randomnessStateUpdate'
    },
  ],
  '4': [TransactionKind_Kind$json],
  '8': [
    {'1': 'data'},
    {'1': '_kind'},
  ],
};

@$core.Deprecated('Use transactionKindDescriptor instead')
const TransactionKind_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'KIND_UNKNOWN', '2': 0},
    {'1': 'PROGRAMMABLE_TRANSACTION', '2': 1},
    {'1': 'CHANGE_EPOCH', '2': 2},
    {'1': 'GENESIS', '2': 3},
    {'1': 'CONSENSUS_COMMIT_PROLOGUE_V1', '2': 4},
    {'1': 'AUTHENTICATOR_STATE_UPDATE', '2': 5},
    {'1': 'END_OF_EPOCH', '2': 6},
    {'1': 'RANDOMNESS_STATE_UPDATE', '2': 7},
    {'1': 'CONSENSUS_COMMIT_PROLOGUE_V2', '2': 8},
    {'1': 'CONSENSUS_COMMIT_PROLOGUE_V3', '2': 9},
    {'1': 'CONSENSUS_COMMIT_PROLOGUE_V4', '2': 10},
    {'1': 'PROGRAMMABLE_SYSTEM_TRANSACTION', '2': 11},
  ],
};

/// Descriptor for `TransactionKind`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transactionKindDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2FjdGlvbktpbmQSOQoEa2luZBgBIAEoDjIgLnN1aS5ycGMudjIuVHJhbnNhY3Rpb2'
    '5LaW5kLktpbmRIAVIEa2luZIgBARJgChhwcm9ncmFtbWFibGVfdHJhbnNhY3Rpb24YAiABKAsy'
    'Iy5zdWkucnBjLnYyLlByb2dyYW1tYWJsZVRyYW5zYWN0aW9uSABSF3Byb2dyYW1tYWJsZVRyYW'
    '5zYWN0aW9uEjwKDGNoYW5nZV9lcG9jaBgDIAEoCzIXLnN1aS5ycGMudjIuQ2hhbmdlRXBvY2hI'
    'AFILY2hhbmdlRXBvY2gSOgoHZ2VuZXNpcxgEIAEoCzIeLnN1aS5ycGMudjIuR2VuZXNpc1RyYW'
    '5zYWN0aW9uSABSB2dlbmVzaXMSYQoZY29uc2Vuc3VzX2NvbW1pdF9wcm9sb2d1ZRgFIAEoCzIj'
    'LnN1aS5ycGMudjIuQ29uc2Vuc3VzQ29tbWl0UHJvbG9ndWVIAFIXY29uc2Vuc3VzQ29tbWl0UH'
    'JvbG9ndWUSZAoaYXV0aGVudGljYXRvcl9zdGF0ZV91cGRhdGUYBiABKAsyJC5zdWkucnBjLnYy'
    'LkF1dGhlbnRpY2F0b3JTdGF0ZVVwZGF0ZUgAUhhhdXRoZW50aWNhdG9yU3RhdGVVcGRhdGUSRQ'
    'oMZW5kX29mX2Vwb2NoGAcgASgLMiEuc3VpLnJwYy52Mi5FbmRPZkVwb2NoVHJhbnNhY3Rpb25I'
    'AFIKZW5kT2ZFcG9jaBJbChdyYW5kb21uZXNzX3N0YXRlX3VwZGF0ZRgIIAEoCzIhLnN1aS5ycG'
    'MudjIuUmFuZG9tbmVzc1N0YXRlVXBkYXRlSABSFXJhbmRvbW5lc3NTdGF0ZVVwZGF0ZSLRAgoE'
    'S2luZBIQCgxLSU5EX1VOS05PV04QABIcChhQUk9HUkFNTUFCTEVfVFJBTlNBQ1RJT04QARIQCg'
    'xDSEFOR0VfRVBPQ0gQAhILCgdHRU5FU0lTEAMSIAocQ09OU0VOU1VTX0NPTU1JVF9QUk9MT0dV'
    'RV9WMRAEEh4KGkFVVEhFTlRJQ0FUT1JfU1RBVEVfVVBEQVRFEAUSEAoMRU5EX09GX0VQT0NIEA'
    'YSGwoXUkFORE9NTkVTU19TVEFURV9VUERBVEUQBxIgChxDT05TRU5TVVNfQ09NTUlUX1BST0xP'
    'R1VFX1YyEAgSIAocQ09OU0VOU1VTX0NPTU1JVF9QUk9MT0dVRV9WMxAJEiAKHENPTlNFTlNVU1'
    '9DT01NSVRfUFJPTE9HVUVfVjQQChIjCh9QUk9HUkFNTUFCTEVfU1lTVEVNX1RSQU5TQUNUSU9O'
    'EAtCBgoEZGF0YUIHCgVfa2luZA==');

@$core.Deprecated('Use programmableTransactionDescriptor instead')
const ProgrammableTransaction$json = {
  '1': 'ProgrammableTransaction',
  '2': [
    {
      '1': 'inputs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Input',
      '10': 'inputs'
    },
    {
      '1': 'commands',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Command',
      '10': 'commands'
    },
  ],
};

/// Descriptor for `ProgrammableTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List programmableTransactionDescriptor = $convert.base64Decode(
    'ChdQcm9ncmFtbWFibGVUcmFuc2FjdGlvbhIpCgZpbnB1dHMYASADKAsyES5zdWkucnBjLnYyLk'
    'lucHV0UgZpbnB1dHMSLwoIY29tbWFuZHMYAiADKAsyEy5zdWkucnBjLnYyLkNvbW1hbmRSCGNv'
    'bW1hbmRz');

@$core.Deprecated('Use commandDescriptor instead')
const Command$json = {
  '1': 'Command',
  '2': [
    {
      '1': 'move_call',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveCall',
      '9': 0,
      '10': 'moveCall'
    },
    {
      '1': 'transfer_objects',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.TransferObjects',
      '9': 0,
      '10': 'transferObjects'
    },
    {
      '1': 'split_coins',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.SplitCoins',
      '9': 0,
      '10': 'splitCoins'
    },
    {
      '1': 'merge_coins',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MergeCoins',
      '9': 0,
      '10': 'mergeCoins'
    },
    {
      '1': 'publish',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Publish',
      '9': 0,
      '10': 'publish'
    },
    {
      '1': 'make_move_vector',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MakeMoveVector',
      '9': 0,
      '10': 'makeMoveVector'
    },
    {
      '1': 'upgrade',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Upgrade',
      '9': 0,
      '10': 'upgrade'
    },
  ],
  '8': [
    {'1': 'command'},
  ],
};

/// Descriptor for `Command`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandDescriptor = $convert.base64Decode(
    'CgdDb21tYW5kEjMKCW1vdmVfY2FsbBgBIAEoCzIULnN1aS5ycGMudjIuTW92ZUNhbGxIAFIIbW'
    '92ZUNhbGwSSAoQdHJhbnNmZXJfb2JqZWN0cxgCIAEoCzIbLnN1aS5ycGMudjIuVHJhbnNmZXJP'
    'YmplY3RzSABSD3RyYW5zZmVyT2JqZWN0cxI5CgtzcGxpdF9jb2lucxgDIAEoCzIWLnN1aS5ycG'
    'MudjIuU3BsaXRDb2luc0gAUgpzcGxpdENvaW5zEjkKC21lcmdlX2NvaW5zGAQgASgLMhYuc3Vp'
    'LnJwYy52Mi5NZXJnZUNvaW5zSABSCm1lcmdlQ29pbnMSLwoHcHVibGlzaBgFIAEoCzITLnN1aS'
    '5ycGMudjIuUHVibGlzaEgAUgdwdWJsaXNoEkYKEG1ha2VfbW92ZV92ZWN0b3IYBiABKAsyGi5z'
    'dWkucnBjLnYyLk1ha2VNb3ZlVmVjdG9ySABSDm1ha2VNb3ZlVmVjdG9yEi8KB3VwZ3JhZGUYBy'
    'ABKAsyEy5zdWkucnBjLnYyLlVwZ3JhZGVIAFIHdXBncmFkZUIJCgdjb21tYW5k');

@$core.Deprecated('Use moveCallDescriptor instead')
const MoveCall$json = {
  '1': 'MoveCall',
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
      '5': 9,
      '9': 2,
      '10': 'function',
      '17': true
    },
    {'1': 'type_arguments', '3': 4, '4': 3, '5': 9, '10': 'typeArguments'},
    {
      '1': 'arguments',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Argument',
      '10': 'arguments'
    },
  ],
  '8': [
    {'1': '_package'},
    {'1': '_module'},
    {'1': '_function'},
  ],
};

/// Descriptor for `MoveCall`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List moveCallDescriptor = $convert.base64Decode(
    'CghNb3ZlQ2FsbBIdCgdwYWNrYWdlGAEgASgJSABSB3BhY2thZ2WIAQESGwoGbW9kdWxlGAIgAS'
    'gJSAFSBm1vZHVsZYgBARIfCghmdW5jdGlvbhgDIAEoCUgCUghmdW5jdGlvbogBARIlCg50eXBl'
    'X2FyZ3VtZW50cxgEIAMoCVINdHlwZUFyZ3VtZW50cxIyCglhcmd1bWVudHMYBSADKAsyFC5zdW'
    'kucnBjLnYyLkFyZ3VtZW50Uglhcmd1bWVudHNCCgoIX3BhY2thZ2VCCQoHX21vZHVsZUILCglf'
    'ZnVuY3Rpb24=');

@$core.Deprecated('Use transferObjectsDescriptor instead')
const TransferObjects$json = {
  '1': 'TransferObjects',
  '2': [
    {
      '1': 'objects',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Argument',
      '10': 'objects'
    },
    {
      '1': 'address',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Argument',
      '9': 0,
      '10': 'address',
      '17': true
    },
  ],
  '8': [
    {'1': '_address'},
  ],
};

/// Descriptor for `TransferObjects`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List transferObjectsDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2Zlck9iamVjdHMSLgoHb2JqZWN0cxgBIAMoCzIULnN1aS5ycGMudjIuQXJndW1lbn'
    'RSB29iamVjdHMSMwoHYWRkcmVzcxgCIAEoCzIULnN1aS5ycGMudjIuQXJndW1lbnRIAFIHYWRk'
    'cmVzc4gBAUIKCghfYWRkcmVzcw==');

@$core.Deprecated('Use splitCoinsDescriptor instead')
const SplitCoins$json = {
  '1': 'SplitCoins',
  '2': [
    {
      '1': 'coin',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Argument',
      '9': 0,
      '10': 'coin',
      '17': true
    },
    {
      '1': 'amounts',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Argument',
      '10': 'amounts'
    },
  ],
  '8': [
    {'1': '_coin'},
  ],
};

/// Descriptor for `SplitCoins`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List splitCoinsDescriptor = $convert.base64Decode(
    'CgpTcGxpdENvaW5zEi0KBGNvaW4YASABKAsyFC5zdWkucnBjLnYyLkFyZ3VtZW50SABSBGNvaW'
    '6IAQESLgoHYW1vdW50cxgCIAMoCzIULnN1aS5ycGMudjIuQXJndW1lbnRSB2Ftb3VudHNCBwoF'
    'X2NvaW4=');

@$core.Deprecated('Use mergeCoinsDescriptor instead')
const MergeCoins$json = {
  '1': 'MergeCoins',
  '2': [
    {
      '1': 'coin',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Argument',
      '9': 0,
      '10': 'coin',
      '17': true
    },
    {
      '1': 'coins_to_merge',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Argument',
      '10': 'coinsToMerge'
    },
  ],
  '8': [
    {'1': '_coin'},
  ],
};

/// Descriptor for `MergeCoins`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mergeCoinsDescriptor = $convert.base64Decode(
    'CgpNZXJnZUNvaW5zEi0KBGNvaW4YASABKAsyFC5zdWkucnBjLnYyLkFyZ3VtZW50SABSBGNvaW'
    '6IAQESOgoOY29pbnNfdG9fbWVyZ2UYAiADKAsyFC5zdWkucnBjLnYyLkFyZ3VtZW50Ugxjb2lu'
    'c1RvTWVyZ2VCBwoFX2NvaW4=');

@$core.Deprecated('Use publishDescriptor instead')
const Publish$json = {
  '1': 'Publish',
  '2': [
    {'1': 'modules', '3': 1, '4': 3, '5': 12, '10': 'modules'},
    {'1': 'dependencies', '3': 2, '4': 3, '5': 9, '10': 'dependencies'},
  ],
};

/// Descriptor for `Publish`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publishDescriptor = $convert.base64Decode(
    'CgdQdWJsaXNoEhgKB21vZHVsZXMYASADKAxSB21vZHVsZXMSIgoMZGVwZW5kZW5jaWVzGAIgAy'
    'gJUgxkZXBlbmRlbmNpZXM=');

@$core.Deprecated('Use makeMoveVectorDescriptor instead')
const MakeMoveVector$json = {
  '1': 'MakeMoveVector',
  '2': [
    {
      '1': 'element_type',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'elementType',
      '17': true
    },
    {
      '1': 'elements',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Argument',
      '10': 'elements'
    },
  ],
  '8': [
    {'1': '_element_type'},
  ],
};

/// Descriptor for `MakeMoveVector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List makeMoveVectorDescriptor = $convert.base64Decode(
    'Cg5NYWtlTW92ZVZlY3RvchImCgxlbGVtZW50X3R5cGUYASABKAlIAFILZWxlbWVudFR5cGWIAQ'
    'ESMAoIZWxlbWVudHMYAiADKAsyFC5zdWkucnBjLnYyLkFyZ3VtZW50UghlbGVtZW50c0IPCg1f'
    'ZWxlbWVudF90eXBl');

@$core.Deprecated('Use upgradeDescriptor instead')
const Upgrade$json = {
  '1': 'Upgrade',
  '2': [
    {'1': 'modules', '3': 1, '4': 3, '5': 12, '10': 'modules'},
    {'1': 'dependencies', '3': 2, '4': 3, '5': 9, '10': 'dependencies'},
    {
      '1': 'package',
      '3': 3,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'package',
      '17': true
    },
    {
      '1': 'ticket',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Argument',
      '9': 1,
      '10': 'ticket',
      '17': true
    },
  ],
  '8': [
    {'1': '_package'},
    {'1': '_ticket'},
  ],
};

/// Descriptor for `Upgrade`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upgradeDescriptor = $convert.base64Decode(
    'CgdVcGdyYWRlEhgKB21vZHVsZXMYASADKAxSB21vZHVsZXMSIgoMZGVwZW5kZW5jaWVzGAIgAy'
    'gJUgxkZXBlbmRlbmNpZXMSHQoHcGFja2FnZRgDIAEoCUgAUgdwYWNrYWdliAEBEjEKBnRpY2tl'
    'dBgEIAEoCzIULnN1aS5ycGMudjIuQXJndW1lbnRIAVIGdGlja2V0iAEBQgoKCF9wYWNrYWdlQg'
    'kKB190aWNrZXQ=');

@$core.Deprecated('Use randomnessStateUpdateDescriptor instead')
const RandomnessStateUpdate$json = {
  '1': 'RandomnessStateUpdate',
  '2': [
    {'1': 'epoch', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'epoch', '17': true},
    {
      '1': 'randomness_round',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'randomnessRound',
      '17': true
    },
    {
      '1': 'random_bytes',
      '3': 3,
      '4': 1,
      '5': 12,
      '9': 2,
      '10': 'randomBytes',
      '17': true
    },
    {
      '1': 'randomness_object_initial_shared_version',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'randomnessObjectInitialSharedVersion',
      '17': true
    },
  ],
  '8': [
    {'1': '_epoch'},
    {'1': '_randomness_round'},
    {'1': '_random_bytes'},
    {'1': '_randomness_object_initial_shared_version'},
  ],
};

/// Descriptor for `RandomnessStateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List randomnessStateUpdateDescriptor = $convert.base64Decode(
    'ChVSYW5kb21uZXNzU3RhdGVVcGRhdGUSGQoFZXBvY2gYASABKARIAFIFZXBvY2iIAQESLgoQcm'
    'FuZG9tbmVzc19yb3VuZBgCIAEoBEgBUg9yYW5kb21uZXNzUm91bmSIAQESJgoMcmFuZG9tX2J5'
    'dGVzGAMgASgMSAJSC3JhbmRvbUJ5dGVziAEBElsKKHJhbmRvbW5lc3Nfb2JqZWN0X2luaXRpYW'
    'xfc2hhcmVkX3ZlcnNpb24YBCABKARIA1IkcmFuZG9tbmVzc09iamVjdEluaXRpYWxTaGFyZWRW'
    'ZXJzaW9uiAEBQggKBl9lcG9jaEITChFfcmFuZG9tbmVzc19yb3VuZEIPCg1fcmFuZG9tX2J5dG'
    'VzQisKKV9yYW5kb21uZXNzX29iamVjdF9pbml0aWFsX3NoYXJlZF92ZXJzaW9u');

@$core.Deprecated('Use changeEpochDescriptor instead')
const ChangeEpoch$json = {
  '1': 'ChangeEpoch',
  '2': [
    {'1': 'epoch', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'epoch', '17': true},
    {
      '1': 'protocol_version',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'protocolVersion',
      '17': true
    },
    {
      '1': 'storage_charge',
      '3': 3,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'storageCharge',
      '17': true
    },
    {
      '1': 'computation_charge',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 3,
      '10': 'computationCharge',
      '17': true
    },
    {
      '1': 'storage_rebate',
      '3': 5,
      '4': 1,
      '5': 4,
      '9': 4,
      '10': 'storageRebate',
      '17': true
    },
    {
      '1': 'non_refundable_storage_fee',
      '3': 6,
      '4': 1,
      '5': 4,
      '9': 5,
      '10': 'nonRefundableStorageFee',
      '17': true
    },
    {
      '1': 'epoch_start_timestamp',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 6,
      '10': 'epochStartTimestamp',
      '17': true
    },
    {
      '1': 'system_packages',
      '3': 8,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.SystemPackage',
      '10': 'systemPackages'
    },
  ],
  '8': [
    {'1': '_epoch'},
    {'1': '_protocol_version'},
    {'1': '_storage_charge'},
    {'1': '_computation_charge'},
    {'1': '_storage_rebate'},
    {'1': '_non_refundable_storage_fee'},
    {'1': '_epoch_start_timestamp'},
  ],
};

/// Descriptor for `ChangeEpoch`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List changeEpochDescriptor = $convert.base64Decode(
    'CgtDaGFuZ2VFcG9jaBIZCgVlcG9jaBgBIAEoBEgAUgVlcG9jaIgBARIuChBwcm90b2NvbF92ZX'
    'JzaW9uGAIgASgESAFSD3Byb3RvY29sVmVyc2lvbogBARIqCg5zdG9yYWdlX2NoYXJnZRgDIAEo'
    'BEgCUg1zdG9yYWdlQ2hhcmdliAEBEjIKEmNvbXB1dGF0aW9uX2NoYXJnZRgEIAEoBEgDUhFjb2'
    '1wdXRhdGlvbkNoYXJnZYgBARIqCg5zdG9yYWdlX3JlYmF0ZRgFIAEoBEgEUg1zdG9yYWdlUmVi'
    'YXRliAEBEkAKGm5vbl9yZWZ1bmRhYmxlX3N0b3JhZ2VfZmVlGAYgASgESAVSF25vblJlZnVuZG'
    'FibGVTdG9yYWdlRmVliAEBElMKFWVwb2NoX3N0YXJ0X3RpbWVzdGFtcBgHIAEoCzIaLmdvb2ds'
    'ZS5wcm90b2J1Zi5UaW1lc3RhbXBIBlITZXBvY2hTdGFydFRpbWVzdGFtcIgBARJCCg9zeXN0ZW'
    '1fcGFja2FnZXMYCCADKAsyGS5zdWkucnBjLnYyLlN5c3RlbVBhY2thZ2VSDnN5c3RlbVBhY2th'
    'Z2VzQggKBl9lcG9jaEITChFfcHJvdG9jb2xfdmVyc2lvbkIRCg9fc3RvcmFnZV9jaGFyZ2VCFQ'
    'oTX2NvbXB1dGF0aW9uX2NoYXJnZUIRCg9fc3RvcmFnZV9yZWJhdGVCHQobX25vbl9yZWZ1bmRh'
    'YmxlX3N0b3JhZ2VfZmVlQhgKFl9lcG9jaF9zdGFydF90aW1lc3RhbXA=');

@$core.Deprecated('Use systemPackageDescriptor instead')
const SystemPackage$json = {
  '1': 'SystemPackage',
  '2': [
    {
      '1': 'version',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'version',
      '17': true
    },
    {'1': 'modules', '3': 2, '4': 3, '5': 12, '10': 'modules'},
    {'1': 'dependencies', '3': 3, '4': 3, '5': 9, '10': 'dependencies'},
  ],
  '8': [
    {'1': '_version'},
  ],
};

/// Descriptor for `SystemPackage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List systemPackageDescriptor = $convert.base64Decode(
    'Cg1TeXN0ZW1QYWNrYWdlEh0KB3ZlcnNpb24YASABKARIAFIHdmVyc2lvbogBARIYCgdtb2R1bG'
    'VzGAIgAygMUgdtb2R1bGVzEiIKDGRlcGVuZGVuY2llcxgDIAMoCVIMZGVwZW5kZW5jaWVzQgoK'
    'CF92ZXJzaW9u');

@$core.Deprecated('Use genesisTransactionDescriptor instead')
const GenesisTransaction$json = {
  '1': 'GenesisTransaction',
  '2': [
    {
      '1': 'objects',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.Object',
      '10': 'objects'
    },
  ],
};

/// Descriptor for `GenesisTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List genesisTransactionDescriptor = $convert.base64Decode(
    'ChJHZW5lc2lzVHJhbnNhY3Rpb24SLAoHb2JqZWN0cxgBIAMoCzISLnN1aS5ycGMudjIuT2JqZW'
    'N0UgdvYmplY3Rz');

@$core.Deprecated('Use consensusCommitPrologueDescriptor instead')
const ConsensusCommitPrologue$json = {
  '1': 'ConsensusCommitPrologue',
  '2': [
    {'1': 'epoch', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'epoch', '17': true},
    {'1': 'round', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'round', '17': true},
    {
      '1': 'commit_timestamp',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '9': 2,
      '10': 'commitTimestamp',
      '17': true
    },
    {
      '1': 'consensus_commit_digest',
      '3': 4,
      '4': 1,
      '5': 9,
      '9': 3,
      '10': 'consensusCommitDigest',
      '17': true
    },
    {
      '1': 'sub_dag_index',
      '3': 5,
      '4': 1,
      '5': 4,
      '9': 4,
      '10': 'subDagIndex',
      '17': true
    },
    {
      '1': 'consensus_determined_version_assignments',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ConsensusDeterminedVersionAssignments',
      '9': 5,
      '10': 'consensusDeterminedVersionAssignments',
      '17': true
    },
    {
      '1': 'additional_state_digest',
      '3': 7,
      '4': 1,
      '5': 9,
      '9': 6,
      '10': 'additionalStateDigest',
      '17': true
    },
  ],
  '8': [
    {'1': '_epoch'},
    {'1': '_round'},
    {'1': '_commit_timestamp'},
    {'1': '_consensus_commit_digest'},
    {'1': '_sub_dag_index'},
    {'1': '_consensus_determined_version_assignments'},
    {'1': '_additional_state_digest'},
  ],
};

/// Descriptor for `ConsensusCommitPrologue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List consensusCommitPrologueDescriptor = $convert.base64Decode(
    'ChdDb25zZW5zdXNDb21taXRQcm9sb2d1ZRIZCgVlcG9jaBgBIAEoBEgAUgVlcG9jaIgBARIZCg'
    'Vyb3VuZBgCIAEoBEgBUgVyb3VuZIgBARJKChBjb21taXRfdGltZXN0YW1wGAMgASgLMhouZ29v'
    'Z2xlLnByb3RvYnVmLlRpbWVzdGFtcEgCUg9jb21taXRUaW1lc3RhbXCIAQESOwoXY29uc2Vuc3'
    'VzX2NvbW1pdF9kaWdlc3QYBCABKAlIA1IVY29uc2Vuc3VzQ29tbWl0RGlnZXN0iAEBEicKDXN1'
    'Yl9kYWdfaW5kZXgYBSABKARIBFILc3ViRGFnSW5kZXiIAQESjwEKKGNvbnNlbnN1c19kZXRlcm'
    '1pbmVkX3ZlcnNpb25fYXNzaWdubWVudHMYBiABKAsyMS5zdWkucnBjLnYyLkNvbnNlbnN1c0Rl'
    'dGVybWluZWRWZXJzaW9uQXNzaWdubWVudHNIBVIlY29uc2Vuc3VzRGV0ZXJtaW5lZFZlcnNpb2'
    '5Bc3NpZ25tZW50c4gBARI7ChdhZGRpdGlvbmFsX3N0YXRlX2RpZ2VzdBgHIAEoCUgGUhVhZGRp'
    'dGlvbmFsU3RhdGVEaWdlc3SIAQFCCAoGX2Vwb2NoQggKBl9yb3VuZEITChFfY29tbWl0X3RpbW'
    'VzdGFtcEIaChhfY29uc2Vuc3VzX2NvbW1pdF9kaWdlc3RCEAoOX3N1Yl9kYWdfaW5kZXhCKwop'
    'X2NvbnNlbnN1c19kZXRlcm1pbmVkX3ZlcnNpb25fYXNzaWdubWVudHNCGgoYX2FkZGl0aW9uYW'
    'xfc3RhdGVfZGlnZXN0');

@$core.Deprecated('Use versionAssignmentDescriptor instead')
const VersionAssignment$json = {
  '1': 'VersionAssignment',
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
      '1': 'start_version',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'startVersion',
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
  ],
  '8': [
    {'1': '_object_id'},
    {'1': '_start_version'},
    {'1': '_version'},
  ],
};

/// Descriptor for `VersionAssignment`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List versionAssignmentDescriptor = $convert.base64Decode(
    'ChFWZXJzaW9uQXNzaWdubWVudBIgCglvYmplY3RfaWQYASABKAlIAFIIb2JqZWN0SWSIAQESKA'
    'oNc3RhcnRfdmVyc2lvbhgCIAEoBEgBUgxzdGFydFZlcnNpb26IAQESHQoHdmVyc2lvbhgDIAEo'
    'BEgCUgd2ZXJzaW9uiAEBQgwKCl9vYmplY3RfaWRCEAoOX3N0YXJ0X3ZlcnNpb25CCgoIX3Zlcn'
    'Npb24=');

@$core.Deprecated('Use canceledTransactionDescriptor instead')
const CanceledTransaction$json = {
  '1': 'CanceledTransaction',
  '2': [
    {'1': 'digest', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'digest', '17': true},
    {
      '1': 'version_assignments',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.VersionAssignment',
      '10': 'versionAssignments'
    },
  ],
  '8': [
    {'1': '_digest'},
  ],
};

/// Descriptor for `CanceledTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List canceledTransactionDescriptor = $convert.base64Decode(
    'ChNDYW5jZWxlZFRyYW5zYWN0aW9uEhsKBmRpZ2VzdBgBIAEoCUgAUgZkaWdlc3SIAQESTgoTdm'
    'Vyc2lvbl9hc3NpZ25tZW50cxgCIAMoCzIdLnN1aS5ycGMudjIuVmVyc2lvbkFzc2lnbm1lbnRS'
    'EnZlcnNpb25Bc3NpZ25tZW50c0IJCgdfZGlnZXN0');

@$core.Deprecated('Use consensusDeterminedVersionAssignmentsDescriptor instead')
const ConsensusDeterminedVersionAssignments$json = {
  '1': 'ConsensusDeterminedVersionAssignments',
  '2': [
    {
      '1': 'version',
      '3': 1,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'version',
      '17': true
    },
    {
      '1': 'canceled_transactions',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.CanceledTransaction',
      '10': 'canceledTransactions'
    },
  ],
  '8': [
    {'1': '_version'},
  ],
};

/// Descriptor for `ConsensusDeterminedVersionAssignments`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List consensusDeterminedVersionAssignmentsDescriptor =
    $convert.base64Decode(
        'CiVDb25zZW5zdXNEZXRlcm1pbmVkVmVyc2lvbkFzc2lnbm1lbnRzEh0KB3ZlcnNpb24YASABKA'
        'VIAFIHdmVyc2lvbogBARJUChVjYW5jZWxlZF90cmFuc2FjdGlvbnMYAyADKAsyHy5zdWkucnBj'
        'LnYyLkNhbmNlbGVkVHJhbnNhY3Rpb25SFGNhbmNlbGVkVHJhbnNhY3Rpb25zQgoKCF92ZXJzaW'
        '9u');

@$core.Deprecated('Use authenticatorStateUpdateDescriptor instead')
const AuthenticatorStateUpdate$json = {
  '1': 'AuthenticatorStateUpdate',
  '2': [
    {'1': 'epoch', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'epoch', '17': true},
    {'1': 'round', '3': 2, '4': 1, '5': 4, '9': 1, '10': 'round', '17': true},
    {
      '1': 'new_active_jwks',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ActiveJwk',
      '10': 'newActiveJwks'
    },
    {
      '1': 'authenticator_object_initial_shared_version',
      '3': 4,
      '4': 1,
      '5': 4,
      '9': 2,
      '10': 'authenticatorObjectInitialSharedVersion',
      '17': true
    },
  ],
  '8': [
    {'1': '_epoch'},
    {'1': '_round'},
    {'1': '_authenticator_object_initial_shared_version'},
  ],
};

/// Descriptor for `AuthenticatorStateUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authenticatorStateUpdateDescriptor = $convert.base64Decode(
    'ChhBdXRoZW50aWNhdG9yU3RhdGVVcGRhdGUSGQoFZXBvY2gYASABKARIAFIFZXBvY2iIAQESGQ'
    'oFcm91bmQYAiABKARIAVIFcm91bmSIAQESPQoPbmV3X2FjdGl2ZV9qd2tzGAMgAygLMhUuc3Vp'
    'LnJwYy52Mi5BY3RpdmVKd2tSDW5ld0FjdGl2ZUp3a3MSYQorYXV0aGVudGljYXRvcl9vYmplY3'
    'RfaW5pdGlhbF9zaGFyZWRfdmVyc2lvbhgEIAEoBEgCUidhdXRoZW50aWNhdG9yT2JqZWN0SW5p'
    'dGlhbFNoYXJlZFZlcnNpb26IAQFCCAoGX2Vwb2NoQggKBl9yb3VuZEIuCixfYXV0aGVudGljYX'
    'Rvcl9vYmplY3RfaW5pdGlhbF9zaGFyZWRfdmVyc2lvbg==');

@$core.Deprecated('Use activeJwkDescriptor instead')
const ActiveJwk$json = {
  '1': 'ActiveJwk',
  '2': [
    {
      '1': 'id',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.JwkId',
      '9': 0,
      '10': 'id',
      '17': true
    },
    {
      '1': 'jwk',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Jwk',
      '9': 1,
      '10': 'jwk',
      '17': true
    },
    {'1': 'epoch', '3': 3, '4': 1, '5': 4, '9': 2, '10': 'epoch', '17': true},
  ],
  '8': [
    {'1': '_id'},
    {'1': '_jwk'},
    {'1': '_epoch'},
  ],
};

/// Descriptor for `ActiveJwk`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List activeJwkDescriptor = $convert.base64Decode(
    'CglBY3RpdmVKd2sSJgoCaWQYASABKAsyES5zdWkucnBjLnYyLkp3a0lkSABSAmlkiAEBEiYKA2'
    'p3axgCIAEoCzIPLnN1aS5ycGMudjIuSndrSAFSA2p3a4gBARIZCgVlcG9jaBgDIAEoBEgCUgVl'
    'cG9jaIgBAUIFCgNfaWRCBgoEX2p3a0IICgZfZXBvY2g=');

@$core.Deprecated('Use endOfEpochTransactionDescriptor instead')
const EndOfEpochTransaction$json = {
  '1': 'EndOfEpochTransaction',
  '2': [
    {
      '1': 'transactions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.EndOfEpochTransactionKind',
      '10': 'transactions'
    },
  ],
};

/// Descriptor for `EndOfEpochTransaction`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endOfEpochTransactionDescriptor = $convert.base64Decode(
    'ChVFbmRPZkVwb2NoVHJhbnNhY3Rpb24SSQoMdHJhbnNhY3Rpb25zGAEgAygLMiUuc3VpLnJwYy'
    '52Mi5FbmRPZkVwb2NoVHJhbnNhY3Rpb25LaW5kUgx0cmFuc2FjdGlvbnM=');

@$core.Deprecated('Use endOfEpochTransactionKindDescriptor instead')
const EndOfEpochTransactionKind$json = {
  '1': 'EndOfEpochTransactionKind',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.EndOfEpochTransactionKind.Kind',
      '9': 1,
      '10': 'kind',
      '17': true
    },
    {
      '1': 'change_epoch',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ChangeEpoch',
      '9': 0,
      '10': 'changeEpoch'
    },
    {
      '1': 'authenticator_state_expire',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.AuthenticatorStateExpire',
      '9': 0,
      '10': 'authenticatorStateExpire'
    },
    {
      '1': 'execution_time_observations',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ExecutionTimeObservations',
      '9': 0,
      '10': 'executionTimeObservations'
    },
    {
      '1': 'bridge_chain_id',
      '3': 5,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'bridgeChainId'
    },
    {
      '1': 'bridge_object_version',
      '3': 6,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'bridgeObjectVersion'
    },
    {'1': 'storage_cost', '3': 7, '4': 1, '5': 4, '9': 0, '10': 'storageCost'},
  ],
  '4': [EndOfEpochTransactionKind_Kind$json],
  '8': [
    {'1': 'data'},
    {'1': '_kind'},
  ],
};

@$core.Deprecated('Use endOfEpochTransactionKindDescriptor instead')
const EndOfEpochTransactionKind_Kind$json = {
  '1': 'Kind',
  '2': [
    {'1': 'KIND_UNKNOWN', '2': 0},
    {'1': 'CHANGE_EPOCH', '2': 1},
    {'1': 'AUTHENTICATOR_STATE_CREATE', '2': 2},
    {'1': 'AUTHENTICATOR_STATE_EXPIRE', '2': 3},
    {'1': 'RANDOMNESS_STATE_CREATE', '2': 4},
    {'1': 'DENY_LIST_STATE_CREATE', '2': 5},
    {'1': 'BRIDGE_STATE_CREATE', '2': 6},
    {'1': 'BRIDGE_COMMITTEE_INIT', '2': 7},
    {'1': 'STORE_EXECUTION_TIME_OBSERVATIONS', '2': 8},
    {'1': 'ACCUMULATOR_ROOT_CREATE', '2': 9},
    {'1': 'COIN_REGISTRY_CREATE', '2': 10},
    {'1': 'DISPLAY_REGISTRY_CREATE', '2': 11},
    {'1': 'ADDRESS_ALIAS_STATE_CREATE', '2': 12},
    {'1': 'WRITE_ACCUMULATOR_STORAGE_COST', '2': 13},
  ],
};

/// Descriptor for `EndOfEpochTransactionKind`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endOfEpochTransactionKindDescriptor = $convert.base64Decode(
    'ChlFbmRPZkVwb2NoVHJhbnNhY3Rpb25LaW5kEkMKBGtpbmQYASABKA4yKi5zdWkucnBjLnYyLk'
    'VuZE9mRXBvY2hUcmFuc2FjdGlvbktpbmQuS2luZEgBUgRraW5kiAEBEjwKDGNoYW5nZV9lcG9j'
    'aBgCIAEoCzIXLnN1aS5ycGMudjIuQ2hhbmdlRXBvY2hIAFILY2hhbmdlRXBvY2gSZAoaYXV0aG'
    'VudGljYXRvcl9zdGF0ZV9leHBpcmUYAyABKAsyJC5zdWkucnBjLnYyLkF1dGhlbnRpY2F0b3JT'
    'dGF0ZUV4cGlyZUgAUhhhdXRoZW50aWNhdG9yU3RhdGVFeHBpcmUSZwobZXhlY3V0aW9uX3RpbW'
    'Vfb2JzZXJ2YXRpb25zGAQgASgLMiUuc3VpLnJwYy52Mi5FeGVjdXRpb25UaW1lT2JzZXJ2YXRp'
    'b25zSABSGWV4ZWN1dGlvblRpbWVPYnNlcnZhdGlvbnMSKAoPYnJpZGdlX2NoYWluX2lkGAUgAS'
    'gJSABSDWJyaWRnZUNoYWluSWQSNAoVYnJpZGdlX29iamVjdF92ZXJzaW9uGAYgASgESABSE2Jy'
    'aWRnZU9iamVjdFZlcnNpb24SIwoMc3RvcmFnZV9jb3N0GAcgASgESABSC3N0b3JhZ2VDb3N0Ip'
    'YDCgRLaW5kEhAKDEtJTkRfVU5LTk9XThAAEhAKDENIQU5HRV9FUE9DSBABEh4KGkFVVEhFTlRJ'
    'Q0FUT1JfU1RBVEVfQ1JFQVRFEAISHgoaQVVUSEVOVElDQVRPUl9TVEFURV9FWFBJUkUQAxIbCh'
    'dSQU5ET01ORVNTX1NUQVRFX0NSRUFURRAEEhoKFkRFTllfTElTVF9TVEFURV9DUkVBVEUQBRIX'
    'ChNCUklER0VfU1RBVEVfQ1JFQVRFEAYSGQoVQlJJREdFX0NPTU1JVFRFRV9JTklUEAcSJQohU1'
    'RPUkVfRVhFQ1VUSU9OX1RJTUVfT0JTRVJWQVRJT05TEAgSGwoXQUNDVU1VTEFUT1JfUk9PVF9D'
    'UkVBVEUQCRIYChRDT0lOX1JFR0lTVFJZX0NSRUFURRAKEhsKF0RJU1BMQVlfUkVHSVNUUllfQ1'
    'JFQVRFEAsSHgoaQUREUkVTU19BTElBU19TVEFURV9DUkVBVEUQDBIiCh5XUklURV9BQ0NVTVVM'
    'QVRPUl9TVE9SQUdFX0NPU1QQDUIGCgRkYXRhQgcKBV9raW5k');

@$core.Deprecated('Use authenticatorStateExpireDescriptor instead')
const AuthenticatorStateExpire$json = {
  '1': 'AuthenticatorStateExpire',
  '2': [
    {
      '1': 'min_epoch',
      '3': 1,
      '4': 1,
      '5': 4,
      '9': 0,
      '10': 'minEpoch',
      '17': true
    },
    {
      '1': 'authenticator_object_initial_shared_version',
      '3': 2,
      '4': 1,
      '5': 4,
      '9': 1,
      '10': 'authenticatorObjectInitialSharedVersion',
      '17': true
    },
  ],
  '8': [
    {'1': '_min_epoch'},
    {'1': '_authenticator_object_initial_shared_version'},
  ],
};

/// Descriptor for `AuthenticatorStateExpire`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authenticatorStateExpireDescriptor = $convert.base64Decode(
    'ChhBdXRoZW50aWNhdG9yU3RhdGVFeHBpcmUSIAoJbWluX2Vwb2NoGAEgASgESABSCG1pbkVwb2'
    'NoiAEBEmEKK2F1dGhlbnRpY2F0b3Jfb2JqZWN0X2luaXRpYWxfc2hhcmVkX3ZlcnNpb24YAiAB'
    'KARIAVInYXV0aGVudGljYXRvck9iamVjdEluaXRpYWxTaGFyZWRWZXJzaW9uiAEBQgwKCl9taW'
    '5fZXBvY2hCLgosX2F1dGhlbnRpY2F0b3Jfb2JqZWN0X2luaXRpYWxfc2hhcmVkX3ZlcnNpb24=');

@$core.Deprecated('Use executionTimeObservationsDescriptor instead')
const ExecutionTimeObservations$json = {
  '1': 'ExecutionTimeObservations',
  '2': [
    {
      '1': 'version',
      '3': 1,
      '4': 1,
      '5': 5,
      '9': 0,
      '10': 'version',
      '17': true
    },
    {
      '1': 'observations',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ExecutionTimeObservation',
      '10': 'observations'
    },
  ],
  '8': [
    {'1': '_version'},
  ],
};

/// Descriptor for `ExecutionTimeObservations`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executionTimeObservationsDescriptor = $convert.base64Decode(
    'ChlFeGVjdXRpb25UaW1lT2JzZXJ2YXRpb25zEh0KB3ZlcnNpb24YASABKAVIAFIHdmVyc2lvbo'
    'gBARJICgxvYnNlcnZhdGlvbnMYAiADKAsyJC5zdWkucnBjLnYyLkV4ZWN1dGlvblRpbWVPYnNl'
    'cnZhdGlvblIMb2JzZXJ2YXRpb25zQgoKCF92ZXJzaW9u');

@$core.Deprecated('Use executionTimeObservationDescriptor instead')
const ExecutionTimeObservation$json = {
  '1': 'ExecutionTimeObservation',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.sui.rpc.v2.ExecutionTimeObservation.ExecutionTimeObservationKind',
      '9': 0,
      '10': 'kind',
      '17': true
    },
    {
      '1': 'move_entry_point',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.MoveCall',
      '9': 1,
      '10': 'moveEntryPoint',
      '17': true
    },
    {
      '1': 'validator_observations',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.sui.rpc.v2.ValidatorExecutionTimeObservation',
      '10': 'validatorObservations'
    },
  ],
  '4': [ExecutionTimeObservation_ExecutionTimeObservationKind$json],
  '8': [
    {'1': '_kind'},
    {'1': '_move_entry_point'},
  ],
};

@$core.Deprecated('Use executionTimeObservationDescriptor instead')
const ExecutionTimeObservation_ExecutionTimeObservationKind$json = {
  '1': 'ExecutionTimeObservationKind',
  '2': [
    {'1': 'EXECUTION_TIME_OBSERVATION_KIND_UNKNOWN', '2': 0},
    {'1': 'MOVE_ENTRY_POINT', '2': 1},
    {'1': 'TRANSFER_OBJECTS', '2': 2},
    {'1': 'SPLIT_COINS', '2': 3},
    {'1': 'MERGE_COINS', '2': 4},
    {'1': 'PUBLISH', '2': 5},
    {'1': 'MAKE_MOVE_VECTOR', '2': 6},
    {'1': 'UPGRADE', '2': 7},
  ],
};

/// Descriptor for `ExecutionTimeObservation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executionTimeObservationDescriptor = $convert.base64Decode(
    'ChhFeGVjdXRpb25UaW1lT2JzZXJ2YXRpb24SWgoEa2luZBgBIAEoDjJBLnN1aS5ycGMudjIuRX'
    'hlY3V0aW9uVGltZU9ic2VydmF0aW9uLkV4ZWN1dGlvblRpbWVPYnNlcnZhdGlvbktpbmRIAFIE'
    'a2luZIgBARJDChBtb3ZlX2VudHJ5X3BvaW50GAIgASgLMhQuc3VpLnJwYy52Mi5Nb3ZlQ2FsbE'
    'gBUg5tb3ZlRW50cnlQb2ludIgBARJkChZ2YWxpZGF0b3Jfb2JzZXJ2YXRpb25zGAMgAygLMi0u'
    'c3VpLnJwYy52Mi5WYWxpZGF0b3JFeGVjdXRpb25UaW1lT2JzZXJ2YXRpb25SFXZhbGlkYXRvck'
    '9ic2VydmF0aW9ucyLJAQocRXhlY3V0aW9uVGltZU9ic2VydmF0aW9uS2luZBIrCidFWEVDVVRJ'
    'T05fVElNRV9PQlNFUlZBVElPTl9LSU5EX1VOS05PV04QABIUChBNT1ZFX0VOVFJZX1BPSU5UEA'
    'ESFAoQVFJBTlNGRVJfT0JKRUNUUxACEg8KC1NQTElUX0NPSU5TEAMSDwoLTUVSR0VfQ09JTlMQ'
    'BBILCgdQVUJMSVNIEAUSFAoQTUFLRV9NT1ZFX1ZFQ1RPUhAGEgsKB1VQR1JBREUQB0IHCgVfa2'
    'luZEITChFfbW92ZV9lbnRyeV9wb2ludA==');

@$core.Deprecated('Use validatorExecutionTimeObservationDescriptor instead')
const ValidatorExecutionTimeObservation$json = {
  '1': 'ValidatorExecutionTimeObservation',
  '2': [
    {
      '1': 'validator',
      '3': 1,
      '4': 1,
      '5': 12,
      '9': 0,
      '10': 'validator',
      '17': true
    },
    {
      '1': 'duration',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Duration',
      '9': 1,
      '10': 'duration',
      '17': true
    },
  ],
  '8': [
    {'1': '_validator'},
    {'1': '_duration'},
  ],
};

/// Descriptor for `ValidatorExecutionTimeObservation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List validatorExecutionTimeObservationDescriptor =
    $convert.base64Decode(
        'CiFWYWxpZGF0b3JFeGVjdXRpb25UaW1lT2JzZXJ2YXRpb24SIQoJdmFsaWRhdG9yGAEgASgMSA'
        'BSCXZhbGlkYXRvcogBARI6CghkdXJhdGlvbhgCIAEoCzIZLmdvb2dsZS5wcm90b2J1Zi5EdXJh'
        'dGlvbkgBUghkdXJhdGlvbogBAUIMCgpfdmFsaWRhdG9yQgsKCV9kdXJhdGlvbg==');
