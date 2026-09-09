import 'package:json_annotation/json_annotation.dart';

import '../../../Courses/data/models/courses_model.dart';
import '../../../Teachers/data/models/teacher_model.dart';

part 'home_data_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class HomeDataModel {
  final List<CourseModel>? popularCourses;
  final List<TeacherModel>? popularTeachers;

  HomeDataModel({
    this.popularCourses,
    this.popularTeachers,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataModelToJson(this);
}