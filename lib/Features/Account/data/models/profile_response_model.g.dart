// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponseModel _$ProfileResponseModelFromJson(
  Map<String, dynamic> json,
) => ProfileResponseModel(
  id: (json['id'] as num).toInt(),
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  phone: json['phone'] as String,
  whatsapp: json['whatsapp'] as String,
  telegram: json['telegram'] as String?,
  parentEmail: json['parent_email'] as String,
  parentPhone: json['parent_phone'] as String,
  parentWhatsapp: json['parent_whatsapp'] as String,
  parentTelegram: json['parent_telegram'] as String?,
  grade: (json['grade'] as num).toInt(),
  school: json['school'] as String,
  country: json['country'] as String,
  city: json['city'] as String,
  birthDate: json['birth_date'] as String,
);

Map<String, dynamic> _$ProfileResponseModelToJson(
  ProfileResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user.toJson(),
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
