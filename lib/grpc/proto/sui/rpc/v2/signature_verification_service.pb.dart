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

import 'bcs.pb.dart' as $0;
import 'signature.pb.dart' as $1;
import 'transaction.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class VerifySignatureRequest extends $pb.GeneratedMessage {
  factory VerifySignatureRequest({
    $0.Bcs? message,
    $1.UserSignature? signature,
    $core.String? address,
    $core.Iterable<$2.ActiveJwk>? jwks,
  }) {
    final result = create();
    if (message != null) result.message = message;
    if (signature != null) result.signature = signature;
    if (address != null) result.address = address;
    if (jwks != null) result.jwks.addAll(jwks);
    return result;
  }

  VerifySignatureRequest._();

  factory VerifySignatureRequest.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory VerifySignatureRequest.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifySignatureRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$0.Bcs>(1, _omitFieldNames ? '' : 'message', subBuilder: $0.Bcs.create)
    ..aOM<$1.UserSignature>(2, _omitFieldNames ? '' : 'signature', subBuilder: $1.UserSignature.create)
    ..aOS(3, _omitFieldNames ? '' : 'address')
    ..pc<$2.ActiveJwk>(4, _omitFieldNames ? '' : 'jwks', $pb.PbFieldType.PM, subBuilder: $2.ActiveJwk.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifySignatureRequest clone() => VerifySignatureRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifySignatureRequest copyWith(void Function(VerifySignatureRequest) updates) => super.copyWith((message) => updates(message as VerifySignatureRequest)) as VerifySignatureRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifySignatureRequest create() => VerifySignatureRequest._();
  @$core.override
  VerifySignatureRequest createEmptyInstance() => create();
  static $pb.PbList<VerifySignatureRequest> createRepeated() => $pb.PbList<VerifySignatureRequest>();
  @$core.pragma('dart2js:noInline')
  static VerifySignatureRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifySignatureRequest>(create);
  static VerifySignatureRequest? _defaultInstance;

  /// The message to verify against.
  ///
  /// Today the only supported message types are `PersonalMessage` and
  /// `TransactionData` and the `Bcs.name` must be set to indicate which type of
  /// message is being verified.
  @$pb.TagNumber(1)
  $0.Bcs get message => $_getN(0);
  @$pb.TagNumber(1)
  set message($0.Bcs value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Bcs ensureMessage() => $_ensure(0);

  /// The signature to verify.
  @$pb.TagNumber(2)
  $1.UserSignature get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($1.UserSignature value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.UserSignature ensureSignature() => $_ensure(1);

  /// Optional. Address to validate against the provided signature.
  ///
  /// If provided, this address will be compared against the the address derived
  /// from the provide signature and a successful response will only be returned
  /// if they match.
  @$pb.TagNumber(3)
  $core.String get address => $_getSZ(2);
  @$pb.TagNumber(3)
  set address($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAddress() => $_has(2);
  @$pb.TagNumber(3)
  void clearAddress() => $_clearField(3);

  /// The set of JWKs to use when verifying Zklogin signatures.
  /// If this is empty the current set of valid JWKs stored onchain will be used
  @$pb.TagNumber(4)
  $pb.PbList<$2.ActiveJwk> get jwks => $_getList(3);
}

class VerifySignatureResponse extends $pb.GeneratedMessage {
  factory VerifySignatureResponse({
    $core.bool? isValid,
    $core.String? reason,
  }) {
    final result = create();
    if (isValid != null) result.isValid = isValid;
    if (reason != null) result.reason = reason;
    return result;
  }

  VerifySignatureResponse._();

  factory VerifySignatureResponse.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory VerifySignatureResponse.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifySignatureResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isValid')
    ..aOS(2, _omitFieldNames ? '' : 'reason')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifySignatureResponse clone() => VerifySignatureResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VerifySignatureResponse copyWith(void Function(VerifySignatureResponse) updates) => super.copyWith((message) => updates(message as VerifySignatureResponse)) as VerifySignatureResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifySignatureResponse create() => VerifySignatureResponse._();
  @$core.override
  VerifySignatureResponse createEmptyInstance() => create();
  static $pb.PbList<VerifySignatureResponse> createRepeated() => $pb.PbList<VerifySignatureResponse>();
  @$core.pragma('dart2js:noInline')
  static VerifySignatureResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifySignatureResponse>(create);
  static VerifySignatureResponse? _defaultInstance;

  /// Indicates if the provided signature was valid given the requested parameters.
  @$pb.TagNumber(1)
  $core.bool get isValid => $_getBF(0);
  @$pb.TagNumber(1)
  set isValid($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsValid() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsValid() => $_clearField(1);

  /// If `is_valid` is `false`, this is the reason for why the signature verification failed.
  @$pb.TagNumber(2)
  $core.String get reason => $_getSZ(1);
  @$pb.TagNumber(2)
  set reason($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => $_clearField(2);
}

class SignatureVerificationServiceApi {
  final $pb.RpcClient _client;

  SignatureVerificationServiceApi(this._client);

  /// Perform signature verification of a UserSignature against the provided message.
  $async.Future<VerifySignatureResponse> verifySignature($pb.ClientContext? ctx, VerifySignatureRequest request) =>
    _client.invoke<VerifySignatureResponse>(ctx, 'SignatureVerificationService', 'VerifySignature', request, VerifySignatureResponse())
  ;
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
