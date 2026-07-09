// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SuiEvent {
  EventId get id;
  String get packageId;
  String get transactionModule;
  String get sender;
  String get type;
  Map<String, dynamic>? get parsedJson;
  String? get bcs;

  /// Serializes this SuiEvent to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'SuiEvent(id: $id, packageId: $packageId, transactionModule: $transactionModule, sender: $sender, type: $type, parsedJson: $parsedJson, bcs: $bcs)';
  }
}

/// @nodoc
@JsonSerializable()
class _SuiEvent implements SuiEvent {
  const _SuiEvent(
      {required this.id,
      required this.packageId,
      required this.transactionModule,
      required this.sender,
      required this.type,
      required final Map<String, dynamic>? parsedJson,
      required this.bcs})
      : _parsedJson = parsedJson;
  factory _SuiEvent.fromJson(Map<String, dynamic> json) =>
      _$SuiEventFromJson(json);

  @override
  final EventId id;
  @override
  final String packageId;
  @override
  final String transactionModule;
  @override
  final String sender;
  @override
  final String type;
  final Map<String, dynamic>? _parsedJson;
  @override
  Map<String, dynamic>? get parsedJson {
    final value = _parsedJson;
    if (value == null) return null;
    if (_parsedJson is EqualUnmodifiableMapView) return _parsedJson;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? bcs;

  @override
  Map<String, dynamic> toJson() {
    return _$SuiEventToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'SuiEvent(id: $id, packageId: $packageId, transactionModule: $transactionModule, sender: $sender, type: $type, parsedJson: $parsedJson, bcs: $bcs)';
  }
}

/// @nodoc
mixin _$EventId {
  String get txDigest;
  String get eventSeq;

  /// Serializes this EventId to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'EventId(txDigest: $txDigest, eventSeq: $eventSeq)';
  }
}

/// @nodoc
@JsonSerializable()
class _EventId implements EventId {
  const _EventId({required this.txDigest, required this.eventSeq});
  factory _EventId.fromJson(Map<String, dynamic> json) =>
      _$EventIdFromJson(json);

  @override
  final String txDigest;
  @override
  final String eventSeq;

  @override
  Map<String, dynamic> toJson() {
    return _$EventIdToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'EventId(txDigest: $txDigest, eventSeq: $eventSeq)';
  }
}

// dart format on
