// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeacherDetailsModel _$TeacherDetailsModelFromJson(
  Map<String, dynamic> json,
) => TeacherDetailsModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  school: json['school'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  whatsapp: json['whatsapp'] as String?,
  image: json['image'] as String?,
  averageRating: json['average_rating'] as num?,
  ratedStudentsCount: (json['rated_students_count'] as num?)?.toInt(),
  certificates: json['certificates'] as List<dynamic>?,
  weeklySchedule: json['weekly_schedule'] as List<dynamic>?,
  assistantsCount: (json['assistants_count'] as num?)?.toInt(),
  subjects:
      (json['subjects'] as List<dynamic>?)
          ?.map((e) => TeacherSubjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  levels:
      (json['levels'] as List<dynamic>?)
          ?.map((e) => TeacherLevelModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  boards:
      (json['boards'] as List<dynamic>?)
          ?.map((e) => TeacherBoardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  systems:
      (json['systems'] as List<dynamic>?)
          ?.map((e) => TeacherSystemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  courses:
      (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TeacherDetailsModelToJson(
  TeacherDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'school': instance.school,
  'email': instance.email,
  'phone': instance.phone,
  'whatsapp': instance.whatsapp,
  'image': instance.image,
  'average_rating': instance.averageRating,
  'rated_students_count': instance.ratedStudentsCount,
  'certificates': instance.certificates,
  'weekly_schedule': instance.weeklySchedule,
  'assistants_count': instance.assistantsCount,
  'subjects': instance.subjects?.map((e) => e.toJson()).toList(),
  'levels': instance.levels?.map((e) => e.toJson()).toList(),
  'boards': instance.boards?.map((e) => e.toJson()).toList(),
  'systems': instance.systems?.map((e) => e.toJson()).toList(),
  'courses': instance.courses?.map((e) => e.toJson()).toList(),
};

TeacherSubjectModel _$TeacherSubjectModelFromJson(Map<String, dynamic> json) =>
    TeacherSubjectModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TeacherSubjectModelToJson(
  TeacherSubjectModel instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

TeacherLevelModel _$TeacherLevelModelFromJson(Map<String, dynamic> json) =>
    TeacherLevelModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TeacherLevelModelToJson(TeacherLevelModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

TeacherBoardModel _$TeacherBoardModelFromJson(Map<String, dynamic> json) =>
    TeacherBoardModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TeacherBoardModelToJson(TeacherBoardModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

TeacherSystemModel _$TeacherSystemModelFromJson(Map<String, dynamic> json) =>
    TeacherSystemModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TeacherSystemModelToJson(TeacherSystemModel instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};
