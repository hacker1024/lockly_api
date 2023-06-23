// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'errors.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocklyApiException _$LocklyApiExceptionFromJson(Map<String, dynamic> json) {
  return _LocklyApiException.fromJson(json);
}

/// @nodoc
mixin _$LocklyApiException {
  @JsonKey(name: 'cod', fromJson: LocklyApiException._codeFromJson)
  String get code => throw _privateConstructorUsedError;
  @JsonKey(name: 'msg')
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocklyApiExceptionCopyWith<LocklyApiException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocklyApiExceptionCopyWith<$Res> {
  factory $LocklyApiExceptionCopyWith(
          LocklyApiException value, $Res Function(LocklyApiException) then) =
      _$LocklyApiExceptionCopyWithImpl<$Res, LocklyApiException>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cod', fromJson: LocklyApiException._codeFromJson)
          String code,
      @JsonKey(name: 'msg')
          String? message});
}

/// @nodoc
class _$LocklyApiExceptionCopyWithImpl<$Res, $Val extends LocklyApiException>
    implements $LocklyApiExceptionCopyWith<$Res> {
  _$LocklyApiExceptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocklyApiExceptionCopyWith<$Res>
    implements $LocklyApiExceptionCopyWith<$Res> {
  factory _$$_LocklyApiExceptionCopyWith(_$_LocklyApiException value,
          $Res Function(_$_LocklyApiException) then) =
      __$$_LocklyApiExceptionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cod', fromJson: LocklyApiException._codeFromJson)
          String code,
      @JsonKey(name: 'msg')
          String? message});
}

/// @nodoc
class __$$_LocklyApiExceptionCopyWithImpl<$Res>
    extends _$LocklyApiExceptionCopyWithImpl<$Res, _$_LocklyApiException>
    implements _$$_LocklyApiExceptionCopyWith<$Res> {
  __$$_LocklyApiExceptionCopyWithImpl(
      _$_LocklyApiException _value, $Res Function(_$_LocklyApiException) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = freezed,
  }) {
    return _then(_$_LocklyApiException(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocklyApiException implements _LocklyApiException {
  const _$_LocklyApiException(
      {@JsonKey(name: 'cod', fromJson: LocklyApiException._codeFromJson)
          required this.code,
      @JsonKey(name: 'msg')
          this.message});

  factory _$_LocklyApiException.fromJson(Map<String, dynamic> json) =>
      _$$_LocklyApiExceptionFromJson(json);

  @override
  @JsonKey(name: 'cod', fromJson: LocklyApiException._codeFromJson)
  final String code;
  @override
  @JsonKey(name: 'msg')
  final String? message;

  @override
  String toString() {
    return 'LocklyApiException(code: $code, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocklyApiException &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocklyApiExceptionCopyWith<_$_LocklyApiException> get copyWith =>
      __$$_LocklyApiExceptionCopyWithImpl<_$_LocklyApiException>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocklyApiExceptionToJson(
      this,
    );
  }
}

abstract class _LocklyApiException implements LocklyApiException {
  const factory _LocklyApiException(
      {@JsonKey(name: 'cod', fromJson: LocklyApiException._codeFromJson)
          required final String code,
      @JsonKey(name: 'msg')
          final String? message}) = _$_LocklyApiException;

  factory _LocklyApiException.fromJson(Map<String, dynamic> json) =
      _$_LocklyApiException.fromJson;

  @override
  @JsonKey(name: 'cod', fromJson: LocklyApiException._codeFromJson)
  String get code;
  @override
  @JsonKey(name: 'msg')
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_LocklyApiExceptionCopyWith<_$_LocklyApiException> get copyWith =>
      throw _privateConstructorUsedError;
}
