// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentResponseModel _$PaymentResponseModelFromJson(
  Map<String, dynamic> json,
) => PaymentResponseModel(
  id: (json['id'] as num?)?.toInt(),
  amount: (json['amount'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  method: json['method'] as String?,
  methodLabel: json['method_label'] as String?,
  status: json['status'] as String?,
  statusLabel: json['status_label'] as String?,
  isFinal: json['is_final'] as bool?,
  payableType: json['payable_type'] as String?,
  lesson: json['lesson'],
  installment: json['installment'],
  referenceNumber: json['reference_number'] as String?,
  paidAt: json['paid_at'] as String?,
  createdAt: json['created_at'] as String?,
  checkoutUrl: json['checkout_url'] as String?,
);

Map<String, dynamic> _$PaymentResponseModelToJson(
  PaymentResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'amount': instance.amount,
  'currency': instance.currency,
  'method': instance.method,
  'method_label': instance.methodLabel,
  'status': instance.status,
  'status_label': instance.statusLabel,
  'is_final': instance.isFinal,
  'payable_type': instance.payableType,
  'lesson': instance.lesson,
  'installment': instance.installment,
  'reference_number': instance.referenceNumber,
  'paid_at': instance.paidAt,
  'created_at': instance.createdAt,
  'checkout_url': instance.checkoutUrl,
};
