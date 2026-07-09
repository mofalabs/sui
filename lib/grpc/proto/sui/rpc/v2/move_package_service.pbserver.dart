// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/move_package_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'move_package_service.pb.dart' as $1;
import 'move_package_service.pbjson.dart';

export 'move_package_service.pb.dart';

abstract class MovePackageServiceBase extends $pb.GeneratedService {
  $async.Future<$1.GetPackageResponse> getPackage(
      $pb.ServerContext ctx, $1.GetPackageRequest request);
  $async.Future<$1.GetDatatypeResponse> getDatatype(
      $pb.ServerContext ctx, $1.GetDatatypeRequest request);
  $async.Future<$1.GetFunctionResponse> getFunction(
      $pb.ServerContext ctx, $1.GetFunctionRequest request);
  $async.Future<$1.ListPackageVersionsResponse> listPackageVersions(
      $pb.ServerContext ctx, $1.ListPackageVersionsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetPackage':
        return $1.GetPackageRequest();
      case 'GetDatatype':
        return $1.GetDatatypeRequest();
      case 'GetFunction':
        return $1.GetFunctionRequest();
      case 'ListPackageVersions':
        return $1.ListPackageVersionsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetPackage':
        return getPackage(ctx, request as $1.GetPackageRequest);
      case 'GetDatatype':
        return getDatatype(ctx, request as $1.GetDatatypeRequest);
      case 'GetFunction':
        return getFunction(ctx, request as $1.GetFunctionRequest);
      case 'ListPackageVersions':
        return listPackageVersions(
            ctx, request as $1.ListPackageVersionsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json =>
      MovePackageServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => MovePackageServiceBase$messageJson;
}
