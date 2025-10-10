import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable(ignoreUnannotated: true, genericArgumentFactories: true)
class BaseModel<T> {
  @JsonKey(name: 'success')
  final bool? success;

  @JsonKey(name: 'data')
  final T? data;

  @JsonKey(name: 'message')
  final String? message;

  BaseModel({this.success, this.data, this.message});

  factory BaseModel.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseModelFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) => _$BaseModelToJson(this, toJsonT);
}
