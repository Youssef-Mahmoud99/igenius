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
  durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
  order: (json['order'] as num?)?.toInt(),
  isPreview: json['is_preview'] as bool?,
  isBuyable: json['is_buyable'] as bool?,
  price: (json['price'] as num?)?.toInt(),
  viewDate: json['view_date'] as String?,
  deadlineDate: json['deadline_date'] as String?,
);

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'duration_minutes': instance.durationMinutes,
      'order': instance.order,
      'is_preview': instance.isPreview,
      'is_buyable': instance.isBuyable,
      'price': instance.price,
      'view_date': instance.viewDate,
      'deadline_date': instance.deadlineDate,
    };

ExamModel _$ExamModelFromJson(Map<String, dynamic> json) => ExamModel(
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  description: json['description'] as String?,
  durationMinutes: (json['duration_minutes'] as num?)?.toInt(),
  totalMarks: (json['total_marks'] as num?)?.toInt(),
  maxAttempts: (json['max_attempts'] as num?)?.toInt(),
  order: (json['order'] as num?)?.toInt(),
  viewDate: json['view_date'] as String?,
  dueDate: json['due_date'] as String?,
  deadlineDate: json['deadline_date'] as String?,
);

Map<String, dynamic> _$ExamModelToJson(ExamModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'duration_minutes': instance.durationMinutes,
  'total_marks': instance.totalMarks,
  'max_attempts': instance.maxAttempts,
  'order': instance.order,
  'view_date': instance.viewDate,
  'due_date': instance.dueDate,
  'deadline_date': instance.deadlineDate,
};

AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) =>
    AssignmentModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      totalMarks: (json['total_marks'] as num?)?.toInt(),
      maxAttempts: (json['max_attempts'] as num?)?.toInt(),
      order: (json['order'] as num?)?.toInt(),
      viewDate: json['view_date'] as String?,
      dueDate: json['due_date'] as String?,
      deadlineDate: json['deadline_date'] as String?,
    );

Map<String, dynamic> _$AssignmentModelToJson(AssignmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'total_marks': instance.totalMarks,
      'max_attempts': instance.maxAttempts,
      'order': instance.order,
      'view_date': instance.viewDate,
      'due_date': instance.dueDate,
      'deadline_date': instance.deadlineDate,
    };
