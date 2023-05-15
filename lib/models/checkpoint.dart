
import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkpoint.freezed.dart';
part 'checkpoint.g.dart';

@freezed
class Checkpoint with _$Checkpoint{
  const factory Checkpoint({
    required String epoch,
    required String sequenceNumber,
    required String digest,
    required String networkTotalTransactions,
    String? previousDigest,
    required EpochRollingGasCostSummary epochRollingGasCostSummary,
    required String timestampMs,
    required List<String> transactions,
    required List<dynamic> checkpointCommitments,
    required String validatorSignature
  }) = _Checkpoint;

  factory Checkpoint.fromJson(Map<String, dynamic> json) => _$CheckpointFromJson(json);
}

@freezed
class EpochRollingGasCostSummary with _$EpochRollingGasCostSummary{
  const factory EpochRollingGasCostSummary({
    required String computationCost,
    required String storageCost,
    required String storageRebate,
    required String nonRefundableStorageFee,
  }) = _EpochRollingGasCostSummary;

  factory EpochRollingGasCostSummary.fromJson(Map<String, dynamic> json) => _$EpochRollingGasCostSummaryFromJson(json);
}