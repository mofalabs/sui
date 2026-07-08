// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/transaction_execution_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import '../../../google/protobuf/duration.pbjson.dart' as $13;
import '../../../google/protobuf/field_mask.pbjson.dart' as $2;
import '../../../google/protobuf/struct.pbjson.dart' as $6;
import '../../../google/protobuf/timestamp.pbjson.dart' as $8;
import 'argument.pbjson.dart' as $4;
import 'balance_change.pbjson.dart' as $19;
import 'bcs.pbjson.dart' as $5;
import 'effects.pbjson.dart' as $15;
import 'event.pbjson.dart' as $18;
import 'executed_transaction.pbjson.dart' as $3;
import 'execution_status.pbjson.dart' as $16;
import 'gas_cost_summary.pbjson.dart' as $17;
import 'input.pbjson.dart' as $7;
import 'jwk.pbjson.dart' as $12;
import 'move_package.pbjson.dart' as $11;
import 'object.pbjson.dart' as $9;
import 'object_reference.pbjson.dart' as $14;
import 'owner.pbjson.dart' as $10;
import 'signature.pbjson.dart' as $1;
import 'transaction.pbjson.dart' as $0;

@$core.Deprecated('Use executeTransactionRequestDescriptor instead')
const ExecuteTransactionRequest$json = {
  '1': 'ExecuteTransactionRequest',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.Transaction', '9': 0, '10': 'transaction', '17': true},
    {'1': 'signatures', '3': 2, '4': 3, '5': 11, '6': '.sui.rpc.v2.UserSignature', '10': 'signatures'},
    {'1': 'read_mask', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '9': 1, '10': 'readMask', '17': true},
  ],
  '8': [
    {'1': '_transaction'},
    {'1': '_read_mask'},
  ],
};

/// Descriptor for `ExecuteTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executeTransactionRequestDescriptor = $convert.base64Decode(
    'ChlFeGVjdXRlVHJhbnNhY3Rpb25SZXF1ZXN0Ej4KC3RyYW5zYWN0aW9uGAEgASgLMhcuc3VpLn'
    'JwYy52Mi5UcmFuc2FjdGlvbkgAUgt0cmFuc2FjdGlvbogBARI5CgpzaWduYXR1cmVzGAIgAygL'
    'Mhkuc3VpLnJwYy52Mi5Vc2VyU2lnbmF0dXJlUgpzaWduYXR1cmVzEjwKCXJlYWRfbWFzaxgDIA'
    'EoCzIaLmdvb2dsZS5wcm90b2J1Zi5GaWVsZE1hc2tIAVIIcmVhZE1hc2uIAQFCDgoMX3RyYW5z'
    'YWN0aW9uQgwKCl9yZWFkX21hc2s=');

@$core.Deprecated('Use executeTransactionResponseDescriptor instead')
const ExecuteTransactionResponse$json = {
  '1': 'ExecuteTransactionResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.ExecutedTransaction', '9': 0, '10': 'transaction', '17': true},
  ],
  '8': [
    {'1': '_transaction'},
  ],
};

/// Descriptor for `ExecuteTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List executeTransactionResponseDescriptor = $convert.base64Decode(
    'ChpFeGVjdXRlVHJhbnNhY3Rpb25SZXNwb25zZRJGCgt0cmFuc2FjdGlvbhgBIAEoCzIfLnN1aS'
    '5ycGMudjIuRXhlY3V0ZWRUcmFuc2FjdGlvbkgAUgt0cmFuc2FjdGlvbogBAUIOCgxfdHJhbnNh'
    'Y3Rpb24=');

