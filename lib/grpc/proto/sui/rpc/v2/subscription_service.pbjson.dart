// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/subscription_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import '../../../google/protobuf/duration.pbjson.dart' as $20;
import '../../../google/protobuf/field_mask.pbjson.dart' as $0;
import '../../../google/protobuf/struct.pbjson.dart' as $15;
import '../../../google/protobuf/timestamp.pbjson.dart' as $9;
import 'argument.pbjson.dart' as $16;
import 'balance_change.pbjson.dart' as $24;
import 'bcs.pbjson.dart' as $7;
import 'checkpoint.pbjson.dart' as $2;
import 'checkpoint_contents.pbjson.dart' as $11;
import 'checkpoint_summary.pbjson.dart' as $6;
import 'effects.pbjson.dart' as $22;
import 'event.pbjson.dart' as $5;
import 'executed_transaction.pbjson.dart' as $3;
import 'execution_status.pbjson.dart' as $23;
import 'filter.pbjson.dart' as $1;
import 'gas_cost_summary.pbjson.dart' as $8;
import 'input.pbjson.dart' as $14;
import 'jwk.pbjson.dart' as $12;
import 'move_package.pbjson.dart' as $19;
import 'object.pbjson.dart' as $17;
import 'object_reference.pbjson.dart' as $21;
import 'owner.pbjson.dart' as $18;
import 'query_options.pbjson.dart' as $4;
import 'signature.pbjson.dart' as $10;
import 'transaction.pbjson.dart' as $13;

@$core.Deprecated('Use subscribeCheckpointsRequestDescriptor instead')
const SubscribeCheckpointsRequest$json = {
  '1': 'SubscribeCheckpointsRequest',
  '2': [
    {
      '1': 'read_mask',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '9': 0,
      '10': 'readMask',
      '17': true
    },
    {
      '1': 'filter',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.TransactionFilter',
      '9': 1,
      '10': 'filter',
      '17': true
    },
  ],
  '8': [
    {'1': '_read_mask'},
    {'1': '_filter'},
  ],
};

/// Descriptor for `SubscribeCheckpointsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeCheckpointsRequestDescriptor = $convert.base64Decode(
    'ChtTdWJzY3JpYmVDaGVja3BvaW50c1JlcXVlc3QSPAoJcmVhZF9tYXNrGAEgASgLMhouZ29vZ2'
    'xlLnByb3RvYnVmLkZpZWxkTWFza0gAUghyZWFkTWFza4gBARI6CgZmaWx0ZXIYAiABKAsyHS5z'
    'dWkucnBjLnYyLlRyYW5zYWN0aW9uRmlsdGVySAFSBmZpbHRlcogBAUIMCgpfcmVhZF9tYXNrQg'
    'kKB19maWx0ZXI=');

@$core.Deprecated('Use subscribeCheckpointsResponseDescriptor instead')
const SubscribeCheckpointsResponse$json = {
  '1': 'SubscribeCheckpointsResponse',
  '2': [
    {'1': 'cursor', '3': 1, '4': 1, '5': 4, '9': 0, '10': 'cursor', '17': true},
    {
      '1': 'checkpoint',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Checkpoint',
      '9': 1,
      '10': 'checkpoint',
      '17': true
    },
  ],
  '8': [
    {'1': '_cursor'},
    {'1': '_checkpoint'},
  ],
};

/// Descriptor for `SubscribeCheckpointsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeCheckpointsResponseDescriptor =
    $convert.base64Decode(
        'ChxTdWJzY3JpYmVDaGVja3BvaW50c1Jlc3BvbnNlEhsKBmN1cnNvchgBIAEoBEgAUgZjdXJzb3'
        'KIAQESOwoKY2hlY2twb2ludBgCIAEoCzIWLnN1aS5ycGMudjIuQ2hlY2twb2ludEgBUgpjaGVj'
        'a3BvaW50iAEBQgkKB19jdXJzb3JCDQoLX2NoZWNrcG9pbnQ=');

@$core.Deprecated('Use subscribeTransactionsRequestDescriptor instead')
const SubscribeTransactionsRequest$json = {
  '1': 'SubscribeTransactionsRequest',
  '2': [
    {
      '1': 'read_mask',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '9': 0,
      '10': 'readMask',
      '17': true
    },
    {
      '1': 'filter',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.TransactionFilter',
      '9': 1,
      '10': 'filter',
      '17': true
    },
  ],
  '8': [
    {'1': '_read_mask'},
    {'1': '_filter'},
  ],
};

