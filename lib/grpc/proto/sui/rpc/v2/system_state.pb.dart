// This is a generated file - do not edit.
//
// Generated from sui/rpc/v2/system_state.proto.

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

class SystemState extends $pb.GeneratedMessage {
  factory SystemState({
    $fixnum.Int64? version,
    $fixnum.Int64? epoch,
    $fixnum.Int64? protocolVersion,
    ValidatorSet? validators,
    StorageFund? storageFund,
    SystemParameters? parameters,
    $fixnum.Int64? referenceGasPrice,
    $core.Iterable<ValidatorReportRecord>? validatorReportRecords,
    StakeSubsidy? stakeSubsidy,
    $core.bool? safeMode,
    $fixnum.Int64? safeModeStorageRewards,
    $fixnum.Int64? safeModeComputationRewards,
    $fixnum.Int64? safeModeStorageRebates,
    $fixnum.Int64? safeModeNonRefundableStorageFee,
    $fixnum.Int64? epochStartTimestampMs,
    MoveTable? extraFields,
  }) {
    final result = create();
    if (version != null) result.version = version;
    if (epoch != null) result.epoch = epoch;
    if (protocolVersion != null) result.protocolVersion = protocolVersion;
    if (validators != null) result.validators = validators;
    if (storageFund != null) result.storageFund = storageFund;
    if (parameters != null) result.parameters = parameters;
    if (referenceGasPrice != null) result.referenceGasPrice = referenceGasPrice;
    if (validatorReportRecords != null) result.validatorReportRecords.addAll(validatorReportRecords);
    if (stakeSubsidy != null) result.stakeSubsidy = stakeSubsidy;
    if (safeMode != null) result.safeMode = safeMode;
    if (safeModeStorageRewards != null) result.safeModeStorageRewards = safeModeStorageRewards;
    if (safeModeComputationRewards != null) result.safeModeComputationRewards = safeModeComputationRewards;
    if (safeModeStorageRebates != null) result.safeModeStorageRebates = safeModeStorageRebates;
    if (safeModeNonRefundableStorageFee != null) result.safeModeNonRefundableStorageFee = safeModeNonRefundableStorageFee;
    if (epochStartTimestampMs != null) result.epochStartTimestampMs = epochStartTimestampMs;
    if (extraFields != null) result.extraFields = extraFields;
    return result;
  }

  SystemState._();

