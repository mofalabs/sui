
import 'package:freezed_annotation/freezed_annotation.dart';

part 'loaded_child_objects.freezed.dart';
part 'loaded_child_objects.g.dart';

@freezed
class LoadedChildObjects with _$LoadedChildObjects{
  const factory LoadedChildObjects({
    required List<ChildObject> loadedChildObjects
  }) = _LoadedChildObjects;

  factory LoadedChildObjects.fromJson(Map<String, dynamic> json) => _$LoadedChildObjectsFromJson(json);
}

@freezed
class ChildObject with _$ChildObject{
  const factory ChildObject({
    required String objectId,
    required String sequenceNumber
  }) = _ChildObject;

  factory ChildObject.fromJson(Map<String, dynamic> json) => _$ChildObjectFromJson(json);
}