// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/argument.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'argument.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'argument.pbenum.dart';

/// An argument to a programmable transaction command.
class Argument extends $pb.GeneratedMessage {
  factory Argument({
    Argument_ArgumentKind? kind,
    $core.int? input,
    $core.int? result,
    $core.int? subresult,
  }) {
    final result$ = create();
    if (kind != null) result$.kind = kind;
    if (input != null) result$.input = input;
    if (result != null) result$.result = result;
    if (subresult != null) result$.subresult = subresult;
    return result$;
  }

  Argument._();

  factory Argument.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Argument.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Argument',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..e<Argument_ArgumentKind>(
        1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: Argument_ArgumentKind.ARGUMENT_KIND_UNKNOWN,
        valueOf: Argument_ArgumentKind.valueOf,
        enumValues: Argument_ArgumentKind.values)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'input', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'result', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'subresult', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Argument clone() => Argument()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Argument copyWith(void Function(Argument) updates) =>
      super.copyWith((message) => updates(message as Argument)) as Argument;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Argument create() => Argument._();
  @$core.override
  Argument createEmptyInstance() => create();
  static $pb.PbList<Argument> createRepeated() => $pb.PbList<Argument>();
  @$core.pragma('dart2js:noInline')
  static Argument getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Argument>(create);
  static Argument? _defaultInstance;

  @$pb.TagNumber(1)
  Argument_ArgumentKind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(Argument_ArgumentKind value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  /// Index of an input when `kind` is `INPUT`.
  @$pb.TagNumber(2)
  $core.int get input => $_getIZ(1);
  @$pb.TagNumber(2)
  set input($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInput() => $_has(1);
  @$pb.TagNumber(2)
  void clearInput() => $_clearField(2);

  /// Index of a result when `kind` is `RESULT`.
  @$pb.TagNumber(3)
  $core.int get result => $_getIZ(2);
  @$pb.TagNumber(3)
  set result($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasResult() => $_has(2);
  @$pb.TagNumber(3)
  void clearResult() => $_clearField(3);

  /// Used to access a nested result when `kind` is `RESULT`.
  @$pb.TagNumber(4)
  $core.int get subresult => $_getIZ(3);
  @$pb.TagNumber(4)
  set subresult($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSubresult() => $_has(3);
  @$pb.TagNumber(4)
  void clearSubresult() => $_clearField(4);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
