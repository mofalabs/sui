// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/name_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'name_service.pb.dart' as $1;
import 'name_service.pbjson.dart';

export 'name_service.pb.dart';

abstract class NameServiceBase extends $pb.GeneratedService {
  $async.Future<$1.LookupNameResponse> lookupName(
      $pb.ServerContext ctx, $1.LookupNameRequest request);
  $async.Future<$1.ReverseLookupNameResponse> reverseLookupName(
      $pb.ServerContext ctx, $1.ReverseLookupNameRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'LookupName':
        return $1.LookupNameRequest();
      case 'ReverseLookupName':
        return $1.ReverseLookupNameRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'LookupName':
        return lookupName(ctx, request as $1.LookupNameRequest);
      case 'ReverseLookupName':
        return reverseLookupName(ctx, request as $1.ReverseLookupNameRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => NameServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => NameServiceBase$messageJson;
}
