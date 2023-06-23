// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'door_lock.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DoorLock _$$_DoorLockFromJson(Map<String, dynamic> json) => _$_DoorLock(
      propertyId: json['propertyId'] as int,
      roomId: json['roomId'] as int,
      id: json['ID'] as String,
      name: json['na'] as String,
      timezone: json['tz'] as String,
      hubver: json['hubver'] as String,
      model: json['mod'] as String,
      blename: json['blename'] as String,
      lockingMode: json['lockingMode'] as String,
      hubId: json['hubid'] as String,
      iotDMName: json['iotdm'] as String,
      iotDMSecret: json['iotsecret'] as String,
      iotDMProdKey: json['iotprodkey'] as String,
      iotHost: json['iothost'] as String,
    );

Map<String, dynamic> _$$_DoorLockToJson(_$_DoorLock instance) =>
    <String, dynamic>{
      'propertyId': instance.propertyId,
      'roomId': instance.roomId,
      'ID': instance.id,
      'na': instance.name,
      'tz': instance.timezone,
      'hubver': instance.hubver,
      'mod': instance.model,
      'blename': instance.blename,
      'lockingMode': instance.lockingMode,
      'hubid': instance.hubId,
      'iotdm': instance.iotDMName,
      'iotsecret': instance.iotDMSecret,
      'iotprodkey': instance.iotDMProdKey,
      'iothost': instance.iotHost,
    };
