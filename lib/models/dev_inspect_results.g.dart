// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_inspect_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SuiExecutionResult _$SuiExecutionResultFromJson(Map<String, dynamic> json) =>
    _SuiExecutionResult(
      mutableReferenceOutputs: json['mutableReferenceOutputs'],
      returnValues: json['returnValues'],
    );

Map<String, dynamic> _$SuiExecutionResultToJson(_SuiExecutionResult instance) =>
    <String, dynamic>{
      'mutableReferenceOutputs': instance.mutableReferenceOutputs,
      'returnValues': instance.returnValues,
    };

_DevInspectResults _$DevInspectResultsFromJson(Map<String, dynamic> json) =>
    _DevInspectResults(
      effects: TransactionEffects.fromJson(json['effects']),
      events: (json['events'] as List<dynamic>)
          .map((e) => SuiEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => SuiExecutionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DevInspectResultsToJson(_DevInspectResults instance) =>
    <String, dynamic>{
      'effects': instance.effects,
      'events': instance.events,
      'error': instance.error,
      'results': instance.results,
    };
