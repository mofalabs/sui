// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dev_inspect_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuiExecutionResult {
  dynamic get mutableReferenceOutputs;
  dynamic get returnValues;

  /// Serializes this SuiExecutionResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SuiExecutionResult(mutableReferenceOutputs: $mutableReferenceOutputs, returnValues: $returnValues)';
  }
}

/// @nodoc
@JsonSerializable()
class _SuiExecutionResult implements SuiExecutionResult {
  const _SuiExecutionResult({this.mutableReferenceOutputs, this.returnValues});
  factory _SuiExecutionResult.fromJson(Map<String, dynamic> json) =>
      _$SuiExecutionResultFromJson(json);

  @override
  final dynamic mutableReferenceOutputs;
  @override
  final dynamic returnValues;

  @override
  Map<String, dynamic> toJson() {
    return _$SuiExecutionResultToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SuiExecutionResult(mutableReferenceOutputs: $mutableReferenceOutputs, returnValues: $returnValues)';
  }
}

/// @nodoc
mixin _$DevInspectResults {
  TransactionEffects get effects;
  List<SuiEvent> get events;
  String? get error;
  List<SuiExecutionResult>? get results;

  /// Serializes this DevInspectResults to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'DevInspectResults(effects: $effects, events: $events, error: $error, results: $results)';
  }
}

/// @nodoc
@JsonSerializable()
class _DevInspectResults implements DevInspectResults {
  const _DevInspectResults(
      {required this.effects,
      required final List<SuiEvent> events,
      this.error,
      final List<SuiExecutionResult>? results})
      : _events = events,
        _results = results;
  factory _DevInspectResults.fromJson(Map<String, dynamic> json) =>
      _$DevInspectResultsFromJson(json);

  @override
  final TransactionEffects effects;
  final List<SuiEvent> _events;
  @override
  List<SuiEvent> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  final String? error;
  final List<SuiExecutionResult>? _results;
  @override
  List<SuiExecutionResult>? get results {
    final value = _results;
    if (value == null) return null;
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$DevInspectResultsToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'DevInspectResults(effects: $effects, events: $events, error: $error, results: $results)';
  }
}

// dart format on
