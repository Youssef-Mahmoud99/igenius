// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_installment_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayInstallmentParams _$PayInstallmentParamsFromJson(
  Map<String, dynamic> json,
) => PayInstallmentParams(
  method: json['method'] as String,
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$PayInstallmentParamsToJson(
  PayInstallmentParams instance,
) => <String, dynamic>{'method': instance.method, 'id': instance.id};
