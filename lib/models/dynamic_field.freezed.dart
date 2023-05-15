// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dynamic_field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DynamicFieldPage _$DynamicFieldPageFromJson(Map<String, dynamic> json) {
  return _DynamicFieldPage.fromJson(json);
}

/// @nodoc
mixin _$DynamicFieldPage {
  List<DynamicFieldInfo> get data => throw _privateConstructorUsedError;
  String? get nextCursor => throw _privateConstructorUsedError;
  bool get hasNextPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_DynamicFieldPage implements _DynamicFieldPage {
  const _$_DynamicFieldPage(
      {required final List<DynamicFieldInfo> data,
      this.nextCursor,
      required this.hasNextPage})
      : _data = data;

  factory _$_DynamicFieldPage.fromJson(Map<String, dynamic> json) =>
      _$$_DynamicFieldPageFromJson(json);

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
  String toString() {
    return 'DynamicFieldPage(data: $data, nextCursor: $nextCursor, hasNextPage: $hasNextPage)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DynamicFieldPageToJson(
      this,
    );
  }
}

abstract class _DynamicFieldPage implements DynamicFieldPage {
  const factory _DynamicFieldPage(
      {required final List<DynamicFieldInfo> data,
      final String? nextCursor,
      required final bool hasNextPage}) = _$_DynamicFieldPage;

  factory _DynamicFieldPage.fromJson(Map<String, dynamic> json) =
      _$_DynamicFieldPage.fromJson;

  @override
  List<DynamicFieldInfo> get data;
  @override
  String? get nextCursor;
  @override
  bool get hasNextPage;
}

DynamicFieldInfo _$DynamicFieldInfoFromJson(Map<String, dynamic> json) {
  return _DynamicFieldInfo.fromJson(json);
}

/// @nodoc
mixin _$DynamicFieldInfo {
  DynamicFieldName get name => throw _privateConstructorUsedError;
  String get bcsName => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get objectType => throw _privateConstructorUsedError;
  String get objectId => throw _privateConstructorUsedError;
  int get version => throw _privateConstructorUsedError;
  String get digest => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_DynamicFieldInfo implements _DynamicFieldInfo {
  const _$_DynamicFieldInfo(
      {required this.name,
      required this.bcsName,
      required this.type,
      required this.objectType,
      required this.objectId,
      required this.version,
      required this.digest});

  factory _$_DynamicFieldInfo.fromJson(Map<String, dynamic> json) =>
      _$$_DynamicFieldInfoFromJson(json);

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
  String toString() {
    return 'DynamicFieldInfo(name: $name, bcsName: $bcsName, type: $type, objectType: $objectType, objectId: $objectId, version: $version, digest: $digest)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DynamicFieldInfoToJson(
      this,
    );
  }
}

abstract class _DynamicFieldInfo implements DynamicFieldInfo {
  const factory _DynamicFieldInfo(
      {required final DynamicFieldName name,
      required final String bcsName,
      required final String type,
      required final String objectType,
      required final String objectId,
      required final int version,
      required final String digest}) = _$_DynamicFieldInfo;

  factory _DynamicFieldInfo.fromJson(Map<String, dynamic> json) =
      _$_DynamicFieldInfo.fromJson;

  @override
  DynamicFieldName get name;
  @override
  String get bcsName;
  @override
  String get type;
  @override
  String get objectType;
  @override
  String get objectId;
  @override
  int get version;
  @override
  String get digest;
}

DynamicFieldName _$DynamicFieldNameFromJson(Map<String, dynamic> json) {
  return _DynamicFieldName.fromJson(json);
}

/// @nodoc
mixin _$DynamicFieldName {
  String get type => throw _privateConstructorUsedError;
  dynamic get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
@JsonSerializable()
class _$_DynamicFieldName implements _DynamicFieldName {
  const _$_DynamicFieldName({required this.type, this.value});

  factory _$_DynamicFieldName.fromJson(Map<String, dynamic> json) =>
      _$$_DynamicFieldNameFromJson(json);

  @override
  final String type;
  @override
  final dynamic value;

  @override
  String toString() {
    return 'DynamicFieldName(type: $type, value: $value)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_DynamicFieldNameToJson(
      this,
    );
  }
}

abstract class _DynamicFieldName implements DynamicFieldName {
  const factory _DynamicFieldName(
      {required final String type, final dynamic value}) = _$_DynamicFieldName;

  factory _DynamicFieldName.fromJson(Map<String, dynamic> json) =
      _$_DynamicFieldName.fromJson;

  @override
  String get type;
  @override
  dynamic get value;
}
