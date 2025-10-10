import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ErrorModel {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'message')
  final String? message;

  ErrorModel({this.success, this.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) => _$ErrorModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);
}
