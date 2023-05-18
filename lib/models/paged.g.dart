// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Paged<T> _$$_PagedFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    _$_Paged<T>(
      data: fromJsonT(json['data']),
      nextCursor: json['nextCursor'],
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$$_PagedToJson<T>(
  _$_Paged<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': toJsonT(instance.data),
      'nextCursor': instance.nextCursor,
      'hasNextPage': instance.hasNextPage,
    };

_$_NextCursor _$$_NextCursorFromJson(Map<String, dynamic> json) =>
    _$_NextCursor(
      txDigest: json['txDigest'] as String,
      eventSeq: json['eventSeq'] as String,
    );

Map<String, dynamic> _$$_NextCursorToJson(_$_NextCursor instance) =>
    <String, dynamic>{
      'txDigest': instance.txDigest,
      'eventSeq': instance.eventSeq,
    };