@$core.Deprecated('Use simulateTransactionRequestDescriptor instead')
const SimulateTransactionRequest$json = {
  '1': 'SimulateTransactionRequest',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.Transaction', '9': 0, '10': 'transaction', '17': true},
    {'1': 'read_mask', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.FieldMask', '9': 1, '10': 'readMask', '17': true},
    {'1': 'checks', '3': 3, '4': 1, '5': 14, '6': '.sui.rpc.v2.SimulateTransactionRequest.TransactionChecks', '9': 2, '10': 'checks', '17': true},
    {'1': 'do_gas_selection', '3': 4, '4': 1, '5': 8, '9': 3, '10': 'doGasSelection', '17': true},
  ],
  '4': [SimulateTransactionRequest_TransactionChecks$json],
  '8': [
    {'1': '_transaction'},
    {'1': '_read_mask'},
    {'1': '_checks'},
    {'1': '_do_gas_selection'},
  ],
};

@$core.Deprecated('Use simulateTransactionRequestDescriptor instead')
const SimulateTransactionRequest_TransactionChecks$json = {
  '1': 'TransactionChecks',
  '2': [
    {'1': 'ENABLED', '2': 0},
    {'1': 'DISABLED', '2': 1},
  ],
};

/// Descriptor for `SimulateTransactionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simulateTransactionRequestDescriptor = $convert.base64Decode(
    'ChpTaW11bGF0ZVRyYW5zYWN0aW9uUmVxdWVzdBI+Cgt0cmFuc2FjdGlvbhgBIAEoCzIXLnN1aS'
    '5ycGMudjIuVHJhbnNhY3Rpb25IAFILdHJhbnNhY3Rpb26IAQESPAoJcmVhZF9tYXNrGAIgASgL'
    'MhouZ29vZ2xlLnByb3RvYnVmLkZpZWxkTWFza0gBUghyZWFkTWFza4gBARJVCgZjaGVja3MYAy'
    'ABKA4yOC5zdWkucnBjLnYyLlNpbXVsYXRlVHJhbnNhY3Rpb25SZXF1ZXN0LlRyYW5zYWN0aW9u'
    'Q2hlY2tzSAJSBmNoZWNrc4gBARItChBkb19nYXNfc2VsZWN0aW9uGAQgASgISANSDmRvR2FzU2'
    'VsZWN0aW9uiAEBIi4KEVRyYW5zYWN0aW9uQ2hlY2tzEgsKB0VOQUJMRUQQABIMCghESVNBQkxF'
    'RBABQg4KDF90cmFuc2FjdGlvbkIMCgpfcmVhZF9tYXNrQgkKB19jaGVja3NCEwoRX2RvX2dhc1'
    '9zZWxlY3Rpb24=');

@$core.Deprecated('Use simulateTransactionResponseDescriptor instead')
const SimulateTransactionResponse$json = {
  '1': 'SimulateTransactionResponse',
  '2': [
    {'1': 'transaction', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.ExecutedTransaction', '9': 0, '10': 'transaction', '17': true},
    {'1': 'command_outputs', '3': 2, '4': 3, '5': 11, '6': '.sui.rpc.v2.CommandResult', '10': 'commandOutputs'},
    {'1': 'suggested_gas_price', '3': 3, '4': 1, '5': 4, '9': 1, '10': 'suggestedGasPrice', '17': true},
  ],
  '8': [
    {'1': '_transaction'},
    {'1': '_suggested_gas_price'},
  ],
};

/// Descriptor for `SimulateTransactionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List simulateTransactionResponseDescriptor = $convert.base64Decode(
    'ChtTaW11bGF0ZVRyYW5zYWN0aW9uUmVzcG9uc2USRgoLdHJhbnNhY3Rpb24YASABKAsyHy5zdW'
    'kucnBjLnYyLkV4ZWN1dGVkVHJhbnNhY3Rpb25IAFILdHJhbnNhY3Rpb26IAQESQgoPY29tbWFu'
    'ZF9vdXRwdXRzGAIgAygLMhkuc3VpLnJwYy52Mi5Db21tYW5kUmVzdWx0Ug5jb21tYW5kT3V0cH'
    'V0cxIzChNzdWdnZXN0ZWRfZ2FzX3ByaWNlGAMgASgESAFSEXN1Z2dlc3RlZEdhc1ByaWNliAEB'
    'Qg4KDF90cmFuc2FjdGlvbkIWChRfc3VnZ2VzdGVkX2dhc19wcmljZQ==');

