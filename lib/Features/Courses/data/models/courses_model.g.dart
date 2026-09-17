// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
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
  isOwned: json['is_owned'] as bool?,
  isHasLessonBought: json['is_has_lesson_bought'] as bool?,
  isPrivate: json['is_private'] as bool?,
  maxStudents: (json['max_students'] as num?)?.toInt(),
  enrollmentsCount: (json['enrollments_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
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
      'is_owned': instance.isOwned,
      'teacher': instance.teacher,
      'subject': instance.subject,
      'level': instance.level,
      'board': instance.board,
      'system': instance.system,
      'is_has_lesson_bought': instance.isHasLessonBought,
      'is_private': instance.isPrivate,
      'max_students': instance.maxStudents,
      'enrollments_count': instance.enrollmentsCount,
    };
