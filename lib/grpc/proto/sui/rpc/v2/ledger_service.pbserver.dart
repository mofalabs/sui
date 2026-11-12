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

import 'ledger_service.pb.dart' as $30;
import 'ledger_service.pbjson.dart';

export 'ledger_service.pb.dart';

abstract class LedgerServiceBase extends $pb.GeneratedService {
  $async.Future<$30.GetServiceInfoResponse> getServiceInfo(
      $pb.ServerContext ctx, $30.GetServiceInfoRequest request);
  $async.Future<$30.GetObjectResponse> getObject(
      $pb.ServerContext ctx, $30.GetObjectRequest request);
  $async.Future<$30.BatchGetObjectsResponse> batchGetObjects(
      $pb.ServerContext ctx, $30.BatchGetObjectsRequest request);
  $async.Future<$30.GetTransactionResponse> getTransaction(
      $pb.ServerContext ctx, $30.GetTransactionRequest request);
  $async.Future<$30.BatchGetTransactionsResponse> batchGetTransactions(
      $pb.ServerContext ctx, $30.BatchGetTransactionsRequest request);
  $async.Future<$30.GetCheckpointResponse> getCheckpoint(
      $pb.ServerContext ctx, $30.GetCheckpointRequest request);
  $async.Future<$30.GetEpochResponse> getEpoch(
      $pb.ServerContext ctx, $30.GetEpochRequest request);
  $async.Future<$30.ListCheckpointsResponse> listCheckpoints(
      $pb.ServerContext ctx, $30.ListCheckpointsRequest request);
  $async.Future<$30.ListTransactionsResponse> listTransactions(
      $pb.ServerContext ctx, $30.ListTransactionsRequest request);
  $async.Future<$30.ListEventsResponse> listEvents(
      $pb.ServerContext ctx, $30.ListEventsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetServiceInfo':
        return $30.GetServiceInfoRequest();
      case 'GetObject':
        return $30.GetObjectRequest();
      case 'BatchGetObjects':
        return $30.BatchGetObjectsRequest();
      case 'GetTransaction':
        return $30.GetTransactionRequest();
      case 'BatchGetTransactions':
        return $30.BatchGetTransactionsRequest();
      case 'GetCheckpoint':
        return $30.GetCheckpointRequest();
      case 'GetEpoch':
        return $30.GetEpochRequest();
      case 'ListCheckpoints':
        return $30.ListCheckpointsRequest();
      case 'ListTransactions':
        return $30.ListTransactionsRequest();
      case 'ListEvents':
        return $30.ListEventsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetServiceInfo':
        return getServiceInfo(ctx, request as $30.GetServiceInfoRequest);
      case 'GetObject':
        return getObject(ctx, request as $30.GetObjectRequest);
      case 'BatchGetObjects':
        return batchGetObjects(ctx, request as $30.BatchGetObjectsRequest);
      case 'GetTransaction':
        return getTransaction(ctx, request as $30.GetTransactionRequest);
      case 'BatchGetTransactions':
        return batchGetTransactions(
            ctx, request as $30.BatchGetTransactionsRequest);
      case 'GetCheckpoint':
        return getCheckpoint(ctx, request as $30.GetCheckpointRequest);
      case 'GetEpoch':
        return getEpoch(ctx, request as $30.GetEpochRequest);
      case 'ListCheckpoints':
        return listCheckpoints(ctx, request as $30.ListCheckpointsRequest);
      case 'ListTransactions':
        return listTransactions(ctx, request as $30.ListTransactionsRequest);
      case 'ListEvents':
        return listEvents(ctx, request as $30.ListEventsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => LedgerServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => LedgerServiceBase$messageJson;
}
