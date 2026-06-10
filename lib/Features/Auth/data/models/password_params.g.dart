// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordParams _$PasswordParamsFromJson(Map<String, dynamic> json) =>
    PasswordParams(
      email: json['email'] as String?,
      code: json['code'] as String?,
      password: json['password'] as String?,
      passwordConfirmation: json['password_confirmation'] as String?,
    );

Map<String, dynamic> _$PasswordParamsToJson(PasswordParams instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
    };
