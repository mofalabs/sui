// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dev_inspect_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SuiExecutionResult _$$_SuiExecutionResultFromJson(
        Map<String, dynamic> json) =>
    _$_SuiExecutionResult(
      mutableReferenceOutputs: json['mutableReferenceOutputs'],
      returnValues: json['returnValues'],
    );

Map<String, dynamic> _$$_SuiExecutionResultToJson(
        _$_SuiExecutionResult instance) =>
    <String, dynamic>{
      'mutableReferenceOutputs': instance.mutableReferenceOutputs,
      'returnValues': instance.returnValues,
    };

_$_DevInspectResults _$$_DevInspectResultsFromJson(Map<String, dynamic> json) =>
    _$_DevInspectResults(
      effects: TransactionEffects.fromJson(json['effects']),
      events: (json['events'] as List<dynamic>)
          .map((e) => SuiEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      error: json['error'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => SuiExecutionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_DevInspectResultsToJson(
        _$_DevInspectResults instance) =>
    <String, dynamic>{
      'effects': instance.effects,
      'events': instance.events,
      'error': instance.error,
      'results': instance.results,
    };
