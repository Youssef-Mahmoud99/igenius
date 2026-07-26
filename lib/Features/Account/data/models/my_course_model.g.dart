// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCourseModel _$MyCourseModelFromJson(Map<String, dynamic> json) =>
    MyCourseModel(
      enrollmentId: (json['enrollment_id'] as num?)?.toInt(),
      enrolledAt: json['enrolled_at'] as String?,
      progressPercentage: (json['progress_percentage'] as num?)?.toInt(),
      isCompleted: json['is_completed'] as bool?,
      completedAt: json['completed_at'] as String?,
      paymentStatus: json['payment_status'] as String?,
      course:
          json['course'] == null
              ? null
              : CourseModel.fromJson(json['course'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MyCourseModelToJson(MyCourseModel instance) =>
    <String, dynamic>{
      'enrollment_id': instance.enrollmentId,
      'enrolled_at': instance.enrolledAt,
      'progress_percentage': instance.progressPercentage,
      'is_completed': instance.isCompleted,
      'completed_at': instance.completedAt,
      'payment_status': instance.paymentStatus,
      'course': instance.course?.toJson(),
    };
