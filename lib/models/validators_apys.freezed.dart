// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'validators_apys.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ValidatorsApys {
  List<ValidatorApy> get apys;
  String get epoch;

  /// Serializes this ValidatorsApys to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'ValidatorsApys(apys: $apys, epoch: $epoch)';
  }
}

/// @nodoc
@JsonSerializable()
class _ValidatorsApys implements ValidatorsApys {
  const _ValidatorsApys(
      {required final List<ValidatorApy> apys, required this.epoch})
      : _apys = apys;
  factory _ValidatorsApys.fromJson(Map<String, dynamic> json) =>
      _$ValidatorsApysFromJson(json);

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
  Map<String, dynamic> toJson() {
    return _$ValidatorsApysToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'ValidatorsApys(apys: $apys, epoch: $epoch)';
  }
}

/// @nodoc
mixin _$ValidatorApy {
  String get address;
  double get apy;

  /// Serializes this ValidatorApy to a JSON map.
  Map<String, dynamic> toJson();

  @override
  String toString() {
    return 'ValidatorApy(address: $address, apy: $apy)';
  }
}

/// @nodoc
@JsonSerializable()
class _ValidatorApy implements ValidatorApy {
  const _ValidatorApy({required this.address, required this.apy});
  factory _ValidatorApy.fromJson(Map<String, dynamic> json) =>
      _$ValidatorApyFromJson(json);

  @override
  final String address;
  @override
  final double apy;

  @override
  Map<String, dynamic> toJson() {
    return _$ValidatorApyToJson(
      this,
    );
  }

  @override
  String toString() {
    return 'ValidatorApy(address: $address, apy: $apy)';
  }
}

// dart format on
