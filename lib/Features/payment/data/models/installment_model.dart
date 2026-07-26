import 'package:json_annotation/json_annotation.dart';

import '../../../Courses/data/models/courses_model.dart';

part 'installment_model.g.dart';

@JsonSerializable( explicitToJson: true)
class InstallmentRequestModel {
  final int? id;
  final String? status;

  @JsonKey(name: 'required_months')
  final int? requiredMonths;

  @JsonKey(name: 'rejection_reason')
  final String? rejectionReason;

  @JsonKey(name: 'requested_at')
  final String? requestedAt;

  @JsonKey(name: 'reviewed_at')
  final String? reviewedAt;

  final CourseModel? course;

  final List<dynamic>? installments;

  const InstallmentRequestModel({
    this.id,
    this.status,
    this.requiredMonths,
    this.rejectionReason,
    this.requestedAt,
    this.reviewedAt,
    this.course,
    this.installments,
  });

  factory InstallmentRequestModel.fromJson(Map<String, dynamic> json) =>
      _$InstallmentRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InstallmentRequestModelToJson(this);
}