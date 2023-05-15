// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loaded_child_objects.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoadedChildObjects _$LoadedChildObjectsFromJson(Map<String, dynamic> json) {
  return _LoadedChildObjects.fromJson(json);
}

/// @nodoc
mixin _$LoadedChildObjects {
  List<ChildObject> get loadedChildObjects =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_LoadedChildObjects implements _LoadedChildObjects {
  const _$_LoadedChildObjects(
      {required final List<ChildObject> loadedChildObjects})
      : _loadedChildObjects = loadedChildObjects;

  factory _$_LoadedChildObjects.fromJson(Map<String, dynamic> json) =>
      _$$_LoadedChildObjectsFromJson(json);

  final List<ChildObject> _loadedChildObjects;
  @override
  List<ChildObject> get loadedChildObjects {
    if (_loadedChildObjects is EqualUnmodifiableListView)
      return _loadedChildObjects;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loadedChildObjects);
  }

  @override
  String toString() {
    return 'LoadedChildObjects(loadedChildObjects: $loadedChildObjects)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_LoadedChildObjectsToJson(
      this,
    );
  }
}

abstract class _LoadedChildObjects implements LoadedChildObjects {
  const factory _LoadedChildObjects(
          {required final List<ChildObject> loadedChildObjects}) =
      _$_LoadedChildObjects;

  factory _LoadedChildObjects.fromJson(Map<String, dynamic> json) =
      _$_LoadedChildObjects.fromJson;

  @override
  List<ChildObject> get loadedChildObjects;
}

ChildObject _$ChildObjectFromJson(Map<String, dynamic> json) {
  return _ChildObject.fromJson(json);
}

/// @nodoc
mixin _$ChildObject {
  String get objectId => throw _privateConstructorUsedError;
  String get sequenceNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_ChildObject implements _ChildObject {
  const _$_ChildObject({required this.objectId, required this.sequenceNumber});

  factory _$_ChildObject.fromJson(Map<String, dynamic> json) =>
      _$$_ChildObjectFromJson(json);

  @override
  final String objectId;
  @override
  final String sequenceNumber;

  @override
  String toString() {
    return 'ChildObject(objectId: $objectId, sequenceNumber: $sequenceNumber)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChildObjectToJson(
      this,
    );
  }
}

abstract class _ChildObject implements ChildObject {
  const factory _ChildObject(
      {required final String objectId,
      required final String sequenceNumber}) = _$_ChildObject;

  factory _ChildObject.fromJson(Map<String, dynamic> json) =
      _$_ChildObject.fromJson;

  @override
  String get objectId;
  @override
  String get sequenceNumber;
}
