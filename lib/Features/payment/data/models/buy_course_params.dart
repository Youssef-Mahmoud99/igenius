import 'package:json_annotation/json_annotation.dart';

part 'buy_course_params.g.dart';
@JsonSerializable(explicitToJson: true)
class BuyCourseParams {
  final String method;
  final int id;

    BuyCourseParams({
      required this.method,
      required this.id,

  });

  factory BuyCourseParams.fromJson(Map<String, dynamic> json) =>
      _$BuyCourseParamsFromJson(json);

  Map<String, dynamic> toJson() => _$BuyCourseParamsToJson(this);
}
