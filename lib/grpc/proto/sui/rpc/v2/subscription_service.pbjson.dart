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

import '../../../google/protobuf/duration.pbjson.dart' as $17;
import '../../../google/protobuf/field_mask.pbjson.dart' as $0;
import '../../../google/protobuf/struct.pbjson.dart' as $12;
import '../../../google/protobuf/timestamp.pbjson.dart' as $5;
import 'argument.pbjson.dart' as $13;
import 'balance_change.pbjson.dart' as $22;
import 'bcs.pbjson.dart' as $3;
import 'checkpoint.pbjson.dart' as $1;
import 'checkpoint_contents.pbjson.dart' as $7;
import 'checkpoint_summary.pbjson.dart' as $2;
import 'effects.pbjson.dart' as $19;
import 'event.pbjson.dart' as $21;
import 'executed_transaction.pbjson.dart' as $9;
import 'execution_status.pbjson.dart' as $20;
import 'gas_cost_summary.pbjson.dart' as $4;
import 'input.pbjson.dart' as $11;
import 'jwk.pbjson.dart' as $8;
import 'move_package.pbjson.dart' as $16;
import 'object.pbjson.dart' as $14;
import 'object_reference.pbjson.dart' as $18;
import 'owner.pbjson.dart' as $15;
import 'signature.pbjson.dart' as $6;
import 'transaction.pbjson.dart' as $10;

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
  ],
  '8': [
    {'1': '_read_mask'},
  ],
};

/// Descriptor for `SubscribeCheckpointsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List subscribeCheckpointsRequestDescriptor =
    $convert.base64Decode(
        'ChtTdWJzY3JpYmVDaGVja3BvaW50c1JlcXVlc3QSPAoJcmVhZF9tYXNrGAEgASgLMhouZ29vZ2'
        'xlLnByb3RvYnVmLkZpZWxkTWFza0gAUghyZWFkTWFza4gBAUIMCgpfcmVhZF9tYXNr');

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

const $core.Map<$core.String, $core.dynamic> SubscriptionServiceBase$json = {
  '1': 'SubscriptionService',
  '2': [
    {
      '1': 'SubscribeCheckpoints',
      '2': '.sui.rpc.v2.SubscribeCheckpointsRequest',
      '3': '.sui.rpc.v2.SubscribeCheckpointsResponse',
      '6': true
    },
  ],
};

