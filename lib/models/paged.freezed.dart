// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paged.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Paged<T> {
  T get data;
  dynamic get nextCursor; // NextCursor or String
  bool get hasNextPage;

  /// Serializes this Paged to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);

  @override
  String toString() {
    return 'Paged<$T>(data: $data, nextCursor: $nextCursor, hasNextPage: $hasNextPage)';
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _Paged<T> implements Paged<T> {
  const _Paged(
      {required this.data, this.nextCursor, required this.hasNextPage});
  factory _Paged.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$PagedFromJson(json, fromJsonT);

  @override
  final T data;
  @override
  final dynamic nextCursor;
// NextCursor or String
  @override
  final bool hasNextPage;

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$PagedToJson<T>(this, toJsonT);
  }

  @override
  String toString() {
    return 'Paged<$T>(data: $data, nextCursor: $nextCursor, hasNextPage: $hasNextPage)';
  }
}

/// @nodoc
mixin _$NextCursor {
  String get txDigest;
  String get eventSeq;

  /// Serializes this NextCursor to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'NextCursor(txDigest: $txDigest, eventSeq: $eventSeq)';
  }
}

/// @nodoc
@JsonSerializable()
class _NextCursor implements NextCursor {
  const _NextCursor({required this.txDigest, required this.eventSeq});
  factory _NextCursor.fromJson(Map<String, dynamic> json) =>
      _$NextCursorFromJson(json);

  @override
  final String txDigest;
  @override
  final String eventSeq;

  @override
  Map<String, dynamic> toJson() {
    return _$NextCursorToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'NextCursor(txDigest: $txDigest, eventSeq: $eventSeq)';
  }
}

// dart format on
