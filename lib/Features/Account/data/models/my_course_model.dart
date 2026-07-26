import 'package:igenius/Features/Courses/data/models/courses_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_course_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MyCourseModel {
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

  final CourseModel? course;

  const MyCourseModel({
    this.enrollmentId,
    this.enrolledAt,
    this.progressPercentage,
    this.isCompleted,
    this.completedAt,
    this.paymentStatus,
    this.course,
  });

  factory MyCourseModel.fromJson(Map<String, dynamic> json) =>
      _$MyCourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyCourseModelToJson(this);
}