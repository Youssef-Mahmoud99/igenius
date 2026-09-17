import 'package:json_annotation/json_annotation.dart';

import '../../../../Courses/data/models/course_details.dart';

part 'upcoming_model.g.dart';


@JsonSerializable(explicitToJson: true)
class UpcomingModel {
  final List<LessonModel>? lessons;
  final List<ExamModel>? exams;
  final List<AssignmentModel>? assignments;

  const UpcomingModel({
    this.lessons,
    this.exams,
    this.assignments,
  });

  factory UpcomingModel.fromJson(Map<String, dynamic> json) =>
      _$UpcomingModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingModelToJson(this);
}

