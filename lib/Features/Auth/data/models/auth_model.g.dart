// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
  name: json['name'] as String?,
  email: json['email'] as String?,
  password: json['password'] as String?,
  passwordConfirmation: json['password_confirmation'] as String?,
  phone: json['phone'] as String?,
  whatsapp: json['whatsapp'] as String?,
  telegram: json['telegram'] as String?,
  parentEmail: json['parent_email'] as String?,
  parentPhone: json['parent_phone'] as String?,
  parentWhatsapp: json['parent_whatsapp'] as String?,
  parentTelegram: json['parent_telegram'] as String?,
  grade: json['grade'] as String?,
  school: json['school'] as String?,
  country: json['country'] as String?,
  city: json['city'] as String?,
  birthDate: json['birth_date'] as String?,
);

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
  'password_confirmation': instance.passwordConfirmation,
  'phone': instance.phone,
  'whatsapp': instance.whatsapp,
  'telegram': instance.telegram,
  'parent_email': instance.parentEmail,
  'parent_phone': instance.parentPhone,
  'parent_whatsapp': instance.parentWhatsapp,
  'parent_telegram': instance.parentTelegram,
  'grade': instance.grade,
  'school': instance.school,
  'country': instance.country,
  'city': instance.city,
  'birth_date': instance.birthDate,
};
