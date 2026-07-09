// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkpoint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Checkpoint {
  String get epoch;
  String get sequenceNumber;
  String get digest;
  String get networkTotalTransactions;
  String? get previousDigest;
  EpochRollingGasCostSummary get epochRollingGasCostSummary;
  String get timestampMs;
  List<String> get transactions;
  List<dynamic> get checkpointCommitments;
  String get validatorSignature;

  /// Serializes this Checkpoint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'Checkpoint(epoch: $epoch, sequenceNumber: $sequenceNumber, digest: $digest, networkTotalTransactions: $networkTotalTransactions, previousDigest: $previousDigest, epochRollingGasCostSummary: $epochRollingGasCostSummary, timestampMs: $timestampMs, transactions: $transactions, checkpointCommitments: $checkpointCommitments, validatorSignature: $validatorSignature)';
  }
}

/// @nodoc
@JsonSerializable()
class _Checkpoint implements Checkpoint {
  const _Checkpoint(
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
  factory _Checkpoint.fromJson(Map<String, dynamic> json) =>
      _$CheckpointFromJson(json);

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
  Map<String, dynamic> toJson() {
    return _$CheckpointToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'Checkpoint(epoch: $epoch, sequenceNumber: $sequenceNumber, digest: $digest, networkTotalTransactions: $networkTotalTransactions, previousDigest: $previousDigest, epochRollingGasCostSummary: $epochRollingGasCostSummary, timestampMs: $timestampMs, transactions: $transactions, checkpointCommitments: $checkpointCommitments, validatorSignature: $validatorSignature)';
  }
}

/// @nodoc
mixin _$EpochRollingGasCostSummary {
  String get computationCost;
  String get storageCost;
  String get storageRebate;
  String get nonRefundableStorageFee;

  /// Serializes this EpochRollingGasCostSummary to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'EpochRollingGasCostSummary(computationCost: $computationCost, storageCost: $storageCost, storageRebate: $storageRebate, nonRefundableStorageFee: $nonRefundableStorageFee)';
  }
}

/// @nodoc
@JsonSerializable()
class _EpochRollingGasCostSummary implements EpochRollingGasCostSummary {
  const _EpochRollingGasCostSummary(
      {required this.computationCost,
      required this.storageCost,
      required this.storageRebate,
      required this.nonRefundableStorageFee});
  factory _EpochRollingGasCostSummary.fromJson(Map<String, dynamic> json) =>
      _$EpochRollingGasCostSummaryFromJson(json);

  @override
  final String computationCost;
  @override
  final String storageCost;
  @override
  final String storageRebate;
  @override
  final String nonRefundableStorageFee;

  @override
  Map<String, dynamic> toJson() {
    return _$EpochRollingGasCostSummaryToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'EpochRollingGasCostSummary(computationCost: $computationCost, storageCost: $storageCost, storageRebate: $storageRebate, nonRefundableStorageFee: $nonRefundableStorageFee)';
  }
}

// dart format on
