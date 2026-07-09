// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/ledger_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'ledger_service.pb.dart' as $28;
import 'ledger_service.pbjson.dart';

export 'ledger_service.pb.dart';

abstract class LedgerServiceBase extends $pb.GeneratedService {
  $async.Future<$28.GetServiceInfoResponse> getServiceInfo(
      $pb.ServerContext ctx, $28.GetServiceInfoRequest request);
  $async.Future<$28.GetObjectResponse> getObject(
      $pb.ServerContext ctx, $28.GetObjectRequest request);
  $async.Future<$28.BatchGetObjectsResponse> batchGetObjects(
      $pb.ServerContext ctx, $28.BatchGetObjectsRequest request);
  $async.Future<$28.GetTransactionResponse> getTransaction(
      $pb.ServerContext ctx, $28.GetTransactionRequest request);
  $async.Future<$28.BatchGetTransactionsResponse> batchGetTransactions(
      $pb.ServerContext ctx, $28.BatchGetTransactionsRequest request);
  $async.Future<$28.GetCheckpointResponse> getCheckpoint(
      $pb.ServerContext ctx, $28.GetCheckpointRequest request);
  $async.Future<$28.GetEpochResponse> getEpoch(
      $pb.ServerContext ctx, $28.GetEpochRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetServiceInfo':
        return $28.GetServiceInfoRequest();
      case 'GetObject':
        return $28.GetObjectRequest();
      case 'BatchGetObjects':
        return $28.BatchGetObjectsRequest();
      case 'GetTransaction':
        return $28.GetTransactionRequest();
      case 'BatchGetTransactions':
        return $28.BatchGetTransactionsRequest();
      case 'GetCheckpoint':
        return $28.GetCheckpointRequest();
      case 'GetEpoch':
        return $28.GetEpochRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetServiceInfo':
        return getServiceInfo(ctx, request as $28.GetServiceInfoRequest);
      case 'GetObject':
        return getObject(ctx, request as $28.GetObjectRequest);
      case 'BatchGetObjects':
        return batchGetObjects(ctx, request as $28.BatchGetObjectsRequest);
      case 'GetTransaction':
        return getTransaction(ctx, request as $28.GetTransactionRequest);
      case 'BatchGetTransactions':
        return batchGetTransactions(
            ctx, request as $28.BatchGetTransactionsRequest);
      case 'GetCheckpoint':
        return getCheckpoint(ctx, request as $28.GetCheckpointRequest);
      case 'GetEpoch':
        return getEpoch(ctx, request as $28.GetEpochRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => LedgerServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => LedgerServiceBase$messageJson;
}
