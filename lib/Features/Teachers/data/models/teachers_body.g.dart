// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teachers_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeachersBody _$TeachersBodyFromJson(Map<String, dynamic> json) => TeachersBody(
  page: (json['page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
  search: json['search'] as String?,
  subjectId: (json['subject_id'] as num?)?.toInt(),
  sort: json['sort'] as String?,
);

Map<String, dynamic> _$TeachersBodyToJson(TeachersBody instance) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.perPage,
      if (instance.search case final value?) 'search': value,
      if (instance.subjectId case final value?) 'subject_id': value,
      if (instance.sort case final value?) 'sort': value,
    };
