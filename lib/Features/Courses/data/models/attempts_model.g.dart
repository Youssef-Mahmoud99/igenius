// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attempts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttemptsModel _$AttemptsModelFromJson(Map<String, dynamic> json) =>
    AttemptsModel(
      id: (json['id'] as num?)?.toInt(),
      attemptNumber: (json['attemptNumber'] as num?)?.toInt(),
      submittedAt: json['submitted_at'] as String?,
      status: json['status'] as String?,
      score: (json['score'] as num?)?.toInt(),
      totalMarks: (json['total_marks'] as num?)?.toInt(),
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => FileModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$AttemptsModelToJson(AttemptsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'attemptNumber': instance.attemptNumber,
      'submitted_at': instance.submittedAt,
      'status': instance.status,
      'score': instance.score,
      'total_marks': instance.totalMarks,
      'files': instance.files,
    };

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  fileUrl: json['file_url'] as String?,
  fileWithCommentsUrl: json['file_with_comments_url'] as String?,
);

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'file_url': instance.fileUrl,
  'file_with_comments_url': instance.fileWithCommentsUrl,
};
