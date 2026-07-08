// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/state_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'state_service.pb.dart' as $6;
import 'state_service.pbjson.dart';

export 'state_service.pb.dart';

abstract class StateServiceBase extends $pb.GeneratedService {
  $async.Future<$6.ListDynamicFieldsResponse> listDynamicFields($pb.ServerContext ctx, $6.ListDynamicFieldsRequest request);
  $async.Future<$6.ListOwnedObjectsResponse> listOwnedObjects($pb.ServerContext ctx, $6.ListOwnedObjectsRequest request);
  $async.Future<$6.GetCoinInfoResponse> getCoinInfo($pb.ServerContext ctx, $6.GetCoinInfoRequest request);
  $async.Future<$6.GetBalanceResponse> getBalance($pb.ServerContext ctx, $6.GetBalanceRequest request);
  $async.Future<$6.ListBalancesResponse> listBalances($pb.ServerContext ctx, $6.ListBalancesRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListDynamicFields': return $6.ListDynamicFieldsRequest();
      case 'ListOwnedObjects': return $6.ListOwnedObjectsRequest();
      case 'GetCoinInfo': return $6.GetCoinInfoRequest();
      case 'GetBalance': return $6.GetBalanceRequest();
      case 'ListBalances': return $6.ListBalancesRequest();
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListDynamicFields': return listDynamicFields(ctx, request as $6.ListDynamicFieldsRequest);
      case 'ListOwnedObjects': return listOwnedObjects(ctx, request as $6.ListOwnedObjectsRequest);
      case 'GetCoinInfo': return getCoinInfo(ctx, request as $6.GetCoinInfoRequest);
      case 'GetBalance': return getBalance(ctx, request as $6.GetBalanceRequest);
      case 'ListBalances': return listBalances(ctx, request as $6.ListBalancesRequest);
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => StateServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => StateServiceBase$messageJson;
}