@$core.Deprecated('Use commandResultDescriptor instead')
const CommandResult$json = {
  '1': 'CommandResult',
  '2': [
    {'1': 'return_values', '3': 1, '4': 3, '5': 11, '6': '.sui.rpc.v2.CommandOutput', '10': 'returnValues'},
    {'1': 'mutated_by_ref', '3': 2, '4': 3, '5': 11, '6': '.sui.rpc.v2.CommandOutput', '10': 'mutatedByRef'},
  ],
};

/// Descriptor for `CommandResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandResultDescriptor = $convert.base64Decode(
    'Cg1Db21tYW5kUmVzdWx0Ej4KDXJldHVybl92YWx1ZXMYASADKAsyGS5zdWkucnBjLnYyLkNvbW'
    '1hbmRPdXRwdXRSDHJldHVyblZhbHVlcxI/Cg5tdXRhdGVkX2J5X3JlZhgCIAMoCzIZLnN1aS5y'
    'cGMudjIuQ29tbWFuZE91dHB1dFIMbXV0YXRlZEJ5UmVm');

@$core.Deprecated('Use commandOutputDescriptor instead')
const CommandOutput$json = {
  '1': 'CommandOutput',
  '2': [
    {'1': 'argument', '3': 1, '4': 1, '5': 11, '6': '.sui.rpc.v2.Argument', '9': 0, '10': 'argument', '17': true},
    {'1': 'value', '3': 2, '4': 1, '5': 11, '6': '.sui.rpc.v2.Bcs', '9': 1, '10': 'value', '17': true},
    {'1': 'json', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Value', '9': 2, '10': 'json', '17': true},
  ],
  '8': [
    {'1': '_argument'},
    {'1': '_value'},
    {'1': '_json'},
  ],
};

/// Descriptor for `CommandOutput`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandOutputDescriptor = $convert.base64Decode(
    'Cg1Db21tYW5kT3V0cHV0EjUKCGFyZ3VtZW50GAEgASgLMhQuc3VpLnJwYy52Mi5Bcmd1bWVudE'
    'gAUghhcmd1bWVudIgBARIqCgV2YWx1ZRgCIAEoCzIPLnN1aS5ycGMudjIuQmNzSAFSBXZhbHVl'
    'iAEBEi8KBGpzb24YAyABKAsyFi5nb29nbGUucHJvdG9idWYuVmFsdWVIAlIEanNvbogBAUILCg'
    'lfYXJndW1lbnRCCAoGX3ZhbHVlQgcKBV9qc29u');

const $core.Map<$core.String, $core.dynamic> TransactionExecutionServiceBase$json = {
  '1': 'TransactionExecutionService',
  '2': [
    {'1': 'ExecuteTransaction', '2': '.sui.rpc.v2.ExecuteTransactionRequest', '3': '.sui.rpc.v2.ExecuteTransactionResponse'},
    {'1': 'SimulateTransaction', '2': '.sui.rpc.v2.SimulateTransactionRequest', '3': '.sui.rpc.v2.SimulateTransactionResponse'},
  ],
};

