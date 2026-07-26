import 'package:json_annotation/json_annotation.dart';

part 'buy_lesson_params.g.dart';
@JsonSerializable(explicitToJson: true)
class BuylessonParams {
  final String method;
  final int id;

    BuylessonParams({
      required this.method,
      required this.id,
  });

  factory BuylessonParams.fromJson(Map<String, dynamic> json) =>
      _$BuylessonParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BuylessonParamsToJson(this);
}