@$core.Deprecated('Use subscriptionServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    SubscriptionServiceBase$messageJson = {
  '.sui.rpc.v2.SubscribeCheckpointsRequest': SubscribeCheckpointsRequest$json,
  '.google.protobuf.FieldMask': $0.FieldMask$json,
  '.sui.rpc.v2.SubscribeCheckpointsResponse': SubscribeCheckpointsResponse$json,
  '.sui.rpc.v2.Checkpoint': $1.Checkpoint$json,
  '.sui.rpc.v2.CheckpointSummary': $2.CheckpointSummary$json,
  '.sui.rpc.v2.Bcs': $3.Bcs$json,
  '.sui.rpc.v2.GasCostSummary': $4.GasCostSummary$json,
  '.google.protobuf.Timestamp': $5.Timestamp$json,
  '.sui.rpc.v2.CheckpointCommitment': $2.CheckpointCommitment$json,
  '.sui.rpc.v2.EndOfEpochData': $2.EndOfEpochData$json,
  '.sui.rpc.v2.ValidatorCommitteeMember': $6.ValidatorCommitteeMember$json,
  '.sui.rpc.v2.ValidatorAggregatedSignature':
      $6.ValidatorAggregatedSignature$json,
  '.sui.rpc.v2.CheckpointContents': $7.CheckpointContents$json,
  '.sui.rpc.v2.CheckpointedTransactionInfo':
      $7.CheckpointedTransactionInfo$json,
  '.sui.rpc.v2.UserSignature': $6.UserSignature$json,
  '.sui.rpc.v2.SimpleSignature': $6.SimpleSignature$json,
  '.sui.rpc.v2.MultisigAggregatedSignature':
      $6.MultisigAggregatedSignature$json,
  '.sui.rpc.v2.MultisigMemberSignature': $6.MultisigMemberSignature$json,
  '.sui.rpc.v2.ZkLoginAuthenticator': $6.ZkLoginAuthenticator$json,
  '.sui.rpc.v2.ZkLoginInputs': $6.ZkLoginInputs$json,
  '.sui.rpc.v2.ZkLoginProof': $6.ZkLoginProof$json,
  '.sui.rpc.v2.CircomG1': $6.CircomG1$json,
  '.sui.rpc.v2.CircomG2': $6.CircomG2$json,
  '.sui.rpc.v2.ZkLoginClaim': $6.ZkLoginClaim$json,
  '.sui.rpc.v2.ZkLoginPublicIdentifier': $6.ZkLoginPublicIdentifier$json,
  '.sui.rpc.v2.JwkId': $8.JwkId$json,
  '.sui.rpc.v2.PasskeyAuthenticator': $6.PasskeyAuthenticator$json,
  '.sui.rpc.v2.MultisigCommittee': $6.MultisigCommittee$json,
  '.sui.rpc.v2.MultisigMember': $6.MultisigMember$json,
  '.sui.rpc.v2.MultisigMemberPublicKey': $6.MultisigMemberPublicKey$json,
  '.sui.rpc.v2.AddressAliasesVersion': $7.AddressAliasesVersion$json,
  '.sui.rpc.v2.ExecutedTransaction': $9.ExecutedTransaction$json,
  '.sui.rpc.v2.Transaction': $10.Transaction$json,
  '.sui.rpc.v2.TransactionKind': $10.TransactionKind$json,
  '.sui.rpc.v2.ProgrammableTransaction': $10.ProgrammableTransaction$json,
  '.sui.rpc.v2.Input': $11.Input$json,
  '.sui.rpc.v2.FundsWithdrawal': $11.FundsWithdrawal$json,
  '.google.protobuf.Value': $12.Value$json,
  '.google.protobuf.Struct': $12.Struct$json,
  '.google.protobuf.Struct.FieldsEntry': $12.Struct_FieldsEntry$json,
  '.google.protobuf.ListValue': $12.ListValue$json,
  '.sui.rpc.v2.Command': $10.Command$json,
  '.sui.rpc.v2.MoveCall': $10.MoveCall$json,
  '.sui.rpc.v2.Argument': $13.Argument$json,
  '.sui.rpc.v2.TransferObjects': $10.TransferObjects$json,
  '.sui.rpc.v2.SplitCoins': $10.SplitCoins$json,
  '.sui.rpc.v2.MergeCoins': $10.MergeCoins$json,
  '.sui.rpc.v2.Publish': $10.Publish$json,
  '.sui.rpc.v2.MakeMoveVector': $10.MakeMoveVector$json,
  '.sui.rpc.v2.Upgrade': $10.Upgrade$json,
  '.sui.rpc.v2.ChangeEpoch': $10.ChangeEpoch$json,
  '.sui.rpc.v2.SystemPackage': $10.SystemPackage$json,
  '.sui.rpc.v2.GenesisTransaction': $10.GenesisTransaction$json,
  '.sui.rpc.v2.Object': $14.Object$json,
  '.sui.rpc.v2.Owner': $15.Owner$json,
  '.sui.rpc.v2.Package': $16.Package$json,
  '.sui.rpc.v2.Module': $16.Module$json,
  '.sui.rpc.v2.DatatypeDescriptor': $16.DatatypeDescriptor$json,
  '.sui.rpc.v2.TypeParameter': $16.TypeParameter$json,
  '.sui.rpc.v2.FieldDescriptor': $16.FieldDescriptor$json,
  '.sui.rpc.v2.OpenSignatureBody': $16.OpenSignatureBody$json,
  '.sui.rpc.v2.VariantDescriptor': $16.VariantDescriptor$json,
  '.sui.rpc.v2.FunctionDescriptor': $16.FunctionDescriptor$json,
  '.sui.rpc.v2.OpenSignature': $16.OpenSignature$json,
  '.sui.rpc.v2.TypeOrigin': $16.TypeOrigin$json,
  '.sui.rpc.v2.Linkage': $16.Linkage$json,
  '.sui.rpc.v2.Display': $14.Display$json,
  '.sui.rpc.v2.ConsensusCommitPrologue': $10.ConsensusCommitPrologue$json,
  '.sui.rpc.v2.ConsensusDeterminedVersionAssignments':
      $10.ConsensusDeterminedVersionAssignments$json,
  '.sui.rpc.v2.CanceledTransaction': $10.CanceledTransaction$json,
  '.sui.rpc.v2.VersionAssignment': $10.VersionAssignment$json,
  '.sui.rpc.v2.AuthenticatorStateUpdate': $10.AuthenticatorStateUpdate$json,
  '.sui.rpc.v2.ActiveJwk': $10.ActiveJwk$json,
  '.sui.rpc.v2.Jwk': $8.Jwk$json,
  '.sui.rpc.v2.EndOfEpochTransaction': $10.EndOfEpochTransaction$json,
  '.sui.rpc.v2.EndOfEpochTransactionKind': $10.EndOfEpochTransactionKind$json,
  '.sui.rpc.v2.AuthenticatorStateExpire': $10.AuthenticatorStateExpire$json,
  '.sui.rpc.v2.ExecutionTimeObservations': $10.ExecutionTimeObservations$json,
  '.sui.rpc.v2.ExecutionTimeObservation': $10.ExecutionTimeObservation$json,
  '.sui.rpc.v2.ValidatorExecutionTimeObservation':
      $10.ValidatorExecutionTimeObservation$json,
  '.google.protobuf.Duration': $17.Duration$json,
  '.sui.rpc.v2.RandomnessStateUpdate': $10.RandomnessStateUpdate$json,
  '.sui.rpc.v2.GasPayment': $10.GasPayment$json,
  '.sui.rpc.v2.ObjectReference': $18.ObjectReference$json,
  '.sui.rpc.v2.TransactionExpiration': $10.TransactionExpiration$json,
  '.sui.rpc.v2.TransactionEffects': $19.TransactionEffects$json,
  '.sui.rpc.v2.ExecutionStatus': $20.ExecutionStatus$json,
  '.sui.rpc.v2.ExecutionError': $20.ExecutionError$json,
  '.sui.rpc.v2.MoveAbort': $20.MoveAbort$json,
  '.sui.rpc.v2.MoveLocation': $20.MoveLocation$json,
  '.sui.rpc.v2.CleverError': $20.CleverError$json,
  '.sui.rpc.v2.SizeError': $20.SizeError$json,
  '.sui.rpc.v2.CommandArgumentError': $20.CommandArgumentError$json,
  '.sui.rpc.v2.IndexError': $20.IndexError$json,
  '.sui.rpc.v2.TypeArgumentError': $20.TypeArgumentError$json,
  '.sui.rpc.v2.PackageUpgradeError': $20.PackageUpgradeError$json,
  '.sui.rpc.v2.CoinDenyListError': $20.CoinDenyListError$json,
  '.sui.rpc.v2.CongestedObjects': $20.CongestedObjects$json,
  '.sui.rpc.v2.ChangedObject': $19.ChangedObject$json,
  '.sui.rpc.v2.AccumulatorWrite': $19.AccumulatorWrite$json,
  '.sui.rpc.v2.EventDigestEntry': $19.EventDigestEntry$json,
  '.sui.rpc.v2.UnchangedConsensusObject': $19.UnchangedConsensusObject$json,
  '.sui.rpc.v2.TransactionEvents': $21.TransactionEvents$json,
  '.sui.rpc.v2.Event': $21.Event$json,
  '.sui.rpc.v2.BalanceChange': $22.BalanceChange$json,
  '.sui.rpc.v2.ObjectSet': $14.ObjectSet$json,
};

/// Descriptor for `SubscriptionService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List subscriptionServiceDescriptor = $convert.base64Decode(
    'ChNTdWJzY3JpcHRpb25TZXJ2aWNlEmsKFFN1YnNjcmliZUNoZWNrcG9pbnRzEicuc3VpLnJwYy'
    '52Mi5TdWJzY3JpYmVDaGVja3BvaW50c1JlcXVlc3QaKC5zdWkucnBjLnYyLlN1YnNjcmliZUNo'
    'ZWNrcG9pbnRzUmVzcG9uc2UwAQ==');
