import 'package:freezed_annotation/freezed_annotation.dart';

part 'validators_apys.freezed.dart';
part 'validators_apys.g.dart';

@freezed
abstract class ValidatorsApys with _$ValidatorsApys {
  const factory ValidatorsApys({
    required List<ValidatorApy> apys,
    required String epoch,
  }) = _ValidatorsApys;

  factory ValidatorsApys.fromJson(Map<String, dynamic> json) =>
      _$ValidatorsApysFromJson(json);
}

@freezed
abstract class ValidatorApy with _$ValidatorApy {
  const factory ValidatorApy({
    required String address,
    required double apy,
  }) = _ValidatorApy;

  factory ValidatorApy.fromJson(Map<String, dynamic> json) =>
      _$ValidatorApyFromJson(json);
}
