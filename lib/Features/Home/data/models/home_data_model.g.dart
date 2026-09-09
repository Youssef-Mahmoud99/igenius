// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataModel _$HomeDataModelFromJson(Map<String, dynamic> json) =>
    HomeDataModel(
      popularCourses:
          (json['popular_courses'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      popularTeachers:
          (json['popular_teachers'] as List<dynamic>?)
              ?.map((e) => TeacherModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$HomeDataModelToJson(
  HomeDataModel instance,
) => <String, dynamic>{
  'popular_courses': instance.popularCourses?.map((e) => e.toJson()).toList(),
  'popular_teachers': instance.popularTeachers?.map((e) => e.toJson()).toList(),
};