@$core.Deprecated('Use transactionExecutionServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> TransactionExecutionServiceBase$messageJson = {
  '.sui.rpc.v2.ExecuteTransactionRequest': ExecuteTransactionRequest$json,
  '.sui.rpc.v2.Transaction': $0.Transaction$json,
  '.sui.rpc.v2.Bcs': $5.Bcs$json,
  '.sui.rpc.v2.TransactionKind': $0.TransactionKind$json,
  '.sui.rpc.v2.ProgrammableTransaction': $0.ProgrammableTransaction$json,
  '.sui.rpc.v2.Input': $7.Input$json,
  '.sui.rpc.v2.FundsWithdrawal': $7.FundsWithdrawal$json,
  '.google.protobuf.Value': $6.Value$json,
  '.google.protobuf.Struct': $6.Struct$json,
  '.google.protobuf.Struct.FieldsEntry': $6.Struct_FieldsEntry$json,
  '.google.protobuf.ListValue': $6.ListValue$json,
  '.sui.rpc.v2.Command': $0.Command$json,
  '.sui.rpc.v2.MoveCall': $0.MoveCall$json,
  '.sui.rpc.v2.Argument': $4.Argument$json,
  '.sui.rpc.v2.TransferObjects': $0.TransferObjects$json,
  '.sui.rpc.v2.SplitCoins': $0.SplitCoins$json,
  '.sui.rpc.v2.MergeCoins': $0.MergeCoins$json,
  '.sui.rpc.v2.Publish': $0.Publish$json,
  '.sui.rpc.v2.MakeMoveVector': $0.MakeMoveVector$json,
  '.sui.rpc.v2.Upgrade': $0.Upgrade$json,
  '.sui.rpc.v2.ChangeEpoch': $0.ChangeEpoch$json,
  '.google.protobuf.Timestamp': $8.Timestamp$json,
  '.sui.rpc.v2.SystemPackage': $0.SystemPackage$json,
  '.sui.rpc.v2.GenesisTransaction': $0.GenesisTransaction$json,
  '.sui.rpc.v2.Object': $9.Object$json,
  '.sui.rpc.v2.Owner': $10.Owner$json,
  '.sui.rpc.v2.Package': $11.Package$json,
  '.sui.rpc.v2.Module': $11.Module$json,
  '.sui.rpc.v2.DatatypeDescriptor': $11.DatatypeDescriptor$json,
  '.sui.rpc.v2.TypeParameter': $11.TypeParameter$json,
  '.sui.rpc.v2.FieldDescriptor': $11.FieldDescriptor$json,
  '.sui.rpc.v2.OpenSignatureBody': $11.OpenSignatureBody$json,
  '.sui.rpc.v2.VariantDescriptor': $11.VariantDescriptor$json,
  '.sui.rpc.v2.FunctionDescriptor': $11.FunctionDescriptor$json,
  '.sui.rpc.v2.OpenSignature': $11.OpenSignature$json,
  '.sui.rpc.v2.TypeOrigin': $11.TypeOrigin$json,
  '.sui.rpc.v2.Linkage': $11.Linkage$json,
  '.sui.rpc.v2.Display': $9.Display$json,
  '.sui.rpc.v2.ConsensusCommitPrologue': $0.ConsensusCommitPrologue$json,
  '.sui.rpc.v2.ConsensusDeterminedVersionAssignments': $0.ConsensusDeterminedVersionAssignments$json,
  '.sui.rpc.v2.CanceledTransaction': $0.CanceledTransaction$json,
  '.sui.rpc.v2.VersionAssignment': $0.VersionAssignment$json,
  '.sui.rpc.v2.AuthenticatorStateUpdate': $0.AuthenticatorStateUpdate$json,
  '.sui.rpc.v2.ActiveJwk': $0.ActiveJwk$json,
  '.sui.rpc.v2.JwkId': $12.JwkId$json,
  '.sui.rpc.v2.Jwk': $12.Jwk$json,
  '.sui.rpc.v2.EndOfEpochTransaction': $0.EndOfEpochTransaction$json,
  '.sui.rpc.v2.EndOfEpochTransactionKind': $0.EndOfEpochTransactionKind$json,
  '.sui.rpc.v2.AuthenticatorStateExpire': $0.AuthenticatorStateExpire$json,
  '.sui.rpc.v2.ExecutionTimeObservations': $0.ExecutionTimeObservations$json,
  '.sui.rpc.v2.ExecutionTimeObservation': $0.ExecutionTimeObservation$json,
  '.sui.rpc.v2.ValidatorExecutionTimeObservation': $0.ValidatorExecutionTimeObservation$json,
  '.google.protobuf.Duration': $13.Duration$json,
  '.sui.rpc.v2.RandomnessStateUpdate': $0.RandomnessStateUpdate$json,
  '.sui.rpc.v2.GasPayment': $0.GasPayment$json,
  '.sui.rpc.v2.ObjectReference': $14.ObjectReference$json,
  '.sui.rpc.v2.TransactionExpiration': $0.TransactionExpiration$json,
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
  '.sui.rpc.v2.PasskeyAuthenticator': $1.PasskeyAuthenticator$json,
  '.sui.rpc.v2.MultisigCommittee': $1.MultisigCommittee$json,
  '.sui.rpc.v2.MultisigMember': $1.MultisigMember$json,
  '.sui.rpc.v2.MultisigMemberPublicKey': $1.MultisigMemberPublicKey$json,
  '.google.protobuf.FieldMask': $2.FieldMask$json,
  '.sui.rpc.v2.ExecuteTransactionResponse': ExecuteTransactionResponse$json,
  '.sui.rpc.v2.ExecutedTransaction': $3.ExecutedTransaction$json,
  '.sui.rpc.v2.TransactionEffects': $15.TransactionEffects$json,
  '.sui.rpc.v2.ExecutionStatus': $16.ExecutionStatus$json,
  '.sui.rpc.v2.ExecutionError': $16.ExecutionError$json,
  '.sui.rpc.v2.MoveAbort': $16.MoveAbort$json,
  '.sui.rpc.v2.MoveLocation': $16.MoveLocation$json,
  '.sui.rpc.v2.CleverError': $16.CleverError$json,
  '.sui.rpc.v2.SizeError': $16.SizeError$json,
  '.sui.rpc.v2.CommandArgumentError': $16.CommandArgumentError$json,
  '.sui.rpc.v2.IndexError': $16.IndexError$json,
  '.sui.rpc.v2.TypeArgumentError': $16.TypeArgumentError$json,
  '.sui.rpc.v2.PackageUpgradeError': $16.PackageUpgradeError$json,
  '.sui.rpc.v2.CoinDenyListError': $16.CoinDenyListError$json,
  '.sui.rpc.v2.CongestedObjects': $16.CongestedObjects$json,
  '.sui.rpc.v2.GasCostSummary': $17.GasCostSummary$json,
  '.sui.rpc.v2.ChangedObject': $15.ChangedObject$json,
  '.sui.rpc.v2.AccumulatorWrite': $15.AccumulatorWrite$json,
  '.sui.rpc.v2.EventDigestEntry': $15.EventDigestEntry$json,
  '.sui.rpc.v2.UnchangedConsensusObject': $15.UnchangedConsensusObject$json,
  '.sui.rpc.v2.TransactionEvents': $18.TransactionEvents$json,
  '.sui.rpc.v2.Event': $18.Event$json,
  '.sui.rpc.v2.BalanceChange': $19.BalanceChange$json,
  '.sui.rpc.v2.ObjectSet': $9.ObjectSet$json,
  '.sui.rpc.v2.SimulateTransactionRequest': SimulateTransactionRequest$json,
  '.sui.rpc.v2.SimulateTransactionResponse': SimulateTransactionResponse$json,
  '.sui.rpc.v2.CommandResult': CommandResult$json,
  '.sui.rpc.v2.CommandOutput': CommandOutput$json,
};

/// Descriptor for `TransactionExecutionService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List transactionExecutionServiceDescriptor = $convert.base64Decode(
    'ChtUcmFuc2FjdGlvbkV4ZWN1dGlvblNlcnZpY2USYwoSRXhlY3V0ZVRyYW5zYWN0aW9uEiUuc3'
    'VpLnJwYy52Mi5FeGVjdXRlVHJhbnNhY3Rpb25SZXF1ZXN0GiYuc3VpLnJwYy52Mi5FeGVjdXRl'
    'VHJhbnNhY3Rpb25SZXNwb25zZRJmChNTaW11bGF0ZVRyYW5zYWN0aW9uEiYuc3VpLnJwYy52Mi'
    '5TaW11bGF0ZVRyYW5zYWN0aW9uUmVxdWVzdBonLnN1aS5ycGMudjIuU2ltdWxhdGVUcmFuc2Fj'
    'dGlvblJlc3BvbnNl');

