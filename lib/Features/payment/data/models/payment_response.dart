import 'package:json_annotation/json_annotation.dart';

part 'payment_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentResponseModel {
  final int? id;

  final int? amount;

  final String? currency;

  final String? method;

  @JsonKey(name: 'method_label')
  final String? methodLabel;

  final String? status;

  @JsonKey(name: 'status_label')
  final String? statusLabel;

  @JsonKey(name: 'is_final')
  final bool? isFinal;

  @JsonKey(name: 'payable_type')
  final String? payableType;

  final dynamic lesson;

  final dynamic installment;

  @JsonKey(name: 'reference_number')
  final String? referenceNumber;

  @JsonKey(name: 'paid_at')
  final String? paidAt;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'checkout_url')
  final String? checkoutUrl;

  const PaymentResponseModel({
    this.id,
    this.amount,
    this.currency,
    this.method,
    this.methodLabel,
    this.status,
    this.statusLabel,
    this.isFinal,
    this.payableType,
    this.lesson,
    this.installment,
    this.referenceNumber,
    this.paidAt,
    this.createdAt,
    this.checkoutUrl,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentResponseModelToJson(this);
}