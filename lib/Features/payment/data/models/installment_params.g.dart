// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstallmentParams _$InstallmentParamsFromJson(Map<String, dynamic> json) =>
    InstallmentParams(
      courseId: (json['course_id'] as num?)?.toInt(),
      requiredMonths: (json['required_months'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InstallmentParamsToJson(InstallmentParams instance) =>
    <String, dynamic>{
      'course_id': instance.courseId,
      'required_months': instance.requiredMonths,
    };
