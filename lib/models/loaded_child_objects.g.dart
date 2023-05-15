// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loaded_child_objects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoadedChildObjects _$$_LoadedChildObjectsFromJson(
        Map<String, dynamic> json) =>
    _$_LoadedChildObjects(
      loadedChildObjects: (json['loadedChildObjects'] as List<dynamic>)
          .map((e) => ChildObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_LoadedChildObjectsToJson(
        _$_LoadedChildObjects instance) =>
    <String, dynamic>{
      'loadedChildObjects': instance.loadedChildObjects,
    };

_$_ChildObject _$$_ChildObjectFromJson(Map<String, dynamic> json) =>
    _$_ChildObject(
      objectId: json['objectId'] as String,
      sequenceNumber: json['sequenceNumber'] as String,
    );

Map<String, dynamic> _$$_ChildObjectToJson(_$_ChildObject instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'sequenceNumber': instance.sequenceNumber,
    };
