// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dev_inspect_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SuiExecutionResult _$SuiExecutionResultFromJson(Map<String, dynamic> json) {
  return _SuiExecutionResult.fromJson(json);
}

/// @nodoc
mixin _$SuiExecutionResult {
  dynamic get mutableReferenceOutputs => throw _privateConstructorUsedError;
  dynamic get returnValues => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_SuiExecutionResult implements _SuiExecutionResult {
  const _$_SuiExecutionResult(
      {this.mutableReferenceOutputs, this.returnValues});

  factory _$_SuiExecutionResult.fromJson(Map<String, dynamic> json) =>
      _$$_SuiExecutionResultFromJson(json);

  @override
  final dynamic mutableReferenceOutputs;
  @override
  final dynamic returnValues;

  @override
  String toString() {
    return 'SuiExecutionResult(mutableReferenceOutputs: $mutableReferenceOutputs, returnValues: $returnValues)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_SuiExecutionResultToJson(
      this,
    );
  }
}

abstract class _SuiExecutionResult implements SuiExecutionResult {
  const factory _SuiExecutionResult(
      {final dynamic mutableReferenceOutputs,
      final dynamic returnValues}) = _$_SuiExecutionResult;

  factory _SuiExecutionResult.fromJson(Map<String, dynamic> json) =
      _$_SuiExecutionResult.fromJson;

  @override
  dynamic get mutableReferenceOutputs;
  @override
  dynamic get returnValues;
}

DevInspectResults _$DevInspectResultsFromJson(Map<String, dynamic> json) {
  return _DevInspectResults.fromJson(json);
}

/// @nodoc
mixin _$DevInspectResults {
  TransactionEffects get effects => throw _privateConstructorUsedError;
  List<SuiEvent> get events => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  List<SuiExecutionResult>? get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_DevInspectResults implements _DevInspectResults {
  const _$_DevInspectResults(
      {required this.effects,
      required final List<SuiEvent> events,
      this.error,
      final List<SuiExecutionResult>? results})
      : _events = events,
        _results = results;

  factory _$_DevInspectResults.fromJson(Map<String, dynamic> json) =>
      _$$_DevInspectResultsFromJson(json);

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
  String toString() {
    return 'DevInspectResults(effects: $effects, events: $events, error: $error, results: $results)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DevInspectResultsToJson(
      this,
    );
  }
}

abstract class _DevInspectResults implements DevInspectResults {
  const factory _DevInspectResults(
      {required final TransactionEffects effects,
      required final List<SuiEvent> events,
      final String? error,
      final List<SuiExecutionResult>? results}) = _$_DevInspectResults;

  factory _DevInspectResults.fromJson(Map<String, dynamic> json) =
      _$_DevInspectResults.fromJson;

  @override
  TransactionEffects get effects;
  @override
  List<SuiEvent> get events;
  @override
  String? get error;
  @override
  List<SuiExecutionResult>? get results;
}
