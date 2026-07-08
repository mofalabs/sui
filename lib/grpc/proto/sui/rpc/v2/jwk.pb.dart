// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/jwk.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Key to uniquely identify a JWK.
class JwkId extends $pb.GeneratedMessage {
  factory JwkId({
    $core.String? iss,
    $core.String? kid,
  }) {
    final result = create();
    if (iss != null) result.iss = iss;
    if (kid != null) result.kid = kid;
    return result;
  }

  JwkId._();

  factory JwkId.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory JwkId.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'JwkId', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iss')
    ..aOS(2, _omitFieldNames ? '' : 'kid')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JwkId clone() => JwkId()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JwkId copyWith(void Function(JwkId) updates) => super.copyWith((message) => updates(message as JwkId)) as JwkId;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static JwkId create() => JwkId._();
  @$core.override
  JwkId createEmptyInstance() => create();
  static $pb.PbList<JwkId> createRepeated() => $pb.PbList<JwkId>();
  @$core.pragma('dart2js:noInline')
  static JwkId getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JwkId>(create);
  static JwkId? _defaultInstance;

  /// The issuer or identity of the OIDC provider.
  @$pb.TagNumber(1)
  $core.String get iss => $_getSZ(0);
  @$pb.TagNumber(1)
  set iss($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIss() => $_has(0);
  @$pb.TagNumber(1)
  void clearIss() => $_clearField(1);

  /// A key ID used to uniquely identify a key from an OIDC provider.
  @$pb.TagNumber(2)
  $core.String get kid => $_getSZ(1);
  @$pb.TagNumber(2)
  set kid($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKid() => $_has(1);
  @$pb.TagNumber(2)
  void clearKid() => $_clearField(2);
}

/// A JSON web key.
///
/// Struct that contains info for a JWK. A list of them for different kinds can
/// be retrieved from the JWK endpoint (for example, <https://www.googleapis.com/oauth2/v3/certs>).
/// The JWK is used to verify the JWT token.
class Jwk extends $pb.GeneratedMessage {
  factory Jwk({
    $core.String? kty,
    $core.String? e,
    $core.String? n,
    $core.String? alg,
  }) {
    final result = create();
    if (kty != null) result.kty = kty;
    if (e != null) result.e = e;
    if (n != null) result.n = n;
    if (alg != null) result.alg = alg;
    return result;
  }

  Jwk._();

  factory Jwk.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Jwk.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Jwk', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'kty')
    ..aOS(2, _omitFieldNames ? '' : 'e')
    ..aOS(3, _omitFieldNames ? '' : 'n')
    ..aOS(4, _omitFieldNames ? '' : 'alg')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Jwk clone() => Jwk()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Jwk copyWith(void Function(Jwk) updates) => super.copyWith((message) => updates(message as Jwk)) as Jwk;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Jwk create() => Jwk._();
  @$core.override
  Jwk createEmptyInstance() => create();
  static $pb.PbList<Jwk> createRepeated() => $pb.PbList<Jwk>();
  @$core.pragma('dart2js:noInline')
  static Jwk getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Jwk>(create);
  static Jwk? _defaultInstance;

  /// Key type parameter, https://datatracker.ietf.org/doc/html/rfc7517#section-4.1.
  @$pb.TagNumber(1)
  $core.String get kty => $_getSZ(0);
  @$pb.TagNumber(1)
  set kty($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKty() => $_has(0);
  @$pb.TagNumber(1)
  void clearKty() => $_clearField(1);

  /// RSA public exponent, https://datatracker.ietf.org/doc/html/rfc7517#section-9.3.
  @$pb.TagNumber(2)
  $core.String get e => $_getSZ(1);
  @$pb.TagNumber(2)
  set e($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasE() => $_has(1);
  @$pb.TagNumber(2)
  void clearE() => $_clearField(2);

  /// RSA modulus, https://datatracker.ietf.org/doc/html/rfc7517#section-9.3.
  @$pb.TagNumber(3)
  $core.String get n => $_getSZ(2);
  @$pb.TagNumber(3)
  set n($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasN() => $_has(2);
  @$pb.TagNumber(3)
  void clearN() => $_clearField(3);

  /// Algorithm parameter, https://datatracker.ietf.org/doc/html/rfc7517#section-4.4.
  @$pb.TagNumber(4)
  $core.String get alg => $_getSZ(3);
  @$pb.TagNumber(4)
  set alg($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAlg() => $_has(3);
  @$pb.TagNumber(4)
  void clearAlg() => $_clearField(4);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
