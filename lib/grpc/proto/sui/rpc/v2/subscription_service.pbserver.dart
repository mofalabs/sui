// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/subscription_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'subscription_service.pb.dart' as $25;
import 'subscription_service.pbjson.dart';

export 'subscription_service.pb.dart';

abstract class SubscriptionServiceBase extends $pb.GeneratedService {
  $async.Future<$25.SubscribeCheckpointsResponse> subscribeCheckpoints(
      $pb.ServerContext ctx, $25.SubscribeCheckpointsRequest request);
  $async.Future<$25.SubscribeTransactionsResponse> subscribeTransactions(
      $pb.ServerContext ctx, $25.SubscribeTransactionsRequest request);
  $async.Future<$25.SubscribeEventsResponse> subscribeEvents(
      $pb.ServerContext ctx, $25.SubscribeEventsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'SubscribeCheckpoints':
        return $25.SubscribeCheckpointsRequest();
      case 'SubscribeTransactions':
        return $25.SubscribeTransactionsRequest();
      case 'SubscribeEvents':
        return $25.SubscribeEventsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'SubscribeCheckpoints':
        return subscribeCheckpoints(
            ctx, request as $25.SubscribeCheckpointsRequest);
      case 'SubscribeTransactions':
        return subscribeTransactions(
            ctx, request as $25.SubscribeTransactionsRequest);
      case 'SubscribeEvents':
        return subscribeEvents(ctx, request as $25.SubscribeEventsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      SubscriptionServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => SubscriptionServiceBase$messageJson;
}