/// Descriptor for `SubscribeTransactionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeTransactionsRequestDescriptor = $convert.base64Decode(
    'ChxTdWJzY3JpYmVUcmFuc2FjdGlvbnNSZXF1ZXN0EjwKCXJlYWRfbWFzaxgBIAEoCzIaLmdvb2'
    'dsZS5wcm90b2J1Zi5GaWVsZE1hc2tIAFIIcmVhZE1hc2uIAQESOgoGZmlsdGVyGAIgASgLMh0u'
    'c3VpLnJwYy52Mi5UcmFuc2FjdGlvbkZpbHRlckgBUgZmaWx0ZXKIAQFCDAoKX3JlYWRfbWFza0'
    'IJCgdfZmlsdGVy');

@$core.Deprecated('Use subscribeTransactionsResponseDescriptor instead')
const SubscribeTransactionsResponse$json = {
  '1': 'SubscribeTransactionsResponse',
  '2': [
    {
      '1': 'transaction',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.ExecutedTransaction',
      '9': 0,
      '10': 'transaction',
      '17': true
    },
    {
      '1': 'watermark',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Watermark',
      '9': 1,
      '10': 'watermark',
      '17': true
    },
  ],
  '8': [
    {'1': '_transaction'},
    {'1': '_watermark'},
  ],
};

/// Descriptor for `SubscribeTransactionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeTransactionsResponseDescriptor = $convert.base64Decode(
    'Ch1TdWJzY3JpYmVUcmFuc2FjdGlvbnNSZXNwb25zZRJGCgt0cmFuc2FjdGlvbhgBIAEoCzIfLn'
    'N1aS5ycGMudjIuRXhlY3V0ZWRUcmFuc2FjdGlvbkgAUgt0cmFuc2FjdGlvbogBARI4Cgl3YXRl'
    'cm1hcmsYAiABKAsyFS5zdWkucnBjLnYyLldhdGVybWFya0gBUgl3YXRlcm1hcmuIAQFCDgoMX3'
    'RyYW5zYWN0aW9uQgwKCl93YXRlcm1hcms=');

@$core.Deprecated('Use subscribeEventsRequestDescriptor instead')
const SubscribeEventsRequest$json = {
  '1': 'SubscribeEventsRequest',
  '2': [
    {
      '1': 'read_mask',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.FieldMask',
      '9': 0,
      '10': 'readMask',
      '17': true
    },
    {
      '1': 'filter',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.EventFilter',
      '9': 1,
      '10': 'filter',
      '17': true
    },
  ],
  '8': [
    {'1': '_read_mask'},
    {'1': '_filter'},
  ],
};

/// Descriptor for `SubscribeEventsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeEventsRequestDescriptor = $convert.base64Decode(
    'ChZTdWJzY3JpYmVFdmVudHNSZXF1ZXN0EjwKCXJlYWRfbWFzaxgBIAEoCzIaLmdvb2dsZS5wcm'
    '90b2J1Zi5GaWVsZE1hc2tIAFIIcmVhZE1hc2uIAQESNAoGZmlsdGVyGAIgASgLMhcuc3VpLnJw'
    'Yy52Mi5FdmVudEZpbHRlckgBUgZmaWx0ZXKIAQFCDAoKX3JlYWRfbWFza0IJCgdfZmlsdGVy');

@$core.Deprecated('Use subscribeEventsResponseDescriptor instead')
const SubscribeEventsResponse$json = {
  '1': 'SubscribeEventsResponse',
  '2': [
    {
      '1': 'event',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Event',
      '9': 0,
      '10': 'event',
      '17': true
    },
    {
      '1': 'watermark',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.sui.rpc.v2.Watermark',
      '9': 1,
      '10': 'watermark',
      '17': true
    },
  ],
  '8': [
    {'1': '_event'},
    {'1': '_watermark'},
  ],
};

/// Descriptor for `SubscribeEventsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeEventsResponseDescriptor = $convert.base64Decode(
    'ChdTdWJzY3JpYmVFdmVudHNSZXNwb25zZRIsCgVldmVudBgBIAEoCzIRLnN1aS5ycGMudjIuRX'
    'ZlbnRIAFIFZXZlbnSIAQESOAoJd2F0ZXJtYXJrGAIgASgLMhUuc3VpLnJwYy52Mi5XYXRlcm1h'
    'cmtIAVIJd2F0ZXJtYXJriAEBQggKBl9ldmVudEIMCgpfd2F0ZXJtYXJr');

