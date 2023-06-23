import 'package:freezed_annotation/freezed_annotation.dart';

part 'lockly_api_request_body.freezed.dart';
part 'lockly_api_request_body.g.dart';

abstract class LocklyApiRequestBody<T extends Object> {
  String? get country;

  String? get deviceId;

  String? get locale;

  String get os;

  T get parameters;

  String? get fcmToken;

  String? get miPushToken;

  String? get token;

  String get versionCode;

  String get versionName;
}

enum LocklyApiRequestEncryption {
  unknown,
  anonymous,
  user,
}

@freezed
class DecryptedLocklyApiRequestBody
    with _$DecryptedLocklyApiRequestBody
    implements LocklyApiRequestBody<Map<String, dynamic>> {
  const factory DecryptedLocklyApiRequestBody({
    @Default(LocklyApiRequestEncryption.unknown)
        LocklyApiRequestEncryption encryption,
    String? country,
    String? deviceId,
    String? locale,
    required String os,
    required Map<String, dynamic> parameters,
    String? fcmToken,
    String? miPushToken,
    String? token,
    required String versionCode,
    required String versionName,
  }) = _DecryptedLocklyApiRequestBody;
}

@freezed
class EncryptedLocklyApiRequestBody
    with _$EncryptedLocklyApiRequestBody
    implements LocklyApiRequestBody<String> {
  const factory EncryptedLocklyApiRequestBody({
    @JsonKey(ignore: true)
    @Default(LocklyApiRequestEncryption.unknown)
        LocklyApiRequestEncryption encryption,
    @JsonKey(name: 'ctry', fromJson: EncryptedLocklyApiRequestBody._optionalFieldFromJson, toJson: EncryptedLocklyApiRequestBody._optionalFieldToJson)
        String? country,
    @JsonKey(name: 'dvid', fromJson: EncryptedLocklyApiRequestBody._optionalFieldFromJson, toJson: EncryptedLocklyApiRequestBody._optionalFieldToJson)
        String? deviceId,
    @JsonKey(name: 'locale', fromJson: EncryptedLocklyApiRequestBody._optionalFieldFromJson, toJson: EncryptedLocklyApiRequestBody._optionalFieldToJson)
        String? locale,
    @JsonKey(name: 'os') required String os,
    @JsonKey(name: 'para') required String parameters,
    @JsonKey(name: 'rid1', fromJson: EncryptedLocklyApiRequestBody._optionalFieldFromJson, toJson: EncryptedLocklyApiRequestBody._optionalFieldToJson)
        String? fcmToken,
    @JsonKey(name: 'rid2', fromJson: EncryptedLocklyApiRequestBody._optionalFieldFromJson, toJson: EncryptedLocklyApiRequestBody._optionalFieldToJson)
        String? miPushToken,
    @JsonKey(name: 'tk', fromJson: EncryptedLocklyApiRequestBody._optionalFieldFromJson, toJson: EncryptedLocklyApiRequestBody._optionalFieldToJson)
        String? token,
    @JsonKey(name: 'ver') required String versionCode,
    @JsonKey(name: 'versionName') required String versionName,
  }) = _EncryptedLocklyApiRequestBody;

  factory EncryptedLocklyApiRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EncryptedLocklyApiRequestBodyFromJson(json);

  static String? _optionalFieldFromJson(String value) =>
      value.isEmpty ? null : value;

  static String _optionalFieldToJson(String? value) => value ?? '';
}
