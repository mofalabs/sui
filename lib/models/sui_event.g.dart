// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sui_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SuiEvent _$$_SuiEventFromJson(Map<String, dynamic> json) => _$_SuiEvent(
      id: EventId.fromJson(json['id'] as Map<String, dynamic>),
      packageId: json['packageId'] as String,
      transactionModule: json['transactionModule'] as String,
      sender: json['sender'] as String,
      type: json['type'] as String,
      parsedJson: json['parsedJson'] as Map<String, dynamic>?,
      bcs: json['bcs'] as String?,
    );

Map<String, dynamic> _$$_SuiEventToJson(_$_SuiEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'packageId': instance.packageId,
      'transactionModule': instance.transactionModule,
      'sender': instance.sender,
      'type': instance.type,
      'parsedJson': instance.parsedJson,
      'bcs': instance.bcs,
    };

_$_EventId _$$_EventIdFromJson(Map<String, dynamic> json) => _$_EventId(
      txDigest: json['txDigest'] as String,
      eventSeq: json['eventSeq'] as String,
    );

Map<String, dynamic> _$$_EventIdToJson(_$_EventId instance) =>
    <String, dynamic>{
      'txDigest': instance.txDigest,
      'eventSeq': instance.eventSeq,
    };
