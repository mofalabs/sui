// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/checkpoint_contents.proto.

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
import 'signature.pb.dart' as $1;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// The committed to contents of a checkpoint.
class CheckpointContents extends $pb.GeneratedMessage {
  factory CheckpointContents({
    $0.Bcs? bcs,
    $core.String? digest,
    $core.int? version,
    $core.Iterable<CheckpointedTransactionInfo>? transactions,
  }) {
    final result = create();
    if (bcs != null) result.bcs = bcs;
    if (digest != null) result.digest = digest;
    if (version != null) result.version = version;
    if (transactions != null) result.transactions.addAll(transactions);
    return result;
  }

  CheckpointContents._();

  factory CheckpointContents.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CheckpointContents.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckpointContents', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOM<$0.Bcs>(1, _omitFieldNames ? '' : 'bcs', subBuilder: $0.Bcs.create)
    ..aOS(2, _omitFieldNames ? '' : 'digest')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'version', $pb.PbFieldType.O3)
    ..pc<CheckpointedTransactionInfo>(4, _omitFieldNames ? '' : 'transactions', $pb.PbFieldType.PM, subBuilder: CheckpointedTransactionInfo.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckpointContents clone() => CheckpointContents()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckpointContents copyWith(void Function(CheckpointContents) updates) => super.copyWith((message) => updates(message as CheckpointContents)) as CheckpointContents;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckpointContents create() => CheckpointContents._();
  @$core.override
  CheckpointContents createEmptyInstance() => create();
  static $pb.PbList<CheckpointContents> createRepeated() => $pb.PbList<CheckpointContents>();
  @$core.pragma('dart2js:noInline')
  static CheckpointContents getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckpointContents>(create);
  static CheckpointContents? _defaultInstance;

  /// This CheckpointContents serialized as BCS.
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

  /// The digest of this CheckpointContents.
  @$pb.TagNumber(2)
  $core.String get digest => $_getSZ(1);
  @$pb.TagNumber(2)
  set digest($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDigest() => $_has(1);
  @$pb.TagNumber(2)
  void clearDigest() => $_clearField(2);

  /// Version of this CheckpointContents
  @$pb.TagNumber(3)
  $core.int get version => $_getIZ(2);
  @$pb.TagNumber(3)
  set version($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearVersion() => $_clearField(3);

  /// Set of transactions committed to in this checkpoint.
  @$pb.TagNumber(4)
  $pb.PbList<CheckpointedTransactionInfo> get transactions => $_getList(3);
}

/// Transaction information committed to in a checkpoint.
class CheckpointedTransactionInfo extends $pb.GeneratedMessage {
  factory CheckpointedTransactionInfo({
    $core.String? transaction,
    $core.String? effects,
    $core.Iterable<$1.UserSignature>? signatures,
    $core.Iterable<AddressAliasesVersion>? addressAliasesVersions,
  }) {
    final result = create();
    if (transaction != null) result.transaction = transaction;
    if (effects != null) result.effects = effects;
    if (signatures != null) result.signatures.addAll(signatures);
    if (addressAliasesVersions != null) result.addressAliasesVersions.addAll(addressAliasesVersions);
    return result;
  }

  CheckpointedTransactionInfo._();

  factory CheckpointedTransactionInfo.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory CheckpointedTransactionInfo.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CheckpointedTransactionInfo', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'transaction')
    ..aOS(2, _omitFieldNames ? '' : 'effects')
    ..pc<$1.UserSignature>(3, _omitFieldNames ? '' : 'signatures', $pb.PbFieldType.PM, subBuilder: $1.UserSignature.create)
    ..pc<AddressAliasesVersion>(4, _omitFieldNames ? '' : 'addressAliasesVersions', $pb.PbFieldType.PM, subBuilder: AddressAliasesVersion.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckpointedTransactionInfo clone() => CheckpointedTransactionInfo()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckpointedTransactionInfo copyWith(void Function(CheckpointedTransactionInfo) updates) => super.copyWith((message) => updates(message as CheckpointedTransactionInfo)) as CheckpointedTransactionInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CheckpointedTransactionInfo create() => CheckpointedTransactionInfo._();
  @$core.override
  CheckpointedTransactionInfo createEmptyInstance() => create();
  static $pb.PbList<CheckpointedTransactionInfo> createRepeated() => $pb.PbList<CheckpointedTransactionInfo>();
  @$core.pragma('dart2js:noInline')
  static CheckpointedTransactionInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CheckpointedTransactionInfo>(create);
  static CheckpointedTransactionInfo? _defaultInstance;

  /// Digest of the transaction.
  @$pb.TagNumber(1)
  $core.String get transaction => $_getSZ(0);
  @$pb.TagNumber(1)
  set transaction($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTransaction() => $_has(0);
  @$pb.TagNumber(1)
  void clearTransaction() => $_clearField(1);

  /// Digest of the effects.
  @$pb.TagNumber(2)
  $core.String get effects => $_getSZ(1);
  @$pb.TagNumber(2)
  set effects($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEffects() => $_has(1);
  @$pb.TagNumber(2)
  void clearEffects() => $_clearField(2);

  /// Set of user signatures that authorized the transaction.
  @$pb.TagNumber(3)
  $pb.PbList<$1.UserSignature> get signatures => $_getList(2);

  /// The `AddressAliases` object version, if any, that was used to verify the
  /// UserSignature at the same position in `signatures`.
  ///
  /// This field is present when CheckpointContents.version is >= 2.
  @$pb.TagNumber(4)
  $pb.PbList<AddressAliasesVersion> get addressAliasesVersions => $_getList(3);
}

class AddressAliasesVersion extends $pb.GeneratedMessage {
  factory AddressAliasesVersion({
    $fixnum.Int64? version,
  }) {
    final result = create();
    if (version != null) result.version = version;
    return result;
  }

  AddressAliasesVersion._();

  factory AddressAliasesVersion.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory AddressAliasesVersion.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AddressAliasesVersion', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddressAliasesVersion clone() => AddressAliasesVersion()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddressAliasesVersion copyWith(void Function(AddressAliasesVersion) updates) => super.copyWith((message) => updates(message as AddressAliasesVersion)) as AddressAliasesVersion;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddressAliasesVersion create() => AddressAliasesVersion._();
  @$core.override
  AddressAliasesVersion createEmptyInstance() => create();
  static $pb.PbList<AddressAliasesVersion> createRepeated() => $pb.PbList<AddressAliasesVersion>();
  @$core.pragma('dart2js:noInline')
  static AddressAliasesVersion getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddressAliasesVersion>(create);
  static AddressAliasesVersion? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get version => $_getI64(0);
  @$pb.TagNumber(1)
  set version($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
