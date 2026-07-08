// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/signature_verification_service.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'signature_verification_service.pb.dart' as $4;
import 'signature_verification_service.pbjson.dart';

export 'signature_verification_service.pb.dart';

abstract class SignatureVerificationServiceBase extends $pb.GeneratedService {
  $async.Future<$4.VerifySignatureResponse> verifySignature($pb.ServerContext ctx, $4.VerifySignatureRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'VerifySignature': return $4.VerifySignatureRequest();
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx, $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'VerifySignature': return verifySignature(ctx, request as $4.VerifySignatureRequest);
      default: throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => SignatureVerificationServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>> get $messageJson => SignatureVerificationServiceBase$messageJson;
}

