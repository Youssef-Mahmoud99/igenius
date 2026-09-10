import 'package:json_annotation/json_annotation.dart';

part 'notifications_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final int? id;
  final String? title;
  final String? body;
  final String? status;

  @JsonKey(name: 'is_read')
  final bool? isReadFromApi;

  @JsonKey(name: 'read_at')
  final String? readAt;

  @JsonKey(name: 'lesson_id')
  final int? lessonId;

  @JsonKey(name: 'exam_id')
  final int? examId;

  @JsonKey(name: 'assignment_id')
  final int? assignmentId;

  @JsonKey(name: 'link_url')
  final String? linkUrl;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.status,
    this.isReadFromApi,
    this.readAt,
    this.lessonId,
    this.examId,
    this.assignmentId,
    this.linkUrl,
    this.createdAt,
  });

  bool get isRead => isReadFromApi ?? readAt != null;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

    NotificationModel copyWith({
    bool? isReadFromApi,
    String? title,
    String? body,
    String? status,
    bool? isRead,
    String? readAt,
    int? lessonId,
    int? examId,
    int? assignmentId,
    String? linkUrl,
    String? createdAt,
  }) {
    return NotificationModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      status: status ?? this.status,
      isReadFromApi: isReadFromApi ?? this.isReadFromApi,
      readAt: readAt ?? this.readAt,
      lessonId: lessonId ?? this.lessonId,
      examId: examId ?? this.examId,
      assignmentId: assignmentId ?? this.assignmentId,
      linkUrl: linkUrl ?? this.linkUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

@JsonSerializable()
class NotificationsMetaModel {
  @JsonKey(name: 'current_page')
  final int? currentPage;

  @JsonKey(name: 'last_page')
  final int? lastPage;

  @JsonKey(name: 'per_page')
  final int? perPage;

  final int? total;

  @JsonKey(name: 'unread_count')
  final int? unreadCount;

  NotificationsMetaModel({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.unreadCount,
  });

  factory NotificationsMetaModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationsMetaModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsMetaModelToJson(this);
}

