// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DynamicFieldPage _$$_DynamicFieldPageFromJson(Map<String, dynamic> json) =>
    _$_DynamicFieldPage(
      data: (json['data'] as List<dynamic>)
          .map((e) => DynamicFieldInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextCursor: json['nextCursor'] as String?,
      hasNextPage: json['hasNextPage'] as bool,
    );

Map<String, dynamic> _$$_DynamicFieldPageToJson(_$_DynamicFieldPage instance) =>
    <String, dynamic>{
      'data': instance.data,
      'nextCursor': instance.nextCursor,
      'hasNextPage': instance.hasNextPage,
    };

_$_DynamicFieldInfo _$$_DynamicFieldInfoFromJson(Map<String, dynamic> json) =>
    _$_DynamicFieldInfo(
      name: DynamicFieldName.fromJson(json['name'] as Map<String, dynamic>),
      bcsName: json['bcsName'] as String,
      type: json['type'] as String,
      objectType: json['objectType'] as String,
      objectId: json['objectId'] as String,
      version: json['version'] as int,
      digest: json['digest'] as String,
    );

Map<String, dynamic> _$$_DynamicFieldInfoToJson(_$_DynamicFieldInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'bcsName': instance.bcsName,
      'type': instance.type,
      'objectType': instance.objectType,
      'objectId': instance.objectId,
      'version': instance.version,
      'digest': instance.digest,
    };

_$_DynamicFieldName _$$_DynamicFieldNameFromJson(Map<String, dynamic> json) =>
    _$_DynamicFieldName(
      type: json['type'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$$_DynamicFieldNameToJson(_$_DynamicFieldName instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
    };
