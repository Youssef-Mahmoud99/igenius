import 'package:json_annotation/json_annotation.dart';

import '../../../Courses/data/models/course_details.dart';

 part 'my_course_details_model.g.dart';
@JsonSerializable( explicitToJson: true)
class MyCourseDetails {
  @JsonKey(name: 'enrollment_id')
  final int? enrollmentId;

  @JsonKey(name: 'enrolled_at')
  final String? enrolledAt;

  @JsonKey(name: 'progress_percentage')
  final int? progressPercentage;

  @JsonKey(name: 'is_completed')
  final bool? isCompleted;

  @JsonKey(name: 'completed_at')
  final String? completedAt;

  @JsonKey(name: 'payment_status')
  final String? paymentStatus;

  final CourseDetails? course;

  const MyCourseDetails({
    this.enrollmentId,
    this.enrolledAt,
    this.progressPercentage,
    this.isCompleted,
    this.completedAt,
    this.paymentStatus,
    this.course,
  });

  factory MyCourseDetails.fromJson(Map<String, dynamic> json) =>
      _$MyCourseDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MyCourseDetailsToJson(this);
}