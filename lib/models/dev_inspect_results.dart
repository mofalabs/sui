
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sui/models/sui_event.dart';
import 'package:sui/types/transactions.dart';

part 'dev_inspect_results.freezed.dart';
part 'dev_inspect_results.g.dart';

@freezed
class SuiExecutionResult with _$SuiExecutionResult{
  const factory SuiExecutionResult({
    dynamic mutableReferenceOutputs,
    dynamic returnValues
  }) = _SuiExecutionResult;

  factory SuiExecutionResult.fromJson(Map<String, dynamic> json) => _$SuiExecutionResultFromJson(json);
}

@freezed
class DevInspectResults with _$DevInspectResults{
  const factory DevInspectResults({
    required TransactionEffects effects,
    required List<SuiEvent> events,
    String? error,
    List<SuiExecutionResult>? results
  }) = _DevInspectResults;

  factory DevInspectResults.fromJson(Map<String, dynamic> json) => _$DevInspectResultsFromJson(json);
}