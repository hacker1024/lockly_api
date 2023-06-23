// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'lockly_api_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EncryptedLocklyApiRequestBody _$$_EncryptedLocklyApiRequestBodyFromJson(
        Map<String, dynamic> json) =>
    _$_EncryptedLocklyApiRequestBody(
      country: EncryptedLocklyApiRequestBody._optionalFieldFromJson(
          json['ctry'] as String),
      deviceId: EncryptedLocklyApiRequestBody._optionalFieldFromJson(
          json['dvid'] as String),
      locale: EncryptedLocklyApiRequestBody._optionalFieldFromJson(
          json['locale'] as String),
      os: json['os'] as String,
      parameters: json['para'] as String,
      fcmToken: EncryptedLocklyApiRequestBody._optionalFieldFromJson(
          json['rid1'] as String),
      miPushToken: EncryptedLocklyApiRequestBody._optionalFieldFromJson(
          json['rid2'] as String),
      token: EncryptedLocklyApiRequestBody._optionalFieldFromJson(
          json['tk'] as String),
      versionCode: json['ver'] as String,
      versionName: json['versionName'] as String,
    );

Map<String, dynamic> _$$_EncryptedLocklyApiRequestBodyToJson(
        _$_EncryptedLocklyApiRequestBody instance) =>
    <String, dynamic>{
      'ctry':
          EncryptedLocklyApiRequestBody._optionalFieldToJson(instance.country),
      'dvid':
          EncryptedLocklyApiRequestBody._optionalFieldToJson(instance.deviceId),
      'locale':
          EncryptedLocklyApiRequestBody._optionalFieldToJson(instance.locale),
      'os': instance.os,
      'para': instance.parameters,
      'rid1':
          EncryptedLocklyApiRequestBody._optionalFieldToJson(instance.fcmToken),
      'rid2': EncryptedLocklyApiRequestBody._optionalFieldToJson(
          instance.miPushToken),
      'tk': EncryptedLocklyApiRequestBody._optionalFieldToJson(instance.token),
      'ver': instance.versionCode,
      'versionName': instance.versionName,
    };