  factory SystemState.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SystemState.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SystemState', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'version', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'epoch', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'protocolVersion', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<ValidatorSet>(4, _omitFieldNames ? '' : 'validators', subBuilder: ValidatorSet.create)
    ..aOM<StorageFund>(5, _omitFieldNames ? '' : 'storageFund', subBuilder: StorageFund.create)
    ..aOM<SystemParameters>(6, _omitFieldNames ? '' : 'parameters', subBuilder: SystemParameters.create)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'referenceGasPrice', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<ValidatorReportRecord>(8, _omitFieldNames ? '' : 'validatorReportRecords', $pb.PbFieldType.PM, subBuilder: ValidatorReportRecord.create)
    ..aOM<StakeSubsidy>(9, _omitFieldNames ? '' : 'stakeSubsidy', subBuilder: StakeSubsidy.create)
    ..aOB(10, _omitFieldNames ? '' : 'safeMode')
    ..a<$fixnum.Int64>(11, _omitFieldNames ? '' : 'safeModeStorageRewards', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(12, _omitFieldNames ? '' : 'safeModeComputationRewards', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(13, _omitFieldNames ? '' : 'safeModeStorageRebates', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(14, _omitFieldNames ? '' : 'safeModeNonRefundableStorageFee', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(15, _omitFieldNames ? '' : 'epochStartTimestampMs', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MoveTable>(16, _omitFieldNames ? '' : 'extraFields', subBuilder: MoveTable.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemState clone() => SystemState()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemState copyWith(void Function(SystemState) updates) => super.copyWith((message) => updates(message as SystemState)) as SystemState;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemState create() => SystemState._();
  @$core.override
  SystemState createEmptyInstance() => create();
  static $pb.PbList<SystemState> createRepeated() => $pb.PbList<SystemState>();
  @$core.pragma('dart2js:noInline')
  static SystemState getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SystemState>(create);
  static SystemState? _defaultInstance;

  /// The version of the system state data structure type.
  @$pb.TagNumber(1)
  $fixnum.Int64 get version => $_getI64(0);
  @$pb.TagNumber(1)
  set version($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);

  /// The epoch id
  @$pb.TagNumber(2)
  $fixnum.Int64 get epoch => $_getI64(1);
  @$pb.TagNumber(2)
  set epoch($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEpoch() => $_has(1);
  @$pb.TagNumber(2)
  void clearEpoch() => $_clearField(2);

  /// The protocol version
  @$pb.TagNumber(3)
  $fixnum.Int64 get protocolVersion => $_getI64(2);
  @$pb.TagNumber(3)
  set protocolVersion($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasProtocolVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearProtocolVersion() => $_clearField(3);

  /// Information about the validators
  @$pb.TagNumber(4)
  ValidatorSet get validators => $_getN(3);
  @$pb.TagNumber(4)
  set validators(ValidatorSet value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasValidators() => $_has(3);
  @$pb.TagNumber(4)
  void clearValidators() => $_clearField(4);
  @$pb.TagNumber(4)
  ValidatorSet ensureValidators() => $_ensure(3);

  /// Storage Fund info
  @$pb.TagNumber(5)
  StorageFund get storageFund => $_getN(4);
  @$pb.TagNumber(5)
  set storageFund(StorageFund value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStorageFund() => $_has(4);
  @$pb.TagNumber(5)
  void clearStorageFund() => $_clearField(5);
  @$pb.TagNumber(5)
  StorageFund ensureStorageFund() => $_ensure(4);

  /// Set of system config parameters
  @$pb.TagNumber(6)
  SystemParameters get parameters => $_getN(5);
  @$pb.TagNumber(6)
  set parameters(SystemParameters value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasParameters() => $_has(5);
  @$pb.TagNumber(6)
  void clearParameters() => $_clearField(6);
  @$pb.TagNumber(6)
  SystemParameters ensureParameters() => $_ensure(5);

  /// The reference gas price for this epoch
  @$pb.TagNumber(7)
  $fixnum.Int64 get referenceGasPrice => $_getI64(6);
  @$pb.TagNumber(7)
  set referenceGasPrice($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReferenceGasPrice() => $_has(6);
  @$pb.TagNumber(7)
  void clearReferenceGasPrice() => $_clearField(7);

  /// A list of the records of validator reporting each other.
  ///
  /// There is an entry in this list for each validator that has been reported
  /// at least once. Each record contains all the validators that reported
  /// them. If a validator has never been reported they don't have a record in this list.
  /// This lists persists across epoch: a peer continues being in a reported state until the
  /// reporter doesn't explicitly remove their report.
  @$pb.TagNumber(8)
  $pb.PbList<ValidatorReportRecord> get validatorReportRecords => $_getList(7);

  /// Schedule of stake subsidies given out each epoch.
  @$pb.TagNumber(9)
  StakeSubsidy get stakeSubsidy => $_getN(8);
  @$pb.TagNumber(9)
  set stakeSubsidy(StakeSubsidy value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasStakeSubsidy() => $_has(8);
  @$pb.TagNumber(9)
  void clearStakeSubsidy() => $_clearField(9);
  @$pb.TagNumber(9)
  StakeSubsidy ensureStakeSubsidy() => $_ensure(8);

  /// Whether the system is running in a downgraded safe mode due to a non-recoverable bug.
  /// This is set whenever we failed to execute advance_epoch, and ended up executing advance_epoch_safe_mode.
  /// It can be reset once we are able to successfully execute advance_epoch.
  /// The rest of the fields starting with `safe_mode_` are accumulated during safe mode
  /// when advance_epoch_safe_mode is executed. They will eventually be processed once we
  /// are out of safe mode.
  @$pb.TagNumber(10)
  $core.bool get safeMode => $_getBF(9);
  @$pb.TagNumber(10)
  set safeMode($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasSafeMode() => $_has(9);
  @$pb.TagNumber(10)
  void clearSafeMode() => $_clearField(10);

  /// Storage rewards accumulated during safe_mode
  @$pb.TagNumber(11)
  $fixnum.Int64 get safeModeStorageRewards => $_getI64(10);
  @$pb.TagNumber(11)
  set safeModeStorageRewards($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasSafeModeStorageRewards() => $_has(10);
  @$pb.TagNumber(11)
  void clearSafeModeStorageRewards() => $_clearField(11);

  /// Computation rewards accumulated during safe_mode
  @$pb.TagNumber(12)
  $fixnum.Int64 get safeModeComputationRewards => $_getI64(11);
  @$pb.TagNumber(12)
  set safeModeComputationRewards($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasSafeModeComputationRewards() => $_has(11);
  @$pb.TagNumber(12)
  void clearSafeModeComputationRewards() => $_clearField(12);

  /// Storage rebates paid out during safe_mode
  @$pb.TagNumber(13)
  $fixnum.Int64 get safeModeStorageRebates => $_getI64(12);
  @$pb.TagNumber(13)
  set safeModeStorageRebates($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasSafeModeStorageRebates() => $_has(12);
  @$pb.TagNumber(13)
  void clearSafeModeStorageRebates() => $_clearField(13);

  /// Nonrefundable storage fees accumulated during safe_mode
  @$pb.TagNumber(14)
  $fixnum.Int64 get safeModeNonRefundableStorageFee => $_getI64(13);
  @$pb.TagNumber(14)
  set safeModeNonRefundableStorageFee($fixnum.Int64 value) => $_setInt64(13, value);
  @$pb.TagNumber(14)
  $core.bool hasSafeModeNonRefundableStorageFee() => $_has(13);
  @$pb.TagNumber(14)
  void clearSafeModeNonRefundableStorageFee() => $_clearField(14);

  /// Unix timestamp of when this this epoch started
  @$pb.TagNumber(15)
  $fixnum.Int64 get epochStartTimestampMs => $_getI64(14);
  @$pb.TagNumber(15)
  set epochStartTimestampMs($fixnum.Int64 value) => $_setInt64(14, value);
  @$pb.TagNumber(15)
  $core.bool hasEpochStartTimestampMs() => $_has(14);
  @$pb.TagNumber(15)
  void clearEpochStartTimestampMs() => $_clearField(15);

  /// Any extra fields that's not defined statically.
  @$pb.TagNumber(16)
  MoveTable get extraFields => $_getN(15);
  @$pb.TagNumber(16)
  set extraFields(MoveTable value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasExtraFields() => $_has(15);
  @$pb.TagNumber(16)
  void clearExtraFields() => $_clearField(16);
  @$pb.TagNumber(16)
  MoveTable ensureExtraFields() => $_ensure(15);
}

class ValidatorReportRecord extends $pb.GeneratedMessage {
  factory ValidatorReportRecord({
    $core.String? reported,
    $core.Iterable<$core.String>? reporters,
  }) {
    final result = create();
    if (reported != null) result.reported = reported;
    if (reporters != null) result.reporters.addAll(reporters);
    return result;
  }

  ValidatorReportRecord._();

  factory ValidatorReportRecord.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ValidatorReportRecord.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidatorReportRecord', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'reported')
    ..pPS(2, _omitFieldNames ? '' : 'reporters')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorReportRecord clone() => ValidatorReportRecord()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorReportRecord copyWith(void Function(ValidatorReportRecord) updates) => super.copyWith((message) => updates(message as ValidatorReportRecord)) as ValidatorReportRecord;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidatorReportRecord create() => ValidatorReportRecord._();
  @$core.override
  ValidatorReportRecord createEmptyInstance() => create();
  static $pb.PbList<ValidatorReportRecord> createRepeated() => $pb.PbList<ValidatorReportRecord>();
  @$core.pragma('dart2js:noInline')
  static ValidatorReportRecord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidatorReportRecord>(create);
  static ValidatorReportRecord? _defaultInstance;

  /// The address of the validator being reported
  @$pb.TagNumber(1)
  $core.String get reported => $_getSZ(0);
  @$pb.TagNumber(1)
  set reported($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReported() => $_has(0);
  @$pb.TagNumber(1)
  void clearReported() => $_clearField(1);

  /// The list of validator (addresses) that are reporting on the validator specified by `reported`
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get reporters => $_getList(1);
}

class SystemParameters extends $pb.GeneratedMessage {
  factory SystemParameters({
    $fixnum.Int64? epochDurationMs,
    $fixnum.Int64? stakeSubsidyStartEpoch,
    $fixnum.Int64? minValidatorCount,
    $fixnum.Int64? maxValidatorCount,
    $fixnum.Int64? minValidatorJoiningStake,
    $fixnum.Int64? validatorLowStakeThreshold,
    $fixnum.Int64? validatorVeryLowStakeThreshold,
    $fixnum.Int64? validatorLowStakeGracePeriod,
    MoveTable? extraFields,
  }) {
    final result = create();
    if (epochDurationMs != null) result.epochDurationMs = epochDurationMs;
    if (stakeSubsidyStartEpoch != null) result.stakeSubsidyStartEpoch = stakeSubsidyStartEpoch;
    if (minValidatorCount != null) result.minValidatorCount = minValidatorCount;
    if (maxValidatorCount != null) result.maxValidatorCount = maxValidatorCount;
    if (minValidatorJoiningStake != null) result.minValidatorJoiningStake = minValidatorJoiningStake;
    if (validatorLowStakeThreshold != null) result.validatorLowStakeThreshold = validatorLowStakeThreshold;
    if (validatorVeryLowStakeThreshold != null) result.validatorVeryLowStakeThreshold = validatorVeryLowStakeThreshold;
    if (validatorLowStakeGracePeriod != null) result.validatorLowStakeGracePeriod = validatorLowStakeGracePeriod;
    if (extraFields != null) result.extraFields = extraFields;
    return result;
  }

  SystemParameters._();

  factory SystemParameters.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory SystemParameters.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SystemParameters', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'epochDurationMs', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'stakeSubsidyStartEpoch', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'minValidatorCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'maxValidatorCount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'minValidatorJoiningStake', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'validatorLowStakeThreshold', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'validatorVeryLowStakeThreshold', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'validatorLowStakeGracePeriod', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MoveTable>(9, _omitFieldNames ? '' : 'extraFields', subBuilder: MoveTable.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemParameters clone() => SystemParameters()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SystemParameters copyWith(void Function(SystemParameters) updates) => super.copyWith((message) => updates(message as SystemParameters)) as SystemParameters;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SystemParameters create() => SystemParameters._();
  @$core.override
  SystemParameters createEmptyInstance() => create();
  static $pb.PbList<SystemParameters> createRepeated() => $pb.PbList<SystemParameters>();
  @$core.pragma('dart2js:noInline')
  static SystemParameters getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SystemParameters>(create);
  static SystemParameters? _defaultInstance;

  /// The duration of an epoch, in milliseconds.
  @$pb.TagNumber(1)
  $fixnum.Int64 get epochDurationMs => $_getI64(0);
  @$pb.TagNumber(1)
  set epochDurationMs($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEpochDurationMs() => $_has(0);
  @$pb.TagNumber(1)
  void clearEpochDurationMs() => $_clearField(1);

  /// The starting epoch in which stake subsidies start being paid out
  @$pb.TagNumber(2)
  $fixnum.Int64 get stakeSubsidyStartEpoch => $_getI64(1);
  @$pb.TagNumber(2)
  set stakeSubsidyStartEpoch($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStakeSubsidyStartEpoch() => $_has(1);
  @$pb.TagNumber(2)
  void clearStakeSubsidyStartEpoch() => $_clearField(2);

  /// Minimum number of active validators at any moment.
  @$pb.TagNumber(3)
  $fixnum.Int64 get minValidatorCount => $_getI64(2);
  @$pb.TagNumber(3)
  set minValidatorCount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinValidatorCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinValidatorCount() => $_clearField(3);

  /// Maximum number of active validators at any moment.
  /// We do not allow the number of validators in any epoch to go above this.
  @$pb.TagNumber(4)
  $fixnum.Int64 get maxValidatorCount => $_getI64(3);
  @$pb.TagNumber(4)
  set maxValidatorCount($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxValidatorCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxValidatorCount() => $_clearField(4);

  /// Deprecated.
  /// Lower-bound on the amount of stake required to become a validator.
  @$pb.TagNumber(5)
  $fixnum.Int64 get minValidatorJoiningStake => $_getI64(4);
  @$pb.TagNumber(5)
  set minValidatorJoiningStake($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasMinValidatorJoiningStake() => $_has(4);
  @$pb.TagNumber(5)
  void clearMinValidatorJoiningStake() => $_clearField(5);

  /// Deprecated.
  /// Validators with stake amount below `validator_low_stake_threshold` are considered to
  /// have low stake and will be escorted out of the validator set after being below this
  /// threshold for more than `validator_low_stake_grace_period` number of epochs.
  @$pb.TagNumber(6)
  $fixnum.Int64 get validatorLowStakeThreshold => $_getI64(5);
  @$pb.TagNumber(6)
  set validatorLowStakeThreshold($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasValidatorLowStakeThreshold() => $_has(5);
  @$pb.TagNumber(6)
  void clearValidatorLowStakeThreshold() => $_clearField(6);

  /// Deprecated.
  /// Validators with stake below `validator_very_low_stake_threshold` will be removed
  /// immediately at epoch change, no grace period.
  @$pb.TagNumber(7)
  $fixnum.Int64 get validatorVeryLowStakeThreshold => $_getI64(6);
  @$pb.TagNumber(7)
  set validatorVeryLowStakeThreshold($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasValidatorVeryLowStakeThreshold() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidatorVeryLowStakeThreshold() => $_clearField(7);

  /// A validator can have stake below `validator_low_stake_threshold`
  /// for this many epochs before being kicked out.
  @$pb.TagNumber(8)
  $fixnum.Int64 get validatorLowStakeGracePeriod => $_getI64(7);
  @$pb.TagNumber(8)
  set validatorLowStakeGracePeriod($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasValidatorLowStakeGracePeriod() => $_has(7);
  @$pb.TagNumber(8)
  void clearValidatorLowStakeGracePeriod() => $_clearField(8);

  /// Any extra fields that are not defined statically.
  @$pb.TagNumber(9)
  MoveTable get extraFields => $_getN(8);
  @$pb.TagNumber(9)
  set extraFields(MoveTable value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasExtraFields() => $_has(8);
  @$pb.TagNumber(9)
  void clearExtraFields() => $_clearField(9);
  @$pb.TagNumber(9)
  MoveTable ensureExtraFields() => $_ensure(8);
}

/// A message that represents a Move `0x2::table::Table` or `0x2::bag::Bag`
class MoveTable extends $pb.GeneratedMessage {
  factory MoveTable({
    $core.String? id,
    $fixnum.Int64? size,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (size != null) result.size = size;
    return result;
  }

  MoveTable._();

  factory MoveTable.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory MoveTable.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'MoveTable', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'size', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveTable clone() => MoveTable()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MoveTable copyWith(void Function(MoveTable) updates) => super.copyWith((message) => updates(message as MoveTable)) as MoveTable;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MoveTable create() => MoveTable._();
  @$core.override
  MoveTable createEmptyInstance() => create();
  static $pb.PbList<MoveTable> createRepeated() => $pb.PbList<MoveTable>();
  @$core.pragma('dart2js:noInline')
  static MoveTable getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MoveTable>(create);
  static MoveTable? _defaultInstance;

  /// The UID of the table or bag
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// The size or number of key-value pairs in the table or bag
  @$pb.TagNumber(2)
  $fixnum.Int64 get size => $_getI64(1);
  @$pb.TagNumber(2)
  set size($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSize() => $_has(1);
  @$pb.TagNumber(2)
  void clearSize() => $_clearField(2);
}

class StakeSubsidy extends $pb.GeneratedMessage {
  factory StakeSubsidy({
    $fixnum.Int64? balance,
    $fixnum.Int64? distributionCounter,
    $fixnum.Int64? currentDistributionAmount,
    $fixnum.Int64? stakeSubsidyPeriodLength,
    $core.int? stakeSubsidyDecreaseRate,
    MoveTable? extraFields,
  }) {
    final result = create();
    if (balance != null) result.balance = balance;
    if (distributionCounter != null) result.distributionCounter = distributionCounter;
    if (currentDistributionAmount != null) result.currentDistributionAmount = currentDistributionAmount;
    if (stakeSubsidyPeriodLength != null) result.stakeSubsidyPeriodLength = stakeSubsidyPeriodLength;
    if (stakeSubsidyDecreaseRate != null) result.stakeSubsidyDecreaseRate = stakeSubsidyDecreaseRate;
    if (extraFields != null) result.extraFields = extraFields;
    return result;
  }

  StakeSubsidy._();

  factory StakeSubsidy.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory StakeSubsidy.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StakeSubsidy', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'balance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'distributionCounter', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'currentDistributionAmount', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'stakeSubsidyPeriodLength', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'stakeSubsidyDecreaseRate', $pb.PbFieldType.OU3)
    ..aOM<MoveTable>(6, _omitFieldNames ? '' : 'extraFields', subBuilder: MoveTable.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StakeSubsidy clone() => StakeSubsidy()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StakeSubsidy copyWith(void Function(StakeSubsidy) updates) => super.copyWith((message) => updates(message as StakeSubsidy)) as StakeSubsidy;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StakeSubsidy create() => StakeSubsidy._();
  @$core.override
  StakeSubsidy createEmptyInstance() => create();
  static $pb.PbList<StakeSubsidy> createRepeated() => $pb.PbList<StakeSubsidy>();
  @$core.pragma('dart2js:noInline')
  static StakeSubsidy getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StakeSubsidy>(create);
  static StakeSubsidy? _defaultInstance;

  /// Balance of SUI set aside for stake subsidies that will be drawn down over time.
  @$pb.TagNumber(1)
  $fixnum.Int64 get balance => $_getI64(0);
  @$pb.TagNumber(1)
  set balance($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasBalance() => $_has(0);
  @$pb.TagNumber(1)
  void clearBalance() => $_clearField(1);

  /// Count of the number of times stake subsidies have been distributed.
  @$pb.TagNumber(2)
  $fixnum.Int64 get distributionCounter => $_getI64(1);
  @$pb.TagNumber(2)
  set distributionCounter($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDistributionCounter() => $_has(1);
  @$pb.TagNumber(2)
  void clearDistributionCounter() => $_clearField(2);

  /// The amount of stake subsidy to be drawn down per distribution.
  /// This amount decays and decreases over time.
  @$pb.TagNumber(3)
  $fixnum.Int64 get currentDistributionAmount => $_getI64(2);
  @$pb.TagNumber(3)
  set currentDistributionAmount($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentDistributionAmount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentDistributionAmount() => $_clearField(3);

  /// Number of distributions to occur before the distribution amount decays.
  @$pb.TagNumber(4)
  $fixnum.Int64 get stakeSubsidyPeriodLength => $_getI64(3);
  @$pb.TagNumber(4)
  set stakeSubsidyPeriodLength($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStakeSubsidyPeriodLength() => $_has(3);
  @$pb.TagNumber(4)
  void clearStakeSubsidyPeriodLength() => $_clearField(4);

  /// The rate at which the distribution amount decays at the end of each
  /// period. Expressed in basis points.
  @$pb.TagNumber(5)
  $core.int get stakeSubsidyDecreaseRate => $_getIZ(4);
  @$pb.TagNumber(5)
  set stakeSubsidyDecreaseRate($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStakeSubsidyDecreaseRate() => $_has(4);
  @$pb.TagNumber(5)
  void clearStakeSubsidyDecreaseRate() => $_clearField(5);

  /// Any extra fields that's not defined statically.
  @$pb.TagNumber(6)
  MoveTable get extraFields => $_getN(5);
  @$pb.TagNumber(6)
  set extraFields(MoveTable value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasExtraFields() => $_has(5);
  @$pb.TagNumber(6)
  void clearExtraFields() => $_clearField(6);
  @$pb.TagNumber(6)
  MoveTable ensureExtraFields() => $_ensure(5);
}

/// Struct representing the onchain storage fund.
class StorageFund extends $pb.GeneratedMessage {
  factory StorageFund({
    $fixnum.Int64? totalObjectStorageRebates,
    $fixnum.Int64? nonRefundableBalance,
  }) {
    final result = create();
    if (totalObjectStorageRebates != null) result.totalObjectStorageRebates = totalObjectStorageRebates;
    if (nonRefundableBalance != null) result.nonRefundableBalance = nonRefundableBalance;
    return result;
  }

  StorageFund._();

  factory StorageFund.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory StorageFund.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StorageFund', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'totalObjectStorageRebates', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'nonRefundableBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageFund clone() => StorageFund()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StorageFund copyWith(void Function(StorageFund) updates) => super.copyWith((message) => updates(message as StorageFund)) as StorageFund;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StorageFund create() => StorageFund._();
  @$core.override
  StorageFund createEmptyInstance() => create();
  static $pb.PbList<StorageFund> createRepeated() => $pb.PbList<StorageFund>();
  @$core.pragma('dart2js:noInline')
  static StorageFund getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StorageFund>(create);
  static StorageFund? _defaultInstance;

  /// This is the sum of `storage_rebate` of
  /// all objects currently stored on-chain. To maintain this invariant, the only inflow of this
  /// balance is storage charges collected from transactions, and the only outflow is storage rebates
  /// of transactions, including both the portion refunded to the transaction senders as well as
  /// the non-refundable portion taken out and put into `non_refundable_balance`.
  @$pb.TagNumber(1)
  $fixnum.Int64 get totalObjectStorageRebates => $_getI64(0);
  @$pb.TagNumber(1)
  set totalObjectStorageRebates($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalObjectStorageRebates() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalObjectStorageRebates() => $_clearField(1);

  /// Represents any remaining inflow of the storage fund that should not
  /// be taken out of the fund.
  @$pb.TagNumber(2)
  $fixnum.Int64 get nonRefundableBalance => $_getI64(1);
  @$pb.TagNumber(2)
  set nonRefundableBalance($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNonRefundableBalance() => $_has(1);
  @$pb.TagNumber(2)
  void clearNonRefundableBalance() => $_clearField(2);
}

class ValidatorSet extends $pb.GeneratedMessage {
  factory ValidatorSet({
    $fixnum.Int64? totalStake,
    $core.Iterable<Validator>? activeValidators,
    MoveTable? pendingActiveValidators,
    $core.Iterable<$fixnum.Int64>? pendingRemovals,
    MoveTable? stakingPoolMappings,
    MoveTable? inactiveValidators,
    MoveTable? validatorCandidates,
    $core.Iterable<$core.MapEntry<$core.String, $fixnum.Int64>>? atRiskValidators,
    MoveTable? extraFields,
  }) {
    final result = create();
    if (totalStake != null) result.totalStake = totalStake;
    if (activeValidators != null) result.activeValidators.addAll(activeValidators);
    if (pendingActiveValidators != null) result.pendingActiveValidators = pendingActiveValidators;
    if (pendingRemovals != null) result.pendingRemovals.addAll(pendingRemovals);
    if (stakingPoolMappings != null) result.stakingPoolMappings = stakingPoolMappings;
    if (inactiveValidators != null) result.inactiveValidators = inactiveValidators;
    if (validatorCandidates != null) result.validatorCandidates = validatorCandidates;
    if (atRiskValidators != null) result.atRiskValidators.addEntries(atRiskValidators);
    if (extraFields != null) result.extraFields = extraFields;
    return result;
  }

  ValidatorSet._();

  factory ValidatorSet.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory ValidatorSet.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ValidatorSet', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'totalStake', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..pc<Validator>(2, _omitFieldNames ? '' : 'activeValidators', $pb.PbFieldType.PM, subBuilder: Validator.create)
    ..aOM<MoveTable>(3, _omitFieldNames ? '' : 'pendingActiveValidators', subBuilder: MoveTable.create)
    ..p<$fixnum.Int64>(4, _omitFieldNames ? '' : 'pendingRemovals', $pb.PbFieldType.KU6)
    ..aOM<MoveTable>(5, _omitFieldNames ? '' : 'stakingPoolMappings', subBuilder: MoveTable.create)
    ..aOM<MoveTable>(6, _omitFieldNames ? '' : 'inactiveValidators', subBuilder: MoveTable.create)
    ..aOM<MoveTable>(7, _omitFieldNames ? '' : 'validatorCandidates', subBuilder: MoveTable.create)
    ..m<$core.String, $fixnum.Int64>(8, _omitFieldNames ? '' : 'atRiskValidators', entryClassName: 'ValidatorSet.AtRiskValidatorsEntry', keyFieldType: $pb.PbFieldType.OS, valueFieldType: $pb.PbFieldType.OU6, packageName: const $pb.PackageName('sui.rpc.v2'))
    ..aOM<MoveTable>(9, _omitFieldNames ? '' : 'extraFields', subBuilder: MoveTable.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorSet clone() => ValidatorSet()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ValidatorSet copyWith(void Function(ValidatorSet) updates) => super.copyWith((message) => updates(message as ValidatorSet)) as ValidatorSet;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ValidatorSet create() => ValidatorSet._();
  @$core.override
  ValidatorSet createEmptyInstance() => create();
  static $pb.PbList<ValidatorSet> createRepeated() => $pb.PbList<ValidatorSet>();
  @$core.pragma('dart2js:noInline')
  static ValidatorSet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ValidatorSet>(create);
  static ValidatorSet? _defaultInstance;

  /// Total amount of stake from all active validators at the beginning of the epoch.
  /// Written only once per epoch, in `advance_epoch` function.
  @$pb.TagNumber(1)
  $fixnum.Int64 get totalStake => $_getI64(0);
  @$pb.TagNumber(1)
  set totalStake($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTotalStake() => $_has(0);
  @$pb.TagNumber(1)
  void clearTotalStake() => $_clearField(1);

  /// The current list of active validators.
  @$pb.TagNumber(2)
  $pb.PbList<Validator> get activeValidators => $_getList(1);

  /// List of new validator candidates added during the current epoch.
  /// They will be processed at the end of the epoch.
  ///
  /// key: u64 (index), value: 0x3::validator::Validator
  @$pb.TagNumber(3)
  MoveTable get pendingActiveValidators => $_getN(2);
  @$pb.TagNumber(3)
  set pendingActiveValidators(MoveTable value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPendingActiveValidators() => $_has(2);
  @$pb.TagNumber(3)
  void clearPendingActiveValidators() => $_clearField(3);
  @$pb.TagNumber(3)
  MoveTable ensurePendingActiveValidators() => $_ensure(2);

  /// Removal requests from the validators. Each element is an index
  /// pointing to `active_validators`.
  @$pb.TagNumber(4)
  $pb.PbList<$fixnum.Int64> get pendingRemovals => $_getList(3);

  /// Mappings from staking pool's ID to the sui address of a validator.
  ///
  /// key: address (staking pool Id), value: address (sui address of the validator)
  @$pb.TagNumber(5)
  MoveTable get stakingPoolMappings => $_getN(4);
  @$pb.TagNumber(5)
  set stakingPoolMappings(MoveTable value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStakingPoolMappings() => $_has(4);
  @$pb.TagNumber(5)
  void clearStakingPoolMappings() => $_clearField(5);
  @$pb.TagNumber(5)
  MoveTable ensureStakingPoolMappings() => $_ensure(4);

  /// Mapping from a staking pool ID to the inactive validator that has that pool as its staking pool.
  /// When a validator is deactivated the validator is removed from `active_validators` it
  /// is added to this table so that stakers can continue to withdraw their stake from it.
  ///
  /// key: address (staking pool Id), value: 0x3::validator_wrapper::ValidatorWrapper
  @$pb.TagNumber(6)
  MoveTable get inactiveValidators => $_getN(5);
  @$pb.TagNumber(6)
  set inactiveValidators(MoveTable value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasInactiveValidators() => $_has(5);
  @$pb.TagNumber(6)
  void clearInactiveValidators() => $_clearField(6);
  @$pb.TagNumber(6)
  MoveTable ensureInactiveValidators() => $_ensure(5);

  /// Table storing preactive/candidate validators, mapping their addresses to their `Validator ` structs.
  /// When an address calls `request_add_validator_candidate`, they get added to this table and become a preactive
  /// validator.
  /// When the candidate has met the min stake requirement, they can call `request_add_validator` to
  /// officially add them to the active validator set `active_validators` next epoch.
  ///
  /// key: address (sui address of the validator), value: 0x3::validator_wrapper::ValidatorWrapper
  @$pb.TagNumber(7)
  MoveTable get validatorCandidates => $_getN(6);
  @$pb.TagNumber(7)
  set validatorCandidates(MoveTable value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasValidatorCandidates() => $_has(6);
  @$pb.TagNumber(7)
  void clearValidatorCandidates() => $_clearField(7);
  @$pb.TagNumber(7)
  MoveTable ensureValidatorCandidates() => $_ensure(6);

  /// Table storing the number of epochs during which a validator's stake has been below the low stake threshold.
  @$pb.TagNumber(8)
  $pb.PbMap<$core.String, $fixnum.Int64> get atRiskValidators => $_getMap(7);

  /// Any extra fields that's not defined statically.
  @$pb.TagNumber(9)
  MoveTable get extraFields => $_getN(8);
  @$pb.TagNumber(9)
  set extraFields(MoveTable value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasExtraFields() => $_has(8);
  @$pb.TagNumber(9)
  void clearExtraFields() => $_clearField(9);
  @$pb.TagNumber(9)
  MoveTable ensureExtraFields() => $_ensure(8);
}

/// Definition of a Validator in the system contracts
///
/// Note: fields of ValidatorMetadata are flattened into this type
class Validator extends $pb.GeneratedMessage {
  factory Validator({
    $core.String? name,
    $core.String? address,
    $core.String? description,
    $core.String? imageUrl,
    $core.String? projectUrl,
    $core.List<$core.int>? protocolPublicKey,
    $core.List<$core.int>? proofOfPossession,
    $core.List<$core.int>? networkPublicKey,
    $core.List<$core.int>? workerPublicKey,
    $core.String? networkAddress,
    $core.String? p2pAddress,
    $core.String? primaryAddress,
    $core.String? workerAddress,
    $core.List<$core.int>? nextEpochProtocolPublicKey,
    $core.List<$core.int>? nextEpochProofOfPossession,
    $core.List<$core.int>? nextEpochNetworkPublicKey,
    $core.List<$core.int>? nextEpochWorkerPublicKey,
    $core.String? nextEpochNetworkAddress,
    $core.String? nextEpochP2pAddress,
    $core.String? nextEpochPrimaryAddress,
    $core.String? nextEpochWorkerAddress,
    MoveTable? metadataExtraFields,
    $fixnum.Int64? votingPower,
    $core.String? operationCapId,
    $fixnum.Int64? gasPrice,
    StakingPool? stakingPool,
    $fixnum.Int64? commissionRate,
    $fixnum.Int64? nextEpochStake,
    $fixnum.Int64? nextEpochGasPrice,
    $fixnum.Int64? nextEpochCommissionRate,
    MoveTable? extraFields,
  }) {
    final result = create();
    if (name != null) result.name = name;
    if (address != null) result.address = address;
    if (description != null) result.description = description;
    if (imageUrl != null) result.imageUrl = imageUrl;
    if (projectUrl != null) result.projectUrl = projectUrl;
    if (protocolPublicKey != null) result.protocolPublicKey = protocolPublicKey;
    if (proofOfPossession != null) result.proofOfPossession = proofOfPossession;
    if (networkPublicKey != null) result.networkPublicKey = networkPublicKey;
    if (workerPublicKey != null) result.workerPublicKey = workerPublicKey;
    if (networkAddress != null) result.networkAddress = networkAddress;
    if (p2pAddress != null) result.p2pAddress = p2pAddress;
    if (primaryAddress != null) result.primaryAddress = primaryAddress;
    if (workerAddress != null) result.workerAddress = workerAddress;
    if (nextEpochProtocolPublicKey != null) result.nextEpochProtocolPublicKey = nextEpochProtocolPublicKey;
    if (nextEpochProofOfPossession != null) result.nextEpochProofOfPossession = nextEpochProofOfPossession;
    if (nextEpochNetworkPublicKey != null) result.nextEpochNetworkPublicKey = nextEpochNetworkPublicKey;
    if (nextEpochWorkerPublicKey != null) result.nextEpochWorkerPublicKey = nextEpochWorkerPublicKey;
    if (nextEpochNetworkAddress != null) result.nextEpochNetworkAddress = nextEpochNetworkAddress;
    if (nextEpochP2pAddress != null) result.nextEpochP2pAddress = nextEpochP2pAddress;
    if (nextEpochPrimaryAddress != null) result.nextEpochPrimaryAddress = nextEpochPrimaryAddress;
    if (nextEpochWorkerAddress != null) result.nextEpochWorkerAddress = nextEpochWorkerAddress;
    if (metadataExtraFields != null) result.metadataExtraFields = metadataExtraFields;
    if (votingPower != null) result.votingPower = votingPower;
    if (operationCapId != null) result.operationCapId = operationCapId;
    if (gasPrice != null) result.gasPrice = gasPrice;
    if (stakingPool != null) result.stakingPool = stakingPool;
    if (commissionRate != null) result.commissionRate = commissionRate;
    if (nextEpochStake != null) result.nextEpochStake = nextEpochStake;
    if (nextEpochGasPrice != null) result.nextEpochGasPrice = nextEpochGasPrice;
    if (nextEpochCommissionRate != null) result.nextEpochCommissionRate = nextEpochCommissionRate;
    if (extraFields != null) result.extraFields = extraFields;
    return result;
  }

  Validator._();

  factory Validator.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory Validator.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Validator', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'name')
    ..aOS(2, _omitFieldNames ? '' : 'address')
    ..aOS(3, _omitFieldNames ? '' : 'description')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..aOS(5, _omitFieldNames ? '' : 'projectUrl')
    ..a<$core.List<$core.int>>(7, _omitFieldNames ? '' : 'protocolPublicKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(8, _omitFieldNames ? '' : 'proofOfPossession', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(10, _omitFieldNames ? '' : 'networkPublicKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(12, _omitFieldNames ? '' : 'workerPublicKey', $pb.PbFieldType.OY)
    ..aOS(13, _omitFieldNames ? '' : 'networkAddress')
    ..aOS(14, _omitFieldNames ? '' : 'p2pAddress')
    ..aOS(15, _omitFieldNames ? '' : 'primaryAddress')
    ..aOS(16, _omitFieldNames ? '' : 'workerAddress')
    ..a<$core.List<$core.int>>(18, _omitFieldNames ? '' : 'nextEpochProtocolPublicKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(19, _omitFieldNames ? '' : 'nextEpochProofOfPossession', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(21, _omitFieldNames ? '' : 'nextEpochNetworkPublicKey', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(23, _omitFieldNames ? '' : 'nextEpochWorkerPublicKey', $pb.PbFieldType.OY)
    ..aOS(24, _omitFieldNames ? '' : 'nextEpochNetworkAddress')
    ..aOS(25, _omitFieldNames ? '' : 'nextEpochP2pAddress')
    ..aOS(26, _omitFieldNames ? '' : 'nextEpochPrimaryAddress')
    ..aOS(27, _omitFieldNames ? '' : 'nextEpochWorkerAddress')
    ..aOM<MoveTable>(28, _omitFieldNames ? '' : 'metadataExtraFields', subBuilder: MoveTable.create)
    ..a<$fixnum.Int64>(29, _omitFieldNames ? '' : 'votingPower', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(30, _omitFieldNames ? '' : 'operationCapId')
    ..a<$fixnum.Int64>(31, _omitFieldNames ? '' : 'gasPrice', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<StakingPool>(32, _omitFieldNames ? '' : 'stakingPool', subBuilder: StakingPool.create)
    ..a<$fixnum.Int64>(33, _omitFieldNames ? '' : 'commissionRate', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(34, _omitFieldNames ? '' : 'nextEpochStake', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(35, _omitFieldNames ? '' : 'nextEpochGasPrice', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(36, _omitFieldNames ? '' : 'nextEpochCommissionRate', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MoveTable>(37, _omitFieldNames ? '' : 'extraFields', subBuilder: MoveTable.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Validator clone() => Validator()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Validator copyWith(void Function(Validator) updates) => super.copyWith((message) => updates(message as Validator)) as Validator;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Validator create() => Validator._();
  @$core.override
  Validator createEmptyInstance() => create();
  static $pb.PbList<Validator> createRepeated() => $pb.PbList<Validator>();
  @$core.pragma('dart2js:noInline')
  static Validator getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Validator>(create);
  static Validator? _defaultInstance;

  /// A unique human-readable name of this validator.
  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => $_clearField(1);

  /// The Sui Address of the validator. This is the sender that created the Validator object,
  /// and also the address to send validator/coins to during withdraws.
  @$pb.TagNumber(2)
  $core.String get address => $_getSZ(1);
  @$pb.TagNumber(2)
  set address($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAddress() => $_has(1);
  @$pb.TagNumber(2)
  void clearAddress() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get projectUrl => $_getSZ(4);
  @$pb.TagNumber(5)
  set projectUrl($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasProjectUrl() => $_has(4);
  @$pb.TagNumber(5)
  void clearProjectUrl() => $_clearField(5);

  /// The public key bytes corresponding to the private key that the validator
  /// holds to sign transactions. For now, this is the same as AuthorityName.
  @$pb.TagNumber(7)
  $core.List<$core.int> get protocolPublicKey => $_getN(5);
  @$pb.TagNumber(7)
  set protocolPublicKey($core.List<$core.int> value) => $_setBytes(5, value);
  @$pb.TagNumber(7)
  $core.bool hasProtocolPublicKey() => $_has(5);
  @$pb.TagNumber(7)
  void clearProtocolPublicKey() => $_clearField(7);

  /// This is a proof that the validator has ownership of the protocol private key
  @$pb.TagNumber(8)
  $core.List<$core.int> get proofOfPossession => $_getN(6);
  @$pb.TagNumber(8)
  set proofOfPossession($core.List<$core.int> value) => $_setBytes(6, value);
  @$pb.TagNumber(8)
  $core.bool hasProofOfPossession() => $_has(6);
  @$pb.TagNumber(8)
  void clearProofOfPossession() => $_clearField(8);

  /// The public key bytes corresponding to the private key that the validator
  /// uses to establish TLS connections
  @$pb.TagNumber(10)
  $core.List<$core.int> get networkPublicKey => $_getN(7);
  @$pb.TagNumber(10)
  set networkPublicKey($core.List<$core.int> value) => $_setBytes(7, value);
  @$pb.TagNumber(10)
  $core.bool hasNetworkPublicKey() => $_has(7);
  @$pb.TagNumber(10)
  void clearNetworkPublicKey() => $_clearField(10);

  /// The public key bytes corresponding to the Narwhal Worker
  @$pb.TagNumber(12)
  $core.List<$core.int> get workerPublicKey => $_getN(8);
  @$pb.TagNumber(12)
  set workerPublicKey($core.List<$core.int> value) => $_setBytes(8, value);
  @$pb.TagNumber(12)
  $core.bool hasWorkerPublicKey() => $_has(8);
  @$pb.TagNumber(12)
  void clearWorkerPublicKey() => $_clearField(12);

  /// The network address of the validator (could also contain extra info such as port, DNS and etc.).
  @$pb.TagNumber(13)
  $core.String get networkAddress => $_getSZ(9);
  @$pb.TagNumber(13)
  set networkAddress($core.String value) => $_setString(9, value);
  @$pb.TagNumber(13)
  $core.bool hasNetworkAddress() => $_has(9);
  @$pb.TagNumber(13)
  void clearNetworkAddress() => $_clearField(13);

  /// The address of the validator used for p2p activities such as state sync (could also contain extra info such as port, DNS and etc.).
  @$pb.TagNumber(14)
  $core.String get p2pAddress => $_getSZ(10);
  @$pb.TagNumber(14)
  set p2pAddress($core.String value) => $_setString(10, value);
  @$pb.TagNumber(14)
  $core.bool hasP2pAddress() => $_has(10);
  @$pb.TagNumber(14)
  void clearP2pAddress() => $_clearField(14);

  /// The address of the narwhal primary
  @$pb.TagNumber(15)
  $core.String get primaryAddress => $_getSZ(11);
  @$pb.TagNumber(15)
  set primaryAddress($core.String value) => $_setString(11, value);
  @$pb.TagNumber(15)
  $core.bool hasPrimaryAddress() => $_has(11);
  @$pb.TagNumber(15)
  void clearPrimaryAddress() => $_clearField(15);

  /// The address of the narwhal worker
  @$pb.TagNumber(16)
  $core.String get workerAddress => $_getSZ(12);
  @$pb.TagNumber(16)
  set workerAddress($core.String value) => $_setString(12, value);
  @$pb.TagNumber(16)
  $core.bool hasWorkerAddress() => $_has(12);
  @$pb.TagNumber(16)
  void clearWorkerAddress() => $_clearField(16);

  @$pb.TagNumber(18)
  $core.List<$core.int> get nextEpochProtocolPublicKey => $_getN(13);
  @$pb.TagNumber(18)
  set nextEpochProtocolPublicKey($core.List<$core.int> value) => $_setBytes(13, value);
  @$pb.TagNumber(18)
  $core.bool hasNextEpochProtocolPublicKey() => $_has(13);
  @$pb.TagNumber(18)
  void clearNextEpochProtocolPublicKey() => $_clearField(18);

  @$pb.TagNumber(19)
  $core.List<$core.int> get nextEpochProofOfPossession => $_getN(14);
  @$pb.TagNumber(19)
  set nextEpochProofOfPossession($core.List<$core.int> value) => $_setBytes(14, value);
  @$pb.TagNumber(19)
  $core.bool hasNextEpochProofOfPossession() => $_has(14);
  @$pb.TagNumber(19)
  void clearNextEpochProofOfPossession() => $_clearField(19);

  @$pb.TagNumber(21)
  $core.List<$core.int> get nextEpochNetworkPublicKey => $_getN(15);
  @$pb.TagNumber(21)
  set nextEpochNetworkPublicKey($core.List<$core.int> value) => $_setBytes(15, value);
  @$pb.TagNumber(21)
  $core.bool hasNextEpochNetworkPublicKey() => $_has(15);
  @$pb.TagNumber(21)
  void clearNextEpochNetworkPublicKey() => $_clearField(21);

  @$pb.TagNumber(23)
  $core.List<$core.int> get nextEpochWorkerPublicKey => $_getN(16);
  @$pb.TagNumber(23)
  set nextEpochWorkerPublicKey($core.List<$core.int> value) => $_setBytes(16, value);
  @$pb.TagNumber(23)
  $core.bool hasNextEpochWorkerPublicKey() => $_has(16);
  @$pb.TagNumber(23)
  void clearNextEpochWorkerPublicKey() => $_clearField(23);

  @$pb.TagNumber(24)
  $core.String get nextEpochNetworkAddress => $_getSZ(17);
  @$pb.TagNumber(24)
  set nextEpochNetworkAddress($core.String value) => $_setString(17, value);
  @$pb.TagNumber(24)
  $core.bool hasNextEpochNetworkAddress() => $_has(17);
  @$pb.TagNumber(24)
  void clearNextEpochNetworkAddress() => $_clearField(24);

  @$pb.TagNumber(25)
  $core.String get nextEpochP2pAddress => $_getSZ(18);
  @$pb.TagNumber(25)
  set nextEpochP2pAddress($core.String value) => $_setString(18, value);
  @$pb.TagNumber(25)
  $core.bool hasNextEpochP2pAddress() => $_has(18);
  @$pb.TagNumber(25)
  void clearNextEpochP2pAddress() => $_clearField(25);

  @$pb.TagNumber(26)
  $core.String get nextEpochPrimaryAddress => $_getSZ(19);
  @$pb.TagNumber(26)
  set nextEpochPrimaryAddress($core.String value) => $_setString(19, value);
  @$pb.TagNumber(26)
  $core.bool hasNextEpochPrimaryAddress() => $_has(19);
  @$pb.TagNumber(26)
  void clearNextEpochPrimaryAddress() => $_clearField(26);

  @$pb.TagNumber(27)
  $core.String get nextEpochWorkerAddress => $_getSZ(20);
  @$pb.TagNumber(27)
  set nextEpochWorkerAddress($core.String value) => $_setString(20, value);
  @$pb.TagNumber(27)
  $core.bool hasNextEpochWorkerAddress() => $_has(20);
  @$pb.TagNumber(27)
  void clearNextEpochWorkerAddress() => $_clearField(27);

  /// Any extra fields that's not defined statically in the `ValidatorMetadata` struct
  @$pb.TagNumber(28)
  MoveTable get metadataExtraFields => $_getN(21);
  @$pb.TagNumber(28)
  set metadataExtraFields(MoveTable value) => $_setField(28, value);
  @$pb.TagNumber(28)
  $core.bool hasMetadataExtraFields() => $_has(21);
  @$pb.TagNumber(28)
  void clearMetadataExtraFields() => $_clearField(28);
  @$pb.TagNumber(28)
  MoveTable ensureMetadataExtraFields() => $_ensure(21);

  /// The voting power of this validator, which might be different from its
  /// stake amount.
  @$pb.TagNumber(29)
  $fixnum.Int64 get votingPower => $_getI64(22);
  @$pb.TagNumber(29)
  set votingPower($fixnum.Int64 value) => $_setInt64(22, value);
  @$pb.TagNumber(29)
  $core.bool hasVotingPower() => $_has(22);
  @$pb.TagNumber(29)
  void clearVotingPower() => $_clearField(29);

  /// The ID of this validator's current valid `UnverifiedValidatorOperationCap`
  @$pb.TagNumber(30)
  $core.String get operationCapId => $_getSZ(23);
  @$pb.TagNumber(30)
  set operationCapId($core.String value) => $_setString(23, value);
  @$pb.TagNumber(30)
  $core.bool hasOperationCapId() => $_has(23);
  @$pb.TagNumber(30)
  void clearOperationCapId() => $_clearField(30);

  /// Gas price quote, updated only at end of epoch.
  @$pb.TagNumber(31)
  $fixnum.Int64 get gasPrice => $_getI64(24);
  @$pb.TagNumber(31)
  set gasPrice($fixnum.Int64 value) => $_setInt64(24, value);
  @$pb.TagNumber(31)
  $core.bool hasGasPrice() => $_has(24);
  @$pb.TagNumber(31)
  void clearGasPrice() => $_clearField(31);

  /// Staking pool for this validator.
  @$pb.TagNumber(32)
  StakingPool get stakingPool => $_getN(25);
  @$pb.TagNumber(32)
  set stakingPool(StakingPool value) => $_setField(32, value);
  @$pb.TagNumber(32)
  $core.bool hasStakingPool() => $_has(25);
  @$pb.TagNumber(32)
  void clearStakingPool() => $_clearField(32);
  @$pb.TagNumber(32)
  StakingPool ensureStakingPool() => $_ensure(25);

  /// Commission rate of the validator, in basis point.
  @$pb.TagNumber(33)
  $fixnum.Int64 get commissionRate => $_getI64(26);
  @$pb.TagNumber(33)
  set commissionRate($fixnum.Int64 value) => $_setInt64(26, value);
  @$pb.TagNumber(33)
  $core.bool hasCommissionRate() => $_has(26);
  @$pb.TagNumber(33)
  void clearCommissionRate() => $_clearField(33);

  /// Total amount of stake that would be active in the next epoch.
  @$pb.TagNumber(34)
  $fixnum.Int64 get nextEpochStake => $_getI64(27);
  @$pb.TagNumber(34)
  set nextEpochStake($fixnum.Int64 value) => $_setInt64(27, value);
  @$pb.TagNumber(34)
  $core.bool hasNextEpochStake() => $_has(27);
  @$pb.TagNumber(34)
  void clearNextEpochStake() => $_clearField(34);

  /// This validator's gas price quote for the next epoch.
  @$pb.TagNumber(35)
  $fixnum.Int64 get nextEpochGasPrice => $_getI64(28);
  @$pb.TagNumber(35)
  set nextEpochGasPrice($fixnum.Int64 value) => $_setInt64(28, value);
  @$pb.TagNumber(35)
  $core.bool hasNextEpochGasPrice() => $_has(28);
  @$pb.TagNumber(35)
  void clearNextEpochGasPrice() => $_clearField(35);

  /// The commission rate of the validator starting the next epoch, in basis point.
  @$pb.TagNumber(36)
  $fixnum.Int64 get nextEpochCommissionRate => $_getI64(29);
  @$pb.TagNumber(36)
  set nextEpochCommissionRate($fixnum.Int64 value) => $_setInt64(29, value);
  @$pb.TagNumber(36)
  $core.bool hasNextEpochCommissionRate() => $_has(29);
  @$pb.TagNumber(36)
  void clearNextEpochCommissionRate() => $_clearField(36);

  /// Any extra fields that's not defined statically.
  @$pb.TagNumber(37)
  MoveTable get extraFields => $_getN(30);
  @$pb.TagNumber(37)
  set extraFields(MoveTable value) => $_setField(37, value);
  @$pb.TagNumber(37)
  $core.bool hasExtraFields() => $_has(30);
  @$pb.TagNumber(37)
  void clearExtraFields() => $_clearField(37);
  @$pb.TagNumber(37)
  MoveTable ensureExtraFields() => $_ensure(30);
}

/// A staking pool embedded in each validator struct in the system state object.
class StakingPool extends $pb.GeneratedMessage {
  factory StakingPool({
    $core.String? id,
    $fixnum.Int64? activationEpoch,
    $fixnum.Int64? deactivationEpoch,
    $fixnum.Int64? suiBalance,
    $fixnum.Int64? rewardsPool,
    $fixnum.Int64? poolTokenBalance,
    MoveTable? exchangeRates,
    $fixnum.Int64? pendingStake,
    $fixnum.Int64? pendingTotalSuiWithdraw,
    $fixnum.Int64? pendingPoolTokenWithdraw,
    MoveTable? extraFields,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (activationEpoch != null) result.activationEpoch = activationEpoch;
    if (deactivationEpoch != null) result.deactivationEpoch = deactivationEpoch;
    if (suiBalance != null) result.suiBalance = suiBalance;
    if (rewardsPool != null) result.rewardsPool = rewardsPool;
    if (poolTokenBalance != null) result.poolTokenBalance = poolTokenBalance;
    if (exchangeRates != null) result.exchangeRates = exchangeRates;
    if (pendingStake != null) result.pendingStake = pendingStake;
    if (pendingTotalSuiWithdraw != null) result.pendingTotalSuiWithdraw = pendingTotalSuiWithdraw;
    if (pendingPoolTokenWithdraw != null) result.pendingPoolTokenWithdraw = pendingPoolTokenWithdraw;
    if (extraFields != null) result.extraFields = extraFields;
    return result;
  }

  StakingPool._();

  factory StakingPool.fromBuffer($core.List<$core.int> data, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(data, registry);
  factory StakingPool.fromJson($core.String json, [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'StakingPool', package: const $pb.PackageName(_omitMessageNames ? '' : 'sui.rpc.v2'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'activationEpoch', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'deactivationEpoch', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'suiBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'rewardsPool', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(6, _omitFieldNames ? '' : 'poolTokenBalance', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MoveTable>(7, _omitFieldNames ? '' : 'exchangeRates', subBuilder: MoveTable.create)
    ..a<$fixnum.Int64>(8, _omitFieldNames ? '' : 'pendingStake', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(9, _omitFieldNames ? '' : 'pendingTotalSuiWithdraw', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(10, _omitFieldNames ? '' : 'pendingPoolTokenWithdraw', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MoveTable>(11, _omitFieldNames ? '' : 'extraFields', subBuilder: MoveTable.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StakingPool clone() => StakingPool()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StakingPool copyWith(void Function(StakingPool) updates) => super.copyWith((message) => updates(message as StakingPool)) as StakingPool;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StakingPool create() => StakingPool._();
  @$core.override
  StakingPool createEmptyInstance() => create();
  static $pb.PbList<StakingPool> createRepeated() => $pb.PbList<StakingPool>();
  @$core.pragma('dart2js:noInline')
  static StakingPool getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StakingPool>(create);
  static StakingPool? _defaultInstance;

  /// UID of the StakingPool object
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// The epoch at which this pool became active.
  /// The value is `None` if the pool is pre-active and `Some(<epoch_number>)` if active or inactive.
  @$pb.TagNumber(2)
  $fixnum.Int64 get activationEpoch => $_getI64(1);
  @$pb.TagNumber(2)
  set activationEpoch($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasActivationEpoch() => $_has(1);
  @$pb.TagNumber(2)
  void clearActivationEpoch() => $_clearField(2);

  /// The epoch at which this staking pool ceased to be active. `None` = {pre-active, active},
  /// `Some(<epoch_number>)` if in-active, and it was de-activated at epoch `<epoch_number>`.
  @$pb.TagNumber(3)
  $fixnum.Int64 get deactivationEpoch => $_getI64(2);
  @$pb.TagNumber(3)
  set deactivationEpoch($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDeactivationEpoch() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeactivationEpoch() => $_clearField(3);

  /// The total number of SUI tokens in this pool, including the SUI in the rewards_pool, as well as in all the principal
  /// in the `StakedSui` object, updated at epoch boundaries.
  @$pb.TagNumber(4)
  $fixnum.Int64 get suiBalance => $_getI64(3);
  @$pb.TagNumber(4)
  set suiBalance($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSuiBalance() => $_has(3);
  @$pb.TagNumber(4)
  void clearSuiBalance() => $_clearField(4);

  /// The epoch stake rewards will be added here at the end of each epoch.
  @$pb.TagNumber(5)
  $fixnum.Int64 get rewardsPool => $_getI64(4);
  @$pb.TagNumber(5)
  set rewardsPool($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRewardsPool() => $_has(4);
  @$pb.TagNumber(5)
  void clearRewardsPool() => $_clearField(5);

  /// Total number of pool tokens issued by the pool.
  @$pb.TagNumber(6)
  $fixnum.Int64 get poolTokenBalance => $_getI64(5);
  @$pb.TagNumber(6)
  set poolTokenBalance($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPoolTokenBalance() => $_has(5);
  @$pb.TagNumber(6)
  void clearPoolTokenBalance() => $_clearField(6);

  /// Exchange rate history of previous epochs.
  ///
  /// The entries start from the `activation_epoch` of this pool and contains exchange rates at the beginning of each epoch,
  /// i.e., right after the rewards for the previous epoch have been deposited into the pool.
  ///
  /// key: u64 (epoch number), value: PoolTokenExchangeRate
  @$pb.TagNumber(7)
  MoveTable get exchangeRates => $_getN(6);
  @$pb.TagNumber(7)
  set exchangeRates(MoveTable value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasExchangeRates() => $_has(6);
  @$pb.TagNumber(7)
  void clearExchangeRates() => $_clearField(7);
  @$pb.TagNumber(7)
  MoveTable ensureExchangeRates() => $_ensure(6);

  /// Pending stake amount for this epoch, emptied at epoch boundaries.
  @$pb.TagNumber(8)
  $fixnum.Int64 get pendingStake => $_getI64(7);
  @$pb.TagNumber(8)
  set pendingStake($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasPendingStake() => $_has(7);
  @$pb.TagNumber(8)
  void clearPendingStake() => $_clearField(8);

  /// Pending stake withdrawn during the current epoch, emptied at epoch boundaries.
  /// This includes both the principal and rewards SUI withdrawn.
  @$pb.TagNumber(9)
  $fixnum.Int64 get pendingTotalSuiWithdraw => $_getI64(8);
  @$pb.TagNumber(9)
  set pendingTotalSuiWithdraw($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasPendingTotalSuiWithdraw() => $_has(8);
  @$pb.TagNumber(9)
  void clearPendingTotalSuiWithdraw() => $_clearField(9);

  /// Pending pool token withdrawn during the current epoch, emptied at epoch boundaries.
  @$pb.TagNumber(10)
  $fixnum.Int64 get pendingPoolTokenWithdraw => $_getI64(9);
  @$pb.TagNumber(10)
  set pendingPoolTokenWithdraw($fixnum.Int64 value) => $_setInt64(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPendingPoolTokenWithdraw() => $_has(9);
  @$pb.TagNumber(10)
  void clearPendingPoolTokenWithdraw() => $_clearField(10);

  /// Any extra fields that's not defined statically.
  @$pb.TagNumber(11)
  MoveTable get extraFields => $_getN(10);
  @$pb.TagNumber(11)
  set extraFields(MoveTable value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasExtraFields() => $_has(10);
  @$pb.TagNumber(11)
  void clearExtraFields() => $_clearField(11);
  @$pb.TagNumber(11)
  MoveTable ensureExtraFields() => $_ensure(10);
}


const $core.bool _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
