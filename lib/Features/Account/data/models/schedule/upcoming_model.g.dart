// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upcoming_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpcomingModel _$UpcomingModelFromJson(Map<String, dynamic> json) =>
    UpcomingModel(
      lessons:
          (json['lessons'] as List<dynamic>?)
              ?.map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      exams:
          (json['exams'] as List<dynamic>?)
              ?.map((e) => ExamModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      assignments:
          (json['assignments'] as List<dynamic>?)
              ?.map((e) => AssignmentModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$UpcomingModelToJson(UpcomingModel instance) =>
    <String, dynamic>{
      'lessons': instance.lessons?.map((e) => e.toJson()).toList(),
      'exams': instance.exams?.map((e) => e.toJson()).toList(),
      'assignments': instance.assignments?.map((e) => e.toJson()).toList(),
    };
