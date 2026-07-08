// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/protocol_config.proto.

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

class ProtocolConfig extends $pb.GeneratedMessage {
  factory ProtocolConfig({
    $fixnum.Int64? protocolVersion,
    $core.Iterable<$core.MapEntry<$core.String, $core.bool>>? featureFlags,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? attributes,
  }) {
    final result = create();
    if (protocolVersion != null) result.protocolVersion = protocolVersion;
    if (featureFlags != null) result.featureFlags.addEntries(featureFlags);
    if (attributes != null) result.attributes.addEntries(attributes);
    return result;
  }

  ProtocolConfig._();

  factory ProtocolConfig.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ProtocolConfig.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ProtocolConfig', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'protocolVersion', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..m<$core.String, $core.bool>(2, _omitFieldNames ? '' : 'featureFlags', entryClassName: 'ProtocolConfig.FeatureFlagsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OB, packageName: const $pb.PackageName('sui.rpc.v2'))
    ..m<$core.String, $core.String>(3, _omitFieldNames ? '' : 'attributes', entryClassName: 'ProtocolConfig.AttributesEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OS, packageName: const $pb.PackageName('sui.rpc.v2'))
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtocolConfig clone() => ProtocolConfig()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ProtocolConfig copyWith(void Function(ProtocolConfig) updates) => super.copyWith((message) => updates(message as ProtocolConfig)) as ProtocolConfig;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ProtocolConfig create() => ProtocolConfig._();
  @$core.override
  ProtocolConfig createEmptyInstance() => create();
  static $pb.PbList<ProtocolConfig> createRepeated() => $pb.PbList<ProtocolConfig>();
  @$core.pragma('dart2js:noInline')
  static ProtocolConfig getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ProtocolConfig>(create);
  static ProtocolConfig? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get protocolVersion => $_getI64(0);
  @$pb.TagNumber(1)
  set protocolVersion($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProtocolVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearProtocolVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbMap<$core.String, $core.bool> get featureFlags => $_getMap(1);

  @$pb.TagNumber(3)
  $pb.PbMap<$core.String, $core.String> get attributes => $_getMap(2);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
