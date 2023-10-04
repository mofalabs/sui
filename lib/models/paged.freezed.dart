// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paged.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Paged<T> _$PagedFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _Paged<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$Paged<T> {
  T get data => throw _privateConstructorUsedError;
  dynamic get nextCursor =>
      throw _privateConstructorUsedError; // NextCursor or String
  bool get hasNextPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$_Paged<T> implements _Paged<T> {
  const _$_Paged(
      {required this.data, this.nextCursor, required this.hasNextPage});

  factory _$_Paged.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$_PagedFromJson(json, fromJsonT);

  @override
  final T data;
  @override
  final dynamic nextCursor;
// NextCursor or String
  @override
  final bool hasNextPage;

  @override
  String toString() {
    return 'Paged<$T>(data: $data, nextCursor: $nextCursor, hasNextPage: $hasNextPage)';
  }

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$_PagedToJson<T>(this, toJsonT);
  }
}

abstract class _Paged<T> implements Paged<T> {
  const factory _Paged(
      {required final T data,
      final dynamic nextCursor,
      required final bool hasNextPage}) = _$_Paged<T>;

  factory _Paged.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$_Paged<T>.fromJson;

  @override
  T get data;
  @override
  dynamic get nextCursor;
  @override // NextCursor or String
  bool get hasNextPage;
}

NextCursor _$NextCursorFromJson(Map<String, dynamic> json) {
  return _NextCursor.fromJson(json);
}

/// @nodoc
mixin _$NextCursor {
  String get txDigest => throw _privateConstructorUsedError;
  String get eventSeq => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_NextCursor implements _NextCursor {
  const _$_NextCursor({required this.txDigest, required this.eventSeq});

  factory _$_NextCursor.fromJson(Map<String, dynamic> json) =>
      _$$_NextCursorFromJson(json);

  @override
  final String txDigest;
  @override
  final String eventSeq;

  @override
  String toString() {
    return 'NextCursor(txDigest: $txDigest, eventSeq: $eventSeq)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_NextCursorToJson(
      this,
    );
  }
}

abstract class _NextCursor implements NextCursor {
  const factory _NextCursor(
      {required final String txDigest,
      required final String eventSeq}) = _$_NextCursor;

  factory _NextCursor.fromJson(Map<String, dynamic> json) =
      _$_NextCursor.fromJson;

  @override
  String get txDigest;
  @override
  String get eventSeq;
}
