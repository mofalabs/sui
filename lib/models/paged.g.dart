// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Paged<T> _$PagedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _Paged<T>(
      data: fromJsonT(json['data']),
      nextCursor: json['nextCursor'],
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$PagedToJson<T>(
  _Paged<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
      'nextCursor': instance.nextCursor,
      'hasNextPage': instance.hasNextPage,
    };

_NextCursor _$NextCursorFromJson(Map<String, dynamic> json) => _NextCursor(
      txDigest: json['txDigest'] as String,
      eventSeq: json['eventSeq'] as String,
    );

Map<String, dynamic> _$NextCursorToJson(_NextCursor instance) =>
    <String, dynamic>{
      'txDigest': instance.txDigest,
      'eventSeq': instance.eventSeq,
    };
