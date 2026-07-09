// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/signature.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'bcs.pb.dart' as $0;
import 'jwk.pb.dart' as $1;
import 'signature_scheme.pbenum.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

enum UserSignature_Signature { simple, multisig, zklogin, passkey, notSet }

/// A signature from a user.
class UserSignature extends $pb.GeneratedMessage {
  factory UserSignature({
    $0.Bcs? bcs,
    $2.SignatureScheme? scheme,
    SimpleSignature? simple,
    MultisigAggregatedSignature? multisig,
    ZkLoginAuthenticator? zklogin,
    PasskeyAuthenticator? passkey,
  }) {
    final result = create();
    if (bcs != null) result.bcs = bcs;
    if (scheme != null) result.scheme = scheme;
    if (simple != null) result.simple = simple;
    if (multisig != null) result.multisig = multisig;
    if (zklogin != null) result.zklogin = zklogin;
    if (passkey != null) result.passkey = passkey;
    return result;
  }

  UserSignature._();

  factory UserSignature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserSignature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, UserSignature_Signature>
      _UserSignature_SignatureByTag = {
    3: UserSignature_Signature.simple,
    4: UserSignature_Signature.multisig,
    5: UserSignature_Signature.zklogin,
    6: UserSignature_Signature.passkey,
    0: UserSignature_Signature.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserSignature',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..oo(0, [3, 4, 5, 6])
    ..aOM<$0.Bcs>(1, _omitFieldNames ? '' : 'bcs', subBuilder: $0.Bcs.create)
    ..e<$2.SignatureScheme>(
        2, _omitFieldNames ? '' : 'scheme', $pb.PbFieldType.OE,
        defaultOrMaker: $2.SignatureScheme.ED25519,
        valueOf: $2.SignatureScheme.valueOf,
        enumValues: $2.SignatureScheme.values)
    ..aOM<SimpleSignature>(3, _omitFieldNames ? '' : 'simple',
        subBuilder: SimpleSignature.create)
    ..aOM<MultisigAggregatedSignature>(4, _omitFieldNames ? '' : 'multisig',
        subBuilder: MultisigAggregatedSignature.create)
    ..aOM<ZkLoginAuthenticator>(5, _omitFieldNames ? '' : 'zklogin',
        subBuilder: ZkLoginAuthenticator.create)
    ..aOM<PasskeyAuthenticator>(6, _omitFieldNames ? '' : 'passkey',
        subBuilder: PasskeyAuthenticator.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSignature clone() => UserSignature()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserSignature copyWith(void Function(UserSignature) updates) =>
      super.copyWith((message) => updates(message as UserSignature))
          as UserSignature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserSignature create() => UserSignature._();
  @$core.override
  UserSignature createEmptyInstance() => create();
  static $pb.PbList<UserSignature> createRepeated() =>
      $pb.PbList<UserSignature>();
  @$core.pragma('dart2js:noInline')
  static UserSignature getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserSignature>(create);
  static UserSignature? _defaultInstance;

  UserSignature_Signature whichSignature() =>
      _UserSignature_SignatureByTag[$_whichOneof(0)]!;
  void clearSignature() => $_clearField($_whichOneof(0));

  /// This signature serialized as as BCS.
  ///
  /// When provided as input this will support both the form that is length
  /// prefixed as well as not length prefixed.
  @$pb.TagNumber(1)
  $0.Bcs get bcs => $_getN(0);
  @$pb.TagNumber(1)
  set bcs($0.Bcs value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasBcs() => $_has(0);
  @$pb.TagNumber(1)
  void clearBcs() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Bcs ensureBcs() => $_ensure(0);

  /// The signature scheme of this signature.
  @$pb.TagNumber(2)
  $2.SignatureScheme get scheme => $_getN(1);
  @$pb.TagNumber(2)
  set scheme($2.SignatureScheme value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasScheme() => $_has(1);
  @$pb.TagNumber(2)
  void clearScheme() => $_clearField(2);

  /// Simple signature if scheme is ed25519 | secp256k1 | secp256r1.
  @$pb.TagNumber(3)
  SimpleSignature get simple => $_getN(2);
  @$pb.TagNumber(3)
  set simple(SimpleSignature value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSimple() => $_has(2);
  @$pb.TagNumber(3)
  void clearSimple() => $_clearField(3);
  @$pb.TagNumber(3)
  SimpleSignature ensureSimple() => $_ensure(2);

  /// The multisig aggregated signature if scheme is `MULTISIG`.
  @$pb.TagNumber(4)
  MultisigAggregatedSignature get multisig => $_getN(3);
  @$pb.TagNumber(4)
  set multisig(MultisigAggregatedSignature value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMultisig() => $_has(3);
  @$pb.TagNumber(4)
  void clearMultisig() => $_clearField(4);
  @$pb.TagNumber(4)
  MultisigAggregatedSignature ensureMultisig() => $_ensure(3);

  /// The zklogin authenticator if scheme is `ZKLOGIN`.
  @$pb.TagNumber(5)
  ZkLoginAuthenticator get zklogin => $_getN(4);
  @$pb.TagNumber(5)
  set zklogin(ZkLoginAuthenticator value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasZklogin() => $_has(4);
  @$pb.TagNumber(5)
  void clearZklogin() => $_clearField(5);
  @$pb.TagNumber(5)
  ZkLoginAuthenticator ensureZklogin() => $_ensure(4);

  /// The passkey authenticator if scheme is `PASSKEY`.
  @$pb.TagNumber(6)
  PasskeyAuthenticator get passkey => $_getN(5);
  @$pb.TagNumber(6)
  set passkey(PasskeyAuthenticator value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasPasskey() => $_has(5);
  @$pb.TagNumber(6)
  void clearPasskey() => $_clearField(6);
  @$pb.TagNumber(6)
  PasskeyAuthenticator ensurePasskey() => $_ensure(5);
}

/// Either an ed25519, secp256k1 or secp256r1 signature
class SimpleSignature extends $pb.GeneratedMessage {
  factory SimpleSignature({
    $2.SignatureScheme? scheme,
    $core.List<$core.int>? signature,
    $core.List<$core.int>? publicKey,
  }) {
    final result = create();
    if (scheme != null) result.scheme = scheme;
    if (signature != null) result.signature = signature;
    if (publicKey != null) result.publicKey = publicKey;
    return result;
  }

  SimpleSignature._();

  factory SimpleSignature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SimpleSignature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SimpleSignature',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..e<$2.SignatureScheme>(
        1, _omitFieldNames ? '' : 'scheme', $pb.PbFieldType.OE,
        defaultOrMaker: $2.SignatureScheme.ED25519,
        valueOf: $2.SignatureScheme.valueOf,
        enumValues: $2.SignatureScheme.values)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'publicKey', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleSignature clone() => SimpleSignature()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SimpleSignature copyWith(void Function(SimpleSignature) updates) =>
      super.copyWith((message) => updates(message as SimpleSignature))
          as SimpleSignature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SimpleSignature create() => SimpleSignature._();
  @$core.override
  SimpleSignature createEmptyInstance() => create();
  static $pb.PbList<SimpleSignature> createRepeated() =>
      $pb.PbList<SimpleSignature>();
  @$core.pragma('dart2js:noInline')
  static SimpleSignature getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SimpleSignature>(create);
  static SimpleSignature? _defaultInstance;

  /// The signature scheme of this signature.
  @$pb.TagNumber(1)
  $2.SignatureScheme get scheme => $_getN(0);
  @$pb.TagNumber(1)
  set scheme($2.SignatureScheme value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasScheme() => $_has(0);
  @$pb.TagNumber(1)
  void clearScheme() => $_clearField(1);

  /// Signature bytes
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);

  /// Public key bytes
  @$pb.TagNumber(3)
  $core.List<$core.int> get publicKey => $_getN(2);
  @$pb.TagNumber(3)
  set publicKey($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPublicKey() => $_has(2);
  @$pb.TagNumber(3)
  void clearPublicKey() => $_clearField(3);
}

/// Public key equivalent for zklogin authenticators.
class ZkLoginPublicIdentifier extends $pb.GeneratedMessage {
  factory ZkLoginPublicIdentifier({
    $core.String? iss,
    $core.String? addressSeed,
  }) {
    final result = create();
    if (iss != null) result.iss = iss;
    if (addressSeed != null) result.addressSeed = addressSeed;
    return result;
  }

  ZkLoginPublicIdentifier._();

  factory ZkLoginPublicIdentifier.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZkLoginPublicIdentifier.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZkLoginPublicIdentifier',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'iss')
    ..aOS(2, _omitFieldNames ? '' : 'addressSeed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginPublicIdentifier clone() =>
      ZkLoginPublicIdentifier()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginPublicIdentifier copyWith(
          void Function(ZkLoginPublicIdentifier) updates) =>
      super.copyWith((message) => updates(message as ZkLoginPublicIdentifier))
          as ZkLoginPublicIdentifier;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZkLoginPublicIdentifier create() => ZkLoginPublicIdentifier._();
  @$core.override
  ZkLoginPublicIdentifier createEmptyInstance() => create();
  static $pb.PbList<ZkLoginPublicIdentifier> createRepeated() =>
      $pb.PbList<ZkLoginPublicIdentifier>();
  @$core.pragma('dart2js:noInline')
  static ZkLoginPublicIdentifier getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZkLoginPublicIdentifier>(create);
  static ZkLoginPublicIdentifier? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get iss => $_getSZ(0);
  @$pb.TagNumber(1)
  set iss($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIss() => $_has(0);
  @$pb.TagNumber(1)
  void clearIss() => $_clearField(1);

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(2)
  $core.String get addressSeed => $_getSZ(1);
  @$pb.TagNumber(2)
  set addressSeed($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAddressSeed() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddressSeed() => $_clearField(2);
}

/// Set of valid public keys for multisig committee members.
class MultisigMemberPublicKey extends $pb.GeneratedMessage {
  factory MultisigMemberPublicKey({
    $2.SignatureScheme? scheme,
    $core.List<$core.int>? publicKey,
    ZkLoginPublicIdentifier? zklogin,
  }) {
    final result = create();
    if (scheme != null) result.scheme = scheme;
    if (publicKey != null) result.publicKey = publicKey;
    if (zklogin != null) result.zklogin = zklogin;
    return result;
  }

  MultisigMemberPublicKey._();

  factory MultisigMemberPublicKey.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MultisigMemberPublicKey.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MultisigMemberPublicKey',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..e<$2.SignatureScheme>(
        1, _omitFieldNames ? '' : 'scheme', $pb.PbFieldType.OE,
        defaultOrMaker: $2.SignatureScheme.ED25519,
        valueOf: $2.SignatureScheme.valueOf,
        enumValues: $2.SignatureScheme.values)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'publicKey', $pb.PbFieldType.OY)
    ..aOM<ZkLoginPublicIdentifier>(3, _omitFieldNames ? '' : 'zklogin',
        subBuilder: ZkLoginPublicIdentifier.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigMemberPublicKey clone() =>
      MultisigMemberPublicKey()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigMemberPublicKey copyWith(
          void Function(MultisigMemberPublicKey) updates) =>
      super.copyWith((message) => updates(message as MultisigMemberPublicKey))
          as MultisigMemberPublicKey;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MultisigMemberPublicKey create() => MultisigMemberPublicKey._();
  @$core.override
  MultisigMemberPublicKey createEmptyInstance() => create();
  static $pb.PbList<MultisigMemberPublicKey> createRepeated() =>
      $pb.PbList<MultisigMemberPublicKey>();
  @$core.pragma('dart2js:noInline')
  static MultisigMemberPublicKey getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MultisigMemberPublicKey>(create);
  static MultisigMemberPublicKey? _defaultInstance;

  /// The signature scheme of this public key.
  @$pb.TagNumber(1)
  $2.SignatureScheme get scheme => $_getN(0);
  @$pb.TagNumber(1)
  set scheme($2.SignatureScheme value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasScheme() => $_has(0);
  @$pb.TagNumber(1)
  void clearScheme() => $_clearField(1);

  /// Public key bytes if scheme is ed25519 | secp256k1 | secp256r1 | passkey.
  @$pb.TagNumber(2)
  $core.List<$core.int> get publicKey => $_getN(1);
  @$pb.TagNumber(2)
  set publicKey($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPublicKey() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicKey() => $_clearField(2);

  /// A zklogin public identifier if scheme is zklogin.
  @$pb.TagNumber(3)
  ZkLoginPublicIdentifier get zklogin => $_getN(2);
  @$pb.TagNumber(3)
  set zklogin(ZkLoginPublicIdentifier value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasZklogin() => $_has(2);
  @$pb.TagNumber(3)
  void clearZklogin() => $_clearField(3);
  @$pb.TagNumber(3)
  ZkLoginPublicIdentifier ensureZklogin() => $_ensure(2);
}

/// A member in a multisig committee.
class MultisigMember extends $pb.GeneratedMessage {
  factory MultisigMember({
    MultisigMemberPublicKey? publicKey,
    $core.int? weight,
  }) {
    final result = create();
    if (publicKey != null) result.publicKey = publicKey;
    if (weight != null) result.weight = weight;
    return result;
  }

  MultisigMember._();

  factory MultisigMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MultisigMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MultisigMember',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<MultisigMemberPublicKey>(1, _omitFieldNames ? '' : 'publicKey',
        subBuilder: MultisigMemberPublicKey.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'weight', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigMember clone() => MultisigMember()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigMember copyWith(void Function(MultisigMember) updates) =>
      super.copyWith((message) => updates(message as MultisigMember))
          as MultisigMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MultisigMember create() => MultisigMember._();
  @$core.override
  MultisigMember createEmptyInstance() => create();
  static $pb.PbList<MultisigMember> createRepeated() =>
      $pb.PbList<MultisigMember>();
  @$core.pragma('dart2js:noInline')
  static MultisigMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MultisigMember>(create);
  static MultisigMember? _defaultInstance;

  /// The public key of the committee member.
  @$pb.TagNumber(1)
  MultisigMemberPublicKey get publicKey => $_getN(0);
  @$pb.TagNumber(1)
  set publicKey(MultisigMemberPublicKey value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPublicKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicKey() => $_clearField(1);
  @$pb.TagNumber(1)
  MultisigMemberPublicKey ensurePublicKey() => $_ensure(0);

  /// The weight of this member's signature.
  @$pb.TagNumber(2)
  $core.int get weight => $_getIZ(1);
  @$pb.TagNumber(2)
  set weight($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearWeight() => $_clearField(2);
}

/// A multisig committee.
class MultisigCommittee extends $pb.GeneratedMessage {
  factory MultisigCommittee({
    $core.Iterable<MultisigMember>? members,
    $core.int? threshold,
  }) {
    final result = create();
    if (members != null) result.members.addAll(members);
    if (threshold != null) result.threshold = threshold;
    return result;
  }

  MultisigCommittee._();

  factory MultisigCommittee.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MultisigCommittee.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MultisigCommittee',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<MultisigMember>(
        1, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM,
        subBuilder: MultisigMember.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'threshold', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigCommittee clone() => MultisigCommittee()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigCommittee copyWith(void Function(MultisigCommittee) updates) =>
      super.copyWith((message) => updates(message as MultisigCommittee))
          as MultisigCommittee;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MultisigCommittee create() => MultisigCommittee._();
  @$core.override
  MultisigCommittee createEmptyInstance() => create();
  static $pb.PbList<MultisigCommittee> createRepeated() =>
      $pb.PbList<MultisigCommittee>();
  @$core.pragma('dart2js:noInline')
  static MultisigCommittee getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MultisigCommittee>(create);
  static MultisigCommittee? _defaultInstance;

  /// A list of committee members and their corresponding weight.
  @$pb.TagNumber(1)
  $pb.PbList<MultisigMember> get members => $_getList(0);

  /// The threshold of signatures needed to validate a signature from
  /// this committee.
  @$pb.TagNumber(2)
  $core.int get threshold => $_getIZ(1);
  @$pb.TagNumber(2)
  set threshold($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasThreshold() => $_has(1);
  @$pb.TagNumber(2)
  void clearThreshold() => $_clearField(2);
}

/// Aggregated signature from members of a multisig committee.
class MultisigAggregatedSignature extends $pb.GeneratedMessage {
  factory MultisigAggregatedSignature({
    $core.Iterable<MultisigMemberSignature>? signatures,
    $core.int? bitmap,
    $core.List<$core.int>? legacyBitmap,
    MultisigCommittee? committee,
  }) {
    final result = create();
    if (signatures != null) result.signatures.addAll(signatures);
    if (bitmap != null) result.bitmap = bitmap;
    if (legacyBitmap != null) result.legacyBitmap = legacyBitmap;
    if (committee != null) result.committee = committee;
    return result;
  }

  MultisigAggregatedSignature._();

  factory MultisigAggregatedSignature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MultisigAggregatedSignature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MultisigAggregatedSignature',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pc<MultisigMemberSignature>(
        1, _omitFieldNames ? '' : 'signatures', $pb.PbFieldType.PM,
        subBuilder: MultisigMemberSignature.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'bitmap', $pb.PbFieldType.OU3)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'legacyBitmap', $pb.PbFieldType.OY)
    ..aOM<MultisigCommittee>(4, _omitFieldNames ? '' : 'committee',
        subBuilder: MultisigCommittee.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigAggregatedSignature clone() =>
      MultisigAggregatedSignature()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigAggregatedSignature copyWith(
          void Function(MultisigAggregatedSignature) updates) =>
      super.copyWith(
              (message) => updates(message as MultisigAggregatedSignature))
          as MultisigAggregatedSignature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MultisigAggregatedSignature create() =>
      MultisigAggregatedSignature._();
  @$core.override
  MultisigAggregatedSignature createEmptyInstance() => create();
  static $pb.PbList<MultisigAggregatedSignature> createRepeated() =>
      $pb.PbList<MultisigAggregatedSignature>();
  @$core.pragma('dart2js:noInline')
  static MultisigAggregatedSignature getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MultisigAggregatedSignature>(create);
  static MultisigAggregatedSignature? _defaultInstance;

  /// The plain signatures encoded with signature scheme.
  ///
  /// The signatures must be in the same order as they are listed in the committee.
  @$pb.TagNumber(1)
  $pb.PbList<MultisigMemberSignature> get signatures => $_getList(0);

  /// Bitmap indicating which committee members contributed to the
  /// signature.
  @$pb.TagNumber(2)
  $core.int get bitmap => $_getIZ(1);
  @$pb.TagNumber(2)
  set bitmap($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasBitmap() => $_has(1);
  @$pb.TagNumber(2)
  void clearBitmap() => $_clearField(2);

  /// If present, means this signature's on-chain format uses the old
  /// legacy multisig format.
  @$pb.TagNumber(3)
  $core.List<$core.int> get legacyBitmap => $_getN(2);
  @$pb.TagNumber(3)
  set legacyBitmap($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLegacyBitmap() => $_has(2);
  @$pb.TagNumber(3)
  void clearLegacyBitmap() => $_clearField(3);

  /// The committee to use to validate this signature.
  @$pb.TagNumber(4)
  MultisigCommittee get committee => $_getN(3);
  @$pb.TagNumber(4)
  set committee(MultisigCommittee value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCommittee() => $_has(3);
  @$pb.TagNumber(4)
  void clearCommittee() => $_clearField(4);
  @$pb.TagNumber(4)
  MultisigCommittee ensureCommittee() => $_ensure(3);
}

/// A signature from a member of a multisig committee.
class MultisigMemberSignature extends $pb.GeneratedMessage {
  factory MultisigMemberSignature({
    $2.SignatureScheme? scheme,
    $core.List<$core.int>? signature,
    ZkLoginAuthenticator? zklogin,
    PasskeyAuthenticator? passkey,
  }) {
    final result = create();
    if (scheme != null) result.scheme = scheme;
    if (signature != null) result.signature = signature;
    if (zklogin != null) result.zklogin = zklogin;
    if (passkey != null) result.passkey = passkey;
    return result;
  }

  MultisigMemberSignature._();

  factory MultisigMemberSignature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MultisigMemberSignature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MultisigMemberSignature',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..e<$2.SignatureScheme>(
        1, _omitFieldNames ? '' : 'scheme', $pb.PbFieldType.OE,
        defaultOrMaker: $2.SignatureScheme.ED25519,
        valueOf: $2.SignatureScheme.valueOf,
        enumValues: $2.SignatureScheme.values)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..aOM<ZkLoginAuthenticator>(3, _omitFieldNames ? '' : 'zklogin',
        subBuilder: ZkLoginAuthenticator.create)
    ..aOM<PasskeyAuthenticator>(4, _omitFieldNames ? '' : 'passkey',
        subBuilder: PasskeyAuthenticator.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigMemberSignature clone() =>
      MultisigMemberSignature()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MultisigMemberSignature copyWith(
          void Function(MultisigMemberSignature) updates) =>
      super.copyWith((message) => updates(message as MultisigMemberSignature))
          as MultisigMemberSignature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MultisigMemberSignature create() => MultisigMemberSignature._();
  @$core.override
  MultisigMemberSignature createEmptyInstance() => create();
  static $pb.PbList<MultisigMemberSignature> createRepeated() =>
      $pb.PbList<MultisigMemberSignature>();
  @$core.pragma('dart2js:noInline')
  static MultisigMemberSignature getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MultisigMemberSignature>(create);
  static MultisigMemberSignature? _defaultInstance;

  /// The signature scheme of this signature.
  @$pb.TagNumber(1)
  $2.SignatureScheme get scheme => $_getN(0);
  @$pb.TagNumber(1)
  set scheme($2.SignatureScheme value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasScheme() => $_has(0);
  @$pb.TagNumber(1)
  void clearScheme() => $_clearField(1);

  /// Signature bytes if scheme is ed25519 | secp256k1 | secp256r1.
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);

  /// The zklogin authenticator if scheme is `ZKLOGIN`.
  @$pb.TagNumber(3)
  ZkLoginAuthenticator get zklogin => $_getN(2);
  @$pb.TagNumber(3)
  set zklogin(ZkLoginAuthenticator value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasZklogin() => $_has(2);
  @$pb.TagNumber(3)
  void clearZklogin() => $_clearField(3);
  @$pb.TagNumber(3)
  ZkLoginAuthenticator ensureZklogin() => $_ensure(2);

  /// The passkey authenticator if scheme is `PASSKEY`.
  @$pb.TagNumber(4)
  PasskeyAuthenticator get passkey => $_getN(3);
  @$pb.TagNumber(4)
  set passkey(PasskeyAuthenticator value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPasskey() => $_has(3);
  @$pb.TagNumber(4)
  void clearPasskey() => $_clearField(4);
  @$pb.TagNumber(4)
  PasskeyAuthenticator ensurePasskey() => $_ensure(3);
}

/// A zklogin authenticator.
class ZkLoginAuthenticator extends $pb.GeneratedMessage {
  factory ZkLoginAuthenticator({
    ZkLoginInputs? inputs,
    $fixnum.Int64? maxEpoch,
    SimpleSignature? signature,
    ZkLoginPublicIdentifier? publicIdentifier,
    $1.JwkId? jwkId,
  }) {
    final result = create();
    if (inputs != null) result.inputs = inputs;
    if (maxEpoch != null) result.maxEpoch = maxEpoch;
    if (signature != null) result.signature = signature;
    if (publicIdentifier != null) result.publicIdentifier = publicIdentifier;
    if (jwkId != null) result.jwkId = jwkId;
    return result;
  }

  ZkLoginAuthenticator._();

  factory ZkLoginAuthenticator.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZkLoginAuthenticator.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZkLoginAuthenticator',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<ZkLoginInputs>(1, _omitFieldNames ? '' : 'inputs',
        subBuilder: ZkLoginInputs.create)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'maxEpoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<SimpleSignature>(3, _omitFieldNames ? '' : 'signature',
        subBuilder: SimpleSignature.create)
    ..aOM<ZkLoginPublicIdentifier>(4, _omitFieldNames ? '' : 'publicIdentifier',
        subBuilder: ZkLoginPublicIdentifier.create)
    ..aOM<$1.JwkId>(5, _omitFieldNames ? '' : 'jwkId',
        subBuilder: $1.JwkId.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginAuthenticator clone() =>
      ZkLoginAuthenticator()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginAuthenticator copyWith(void Function(ZkLoginAuthenticator) updates) =>
      super.copyWith((message) => updates(message as ZkLoginAuthenticator))
          as ZkLoginAuthenticator;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZkLoginAuthenticator create() => ZkLoginAuthenticator._();
  @$core.override
  ZkLoginAuthenticator createEmptyInstance() => create();
  static $pb.PbList<ZkLoginAuthenticator> createRepeated() =>
      $pb.PbList<ZkLoginAuthenticator>();
  @$core.pragma('dart2js:noInline')
  static ZkLoginAuthenticator getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZkLoginAuthenticator>(create);
  static ZkLoginAuthenticator? _defaultInstance;

  /// Zklogin proof and inputs required to perform proof verification.
  @$pb.TagNumber(1)
  ZkLoginInputs get inputs => $_getN(0);
  @$pb.TagNumber(1)
  set inputs(ZkLoginInputs value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInputs() => $_has(0);
  @$pb.TagNumber(1)
  void clearInputs() => $_clearField(1);
  @$pb.TagNumber(1)
  ZkLoginInputs ensureInputs() => $_ensure(0);

  /// Maximum epoch for which the proof is valid.
  @$pb.TagNumber(2)
  $fixnum.Int64 get maxEpoch => $_getI64(1);
  @$pb.TagNumber(2)
  set maxEpoch($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxEpoch() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxEpoch() => $_clearField(2);

  /// User signature with the public key attested to by the provided proof.
  @$pb.TagNumber(3)
  SimpleSignature get signature => $_getN(2);
  @$pb.TagNumber(3)
  set signature(SimpleSignature value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSignature() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignature() => $_clearField(3);
  @$pb.TagNumber(3)
  SimpleSignature ensureSignature() => $_ensure(2);

  /// The public identifier (similar to a public key) for this zklogin authenticator
  @$pb.TagNumber(4)
  ZkLoginPublicIdentifier get publicIdentifier => $_getN(3);
  @$pb.TagNumber(4)
  set publicIdentifier(ZkLoginPublicIdentifier value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPublicIdentifier() => $_has(3);
  @$pb.TagNumber(4)
  void clearPublicIdentifier() => $_clearField(4);
  @$pb.TagNumber(4)
  ZkLoginPublicIdentifier ensurePublicIdentifier() => $_ensure(3);

  /// The id of the JWK used to authorize this zklogin authenticator
  @$pb.TagNumber(5)
  $1.JwkId get jwkId => $_getN(4);
  @$pb.TagNumber(5)
  set jwkId($1.JwkId value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasJwkId() => $_has(4);
  @$pb.TagNumber(5)
  void clearJwkId() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.JwkId ensureJwkId() => $_ensure(4);
}

/// A zklogin groth16 proof and the required inputs to perform proof verification.
class ZkLoginInputs extends $pb.GeneratedMessage {
  factory ZkLoginInputs({
    ZkLoginProof? proofPoints,
    ZkLoginClaim? issBase64Details,
    $core.String? headerBase64,
    $core.String? addressSeed,
  }) {
    final result = create();
    if (proofPoints != null) result.proofPoints = proofPoints;
    if (issBase64Details != null) result.issBase64Details = issBase64Details;
    if (headerBase64 != null) result.headerBase64 = headerBase64;
    if (addressSeed != null) result.addressSeed = addressSeed;
    return result;
  }

  ZkLoginInputs._();

  factory ZkLoginInputs.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZkLoginInputs.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZkLoginInputs',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<ZkLoginProof>(1, _omitFieldNames ? '' : 'proofPoints',
        subBuilder: ZkLoginProof.create)
    ..aOM<ZkLoginClaim>(2, _omitFieldNames ? '' : 'issBase64Details',
        subBuilder: ZkLoginClaim.create)
    ..aOS(3, _omitFieldNames ? '' : 'headerBase64')
    ..aOS(4, _omitFieldNames ? '' : 'addressSeed')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginInputs clone() => ZkLoginInputs()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginInputs copyWith(void Function(ZkLoginInputs) updates) =>
      super.copyWith((message) => updates(message as ZkLoginInputs))
          as ZkLoginInputs;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZkLoginInputs create() => ZkLoginInputs._();
  @$core.override
  ZkLoginInputs createEmptyInstance() => create();
  static $pb.PbList<ZkLoginInputs> createRepeated() =>
      $pb.PbList<ZkLoginInputs>();
  @$core.pragma('dart2js:noInline')
  static ZkLoginInputs getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZkLoginInputs>(create);
  static ZkLoginInputs? _defaultInstance;

  @$pb.TagNumber(1)
  ZkLoginProof get proofPoints => $_getN(0);
  @$pb.TagNumber(1)
  set proofPoints(ZkLoginProof value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProofPoints() => $_has(0);
  @$pb.TagNumber(1)
  void clearProofPoints() => $_clearField(1);
  @$pb.TagNumber(1)
  ZkLoginProof ensureProofPoints() => $_ensure(0);

  @$pb.TagNumber(2)
  ZkLoginClaim get issBase64Details => $_getN(1);
  @$pb.TagNumber(2)
  set issBase64Details(ZkLoginClaim value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasIssBase64Details() => $_has(1);
  @$pb.TagNumber(2)
  void clearIssBase64Details() => $_clearField(2);
  @$pb.TagNumber(2)
  ZkLoginClaim ensureIssBase64Details() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.String get headerBase64 => $_getSZ(2);
  @$pb.TagNumber(3)
  set headerBase64($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHeaderBase64() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeaderBase64() => $_clearField(3);

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(4)
  $core.String get addressSeed => $_getSZ(3);
  @$pb.TagNumber(4)
  set addressSeed($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAddressSeed() => $_has(3);
  @$pb.TagNumber(4)
  void clearAddressSeed() => $_clearField(4);
}

/// A zklogin groth16 proof.
class ZkLoginProof extends $pb.GeneratedMessage {
  factory ZkLoginProof({
    CircomG1? a,
    CircomG2? b,
    CircomG1? c,
  }) {
    final result = create();
    if (a != null) result.a = a;
    if (b != null) result.b = b;
    if (c != null) result.c = c;
    return result;
  }

  ZkLoginProof._();

  factory ZkLoginProof.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZkLoginProof.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZkLoginProof',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOM<CircomG1>(1, _omitFieldNames ? '' : 'a', subBuilder: CircomG1.create)
    ..aOM<CircomG2>(2, _omitFieldNames ? '' : 'b', subBuilder: CircomG2.create)
    ..aOM<CircomG1>(3, _omitFieldNames ? '' : 'c', subBuilder: CircomG1.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginProof clone() => ZkLoginProof()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginProof copyWith(void Function(ZkLoginProof) updates) =>
      super.copyWith((message) => updates(message as ZkLoginProof))
          as ZkLoginProof;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZkLoginProof create() => ZkLoginProof._();
  @$core.override
  ZkLoginProof createEmptyInstance() => create();
  static $pb.PbList<ZkLoginProof> createRepeated() =>
      $pb.PbList<ZkLoginProof>();
  @$core.pragma('dart2js:noInline')
  static ZkLoginProof getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZkLoginProof>(create);
  static ZkLoginProof? _defaultInstance;

  @$pb.TagNumber(1)
  CircomG1 get a => $_getN(0);
  @$pb.TagNumber(1)
  set a(CircomG1 value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasA() => $_has(0);
  @$pb.TagNumber(1)
  void clearA() => $_clearField(1);
  @$pb.TagNumber(1)
  CircomG1 ensureA() => $_ensure(0);

  @$pb.TagNumber(2)
  CircomG2 get b => $_getN(1);
  @$pb.TagNumber(2)
  set b(CircomG2 value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasB() => $_has(1);
  @$pb.TagNumber(2)
  void clearB() => $_clearField(2);
  @$pb.TagNumber(2)
  CircomG2 ensureB() => $_ensure(1);

  @$pb.TagNumber(3)
  CircomG1 get c => $_getN(2);
  @$pb.TagNumber(3)
  set c(CircomG1 value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasC() => $_has(2);
  @$pb.TagNumber(3)
  void clearC() => $_clearField(3);
  @$pb.TagNumber(3)
  CircomG1 ensureC() => $_ensure(2);
}

/// A claim of the iss in a zklogin proof.
class ZkLoginClaim extends $pb.GeneratedMessage {
  factory ZkLoginClaim({
    $core.String? value,
    $core.int? indexMod4,
  }) {
    final result = create();
    if (value != null) result.value = value;
    if (indexMod4 != null) result.indexMod4 = indexMod4;
    return result;
  }

  ZkLoginClaim._();

  factory ZkLoginClaim.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ZkLoginClaim.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ZkLoginClaim',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'value')
    ..a<$core.int>(2, _omitFieldNames ? '' : 'indexMod4', $pb.PbFieldType.OU3,
        protoName: 'index_mod_4')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginClaim clone() => ZkLoginClaim()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ZkLoginClaim copyWith(void Function(ZkLoginClaim) updates) =>
      super.copyWith((message) => updates(message as ZkLoginClaim))
          as ZkLoginClaim;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ZkLoginClaim create() => ZkLoginClaim._();
  @$core.override
  ZkLoginClaim createEmptyInstance() => create();
  static $pb.PbList<ZkLoginClaim> createRepeated() =>
      $pb.PbList<ZkLoginClaim>();
  @$core.pragma('dart2js:noInline')
  static ZkLoginClaim getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ZkLoginClaim>(create);
  static ZkLoginClaim? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get indexMod4 => $_getIZ(1);
  @$pb.TagNumber(2)
  set indexMod4($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIndexMod4() => $_has(1);
  @$pb.TagNumber(2)
  void clearIndexMod4() => $_clearField(2);
}

/// A G1 point.
class CircomG1 extends $pb.GeneratedMessage {
  factory CircomG1({
    $core.String? e0,
    $core.String? e1,
    $core.String? e2,
  }) {
    final result = create();
    if (e0 != null) result.e0 = e0;
    if (e1 != null) result.e1 = e1;
    if (e2 != null) result.e2 = e2;
    return result;
  }

  CircomG1._();

  factory CircomG1.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CircomG1.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CircomG1',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'e0')
    ..aOS(2, _omitFieldNames ? '' : 'e1')
    ..aOS(3, _omitFieldNames ? '' : 'e2')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CircomG1 clone() => CircomG1()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CircomG1 copyWith(void Function(CircomG1) updates) =>
      super.copyWith((message) => updates(message as CircomG1)) as CircomG1;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CircomG1 create() => CircomG1._();
  @$core.override
  CircomG1 createEmptyInstance() => create();
  static $pb.PbList<CircomG1> createRepeated() => $pb.PbList<CircomG1>();
  @$core.pragma('dart2js:noInline')
  static CircomG1 getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CircomG1>(create);
  static CircomG1? _defaultInstance;

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(1)
  $core.String get e0 => $_getSZ(0);
  @$pb.TagNumber(1)
  set e0($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasE0() => $_has(0);
  @$pb.TagNumber(1)
  void clearE0() => $_clearField(1);

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(2)
  $core.String get e1 => $_getSZ(1);
  @$pb.TagNumber(2)
  set e1($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasE1() => $_has(1);
  @$pb.TagNumber(2)
  void clearE1() => $_clearField(2);

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(3)
  $core.String get e2 => $_getSZ(2);
  @$pb.TagNumber(3)
  set e2($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasE2() => $_has(2);
  @$pb.TagNumber(3)
  void clearE2() => $_clearField(3);
}

/// A G2 point.
class CircomG2 extends $pb.GeneratedMessage {
  factory CircomG2({
    $core.String? e00,
    $core.String? e01,
    $core.String? e10,
    $core.String? e11,
    $core.String? e20,
    $core.String? e21,
  }) {
    final result = create();
    if (e00 != null) result.e00 = e00;
    if (e01 != null) result.e01 = e01;
    if (e10 != null) result.e10 = e10;
    if (e11 != null) result.e11 = e11;
    if (e20 != null) result.e20 = e20;
    if (e21 != null) result.e21 = e21;
    return result;
  }

  CircomG2._();

  factory CircomG2.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CircomG2.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CircomG2',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'e00')
    ..aOS(2, _omitFieldNames ? '' : 'e01')
    ..aOS(3, _omitFieldNames ? '' : 'e10')
    ..aOS(4, _omitFieldNames ? '' : 'e11')
    ..aOS(5, _omitFieldNames ? '' : 'e20')
    ..aOS(6, _omitFieldNames ? '' : 'e21')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CircomG2 clone() => CircomG2()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CircomG2 copyWith(void Function(CircomG2) updates) =>
      super.copyWith((message) => updates(message as CircomG2)) as CircomG2;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CircomG2 create() => CircomG2._();
  @$core.override
  CircomG2 createEmptyInstance() => create();
  static $pb.PbList<CircomG2> createRepeated() => $pb.PbList<CircomG2>();
  @$core.pragma('dart2js:noInline')
  static CircomG2 getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CircomG2>(create);
  static CircomG2? _defaultInstance;

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(1)
  $core.String get e00 => $_getSZ(0);
  @$pb.TagNumber(1)
  set e00($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasE00() => $_has(0);
  @$pb.TagNumber(1)
  void clearE00() => $_clearField(1);

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(2)
  $core.String get e01 => $_getSZ(1);
  @$pb.TagNumber(2)
  set e01($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasE01() => $_has(1);
  @$pb.TagNumber(2)
  void clearE01() => $_clearField(2);

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(3)
  $core.String get e10 => $_getSZ(2);
  @$pb.TagNumber(3)
  set e10($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasE10() => $_has(2);
  @$pb.TagNumber(3)
  void clearE10() => $_clearField(3);

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(4)
  $core.String get e11 => $_getSZ(3);
  @$pb.TagNumber(4)
  set e11($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasE11() => $_has(3);
  @$pb.TagNumber(4)
  void clearE11() => $_clearField(4);

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(5)
  $core.String get e20 => $_getSZ(4);
  @$pb.TagNumber(5)
  set e20($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasE20() => $_has(4);
  @$pb.TagNumber(5)
  void clearE20() => $_clearField(5);

  /// base10 encoded Bn254FieldElement
  @$pb.TagNumber(6)
  $core.String get e21 => $_getSZ(5);
  @$pb.TagNumber(6)
  set e21($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasE21() => $_has(5);
  @$pb.TagNumber(6)
  void clearE21() => $_clearField(6);
}

/// A passkey authenticator.
///
/// See
/// [struct.PasskeyAuthenticator](https://mystenlabs.github.io/sui-rust-sdk/sui_sdk_types/struct.PasskeyAuthenticator.html#bcs)
/// for more information on the requirements on the shape of the
/// `client_data_json` field.
class PasskeyAuthenticator extends $pb.GeneratedMessage {
  factory PasskeyAuthenticator({
    $core.List<$core.int>? authenticatorData,
    $core.String? clientDataJson,
    SimpleSignature? signature,
  }) {
    final result = create();
    if (authenticatorData != null) result.authenticatorData = authenticatorData;
    if (clientDataJson != null) result.clientDataJson = clientDataJson;
    if (signature != null) result.signature = signature;
    return result;
  }

  PasskeyAuthenticator._();

  factory PasskeyAuthenticator.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PasskeyAuthenticator.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PasskeyAuthenticator',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'authenticatorData', $pb.PbFieldType.OY)
    ..aOS(2, _omitFieldNames ? '' : 'clientDataJson')
    ..aOM<SimpleSignature>(3, _omitFieldNames ? '' : 'signature',
        subBuilder: SimpleSignature.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasskeyAuthenticator clone() =>
      PasskeyAuthenticator()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasskeyAuthenticator copyWith(void Function(PasskeyAuthenticator) updates) =>
      super.copyWith((message) => updates(message as PasskeyAuthenticator))
          as PasskeyAuthenticator;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PasskeyAuthenticator create() => PasskeyAuthenticator._();
  @$core.override
  PasskeyAuthenticator createEmptyInstance() => create();
  static $pb.PbList<PasskeyAuthenticator> createRepeated() =>
      $pb.PbList<PasskeyAuthenticator>();
  @$core.pragma('dart2js:noInline')
  static PasskeyAuthenticator getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PasskeyAuthenticator>(create);
  static PasskeyAuthenticator? _defaultInstance;

  /// Opaque authenticator data for this passkey signature.
  ///
  /// See [Authenticator Data](https://www.w3.org/TR/webauthn-2/#sctn-authenticator-data) for
  /// more information on this field.
  @$pb.TagNumber(1)
  $core.List<$core.int> get authenticatorData => $_getN(0);
  @$pb.TagNumber(1)
  set authenticatorData($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAuthenticatorData() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuthenticatorData() => $_clearField(1);

  /// Structured, unparsed, JSON for this passkey signature.
  ///
  /// See [CollectedClientData](https://www.w3.org/TR/webauthn-2/#dictdef-collectedclientdata)
  /// for more information on this field.
  @$pb.TagNumber(2)
  $core.String get clientDataJson => $_getSZ(1);
  @$pb.TagNumber(2)
  set clientDataJson($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasClientDataJson() => $_has(1);
  @$pb.TagNumber(2)
  void clearClientDataJson() => $_clearField(2);

  /// A secp256r1 signature.
  @$pb.TagNumber(3)
  SimpleSignature get signature => $_getN(2);
  @$pb.TagNumber(3)
  set signature(SimpleSignature value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasSignature() => $_has(2);
  @$pb.TagNumber(3)
  void clearSignature() => $_clearField(3);
  @$pb.TagNumber(3)
  SimpleSignature ensureSignature() => $_ensure(2);
}

/// The validator set for a particular epoch.
class ValidatorCommittee extends $pb.GeneratedMessage {
  factory ValidatorCommittee({
    $fixnum.Int64? epoch,
    $core.Iterable<ValidatorCommitteeMember>? members,
  }) {
    final result = create();
    if (epoch != null) result.epoch = epoch;
    if (members != null) result.members.addAll(members);
    return result;
  }

  ValidatorCommittee._();

  factory ValidatorCommittee.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidatorCommittee.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidatorCommittee',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<ValidatorCommitteeMember>(
        2, _omitFieldNames ? '' : 'members', $pb.PbFieldType.PM,
        subBuilder: ValidatorCommitteeMember.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorCommittee clone() => ValidatorCommittee()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorCommittee copyWith(void Function(ValidatorCommittee) updates) =>
      super.copyWith((message) => updates(message as ValidatorCommittee))
          as ValidatorCommittee;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidatorCommittee create() => ValidatorCommittee._();
  @$core.override
  ValidatorCommittee createEmptyInstance() => create();
  static $pb.PbList<ValidatorCommittee> createRepeated() =>
      $pb.PbList<ValidatorCommittee>();
  @$core.pragma('dart2js:noInline')
  static ValidatorCommittee getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidatorCommittee>(create);
  static ValidatorCommittee? _defaultInstance;

  /// The epoch where this committee governs.
  @$pb.TagNumber(1)
  $fixnum.Int64 get epoch => $_getI64(0);
  @$pb.TagNumber(1)
  set epoch($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => $_clearField(1);

  /// The committee members.
  @$pb.TagNumber(2)
  $pb.PbList<ValidatorCommitteeMember> get members => $_getList(1);
}

/// A member of a validator committee.
class ValidatorCommitteeMember extends $pb.GeneratedMessage {
  factory ValidatorCommitteeMember({
    $core.List<$core.int>? publicKey,
    $fixnum.Int64? weight,
  }) {
    final result = create();
    if (publicKey != null) result.publicKey = publicKey;
    if (weight != null) result.weight = weight;
    return result;
  }

  ValidatorCommitteeMember._();

  factory ValidatorCommitteeMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidatorCommitteeMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidatorCommitteeMember',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'publicKey', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'weight', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorCommitteeMember clone() =>
      ValidatorCommitteeMember()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorCommitteeMember copyWith(
          void Function(ValidatorCommitteeMember) updates) =>
      super.copyWith((message) => updates(message as ValidatorCommitteeMember))
          as ValidatorCommitteeMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidatorCommitteeMember create() => ValidatorCommitteeMember._();
  @$core.override
  ValidatorCommitteeMember createEmptyInstance() => create();
  static $pb.PbList<ValidatorCommitteeMember> createRepeated() =>
      $pb.PbList<ValidatorCommitteeMember>();
  @$core.pragma('dart2js:noInline')
  static ValidatorCommitteeMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidatorCommitteeMember>(create);
  static ValidatorCommitteeMember? _defaultInstance;

  /// The 96-byte Bls12381 public key for this validator.
  @$pb.TagNumber(1)
  $core.List<$core.int> get publicKey => $_getN(0);
  @$pb.TagNumber(1)
  set publicKey($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPublicKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearPublicKey() => $_clearField(1);

  /// voting weight this validator possesses.
  @$pb.TagNumber(2)
  $fixnum.Int64 get weight => $_getI64(1);
  @$pb.TagNumber(2)
  set weight($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearWeight() => $_clearField(2);
}

/// / An aggregated signature from multiple validators.
class ValidatorAggregatedSignature extends $pb.GeneratedMessage {
  factory ValidatorAggregatedSignature({
    $fixnum.Int64? epoch,
    $core.List<$core.int>? signature,
    $core.List<$core.int>? bitmap,
  }) {
    final result = create();
    if (epoch != null) result.epoch = epoch;
    if (signature != null) result.signature = signature;
    if (bitmap != null) result.bitmap = bitmap;
    return result;
  }

  ValidatorAggregatedSignature._();

  factory ValidatorAggregatedSignature.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ValidatorAggregatedSignature.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ValidatorAggregatedSignature',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'signature', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'bitmap', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorAggregatedSignature clone() =>
      ValidatorAggregatedSignature()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorAggregatedSignature copyWith(
          void Function(ValidatorAggregatedSignature) updates) =>
      super.copyWith(
              (message) => updates(message as ValidatorAggregatedSignature))
          as ValidatorAggregatedSignature;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidatorAggregatedSignature create() =>
      ValidatorAggregatedSignature._();
  @$core.override
  ValidatorAggregatedSignature createEmptyInstance() => create();
  static $pb.PbList<ValidatorAggregatedSignature> createRepeated() =>
      $pb.PbList<ValidatorAggregatedSignature>();
  @$core.pragma('dart2js:noInline')
  static ValidatorAggregatedSignature getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ValidatorAggregatedSignature>(create);
  static ValidatorAggregatedSignature? _defaultInstance;

  /// The epoch when this signature was produced.
  ///
  /// This can be used to lookup the `ValidatorCommittee` from this epoch
  /// to verify this signature.
  @$pb.TagNumber(1)
  $fixnum.Int64 get epoch => $_getI64(0);
  @$pb.TagNumber(1)
  set epoch($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpoch() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpoch() => $_clearField(1);

  /// The 48-byte Bls12381 aggregated signature.
  @$pb.TagNumber(2)
  $core.List<$core.int> get signature => $_getN(1);
  @$pb.TagNumber(2)
  set signature($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSignature() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignature() => $_clearField(2);

  /// Bitmap indicating which members of the committee contributed to
  /// this signature.
  @$pb.TagNumber(3)
  $core.List<$core.int> get bitmap => $_getN(2);
  @$pb.TagNumber(3)
  set bitmap($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBitmap() => $_has(2);
  @$pb.TagNumber(3)
  void clearBitmap() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
