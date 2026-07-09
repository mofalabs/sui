// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validators_apys.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ValidatorsApys _$ValidatorsApysFromJson(Map<String, dynamic> json) =>
    _ValidatorsApys(
      apys: (json['apys'] as List<dynamic>)
          .map((e) => ValidatorApy.fromJson(e as Map<String, dynamic>))
          .toList(),
      epoch: json['epoch'] as String,
    );

Map<String, dynamic> _$ValidatorsApysToJson(_ValidatorsApys instance) =>
    <String, dynamic>{
      'apys': instance.apys,
      'epoch': instance.epoch,
    };

_ValidatorApy _$ValidatorApyFromJson(Map<String, dynamic> json) =>
    _ValidatorApy(
      address: json['address'] as String,
      apy: (json['apy'] as num).toDouble(),
    );

Map<String, dynamic> _$ValidatorApyToJson(_ValidatorApy instance) =>
    <String, dynamic>{
      'address': instance.address,
      'apy': instance.apy,
    };
