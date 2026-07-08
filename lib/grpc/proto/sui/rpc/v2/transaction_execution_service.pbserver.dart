// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/transaction_execution_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'transaction_execution_service.pb.dart' as $20;
import 'transaction_execution_service.pbjson.dart';

export 'transaction_execution_service.pb.dart';

abstract class TransactionExecutionServiceBase extends $pb.GeneratedService {
  $async.Future<$20.ExecuteTransactionResponse> executeTransaction($pb.ServerContext ctx, $20.ExecuteTransactionRequest request);
  $async.Future<$20.SimulateTransactionResponse> simulateTransaction($pb.ServerContext ctx, $20.SimulateTransactionRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ExecuteTransaction': return $20.ExecuteTransactionRequest();
      case 'SimulateTransaction': return $20.SimulateTransactionRequest();
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ExecuteTransaction': return executeTransaction(ctx, request as $20.ExecuteTransactionRequest);
      case 'SimulateTransaction': return simulateTransaction(ctx, request as $20.SimulateTransactionRequest);
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => TransactionExecutionServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => TransactionExecutionServiceBase$messageJson;
}

