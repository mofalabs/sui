// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validators_apys.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ValidatorsApys _$ValidatorsApysFromJson(Map<String, dynamic> json) {
  return _ValidatorsApys.fromJson(json);
}

/// @nodoc
mixin _$ValidatorsApys {
  List<ValidatorApy> get apys => throw _privateConstructorUsedError;
  String get epoch => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_ValidatorsApys implements _ValidatorsApys {
  const _$_ValidatorsApys(
      {required final List<ValidatorApy> apys, required this.epoch})
      : _apys = apys;

  factory _$_ValidatorsApys.fromJson(Map<String, dynamic> json) =>
      _$$_ValidatorsApysFromJson(json);

  final List<ValidatorApy> _apys;
  @override
  List<ValidatorApy> get apys {
    if (_apys is EqualUnmodifiableListView) return _apys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_apys);
  }

  @override
  final String epoch;

  @override
  String toString() {
    return 'ValidatorsApys(apys: $apys, epoch: $epoch)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ValidatorsApysToJson(
      this,
    );
  }
}

abstract class _ValidatorsApys implements ValidatorsApys {
  const factory _ValidatorsApys(
      {required final List<ValidatorApy> apys,
      required final String epoch}) = _$_ValidatorsApys;

  factory _ValidatorsApys.fromJson(Map<String, dynamic> json) =
      _$_ValidatorsApys.fromJson;

  @override
  List<ValidatorApy> get apys;
  @override
  String get epoch;
}

ValidatorApy _$ValidatorApyFromJson(Map<String, dynamic> json) {
  return _ValidatorApy.fromJson(json);
}

/// @nodoc
mixin _$ValidatorApy {
  String get address => throw _privateConstructorUsedError;
  double get apy => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_ValidatorApy implements _ValidatorApy {
  const _$_ValidatorApy({required this.address, required this.apy});

  factory _$_ValidatorApy.fromJson(Map<String, dynamic> json) =>
      _$$_ValidatorApyFromJson(json);

  @override
  final String address;
  @override
  final double apy;

  @override
  String toString() {
    return 'ValidatorApy(address: $address, apy: $apy)';
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$_ValidatorApyToJson(
      this,
    );
  }
}

abstract class _ValidatorApy implements ValidatorApy {
  const factory _ValidatorApy(
      {required final String address,
      required final double apy}) = _$_ValidatorApy;

  factory _ValidatorApy.fromJson(Map<String, dynamic> json) =
      _$_ValidatorApy.fromJson;

  @override
  String get address;
  @override
  double get apy;
}
