// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
  id: (json['id'] as num?)?.toInt(),
  amount: (json['amount'] as num?)?.toInt(),
  currency: json['currency'] as String?,
  method: json['method'] as String?,
  methodLabel: json['method_label'] as String?,
  status: json['status'] as String?,
  statusLabel: json['status_label'] as String?,
  payableType: json['payable_type'] as String?,
  referenceNumber: json['reference_number'] as String?,
  paidAt: json['paid_at'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'currency': instance.currency,
      'method': instance.method,
      'method_label': instance.methodLabel,
      'status': instance.status,
      'status_label': instance.statusLabel,
      'payable_type': instance.payableType,
      'reference_number': instance.referenceNumber,
      'paid_at': instance.paidAt,
      'created_at': instance.createdAt,
    };
