// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynamic_field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DynamicFieldPage {
  List<DynamicFieldInfo> get data;
  String? get nextCursor;
  bool get hasNextPage;

  /// Serializes this DynamicFieldPage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'DynamicFieldPage(data: $data, nextCursor: $nextCursor, hasNextPage: $hasNextPage)';
  }
}

/// @nodoc
@JsonSerializable()
class _DynamicFieldPage implements DynamicFieldPage {
  const _DynamicFieldPage(
      {required final List<DynamicFieldInfo> data,
      this.nextCursor,
      required this.hasNextPage})
      : _data = data;
  factory _DynamicFieldPage.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldPageFromJson(json);

  final List<DynamicFieldInfo> _data;
  @override
  List<DynamicFieldInfo> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  final String? nextCursor;
  @override
  final bool hasNextPage;

  @override
  Map<String, dynamic> toJson() {
    return _$DynamicFieldPageToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'DynamicFieldPage(data: $data, nextCursor: $nextCursor, hasNextPage: $hasNextPage)';
  }
}

/// @nodoc
mixin _$DynamicFieldInfo {
  DynamicFieldName get name;
  String get bcsName;
  String get type;
  String get objectType;
  String get objectId;
  int get version;
  String get digest;

  /// Serializes this DynamicFieldInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'DynamicFieldInfo(name: $name, bcsName: $bcsName, type: $type, objectType: $objectType, objectId: $objectId, version: $version, digest: $digest)';
  }
}

/// @nodoc
@JsonSerializable()
class _DynamicFieldInfo implements DynamicFieldInfo {
  const _DynamicFieldInfo(
      {required this.name,
      required this.bcsName,
      required this.type,
      required this.objectType,
      required this.objectId,
      required this.version,
      required this.digest});
  factory _DynamicFieldInfo.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldInfoFromJson(json);

  @override
  final DynamicFieldName name;
  @override
  final String bcsName;
  @override
  final String type;
  @override
  final String objectType;
  @override
  final String objectId;
  @override
  final int version;
  @override
  final String digest;

  @override
  Map<String, dynamic> toJson() {
    return _$DynamicFieldInfoToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'DynamicFieldInfo(name: $name, bcsName: $bcsName, type: $type, objectType: $objectType, objectId: $objectId, version: $version, digest: $digest)';
  }
}

/// @nodoc
mixin _$DynamicFieldName {
  String get type;
  dynamic get value;

  /// Serializes this DynamicFieldName to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'DynamicFieldName(type: $type, value: $value)';
  }
}

/// @nodoc
@JsonSerializable()
class _DynamicFieldName implements DynamicFieldName {
  const _DynamicFieldName({required this.type, this.value});
  factory _DynamicFieldName.fromJson(Map<String, dynamic> json) =>
      _$DynamicFieldNameFromJson(json);

  @override
  final String type;
  @override
  final dynamic value;

  @override
  Map<String, dynamic> toJson() {
    return _$DynamicFieldNameToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'DynamicFieldName(type: $type, value: $value)';
  }
}

// dart format on
