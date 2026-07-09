// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DynamicFieldPage _$DynamicFieldPageFromJson(Map<String, dynamic> json) =>
    _DynamicFieldPage(
      data: (json['data'] as List<dynamic>)
          .map((e) => DynamicFieldInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'] as String?,
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$DynamicFieldPageToJson(_DynamicFieldPage instance) =>
    <String, dynamic>{
      'data': instance.data,
      'nextCursor': instance.nextCursor,
      'hasNextPage': instance.hasNextPage,
    };

_DynamicFieldInfo _$DynamicFieldInfoFromJson(Map<String, dynamic> json) =>
    _DynamicFieldInfo(
      name: DynamicFieldName.fromJson(json['name'] as Map<String, dynamic>),
      bcsName: json['bcsName'] as String,
      type: json['type'] as String,
      objectType: json['objectType'] as String,
      objectId: json['objectId'] as String,
      version: (json['version'] as num).toInt(),
      digest: json['digest'] as String,
    );

Map<String, dynamic> _$DynamicFieldInfoToJson(_DynamicFieldInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'bcsName': instance.bcsName,
      'type': instance.type,
      'objectType': instance.objectType,
      'objectId': instance.objectId,
      'version': instance.version,
      'digest': instance.digest,
    };

_DynamicFieldName _$DynamicFieldNameFromJson(Map<String, dynamic> json) =>
    _DynamicFieldName(
      type: json['type'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$DynamicFieldNameToJson(_DynamicFieldName instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };
