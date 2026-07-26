import 'package:json_annotation/json_annotation.dart';

part 'pay_installment_params.g.dart';
@JsonSerializable(explicitToJson: true)
class PayInstallmentParams {
  final String method;
  final int id;

    PayInstallmentParams({
      required this.method,
      required this.id,
  });

  factory PayInstallmentParams.fromJson(Map<String, dynamic> json) =>
      _$PayInstallmentParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PayInstallmentParamsToJson(this);
}
