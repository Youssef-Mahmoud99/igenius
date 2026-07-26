import 'package:json_annotation/json_annotation.dart';

part 'installment_params.g.dart';

@JsonSerializable(explicitToJson: true)
class InstallmentParams {
  @JsonKey(name: 'course_id')
  final int? courseId;
  @JsonKey(name: 'required_months')
  final int? requiredMonths;

   InstallmentParams({
    this.courseId,
    this.requiredMonths,
  });

  InstallmentParams copyWith({
    int? courseId,
    int? requiredMonths,
  })
  {
    return InstallmentParams(
      courseId: courseId ?? this.courseId,
      requiredMonths: requiredMonths ?? this.requiredMonths,
    );
  
  }

  factory InstallmentParams.fromJson(Map<String, dynamic> json) =>
      _$InstallmentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$InstallmentParamsToJson(this);
}