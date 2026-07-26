// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetails _$CourseDetailsFromJson(Map<String, dynamic> json) =>
    CourseDetails(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toInt(),
      priceAfterDiscount: (json['price_after_discount'] as num?)?.toInt(),
      effectivePrice: (json['effective_price'] as num?)?.toInt(),
      hasDiscount: json['has_discount'] as bool?,
      hasInstallmentPlan: json['has_installment_plan'] as bool?,
      durationWeeks: (json['duration_weeks'] as num?)?.toInt(),
      totalLessons: (json['total_lessons'] as num?)?.toInt(),
      isExternalCourse: json['is_external_course'] as bool?,
      coursePlatform: json['course_platform'],
      teacher:
          json['teacher'] == null
              ? null
              : Teacher.fromJson(json['teacher'] as Map<String, dynamic>),
      subject:
          json['subject'] == null
              ? null
              : Teacher.fromJson(json['subject'] as Map<String, dynamic>),
      level:
          json['level'] == null
              ? null
              : Teacher.fromJson(json['level'] as Map<String, dynamic>),
      board:
          json['board'] == null
              ? null
              : Teacher.fromJson(json['board'] as Map<String, dynamic>),
      system:
          json['system'] == null
              ? null
              : Teacher.fromJson(json['system'] as Map<String, dynamic>),
      units:
          (json['units'] as List<dynamic>?)
              ?.map((e) => UnitModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      isOwned: json['is_owned'] as bool?,
    );

Map<String, dynamic> _$CourseDetailsToJson(CourseDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'price_after_discount': instance.priceAfterDiscount,
      'effective_price': instance.effectivePrice,
      'has_discount': instance.hasDiscount,
      'has_installment_plan': instance.hasInstallmentPlan,
      'duration_weeks': instance.durationWeeks,
      'total_lessons': instance.totalLessons,
      'is_external_course': instance.isExternalCourse,
      'course_platform': instance.coursePlatform,
      'is_owned': instance.isOwned,
      'teacher': instance.teacher,
      'subject': instance.subject,
      'level': instance.level,
      'board': instance.board,
      'system': instance.system,
      'units': instance.units,
    };

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) => UnitModel(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  order: (json['order'] as num?)?.toInt(),
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

Map<String, dynamic> _$UnitModelToJson(UnitModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'order': instance.order,
  'lessons': instance.lessons,
  'exams': instance.exams,
  'assignments': instance.assignments,
};

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  videoUrl: json['video_url'] as String?,
  externalLink: json['external_link'] as String?,
  materials: json['materials'] as String?,
  durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
  order: (json['order'] as num?)?.toInt(),
  isPreview: json['is_preview'] as bool?,
  isBuyable: json['is_buyable'] as bool?,
  price: (json['price'] as num?)?.toInt(),
  isLive: json['is_live'] as bool?,
  meetingUrl: json['meeting_url'] as String?,
  meetingDate: json['meeting_date'] as String?,
  viewDate: json['view_date'] as String?,
  deadlineDate: json['deadline_date'] as String?,
  files:
      (json['files'] as List<dynamic>?)
          ?.map((e) => FileModel.fromJson(e as Map<String, dynamic>))
          .toList(),
  attendance: json['attendance'],
);

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'video_url': instance.videoUrl,
      'external_link': instance.externalLink,
      'materials': instance.materials,
      'duration_minutes': instance.durationMinutes,
      'order': instance.order,
      'is_preview': instance.isPreview,
      'is_buyable': instance.isBuyable,
      'price': instance.price,
      'is_live': instance.isLive,
      'meeting_url': instance.meetingUrl,
      'meeting_date': instance.meetingDate,
      'view_date': instance.viewDate,
      'deadline_date': instance.deadlineDate,
      'files': instance.files,
      'attendance': instance.attendance,
    };

AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) =>
    AssignmentModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      totalMarks: (json['total_marks'] as num?)?.toInt(),
      maxAttempts: (json['max_attempts'] as num?)?.toInt(),
      attemptsUsed: (json['attempts_used'] as num?)?.toInt(),
      canSubmit: json['can_submit'] as bool?,
      order: (json['order'] as num?)?.toInt(),
      viewDate: json['view_date'] as String?,
      dueDate: json['due_date'] as String?,
      deadlineDate: json['deadline_date'] as String?,
      files:
          (json['files'] as List<dynamic>?)
              ?.map((e) => FileModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$AssignmentModelToJson(AssignmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'total_marks': instance.totalMarks,
      'max_attempts': instance.maxAttempts,
      'attempts_used': instance.attemptsUsed,
      'can_submit': instance.canSubmit,
      'order': instance.order,
      'view_date': instance.viewDate,
      'due_date': instance.dueDate,
      'deadline_date': instance.deadlineDate,
      'files': instance.files,
    };

ExamModel _$ExamModelFromJson(Map<String, dynamic> json) => ExamModel(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
  totalMarks: (json['total_marks'] as num?)?.toInt(),
  maxAttempts: (json['max_attempts'] as num?)?.toInt(),
  attemptsUsed: (json['attempts_used'] as num?)?.toInt(),
  canSubmit: json['can_submit'] as bool?,
  order: (json['order'] as num?)?.toInt(),
  viewDate: json['view_date'] as String?,
  dueDate: json['due_date'] as String?,
  deadlineDate: json['deadline_date'] as String?,
  fileUrl: json['file_url'] as String?,
  fileName: json['file_name'] as String?,
  fileSize: (json['file_size'] as num?)?.toInt(),
);

Map<String, dynamic> _$ExamModelToJson(ExamModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'duration_minutes': instance.durationMinutes,
  'total_marks': instance.totalMarks,
  'max_attempts': instance.maxAttempts,
  'attempts_used': instance.attemptsUsed,
  'can_submit': instance.canSubmit,
  'order': instance.order,
  'view_date': instance.viewDate,
  'due_date': instance.dueDate,
  'deadline_date': instance.deadlineDate,
  'file_url': instance.fileUrl,
  'file_name': instance.fileName,
  'file_size': instance.fileSize,
};

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  url: json['url'] as String?,
  size: json['size'] as String?,
);

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'url': instance.url,
  'size': instance.size,
};
