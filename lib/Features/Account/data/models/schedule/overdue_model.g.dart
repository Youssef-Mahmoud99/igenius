// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overdue_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverdueModel _$OverdueModelFromJson(Map<String, dynamic> json) => OverdueModel(
  exams:
      (json['exams'] as List<dynamic>?)
          ?.map((e) => ExamModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  assignments:
      (json['assignments'] as List<dynamic>?)
          ?.map((e) => AssignmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$OverdueModelToJson(OverdueModel instance) =>
    <String, dynamic>{
      'exams': instance.exams?.map((e) => e.toJson()).toList(),
      'assignments': instance.assignments?.map((e) => e.toJson()).toList(),
    };
