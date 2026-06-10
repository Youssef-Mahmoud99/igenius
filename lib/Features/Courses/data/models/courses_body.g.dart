// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursesBody _$CoursesBodyFromJson(Map<String, dynamic> json) => CoursesBody(
  search: json['search'] as String?,
  systemId: (json['system_id'] as num?)?.toInt(),
  boardId: (json['board_id'] as num?)?.toInt(),
  levelId: (json['level_id'] as num?)?.toInt(),
  subjectId: (json['subject_id'] as num?)?.toInt(),
  teacherId: (json['teacher_id'] as num?)?.toInt(),
  hasInstallmentPlan: (json['has_installment_plan'] as num?)?.toInt(),
  perPage: (json['per_page'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
);

Map<String, dynamic> _$CoursesBodyToJson(CoursesBody instance) =>
    <String, dynamic>{
      'search': instance.search,
      'page': instance.page,
      'system_id': instance.systemId,
      'board_id': instance.boardId,
      'level_id': instance.levelId,
      'subject_id': instance.subjectId,
      'teacher_id': instance.teacherId,
      'has_installment_plan': instance.hasInstallmentPlan,
      'per_page': instance.perPage,
    };
