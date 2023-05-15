// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sui_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SuiEvent _$SuiEventFromJson(Map<String, dynamic> json) {
  return _SuiEvent.fromJson(json);
}

/// @nodoc
mixin _$SuiEvent {
  EventId get id => throw _privateConstructorUsedError;
  String get packageId => throw _privateConstructorUsedError;
  String get transactionModule => throw _privateConstructorUsedError;
  String get sender => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic>? get parsedJson => throw _privateConstructorUsedError;
  String? get bcs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_SuiEvent implements _SuiEvent {
  const _$_SuiEvent(
      {required this.id,
      required this.packageId,
      required this.transactionModule,
      required this.sender,
      required this.type,
      required final Map<String, dynamic>? parsedJson,
      required this.bcs})
      : _parsedJson = parsedJson;

  factory _$_SuiEvent.fromJson(Map<String, dynamic> json) =>
      _$$_SuiEventFromJson(json);

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
  String toString() {
    return 'SuiEvent(id: $id, packageId: $packageId, transactionModule: $transactionModule, sender: $sender, type: $type, parsedJson: $parsedJson, bcs: $bcs)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_SuiEventToJson(
      this,
    );
  }
}

abstract class _SuiEvent implements SuiEvent {
  const factory _SuiEvent(
      {required final EventId id,
      required final String packageId,
      required final String transactionModule,
      required final String sender,
      required final String type,
      required final Map<String, dynamic>? parsedJson,
      required final String? bcs}) = _$_SuiEvent;

  factory _SuiEvent.fromJson(Map<String, dynamic> json) = _$_SuiEvent.fromJson;

  @override
  EventId get id;
  @override
  String get packageId;
  @override
  String get transactionModule;
  @override
  String get sender;
  @override
  String get type;
  @override
  Map<String, dynamic>? get parsedJson;
  @override
  String? get bcs;
}

EventId _$EventIdFromJson(Map<String, dynamic> json) {
  return _EventId.fromJson(json);
}

/// @nodoc
mixin _$EventId {
  String get txDigest => throw _privateConstructorUsedError;
  String get eventSeq => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_EventId implements _EventId {
  const _$_EventId({required this.txDigest, required this.eventSeq});

  factory _$_EventId.fromJson(Map<String, dynamic> json) =>
      _$$_EventIdFromJson(json);

  @override
  final String txDigest;
  @override
  final String eventSeq;

  @override
  String toString() {
    return 'EventId(txDigest: $txDigest, eventSeq: $eventSeq)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventIdToJson(
      this,
    );
  }
}

abstract class _EventId implements EventId {
  const factory _EventId(
      {required final String txDigest,
      required final String eventSeq}) = _$_EventId;

  factory _EventId.fromJson(Map<String, dynamic> json) = _$_EventId.fromJson;

  @override
  String get txDigest;
  @override
  String get eventSeq;
}
