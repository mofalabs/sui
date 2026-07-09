// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/execution_status.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'execution_status.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'execution_status.pbenum.dart';

/// The status of an executed transaction.
class ExecutionStatus extends $pb.GeneratedMessage {
  factory ExecutionStatus({
    $core.bool? success,
    ExecutionError? error,
  }) {
    final result = create();
    if (success != null) result.success = success;
    if (error != null) result.error = error;
    return result;
  }

  ExecutionStatus._();

  factory ExecutionStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExecutionStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecutionStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'success')
    ..aOM<ExecutionError>(2, _omitFieldNames ? '' : 'error',
        subBuilder: ExecutionError.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionStatus clone() => ExecutionStatus()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionStatus copyWith(void Function(ExecutionStatus) updates) =>
      super.copyWith((message) => updates(message as ExecutionStatus))
          as ExecutionStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecutionStatus create() => ExecutionStatus._();
  @$core.override
  ExecutionStatus createEmptyInstance() => create();
  static $pb.PbList<ExecutionStatus> createRepeated() =>
      $pb.PbList<ExecutionStatus>();
  @$core.pragma('dart2js:noInline')
  static ExecutionStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExecutionStatus>(create);
  static ExecutionStatus? _defaultInstance;

  /// Indicates if the transaction was successful or not.
  @$pb.TagNumber(1)
  $core.bool get success => $_getBF(0);
  @$pb.TagNumber(1)
  set success($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSuccess() => $_has(0);
  @$pb.TagNumber(1)
  void clearSuccess() => $_clearField(1);

  /// The error if `success` is false.
  @$pb.TagNumber(2)
  ExecutionError get error => $_getN(1);
  @$pb.TagNumber(2)
  set error(ExecutionError value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasError() => $_has(1);
  @$pb.TagNumber(2)
  void clearError() => $_clearField(2);
  @$pb.TagNumber(2)
  ExecutionError ensureError() => $_ensure(1);
}

enum ExecutionError_ErrorDetails {
  abort,
  sizeError,
  commandArgumentError,
  typeArgumentError,
  packageUpgradeError,
  indexError,
  objectId,
  coinDenyListError,
  congestedObjects,
  notSet
}

/// An error that can occur during the execution of a transaction.
class ExecutionError extends $pb.GeneratedMessage {
  factory ExecutionError({
    $core.String? description,
    $fixnum.Int64? command,
    ExecutionError_ExecutionErrorKind? kind,
    MoveAbort? abort,
    SizeError? sizeError,
    CommandArgumentError? commandArgumentError,
    TypeArgumentError? typeArgumentError,
    PackageUpgradeError? packageUpgradeError,
    IndexError? indexError,
    $core.String? objectId,
    CoinDenyListError? coinDenyListError,
    CongestedObjects? congestedObjects,
  }) {
    final result = create();
    if (description != null) result.description = description;
    if (command != null) result.command = command;
    if (kind != null) result.kind = kind;
    if (abort != null) result.abort = abort;
    if (sizeError != null) result.sizeError = sizeError;
    if (commandArgumentError != null)
      result.commandArgumentError = commandArgumentError;
    if (typeArgumentError != null) result.typeArgumentError = typeArgumentError;
    if (packageUpgradeError != null)
      result.packageUpgradeError = packageUpgradeError;
    if (indexError != null) result.indexError = indexError;
    if (objectId != null) result.objectId = objectId;
    if (coinDenyListError != null) result.coinDenyListError = coinDenyListError;
    if (congestedObjects != null) result.congestedObjects = congestedObjects;
    return result;
  }

  ExecutionError._();

  factory ExecutionError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ExecutionError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ExecutionError_ErrorDetails>
      _ExecutionError_ErrorDetailsByTag = {
    4: ExecutionError_ErrorDetails.abort,
    5: ExecutionError_ErrorDetails.sizeError,
    6: ExecutionError_ErrorDetails.commandArgumentError,
    7: ExecutionError_ErrorDetails.typeArgumentError,
    8: ExecutionError_ErrorDetails.packageUpgradeError,
    9: ExecutionError_ErrorDetails.indexError,
    10: ExecutionError_ErrorDetails.objectId,
    11: ExecutionError_ErrorDetails.coinDenyListError,
    12: ExecutionError_ErrorDetails.congestedObjects,
    0: ExecutionError_ErrorDetails.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ExecutionError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..oo(0, [4, 5, 6, 7, 8, 9, 10, 11, 12])
    ..aOS(1, _omitFieldNames ? '' : 'description')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'command', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<ExecutionError_ExecutionErrorKind>(
        3, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker:
            ExecutionError_ExecutionErrorKind.EXECUTION_ERROR_KIND_UNKNOWN,
        valueOf: ExecutionError_ExecutionErrorKind.valueOf,
        enumValues: ExecutionError_ExecutionErrorKind.values)
    ..aOM<MoveAbort>(4, _omitFieldNames ? '' : 'abort',
        subBuilder: MoveAbort.create)
    ..aOM<SizeError>(5, _omitFieldNames ? '' : 'sizeError',
        subBuilder: SizeError.create)
    ..aOM<CommandArgumentError>(
        6, _omitFieldNames ? '' : 'commandArgumentError',
        subBuilder: CommandArgumentError.create)
    ..aOM<TypeArgumentError>(7, _omitFieldNames ? '' : 'typeArgumentError',
        subBuilder: TypeArgumentError.create)
    ..aOM<PackageUpgradeError>(8, _omitFieldNames ? '' : 'packageUpgradeError',
        subBuilder: PackageUpgradeError.create)
    ..aOM<IndexError>(9, _omitFieldNames ? '' : 'indexError',
        subBuilder: IndexError.create)
    ..aOS(10, _omitFieldNames ? '' : 'objectId')
    ..aOM<CoinDenyListError>(11, _omitFieldNames ? '' : 'coinDenyListError',
        subBuilder: CoinDenyListError.create)
    ..aOM<CongestedObjects>(12, _omitFieldNames ? '' : 'congestedObjects',
        subBuilder: CongestedObjects.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionError clone() => ExecutionError()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ExecutionError copyWith(void Function(ExecutionError) updates) =>
      super.copyWith((message) => updates(message as ExecutionError))
          as ExecutionError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExecutionError create() => ExecutionError._();
  @$core.override
  ExecutionError createEmptyInstance() => create();
  static $pb.PbList<ExecutionError> createRepeated() =>
      $pb.PbList<ExecutionError>();
  @$core.pragma('dart2js:noInline')
  static ExecutionError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ExecutionError>(create);
  static ExecutionError? _defaultInstance;

  ExecutionError_ErrorDetails whichErrorDetails() =>
      _ExecutionError_ErrorDetailsByTag[$_whichOneof(0)]!;
  void clearErrorDetails() => $_clearField($_whichOneof(0));

  /// A human readable description of the error
  @$pb.TagNumber(1)
  $core.String get description => $_getSZ(0);
  @$pb.TagNumber(1)
  set description($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDescription() => $_has(0);
  @$pb.TagNumber(1)
  void clearDescription() => $_clearField(1);

  /// The command, if any, during which the error occurred.
  @$pb.TagNumber(2)
  $fixnum.Int64 get command => $_getI64(1);
  @$pb.TagNumber(2)
  set command($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCommand() => $_has(1);
  @$pb.TagNumber(2)
  void clearCommand() => $_clearField(2);

  @$pb.TagNumber(3)
  ExecutionError_ExecutionErrorKind get kind => $_getN(2);
  @$pb.TagNumber(3)
  set kind(ExecutionError_ExecutionErrorKind value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasKind() => $_has(2);
  @$pb.TagNumber(3)
  void clearKind() => $_clearField(3);

  @$pb.TagNumber(4)
  MoveAbort get abort => $_getN(3);
  @$pb.TagNumber(4)
  set abort(MoveAbort value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasAbort() => $_has(3);
  @$pb.TagNumber(4)
  void clearAbort() => $_clearField(4);
  @$pb.TagNumber(4)
  MoveAbort ensureAbort() => $_ensure(3);

  @$pb.TagNumber(5)
  SizeError get sizeError => $_getN(4);
  @$pb.TagNumber(5)
  set sizeError(SizeError value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasSizeError() => $_has(4);
  @$pb.TagNumber(5)
  void clearSizeError() => $_clearField(5);
  @$pb.TagNumber(5)
  SizeError ensureSizeError() => $_ensure(4);

  @$pb.TagNumber(6)
  CommandArgumentError get commandArgumentError => $_getN(5);
  @$pb.TagNumber(6)
  set commandArgumentError(CommandArgumentError value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCommandArgumentError() => $_has(5);
  @$pb.TagNumber(6)
  void clearCommandArgumentError() => $_clearField(6);
  @$pb.TagNumber(6)
  CommandArgumentError ensureCommandArgumentError() => $_ensure(5);

  @$pb.TagNumber(7)
  TypeArgumentError get typeArgumentError => $_getN(6);
  @$pb.TagNumber(7)
  set typeArgumentError(TypeArgumentError value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasTypeArgumentError() => $_has(6);
  @$pb.TagNumber(7)
  void clearTypeArgumentError() => $_clearField(7);
  @$pb.TagNumber(7)
  TypeArgumentError ensureTypeArgumentError() => $_ensure(6);

  @$pb.TagNumber(8)
  PackageUpgradeError get packageUpgradeError => $_getN(7);
  @$pb.TagNumber(8)
  set packageUpgradeError(PackageUpgradeError value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasPackageUpgradeError() => $_has(7);
  @$pb.TagNumber(8)
  void clearPackageUpgradeError() => $_clearField(8);
  @$pb.TagNumber(8)
  PackageUpgradeError ensurePackageUpgradeError() => $_ensure(7);

  @$pb.TagNumber(9)
  IndexError get indexError => $_getN(8);
  @$pb.TagNumber(9)
  set indexError(IndexError value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasIndexError() => $_has(8);
  @$pb.TagNumber(9)
  void clearIndexError() => $_clearField(9);
  @$pb.TagNumber(9)
  IndexError ensureIndexError() => $_ensure(8);

  @$pb.TagNumber(10)
  $core.String get objectId => $_getSZ(9);
  @$pb.TagNumber(10)
  set objectId($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasObjectId() => $_has(9);
  @$pb.TagNumber(10)
  void clearObjectId() => $_clearField(10);

  @$pb.TagNumber(11)
  CoinDenyListError get coinDenyListError => $_getN(10);
  @$pb.TagNumber(11)
  set coinDenyListError(CoinDenyListError value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasCoinDenyListError() => $_has(10);
  @$pb.TagNumber(11)
  void clearCoinDenyListError() => $_clearField(11);
  @$pb.TagNumber(11)
  CoinDenyListError ensureCoinDenyListError() => $_ensure(10);

  /// Set of objects that were congested, leading to the transaction's cancellation.
  @$pb.TagNumber(12)
  CongestedObjects get congestedObjects => $_getN(11);
  @$pb.TagNumber(12)
  set congestedObjects(CongestedObjects value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasCongestedObjects() => $_has(11);
  @$pb.TagNumber(12)
  void clearCongestedObjects() => $_clearField(12);
  @$pb.TagNumber(12)
  CongestedObjects ensureCongestedObjects() => $_ensure(11);
}

class MoveAbort extends $pb.GeneratedMessage {
  factory MoveAbort({
    $fixnum.Int64? abortCode,
    MoveLocation? location,
    CleverError? cleverError,
  }) {
    final result = create();
    if (abortCode != null) result.abortCode = abortCode;
    if (location != null) result.location = location;
    if (cleverError != null) result.cleverError = cleverError;
    return result;
  }

  MoveAbort._();

  factory MoveAbort.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoveAbort.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoveAbort',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'abortCode', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MoveLocation>(2, _omitFieldNames ? '' : 'location',
        subBuilder: MoveLocation.create)
    ..aOM<CleverError>(3, _omitFieldNames ? '' : 'cleverError',
        subBuilder: CleverError.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveAbort clone() => MoveAbort()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveAbort copyWith(void Function(MoveAbort) updates) =>
      super.copyWith((message) => updates(message as MoveAbort)) as MoveAbort;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoveAbort create() => MoveAbort._();
  @$core.override
  MoveAbort createEmptyInstance() => create();
  static $pb.PbList<MoveAbort> createRepeated() => $pb.PbList<MoveAbort>();
  @$core.pragma('dart2js:noInline')
  static MoveAbort getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveAbort>(create);
  static MoveAbort? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get abortCode => $_getI64(0);
  @$pb.TagNumber(1)
  set abortCode($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAbortCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearAbortCode() => $_clearField(1);

  /// Location in Move where the error occurred.
  @$pb.TagNumber(2)
  MoveLocation get location => $_getN(1);
  @$pb.TagNumber(2)
  set location(MoveLocation value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLocation() => $_has(1);
  @$pb.TagNumber(2)
  void clearLocation() => $_clearField(2);
  @$pb.TagNumber(2)
  MoveLocation ensureLocation() => $_ensure(1);

  /// Extra error information if abort code is a "Clever Error"
  @$pb.TagNumber(3)
  CleverError get cleverError => $_getN(2);
  @$pb.TagNumber(3)
  set cleverError(CleverError value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasCleverError() => $_has(2);
  @$pb.TagNumber(3)
  void clearCleverError() => $_clearField(3);
  @$pb.TagNumber(3)
  CleverError ensureCleverError() => $_ensure(2);
}

/// Location in Move bytecode where an error occurred.
class MoveLocation extends $pb.GeneratedMessage {
  factory MoveLocation({
    $core.String? package,
    $core.String? module,
    $core.int? function,
    $core.int? instruction,
    $core.String? functionName,
  }) {
    final result = create();
    if (package != null) result.package = package;
    if (module != null) result.module = module;
    if (function != null) result.function = function;
    if (instruction != null) result.instruction = instruction;
    if (functionName != null) result.functionName = functionName;
    return result;
  }

  MoveLocation._();

  factory MoveLocation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MoveLocation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MoveLocation',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'package')
    ..aOS(2, _omitFieldNames ? '' : 'module')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'function', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'instruction', $pb.PbFieldType.OU3)
    ..aOS(5, _omitFieldNames ? '' : 'functionName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveLocation clone() => MoveLocation()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveLocation copyWith(void Function(MoveLocation) updates) =>
      super.copyWith((message) => updates(message as MoveLocation))
          as MoveLocation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoveLocation create() => MoveLocation._();
  @$core.override
  MoveLocation createEmptyInstance() => create();
  static $pb.PbList<MoveLocation> createRepeated() =>
      $pb.PbList<MoveLocation>();
  @$core.pragma('dart2js:noInline')
  static MoveLocation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MoveLocation>(create);
  static MoveLocation? _defaultInstance;

  /// The package ID.
  @$pb.TagNumber(1)
  $core.String get package => $_getSZ(0);
  @$pb.TagNumber(1)
  set package($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPackage() => $_has(0);
  @$pb.TagNumber(1)
  void clearPackage() => $_clearField(1);

  /// The module name.
  @$pb.TagNumber(2)
  $core.String get module => $_getSZ(1);
  @$pb.TagNumber(2)
  set module($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasModule() => $_has(1);
  @$pb.TagNumber(2)
  void clearModule() => $_clearField(2);

  /// The function index.
  @$pb.TagNumber(3)
  $core.int get function => $_getIZ(2);
  @$pb.TagNumber(3)
  set function($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFunction() => $_has(2);
  @$pb.TagNumber(3)
  void clearFunction() => $_clearField(3);

  /// Offset of the instruction where the error occurred.
  @$pb.TagNumber(4)
  $core.int get instruction => $_getIZ(3);
  @$pb.TagNumber(4)
  set instruction($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInstruction() => $_has(3);
  @$pb.TagNumber(4)
  void clearInstruction() => $_clearField(4);

  /// The name of the function, if available.
  @$pb.TagNumber(5)
  $core.String get functionName => $_getSZ(4);
  @$pb.TagNumber(5)
  set functionName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFunctionName() => $_has(4);
  @$pb.TagNumber(5)
  void clearFunctionName() => $_clearField(5);
}

enum CleverError_Value { rendered, raw, notSet }

class CleverError extends $pb.GeneratedMessage {
  factory CleverError({
    $fixnum.Int64? errorCode,
    $fixnum.Int64? lineNumber,
    $core.String? constantName,
    $core.String? constantType,
    $core.String? rendered,
    $core.List<$core.int>? raw,
  }) {
    final result = create();
    if (errorCode != null) result.errorCode = errorCode;
    if (lineNumber != null) result.lineNumber = lineNumber;
    if (constantName != null) result.constantName = constantName;
    if (constantType != null) result.constantType = constantType;
    if (rendered != null) result.rendered = rendered;
    if (raw != null) result.raw = raw;
    return result;
  }

  CleverError._();

  factory CleverError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CleverError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, CleverError_Value> _CleverError_ValueByTag =
      {
    5: CleverError_Value.rendered,
    6: CleverError_Value.raw,
    0: CleverError_Value.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CleverError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..oo(0, [5, 6])
    ..a<$fixnum.Int64>(
        1, _omitFieldNames ? '' : 'errorCode', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'lineNumber', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, _omitFieldNames ? '' : 'constantName')
    ..aOS(4, _omitFieldNames ? '' : 'constantType')
    ..aOS(5, _omitFieldNames ? '' : 'rendered')
    ..a<$core.List<$core.int>>(
        6, _omitFieldNames ? '' : 'raw', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CleverError clone() => CleverError()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CleverError copyWith(void Function(CleverError) updates) =>
      super.copyWith((message) => updates(message as CleverError))
          as CleverError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CleverError create() => CleverError._();
  @$core.override
  CleverError createEmptyInstance() => create();
  static $pb.PbList<CleverError> createRepeated() => $pb.PbList<CleverError>();
  @$core.pragma('dart2js:noInline')
  static CleverError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CleverError>(create);
  static CleverError? _defaultInstance;

  CleverError_Value whichValue() => _CleverError_ValueByTag[$_whichOneof(0)]!;
  void clearValue() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get errorCode => $_getI64(0);
  @$pb.TagNumber(1)
  set errorCode($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasErrorCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearErrorCode() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get lineNumber => $_getI64(1);
  @$pb.TagNumber(2)
  set lineNumber($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLineNumber() => $_has(1);
  @$pb.TagNumber(2)
  void clearLineNumber() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get constantName => $_getSZ(2);
  @$pb.TagNumber(3)
  set constantName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasConstantName() => $_has(2);
  @$pb.TagNumber(3)
  void clearConstantName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get constantType => $_getSZ(3);
  @$pb.TagNumber(4)
  set constantType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasConstantType() => $_has(3);
  @$pb.TagNumber(4)
  void clearConstantType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get rendered => $_getSZ(4);
  @$pb.TagNumber(5)
  set rendered($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRendered() => $_has(4);
  @$pb.TagNumber(5)
  void clearRendered() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.List<$core.int> get raw => $_getN(5);
  @$pb.TagNumber(6)
  set raw($core.List<$core.int> value) => $_setBytes(5, value);
  @$pb.TagNumber(6)
  $core.bool hasRaw() => $_has(5);
  @$pb.TagNumber(6)
  void clearRaw() => $_clearField(6);
}

/// A size error.
class SizeError extends $pb.GeneratedMessage {
  factory SizeError({
    $fixnum.Int64? size,
    $fixnum.Int64? maxSize,
  }) {
    final result = create();
    if (size != null) result.size = size;
    if (maxSize != null) result.maxSize = maxSize;
    return result;
  }

  SizeError._();

  factory SizeError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SizeError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SizeError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'size', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'maxSize', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SizeError clone() => SizeError()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SizeError copyWith(void Function(SizeError) updates) =>
      super.copyWith((message) => updates(message as SizeError)) as SizeError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SizeError create() => SizeError._();
  @$core.override
  SizeError createEmptyInstance() => create();
  static $pb.PbList<SizeError> createRepeated() => $pb.PbList<SizeError>();
  @$core.pragma('dart2js:noInline')
  static SizeError getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SizeError>(create);
  static SizeError? _defaultInstance;

  /// The offending size.
  @$pb.TagNumber(1)
  $fixnum.Int64 get size => $_getI64(0);
  @$pb.TagNumber(1)
  set size($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSize() => $_has(0);
  @$pb.TagNumber(1)
  void clearSize() => $_clearField(1);

  /// The maximum allowable size.
  @$pb.TagNumber(2)
  $fixnum.Int64 get maxSize => $_getI64(1);
  @$pb.TagNumber(2)
  set maxSize($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxSize() => $_clearField(2);
}

class IndexError extends $pb.GeneratedMessage {
  factory IndexError({
    $core.int? index,
    $core.int? subresult,
  }) {
    final result = create();
    if (index != null) result.index = index;
    if (subresult != null) result.subresult = subresult;
    return result;
  }

  IndexError._();

  factory IndexError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory IndexError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'IndexError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'index', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'subresult', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexError clone() => IndexError()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  IndexError copyWith(void Function(IndexError) updates) =>
      super.copyWith((message) => updates(message as IndexError)) as IndexError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static IndexError create() => IndexError._();
  @$core.override
  IndexError createEmptyInstance() => create();
  static $pb.PbList<IndexError> createRepeated() => $pb.PbList<IndexError>();
  @$core.pragma('dart2js:noInline')
  static IndexError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<IndexError>(create);
  static IndexError? _defaultInstance;

  /// Index of an input or result.
  @$pb.TagNumber(1)
  $core.int get index => $_getIZ(0);
  @$pb.TagNumber(1)
  set index($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIndex() => $_has(0);
  @$pb.TagNumber(1)
  void clearIndex() => $_clearField(1);

  /// Index of a subresult.
  @$pb.TagNumber(2)
  $core.int get subresult => $_getIZ(1);
  @$pb.TagNumber(2)
  set subresult($core.int value) => $_setUnsignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSubresult() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubresult() => $_clearField(2);
}

class CoinDenyListError extends $pb.GeneratedMessage {
  factory CoinDenyListError({
    $core.String? address,
    $core.String? coinType,
  }) {
    final result = create();
    if (address != null) result.address = address;
    if (coinType != null) result.coinType = coinType;
    return result;
  }

  CoinDenyListError._();

  factory CoinDenyListError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CoinDenyListError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CoinDenyListError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'address')
    ..aOS(2, _omitFieldNames ? '' : 'coinType')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CoinDenyListError clone() => CoinDenyListError()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CoinDenyListError copyWith(void Function(CoinDenyListError) updates) =>
      super.copyWith((message) => updates(message as CoinDenyListError))
          as CoinDenyListError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CoinDenyListError create() => CoinDenyListError._();
  @$core.override
  CoinDenyListError createEmptyInstance() => create();
  static $pb.PbList<CoinDenyListError> createRepeated() =>
      $pb.PbList<CoinDenyListError>();
  @$core.pragma('dart2js:noInline')
  static CoinDenyListError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CoinDenyListError>(create);
  static CoinDenyListError? _defaultInstance;

  /// Denied address.
  @$pb.TagNumber(1)
  $core.String get address => $_getSZ(0);
  @$pb.TagNumber(1)
  set address($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAddress() => $_has(0);
  @$pb.TagNumber(1)
  void clearAddress() => $_clearField(1);

  /// Coin type.
  @$pb.TagNumber(2)
  $core.String get coinType => $_getSZ(1);
  @$pb.TagNumber(2)
  set coinType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCoinType() => $_has(1);
  @$pb.TagNumber(2)
  void clearCoinType() => $_clearField(2);
}

/// Set of objects that were congested, leading to the transaction's cancellation.
class CongestedObjects extends $pb.GeneratedMessage {
  factory CongestedObjects({
    $core.Iterable<$core.String>? objects,
  }) {
    final result = create();
    if (objects != null) result.objects.addAll(objects);
    return result;
  }

  CongestedObjects._();

  factory CongestedObjects.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CongestedObjects.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CongestedObjects',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'objects')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CongestedObjects clone() => CongestedObjects()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CongestedObjects copyWith(void Function(CongestedObjects) updates) =>
      super.copyWith((message) => updates(message as CongestedObjects))
          as CongestedObjects;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CongestedObjects create() => CongestedObjects._();
  @$core.override
  CongestedObjects createEmptyInstance() => create();
  static $pb.PbList<CongestedObjects> createRepeated() =>
      $pb.PbList<CongestedObjects>();
  @$core.pragma('dart2js:noInline')
  static CongestedObjects getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CongestedObjects>(create);
  static CongestedObjects? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get objects => $_getList(0);
}

/// An error with an argument to a command.
class CommandArgumentError extends $pb.GeneratedMessage {
  factory CommandArgumentError({
    $core.int? argument,
    CommandArgumentError_CommandArgumentErrorKind? kind,
    IndexError? indexError,
  }) {
    final result = create();
    if (argument != null) result.argument = argument;
    if (kind != null) result.kind = kind;
    if (indexError != null) result.indexError = indexError;
    return result;
  }

  CommandArgumentError._();

  factory CommandArgumentError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CommandArgumentError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CommandArgumentError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'argument', $pb.PbFieldType.OU3)
    ..e<CommandArgumentError_CommandArgumentErrorKind>(
        2, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: CommandArgumentError_CommandArgumentErrorKind
            .COMMAND_ARGUMENT_ERROR_KIND_UNKNOWN,
        valueOf: CommandArgumentError_CommandArgumentErrorKind.valueOf,
        enumValues: CommandArgumentError_CommandArgumentErrorKind.values)
    ..aOM<IndexError>(3, _omitFieldNames ? '' : 'indexError',
        subBuilder: IndexError.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommandArgumentError clone() =>
      CommandArgumentError()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CommandArgumentError copyWith(void Function(CommandArgumentError) updates) =>
      super.copyWith((message) => updates(message as CommandArgumentError))
          as CommandArgumentError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CommandArgumentError create() => CommandArgumentError._();
  @$core.override
  CommandArgumentError createEmptyInstance() => create();
  static $pb.PbList<CommandArgumentError> createRepeated() =>
      $pb.PbList<CommandArgumentError>();
  @$core.pragma('dart2js:noInline')
  static CommandArgumentError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CommandArgumentError>(create);
  static CommandArgumentError? _defaultInstance;

  /// Position of the problematic argument.
  @$pb.TagNumber(1)
  $core.int get argument => $_getIZ(0);
  @$pb.TagNumber(1)
  set argument($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasArgument() => $_has(0);
  @$pb.TagNumber(1)
  void clearArgument() => $_clearField(1);

  @$pb.TagNumber(2)
  CommandArgumentError_CommandArgumentErrorKind get kind => $_getN(1);
  @$pb.TagNumber(2)
  set kind(CommandArgumentError_CommandArgumentErrorKind value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  @$pb.TagNumber(3)
  IndexError get indexError => $_getN(2);
  @$pb.TagNumber(3)
  set indexError(IndexError value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasIndexError() => $_has(2);
  @$pb.TagNumber(3)
  void clearIndexError() => $_clearField(3);
  @$pb.TagNumber(3)
  IndexError ensureIndexError() => $_ensure(2);
}

/// An error with upgrading a package.
class PackageUpgradeError extends $pb.GeneratedMessage {
  factory PackageUpgradeError({
    PackageUpgradeError_PackageUpgradeErrorKind? kind,
    $core.String? packageId,
    $core.String? digest,
    $core.int? policy,
    $core.String? ticketId,
  }) {
    final result = create();
    if (kind != null) result.kind = kind;
    if (packageId != null) result.packageId = packageId;
    if (digest != null) result.digest = digest;
    if (policy != null) result.policy = policy;
    if (ticketId != null) result.ticketId = ticketId;
    return result;
  }

  PackageUpgradeError._();

  factory PackageUpgradeError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PackageUpgradeError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PackageUpgradeError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..e<PackageUpgradeError_PackageUpgradeErrorKind>(
        1, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: PackageUpgradeError_PackageUpgradeErrorKind
            .PACKAGE_UPGRADE_ERROR_KIND_UNKNOWN,
        valueOf: PackageUpgradeError_PackageUpgradeErrorKind.valueOf,
        enumValues: PackageUpgradeError_PackageUpgradeErrorKind.values)
    ..aOS(2, _omitFieldNames ? '' : 'packageId')
    ..aOS(3, _omitFieldNames ? '' : 'digest')
    ..a<$core.int>(4, _omitFieldNames ? '' : 'policy', $pb.PbFieldType.OU3)
    ..aOS(5, _omitFieldNames ? '' : 'ticketId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PackageUpgradeError clone() => PackageUpgradeError()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PackageUpgradeError copyWith(void Function(PackageUpgradeError) updates) =>
      super.copyWith((message) => updates(message as PackageUpgradeError))
          as PackageUpgradeError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PackageUpgradeError create() => PackageUpgradeError._();
  @$core.override
  PackageUpgradeError createEmptyInstance() => create();
  static $pb.PbList<PackageUpgradeError> createRepeated() =>
      $pb.PbList<PackageUpgradeError>();
  @$core.pragma('dart2js:noInline')
  static PackageUpgradeError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PackageUpgradeError>(create);
  static PackageUpgradeError? _defaultInstance;

  @$pb.TagNumber(1)
  PackageUpgradeError_PackageUpgradeErrorKind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(PackageUpgradeError_PackageUpgradeErrorKind value) =>
      $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  /// The Package Id.
  @$pb.TagNumber(2)
  $core.String get packageId => $_getSZ(1);
  @$pb.TagNumber(2)
  set packageId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPackageId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPackageId() => $_clearField(2);

  /// A digest.
  @$pb.TagNumber(3)
  $core.String get digest => $_getSZ(2);
  @$pb.TagNumber(3)
  set digest($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDigest() => $_has(2);
  @$pb.TagNumber(3)
  void clearDigest() => $_clearField(3);

  /// The policy.
  @$pb.TagNumber(4)
  $core.int get policy => $_getIZ(3);
  @$pb.TagNumber(4)
  set policy($core.int value) => $_setUnsignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPolicy() => $_has(3);
  @$pb.TagNumber(4)
  void clearPolicy() => $_clearField(4);

  /// The ticket Id.
  @$pb.TagNumber(5)
  $core.String get ticketId => $_getSZ(4);
  @$pb.TagNumber(5)
  set ticketId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTicketId() => $_has(4);
  @$pb.TagNumber(5)
  void clearTicketId() => $_clearField(5);
}

/// Type argument error.
class TypeArgumentError extends $pb.GeneratedMessage {
  factory TypeArgumentError({
    $core.int? typeArgument,
    TypeArgumentError_TypeArgumentErrorKind? kind,
  }) {
    final result = create();
    if (typeArgument != null) result.typeArgument = typeArgument;
    if (kind != null) result.kind = kind;
    return result;
  }

  TypeArgumentError._();

  factory TypeArgumentError.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TypeArgumentError.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TypeArgumentError',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'),
      createEmptyInstance: create)
    ..a<$core.int>(
        1, _omitFieldNames ? '' : 'typeArgument', $pb.PbFieldType.OU3)
    ..e<TypeArgumentError_TypeArgumentErrorKind>(
        2, _omitFieldNames ? '' : 'kind', $pb.PbFieldType.OE,
        defaultOrMaker: TypeArgumentError_TypeArgumentErrorKind
            .TYPE_ARGUMENT_ERROR_KIND_UNKNOWN,
        valueOf: TypeArgumentError_TypeArgumentErrorKind.valueOf,
        enumValues: TypeArgumentError_TypeArgumentErrorKind.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypeArgumentError clone() => TypeArgumentError()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TypeArgumentError copyWith(void Function(TypeArgumentError) updates) =>
      super.copyWith((message) => updates(message as TypeArgumentError))
          as TypeArgumentError;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TypeArgumentError create() => TypeArgumentError._();
  @$core.override
  TypeArgumentError createEmptyInstance() => create();
  static $pb.PbList<TypeArgumentError> createRepeated() =>
      $pb.PbList<TypeArgumentError>();
  @$core.pragma('dart2js:noInline')
  static TypeArgumentError getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TypeArgumentError>(create);
  static TypeArgumentError? _defaultInstance;

  /// Index of the problematic type argument.
  @$pb.TagNumber(1)
  $core.int get typeArgument => $_getIZ(0);
  @$pb.TagNumber(1)
  set typeArgument($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTypeArgument() => $_has(0);
  @$pb.TagNumber(1)
  void clearTypeArgument() => $_clearField(1);

  @$pb.TagNumber(2)
  TypeArgumentError_TypeArgumentErrorKind get kind => $_getN(1);
  @$pb.TagNumber(2)
  set kind(TypeArgumentError_TypeArgumentErrorKind value) =>
      $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
