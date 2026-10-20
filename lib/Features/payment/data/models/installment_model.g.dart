// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'installment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InstallmentRequestModel _$InstallmentRequestModelFromJson(
  Map<String, dynamic> json,
) => InstallmentRequestModel(
  id: (json['id'] as num?)?.toInt(),
  status: json['status'] as String?,
  requiredMonths: (json['required_months'] as num?)?.toInt(),
  rejectionReason: json['rejection_reason'] as String?,
  requestedAt: json['requested_at'] as String?,
  reviewedAt: json['reviewed_at'] as String?,
  course:
      json['course'] == null
          ? null
          : CourseModel.fromJson(json['course'] as Map<String, dynamic>),
  installments:
      (json['installments'] as List<dynamic>?)
          ?.map(
            (e) => InstallmentDetailsModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
);

Map<String, dynamic> _$InstallmentRequestModelToJson(
  InstallmentRequestModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'required_months': instance.requiredMonths,
  'rejection_reason': instance.rejectionReason,
  'requested_at': instance.requestedAt,
  'reviewed_at': instance.reviewedAt,
  'course': instance.course?.toJson(),
  'installments': instance.installments?.map((e) => e.toJson()).toList(),
};

InstallmentDetailsModel _$InstallmentDetailsModelFromJson(
  Map<String, dynamic> json,
) => InstallmentDetailsModel(
  id: (json['id'] as num?)?.toInt(),
  dueDate: json['due_date'] as String?,
  amount: json['amount'] as num?,
  isPaid: json['is_paid'] as bool?,
  paidAt: json['paid_at'] as String?,
  forgivenessDays: (json['forgiveness_days'] as num?)?.toInt(),
  isOverdue: json['is_overdue'] as bool?,
);

Map<String, dynamic> _$InstallmentDetailsModelToJson(
  InstallmentDetailsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'due_date': instance.dueDate,
  'amount': instance.amount,
  'is_paid': instance.isPaid,
  'paid_at': instance.paidAt,
  'forgiveness_days': instance.forgivenessDays,
  'is_overdue': instance.isOverdue,
};
