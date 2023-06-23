import 'package:freezed_annotation/freezed_annotation.dart';

part 'errors.freezed.dart';
part 'errors.g.dart';

@freezed
class LocklyApiException with _$LocklyApiException {
  const factory LocklyApiException({
    @JsonKey(name: 'cod', fromJson: LocklyApiException._codeFromJson)
        required String code,
    @JsonKey(name: 'msg') String? message,
  }) = _LocklyApiException;

  factory LocklyApiException.fromJson(Map<String, dynamic> json) =>
      _$LocklyApiExceptionFromJson(json);

  static String _codeFromJson(Object code) => code.toString();
}
