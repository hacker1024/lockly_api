// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'errors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocklyApiException _$$_LocklyApiExceptionFromJson(
        Map<String, dynamic> json) =>
    _$_LocklyApiException(
      code: LocklyApiException._codeFromJson(json['cod'] as Object),
      message: json['msg'] as String?,
    );

Map<String, dynamic> _$$_LocklyApiExceptionToJson(
        _$_LocklyApiException instance) =>
    <String, dynamic>{
      'cod': instance.code,
      'msg': instance.message,
    };