const $core.Map<$core.String, $core.dynamic> SubscriptionServiceBase$json = {
  '1': 'SubscriptionService',
  '2': [
    {
      '1': 'SubscribeCheckpoints',
      '2': '.sui.rpc.v2.SubscribeCheckpointsRequest',
      '3': '.sui.rpc.v2.SubscribeCheckpointsResponse',
      '6': true
    },
    {
      '1': 'SubscribeTransactions',
      '2': '.sui.rpc.v2.SubscribeTransactionsRequest',
      '3': '.sui.rpc.v2.SubscribeTransactionsResponse',
      '6': true
    },
    {
      '1': 'SubscribeEvents',
      '2': '.sui.rpc.v2.SubscribeEventsRequest',
      '3': '.sui.rpc.v2.SubscribeEventsResponse',
      '6': true
    },
  ],
};

@$core.Deprecated('Use subscriptionServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    SubscriptionServiceBase$messageJson = {
  '.sui.rpc.v2.SubscribeCheckpointsRequest': SubscribeCheckpointsRequest$json,
  '.google.protobuf.FieldMask': $0.FieldMask$json,
  '.sui.rpc.v2.TransactionFilter': $1.TransactionFilter$json,
  '.sui.rpc.v2.TransactionTerm': $1.TransactionTerm$json,
  '.sui.rpc.v2.TransactionLiteral': $1.TransactionLiteral$json,
  '.sui.rpc.v2.SenderFilter': $1.SenderFilter$json,
  '.sui.rpc.v2.AffectedAddressFilter': $1.AffectedAddressFilter$json,
  '.sui.rpc.v2.AffectedObjectFilter': $1.AffectedObjectFilter$json,
  '.sui.rpc.v2.MoveCallFilter': $1.MoveCallFilter$json,
  '.sui.rpc.v2.EmitModuleFilter': $1.EmitModuleFilter$json,
  '.sui.rpc.v2.EventTypeFilter': $1.EventTypeFilter$json,
  '.sui.rpc.v2.EventStreamHeadFilter': $1.EventStreamHeadFilter$json,
  '.sui.rpc.v2.PackageWriteFilter': $1.PackageWriteFilter$json,
  '.sui.rpc.v2.SubscribeCheckpointsResponse': SubscribeCheckpointsResponse$json,
  '.sui.rpc.v2.Checkpoint': $2.Checkpoint$json,
  '.sui.rpc.v2.CheckpointSummary': $6.CheckpointSummary$json,
  '.sui.rpc.v2.Bcs': $7.Bcs$json,
  '.sui.rpc.v2.GasCostSummary': $8.GasCostSummary$json,
  '.google.protobuf.Timestamp': $9.Timestamp$json,
  '.sui.rpc.v2.CheckpointCommitment': $6.CheckpointCommitment$json,
  '.sui.rpc.v2.EndOfEpochData': $6.EndOfEpochData$json,
  '.sui.rpc.v2.ValidatorCommitteeMember': $10.ValidatorCommitteeMember$json,
  '.sui.rpc.v2.ValidatorAggregatedSignature':
      $10.ValidatorAggregatedSignature$json,
  '.sui.rpc.v2.CheckpointContents': $11.CheckpointContents$json,
  '.sui.rpc.v2.CheckpointedTransactionInfo':
      $11.CheckpointedTransactionInfo$json,
  '.sui.rpc.v2.UserSignature': $10.UserSignature$json,
  '.sui.rpc.v2.SimpleSignature': $10.SimpleSignature$json,
  '.sui.rpc.v2.MultisigAggregatedSignature':
      $10.MultisigAggregatedSignature$json,
  '.sui.rpc.v2.MultisigMemberSignature': $10.MultisigMemberSignature$json,
  '.sui.rpc.v2.ZkLoginAuthenticator': $10.ZkLoginAuthenticator$json,
  '.sui.rpc.v2.ZkLoginInputs': $10.ZkLoginInputs$json,
  '.sui.rpc.v2.ZkLoginProof': $10.ZkLoginProof$json,
  '.sui.rpc.v2.CircomG1': $10.CircomG1$json,
  '.sui.rpc.v2.CircomG2': $10.CircomG2$json,
  '.sui.rpc.v2.ZkLoginClaim': $10.ZkLoginClaim$json,
  '.sui.rpc.v2.ZkLoginPublicIdentifier': $10.ZkLoginPublicIdentifier$json,
  '.sui.rpc.v2.JwkId': $12.JwkId$json,
  '.sui.rpc.v2.PasskeyAuthenticator': $10.PasskeyAuthenticator$json,
  '.sui.rpc.v2.MultisigCommittee': $10.MultisigCommittee$json,
  '.sui.rpc.v2.MultisigMember': $10.MultisigMember$json,
  '.sui.rpc.v2.MultisigMemberPublicKey': $10.MultisigMemberPublicKey$json,
  '.sui.rpc.v2.AddressAliasesVersion': $11.AddressAliasesVersion$json,
  '.sui.rpc.v2.ExecutedTransaction': $3.ExecutedTransaction$json,
  '.sui.rpc.v2.Transaction': $13.Transaction$json,
  '.sui.rpc.v2.TransactionKind': $13.TransactionKind$json,
  '.sui.rpc.v2.ProgrammableTransaction': $13.ProgrammableTransaction$json,
  '.sui.rpc.v2.Input': $14.Input$json,
  '.sui.rpc.v2.FundsWithdrawal': $14.FundsWithdrawal$json,
  '.google.protobuf.Value': $15.Value$json,
  '.google.protobuf.Struct': $15.Struct$json,
  '.google.protobuf.Struct.FieldsEntry': $15.Struct_FieldsEntry$json,
  '.google.protobuf.ListValue': $15.ListValue$json,
  '.sui.rpc.v2.Command': $13.Command$json,
  '.sui.rpc.v2.MoveCall': $13.MoveCall$json,
  '.sui.rpc.v2.Argument': $16.Argument$json,
  '.sui.rpc.v2.TransferObjects': $13.TransferObjects$json,
  '.sui.rpc.v2.SplitCoins': $13.SplitCoins$json,
  '.sui.rpc.v2.MergeCoins': $13.MergeCoins$json,
  '.sui.rpc.v2.Publish': $13.Publish$json,
  '.sui.rpc.v2.MakeMoveVector': $13.MakeMoveVector$json,
  '.sui.rpc.v2.Upgrade': $13.Upgrade$json,
  '.sui.rpc.v2.ChangeEpoch': $13.ChangeEpoch$json,
  '.sui.rpc.v2.SystemPackage': $13.SystemPackage$json,
  '.sui.rpc.v2.GenesisTransaction': $13.GenesisTransaction$json,
  '.sui.rpc.v2.Object': $17.Object$json,
  '.sui.rpc.v2.Owner': $18.Owner$json,
  '.sui.rpc.v2.Package': $19.Package$json,
  '.sui.rpc.v2.Module': $19.Module$json,
  '.sui.rpc.v2.DatatypeDescriptor': $19.DatatypeDescriptor$json,
  '.sui.rpc.v2.TypeParameter': $19.TypeParameter$json,
  '.sui.rpc.v2.FieldDescriptor': $19.FieldDescriptor$json,
  '.sui.rpc.v2.OpenSignatureBody': $19.OpenSignatureBody$json,
  '.sui.rpc.v2.VariantDescriptor': $19.VariantDescriptor$json,
  '.sui.rpc.v2.FunctionDescriptor': $19.FunctionDescriptor$json,
  '.sui.rpc.v2.OpenSignature': $19.OpenSignature$json,
  '.sui.rpc.v2.TypeOrigin': $19.TypeOrigin$json,
  '.sui.rpc.v2.Linkage': $19.Linkage$json,
  '.sui.rpc.v2.Display': $17.Display$json,
  '.sui.rpc.v2.ConsensusCommitPrologue': $13.ConsensusCommitPrologue$json,
  '.sui.rpc.v2.ConsensusDeterminedVersionAssignments':
      $13.ConsensusDeterminedVersionAssignments$json,
  '.sui.rpc.v2.CanceledTransaction': $13.CanceledTransaction$json,
  '.sui.rpc.v2.VersionAssignment': $13.VersionAssignment$json,
  '.sui.rpc.v2.AuthenticatorStateUpdate': $13.AuthenticatorStateUpdate$json,
  '.sui.rpc.v2.ActiveJwk': $13.ActiveJwk$json,
  '.sui.rpc.v2.Jwk': $12.Jwk$json,
  '.sui.rpc.v2.EndOfEpochTransaction': $13.EndOfEpochTransaction$json,
  '.sui.rpc.v2.EndOfEpochTransactionKind': $13.EndOfEpochTransactionKind$json,
  '.sui.rpc.v2.AuthenticatorStateExpire': $13.AuthenticatorStateExpire$json,
  '.sui.rpc.v2.ExecutionTimeObservations': $13.ExecutionTimeObservations$json,
  '.sui.rpc.v2.ExecutionTimeObservation': $13.ExecutionTimeObservation$json,
  '.sui.rpc.v2.ValidatorExecutionTimeObservation':
      $13.ValidatorExecutionTimeObservation$json,
  '.google.protobuf.Duration': $20.Duration$json,
  '.sui.rpc.v2.RandomnessStateUpdate': $13.RandomnessStateUpdate$json,
  '.sui.rpc.v2.GasPayment': $13.GasPayment$json,
  '.sui.rpc.v2.ObjectReference': $21.ObjectReference$json,
  '.sui.rpc.v2.TransactionExpiration': $13.TransactionExpiration$json,
  '.sui.rpc.v2.AllowedProposers': $13.AllowedProposers$json,
  '.sui.rpc.v2.TransactionEffects': $22.TransactionEffects$json,
  '.sui.rpc.v2.ExecutionStatus': $23.ExecutionStatus$json,
  '.sui.rpc.v2.ExecutionError': $23.ExecutionError$json,
  '.sui.rpc.v2.MoveAbort': $23.MoveAbort$json,
  '.sui.rpc.v2.MoveLocation': $23.MoveLocation$json,
  '.sui.rpc.v2.CleverError': $23.CleverError$json,
  '.sui.rpc.v2.SizeError': $23.SizeError$json,
  '.sui.rpc.v2.CommandArgumentError': $23.CommandArgumentError$json,
  '.sui.rpc.v2.IndexError': $23.IndexError$json,
  '.sui.rpc.v2.TypeArgumentError': $23.TypeArgumentError$json,
  '.sui.rpc.v2.PackageUpgradeError': $23.PackageUpgradeError$json,
  '.sui.rpc.v2.CoinDenyListError': $23.CoinDenyListError$json,
  '.sui.rpc.v2.CongestedObjects': $23.CongestedObjects$json,
  '.sui.rpc.v2.ChangedObject': $22.ChangedObject$json,
  '.sui.rpc.v2.AccumulatorWrite': $22.AccumulatorWrite$json,
  '.sui.rpc.v2.EventDigestEntry': $22.EventDigestEntry$json,
  '.sui.rpc.v2.UnchangedConsensusObject': $22.UnchangedConsensusObject$json,
  '.sui.rpc.v2.TransactionEvents': $5.TransactionEvents$json,
  '.sui.rpc.v2.Event': $5.Event$json,
  '.sui.rpc.v2.BalanceChange': $24.BalanceChange$json,
  '.sui.rpc.v2.ObjectSet': $17.ObjectSet$json,
  '.sui.rpc.v2.SubscribeTransactionsRequest': SubscribeTransactionsRequest$json,
  '.sui.rpc.v2.SubscribeTransactionsResponse':
      SubscribeTransactionsResponse$json,
  '.sui.rpc.v2.Watermark': $4.Watermark$json,
  '.sui.rpc.v2.SubscribeEventsRequest': SubscribeEventsRequest$json,
  '.sui.rpc.v2.EventFilter': $1.EventFilter$json,
  '.sui.rpc.v2.EventTerm': $1.EventTerm$json,
  '.sui.rpc.v2.EventLiteral': $1.EventLiteral$json,
  '.sui.rpc.v2.SubscribeEventsResponse': SubscribeEventsResponse$json,
};

/// Descriptor for `SubscriptionService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List subscriptionServiceDescriptor = $convert.base64Decode(
    'ChNTdWJzY3JpcHRpb25TZXJ2aWNlEmsKFFN1YnNjcmliZUNoZWNrcG9pbnRzEicuc3VpLnJwYy'
    '52Mi5TdWJzY3JpYmVDaGVja3BvaW50c1JlcXVlc3QaKC5zdWkucnBjLnYyLlN1YnNjcmliZUNo'
    'ZWNrcG9pbnRzUmVzcG9uc2UwARJuChVTdWJzY3JpYmVUcmFuc2FjdGlvbnMSKC5zdWkucnBjLn'
    'YyLlN1YnNjcmliZVRyYW5zYWN0aW9uc1JlcXVlc3QaKS5zdWkucnBjLnYyLlN1YnNjcmliZVRy'
    'YW5zYWN0aW9uc1Jlc3BvbnNlMAESXAoPU3Vic2NyaWJlRXZlbnRzEiIuc3VpLnJwYy52Mi5TdW'
    'JzY3JpYmVFdmVudHNSZXF1ZXN0GiMuc3VpLnJwYy52Mi5TdWJzY3JpYmVFdmVudHNSZXNwb25z'
    'ZTAB');
