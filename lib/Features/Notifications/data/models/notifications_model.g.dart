// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
      status: json['status'] as String?,
      isReadFromApi: json['is_read'] as bool?,
      readAt: json['read_at'] as String?,
      lessonId: (json['lesson_id'] as num?)?.toInt(),
      examId: (json['exam_id'] as num?)?.toInt(),
      assignmentId: (json['assignment_id'] as num?)?.toInt(),
      linkUrl: json['link_url'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'status': instance.status,
      'is_read': instance.isReadFromApi,
      'read_at': instance.readAt,
      'lesson_id': instance.lessonId,
      'exam_id': instance.examId,
      'assignment_id': instance.assignmentId,
      'link_url': instance.linkUrl,
      'created_at': instance.createdAt,
    };

NotificationsMetaModel _$NotificationsMetaModelFromJson(
  Map<String, dynamic> json,
) => NotificationsMetaModel(
  currentPage: (json['current_page'] as num?)?.toInt(),
  lastPage: (json['last_page'] as num?)?.toInt(),
  perPage: (json['per_page'] as num?)?.toInt(),
  total: (json['total'] as num?)?.toInt(),
  unreadCount: (json['unread_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$NotificationsMetaModelToJson(
  NotificationsMetaModel instance,
) => <String, dynamic>{
  'current_page': instance.currentPage,
  'last_page': instance.lastPage,
  'per_page': instance.perPage,
  'total': instance.total,
  'unread_count': instance.unreadCount,
};
