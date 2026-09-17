import 'package:json_annotation/json_annotation.dart';

import '../../../../Courses/data/models/course_details.dart';

part 'overdue_model.g.dart';


@JsonSerializable(explicitToJson: true)
class OverdueModel {
  final List<ExamModel>? exams;
  final List<AssignmentModel>? assignments;

  const OverdueModel({
    this.exams,
    this.assignments,
  });

  factory OverdueModel.fromJson(Map<String, dynamic> json) =>
      _$OverdueModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverdueModelToJson(this);
}

