// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'validators_apys.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ValidatorsApys _$$_ValidatorsApysFromJson(Map<String, dynamic> json) =>
    _$_ValidatorsApys(
      apys: (json['apys'] as List<dynamic>)
          .map((e) => ValidatorApy.fromJson(e as Map<String, dynamic>))
          .toList(),
      epoch: json['epoch'] as String,
    );

Map<String, dynamic> _$$_ValidatorsApysToJson(_$_ValidatorsApys instance) =>
    <String, dynamic>{
      'apys': instance.apys,
      'epoch': instance.epoch,
    };

_$_ValidatorApy _$$_ValidatorApyFromJson(Map<String, dynamic> json) =>
    _$_ValidatorApy(
      address: json['address'] as String,
      apy: (json['apy'] as num).toDouble(),
    );

Map<String, dynamic> _$$_ValidatorApyToJson(_$_ValidatorApy instance) =>
    <String, dynamic>{
      'address': instance.address,
      'apy': instance.apy,
    };
