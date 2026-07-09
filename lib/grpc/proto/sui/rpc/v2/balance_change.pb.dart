// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/balance_change.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// The delta, or change, in balance for an address for a particular `Coin` type.
class BalanceChange extends $pb.GeneratedMessage {
  factory BalanceChange({
    $core.String? address,
    $core.String? coinType,
    $core.String? amount,
  }) {
    final result = create();
    if (address != null) result.address = address;
    if (coinType != null) result.coinType = coinType;
    if (amount != null) result.amount = amount;
    return result;
  }

  BalanceChange._();

  factory BalanceChange.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory BalanceChange.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BalanceChange',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..aOS(2, _omitFieldNames ? '' : 'coinType')
    ..aOS(3, _omitFieldNames ? '' : 'amount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BalanceChange clone() => BalanceChange()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BalanceChange copyWith(void Function(BalanceChange) updates) =>
      super.copyWith((message) => updates(message as BalanceChange))
          as BalanceChange;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static BalanceChange create() => BalanceChange._();
  @$core.override
  BalanceChange createEmptyInstance() => create();
  static $pb.PbList<BalanceChange> createRepeated() =>
      $pb.PbList<BalanceChange>();
  @$core.pragma('dart2js:noInline')
  static BalanceChange getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<BalanceChange>(create);
  static BalanceChange? _defaultInstance;

  /// The account address that is affected by this balance change event.
  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);

  /// The `Coin` type of this balance change event.
  @$pb.TagNumber(2)
  $core.String get coinType => $_getSZ(1);
  @$pb.TagNumber(2)
  set coinType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCoinType() => $_has(1);
  @$pb.TagNumber(2)
  void clearCoinType() => $_clearField(2);

  /// The amount or change in balance.
  @$pb.TagNumber(3)
  $core.String get amount => $_getSZ(2);
  @$pb.TagNumber(3)
  set amount($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearAmount() => $_clearField(3);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
