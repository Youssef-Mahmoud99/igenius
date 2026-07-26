import 'package:json_annotation/json_annotation.dart';

part 'payment_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PaymentModel {
  final int? id;
  final int? amount;
  final String? currency;
  final String? method;

  @JsonKey(name: 'method_label')
  final String? methodLabel;

  final String? status;

  @JsonKey(name: 'status_label')
  final String? statusLabel;

  @JsonKey(name: 'payable_type')
  final String? payableType;

  @JsonKey(name: 'reference_number')
  final String? referenceNumber;

  @JsonKey(name: 'paid_at')
  final String? paidAt;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  const PaymentModel({
    this.id,
    this.amount,
    this.currency,
    this.method,
    this.methodLabel,
    this.status,
    this.statusLabel,
    this.payableType,
    this.referenceNumber,
    this.paidAt,
    this.createdAt,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);
}
