import 'package:freezed_annotation/freezed_annotation.dart';

part 'sui_event.freezed.dart';
part 'sui_event.g.dart';

@freezed
class SuiEvent with _$SuiEvent{
  const factory SuiEvent({
    required EventId id,
    required String packageId,
    required String transactionModule,
    required String sender,
    required String type,
    required Map<String, dynamic>? parsedJson,
    required String? bcs
  }) = _SuiEvent;

  factory SuiEvent.fromJson(Map<String, dynamic> json) => _$SuiEventFromJson(json);
}

@freezed
class EventId with _$EventId{
  const factory EventId({
    required String txDigest,
    required String eventSeq,
  }) = _EventId;

  factory EventId.fromJson(Map<String, dynamic> json) => _$EventIdFromJson(json);
}