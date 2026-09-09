// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) => TeacherModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  school: json['school'] as String?,
  image: json['image'] as String?,
  averageRating: json['average_rating'] as num?,
  ratedStudentsCount: (json['rated_students_count'] as num?)?.toInt(),
  coursesCount: (json['courses_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'school': instance.school,
      'image': instance.image,
      'average_rating': instance.averageRating,
      'rated_students_count': instance.ratedStudentsCount,
      'courses_count': instance.coursesCount,
    };
