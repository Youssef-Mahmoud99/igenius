// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
  id: (json['id'] as num).toInt(),
  phone: json['phone'] as String,
  grade: json['grade'] as String,
  school: json['school'] as String,
  country: json['country'] as String,
  city: json['city'] as String,
);

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'grade': instance.grade,
      'school': instance.school,
      'country': instance.country,
      'city': instance.city,
    };
