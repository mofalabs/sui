// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkpoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Checkpoint _$$_CheckpointFromJson(Map<String, dynamic> json) =>
    _$_Checkpoint(
      epoch: json['epoch'] as String,
      sequenceNumber: json['sequenceNumber'] as String,
      digest: json['digest'] as String,
      networkTotalTransactions: json['networkTotalTransactions'] as String,
      previousDigest: json['previousDigest'] as String?,
      epochRollingGasCostSummary: EpochRollingGasCostSummary.fromJson(
          json['epochRollingGasCostSummary'] as Map<String, dynamic>),
      timestampMs: json['timestampMs'] as String,
      transactions: (json['transactions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      checkpointCommitments: json['checkpointCommitments'] as List<dynamic>,
      validatorSignature: json['validatorSignature'] as String,
    );

Map<String, dynamic> _$$_CheckpointToJson(_$_Checkpoint instance) =>
    <String, dynamic>{
      'epoch': instance.epoch,
      'sequenceNumber': instance.sequenceNumber,
      'digest': instance.digest,
      'networkTotalTransactions': instance.networkTotalTransactions,
      'previousDigest': instance.previousDigest,
      'epochRollingGasCostSummary': instance.epochRollingGasCostSummary,
      'timestampMs': instance.timestampMs,
      'transactions': instance.transactions,
      'checkpointCommitments': instance.checkpointCommitments,
      'validatorSignature': instance.validatorSignature,
    };

_$_EpochRollingGasCostSummary _$$_EpochRollingGasCostSummaryFromJson(
        Map<String, dynamic> json) =>
    _$_EpochRollingGasCostSummary(
      computationCost: json['computationCost'] as String,
      storageCost: json['storageCost'] as String,
      storageRebate: json['storageRebate'] as String,
      nonRefundableStorageFee: json['nonRefundableStorageFee'] as String,
    );

Map<String, dynamic> _$$_EpochRollingGasCostSummaryToJson(
        _$_EpochRollingGasCostSummary instance) =>
    <String, dynamic>{
      'computationCost': instance.computationCost,
      'storageCost': instance.storageCost,
      'storageRebate': instance.storageRebate,
      'nonRefundableStorageFee': instance.nonRefundableStorageFee,
    };
