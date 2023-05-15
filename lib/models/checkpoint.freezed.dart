// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkpoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Checkpoint _$CheckpointFromJson(Map<String, dynamic> json) {
  return _Checkpoint.fromJson(json);
}

/// @nodoc
mixin _$Checkpoint {
  String get epoch => throw _privateConstructorUsedError;
  String get sequenceNumber => throw _privateConstructorUsedError;
  String get digest => throw _privateConstructorUsedError;
  String get networkTotalTransactions => throw _privateConstructorUsedError;
  String? get previousDigest => throw _privateConstructorUsedError;
  EpochRollingGasCostSummary get epochRollingGasCostSummary =>
      throw _privateConstructorUsedError;
  String get timestampMs => throw _privateConstructorUsedError;
  List<String> get transactions => throw _privateConstructorUsedError;
  List<dynamic> get checkpointCommitments => throw _privateConstructorUsedError;
  String get validatorSignature => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_Checkpoint implements _Checkpoint {
  const _$_Checkpoint(
      {required this.epoch,
      required this.sequenceNumber,
      required this.digest,
      required this.networkTotalTransactions,
      this.previousDigest,
      required this.epochRollingGasCostSummary,
      required this.timestampMs,
      required final List<String> transactions,
      required final List<dynamic> checkpointCommitments,
      required this.validatorSignature})
      : _transactions = transactions,
        _checkpointCommitments = checkpointCommitments;

  factory _$_Checkpoint.fromJson(Map<String, dynamic> json) =>
      _$$_CheckpointFromJson(json);

  @override
  final String epoch;
  @override
  final String sequenceNumber;
  @override
  final String digest;
  @override
  final String networkTotalTransactions;
  @override
  final String? previousDigest;
  @override
  final EpochRollingGasCostSummary epochRollingGasCostSummary;
  @override
  final String timestampMs;
  final List<String> _transactions;
  @override
  List<String> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  final List<dynamic> _checkpointCommitments;
  @override
  List<dynamic> get checkpointCommitments {
    if (_checkpointCommitments is EqualUnmodifiableListView)
      return _checkpointCommitments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_checkpointCommitments);
  }

  @override
  final String validatorSignature;

  @override
  String toString() {
    return 'Checkpoint(epoch: $epoch, sequenceNumber: $sequenceNumber, digest: $digest, networkTotalTransactions: $networkTotalTransactions, previousDigest: $previousDigest, epochRollingGasCostSummary: $epochRollingGasCostSummary, timestampMs: $timestampMs, transactions: $transactions, checkpointCommitments: $checkpointCommitments, validatorSignature: $validatorSignature)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_CheckpointToJson(
      this,
    );
  }
}

abstract class _Checkpoint implements Checkpoint {
  const factory _Checkpoint(
      {required final String epoch,
      required final String sequenceNumber,
      required final String digest,
      required final String networkTotalTransactions,
      final String? previousDigest,
      required final EpochRollingGasCostSummary epochRollingGasCostSummary,
      required final String timestampMs,
      required final List<String> transactions,
      required final List<dynamic> checkpointCommitments,
      required final String validatorSignature}) = _$_Checkpoint;

  factory _Checkpoint.fromJson(Map<String, dynamic> json) =
      _$_Checkpoint.fromJson;

  @override
  String get epoch;
  @override
  String get sequenceNumber;
  @override
  String get digest;
  @override
  String get networkTotalTransactions;
  @override
  String? get previousDigest;
  @override
  EpochRollingGasCostSummary get epochRollingGasCostSummary;
  @override
  String get timestampMs;
  @override
  List<String> get transactions;
  @override
  List<dynamic> get checkpointCommitments;
  @override
  String get validatorSignature;
}

EpochRollingGasCostSummary _$EpochRollingGasCostSummaryFromJson(
    Map<String, dynamic> json) {
  return _EpochRollingGasCostSummary.fromJson(json);
}

/// @nodoc
mixin _$EpochRollingGasCostSummary {
  String get computationCost => throw _privateConstructorUsedError;
  String get storageCost => throw _privateConstructorUsedError;
  String get storageRebate => throw _privateConstructorUsedError;
  String get nonRefundableStorageFee => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_EpochRollingGasCostSummary implements _EpochRollingGasCostSummary {
  const _$_EpochRollingGasCostSummary(
      {required this.computationCost,
      required this.storageCost,
      required this.storageRebate,
      required this.nonRefundableStorageFee});

  factory _$_EpochRollingGasCostSummary.fromJson(Map<String, dynamic> json) =>
      _$$_EpochRollingGasCostSummaryFromJson(json);

  @override
  final String computationCost;
  @override
  final String storageCost;
  @override
  final String storageRebate;
  @override
  final String nonRefundableStorageFee;

  @override
  String toString() {
    return 'EpochRollingGasCostSummary(computationCost: $computationCost, storageCost: $storageCost, storageRebate: $storageRebate, nonRefundableStorageFee: $nonRefundableStorageFee)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_EpochRollingGasCostSummaryToJson(
      this,
    );
  }
}

abstract class _EpochRollingGasCostSummary
    implements EpochRollingGasCostSummary {
  const factory _EpochRollingGasCostSummary(
          {required final String computationCost,
          required final String storageCost,
          required final String storageRebate,
          required final String nonRefundableStorageFee}) =
      _$_EpochRollingGasCostSummary;

  factory _EpochRollingGasCostSummary.fromJson(Map<String, dynamic> json) =
      _$_EpochRollingGasCostSummary.fromJson;

  @override
  String get computationCost;
  @override
  String get storageCost;
  @override
  String get storageRebate;
  @override
  String get nonRefundableStorageFee;
}
