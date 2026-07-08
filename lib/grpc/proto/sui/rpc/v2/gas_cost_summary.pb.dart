// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/gas_cost_summary.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// Summary of gas charges.
class GasCostSummary extends $pb.GeneratedMessage {
  factory GasCostSummary({
    $fixnum.Int64? computationCost,
    $fixnum.Int64? storageCost,
    $fixnum.Int64? storageRebate,
    $fixnum.Int64? nonRefundableStorageFee,
  }) {
    final result = create();
    if (computationCost != null) result.computationCost = computationCost;
    if (storageCost != null) result.storageCost = storageCost;
    if (storageRebate != null) result.storageRebate = storageRebate;
    if (nonRefundableStorageFee != null) result.nonRefundableStorageFee = nonRefundableStorageFee;
    return result;
  }

  GasCostSummary._();

  factory GasCostSummary.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory GasCostSummary.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GasCostSummary', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'computationCost', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'storageCost', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'storageRebate', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'nonRefundableStorageFee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GasCostSummary clone() => GasCostSummary()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GasCostSummary copyWith(void Function(GasCostSummary) updates) => super.copyWith((message) => updates(message as GasCostSummary)) as GasCostSummary;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GasCostSummary create() => GasCostSummary._();
  @$core.override
  GasCostSummary createEmptyInstance() => create();
  static $pb.PbList<GasCostSummary> createRepeated() => $pb.PbList<GasCostSummary>();
  @$core.pragma('dart2js:noInline')
  static GasCostSummary getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GasCostSummary>(create);
  static GasCostSummary? _defaultInstance;

  /// Cost of computation/execution.
  @$pb.TagNumber(1)
  $fixnum.Int64 get computationCost => $_getI64(0);
  @$pb.TagNumber(1)
  set computationCost($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasComputationCost() => $_has(0);
  @$pb.TagNumber(1)
  void clearComputationCost() => $_clearField(1);

  /// Storage cost, it's the sum of all storage cost for all objects created or mutated.
  @$pb.TagNumber(2)
  $fixnum.Int64 get storageCost => $_getI64(1);
  @$pb.TagNumber(2)
  set storageCost($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStorageCost() => $_has(1);
  @$pb.TagNumber(2)
  void clearStorageCost() => $_clearField(2);

  /// The amount of storage cost refunded to the user for all objects deleted or mutated in the
  /// transaction.
  @$pb.TagNumber(3)
  $fixnum.Int64 get storageRebate => $_getI64(2);
  @$pb.TagNumber(3)
  set storageRebate($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStorageRebate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStorageRebate() => $_clearField(3);

  /// The fee for the rebate. The portion of the storage rebate kept by the system.
  @$pb.TagNumber(4)
  $fixnum.Int64 get nonRefundableStorageFee => $_getI64(3);
  @$pb.TagNumber(4)
  set nonRefundableStorageFee($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasNonRefundableStorageFee() => $_has(3);
  @$pb.TagNumber(4)
  void clearNonRefundableStorageFee() => $_clearField(4);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
