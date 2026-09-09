import 'package:json_annotation/json_annotation.dart';

part 'teacher_model.g.dart';

@JsonSerializable(explicitToJson: true)
class TeacherModel {
  final int? id;
  final String? name;
  final String? description;
  final String? school;
  final String? image;

  @JsonKey(name: 'average_rating')
  final num? averageRating;

  @JsonKey(name: 'rated_students_count')
  final int? ratedStudentsCount;

  @JsonKey(name: 'courses_count')
  final int? coursesCount;

  TeacherModel({
    this.id,
    this.name,
    this.description,
    this.school,
    this.image,
    this.averageRating,
    this.ratedStudentsCount,
    this.coursesCount,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);
}