import 'package:json_annotation/json_annotation.dart';

part 'filter_data_model.g.dart';

@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class FilterDataModel {
  @JsonKey(name: 'id')
  final int?  id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'code')
  final String? code;

  const FilterDataModel({
    this.id,
    this.name,
    this.code,
  });

  factory FilterDataModel.fromJson(Map<String, dynamic> json) =>
      _$FilterDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterDataModelToJson(this);

    FilterDataModel copyWith({
     int? id,
     String? name,
     String? code,
  }) {
    return FilterDataModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }
}