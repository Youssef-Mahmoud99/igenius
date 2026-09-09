import 'package:json_annotation/json_annotation.dart';

import '../../../Courses/data/models/courses_model.dart';

part 'teacher_details_model.g.dart';


@JsonSerializable(explicitToJson: true)
class TeacherDetailsModel {
  final int? id;
  final String? name;
  final String? description;
  final String? school;
  final String? email;
  final String? phone;
  final String? whatsapp;
  final String? image;

  @JsonKey(name: 'average_rating')
  final num? averageRating;

  @JsonKey(name: 'rated_students_count')
  final int? ratedStudentsCount;

  final List<dynamic>? certificates;

  @JsonKey(name: 'weekly_schedule')
  final List<dynamic>? weeklySchedule;

  @JsonKey(name: 'assistants_count')
  final int? assistantsCount;

  final List<TeacherSubjectModel>? subjects;
  final List<TeacherLevelModel>? levels;
  final List<TeacherBoardModel>? boards;
  final List<TeacherSystemModel>? systems;
  final List<CourseModel>? courses;

  TeacherDetailsModel({
    this.id,
    this.name,
    this.description,
    this.school,
    this.email,
    this.phone,
    this.whatsapp,
    this.image,
    this.averageRating,
    this.ratedStudentsCount,
    this.certificates,
    this.weeklySchedule,
    this.assistantsCount,
    this.subjects,
    this.levels,
    this.boards,
    this.systems,
    this.courses,
  });

  factory TeacherDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherDetailsModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TeacherDetailsModelToJson(this);
}

@JsonSerializable()
class TeacherSubjectModel {
  final int? id;
  final String? name;

  TeacherSubjectModel({
    this.id,
    this.name,
  });

  factory TeacherSubjectModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherSubjectModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TeacherSubjectModelToJson(this);
}

@JsonSerializable()
class TeacherLevelModel {
  final int? id;
  final String? name;

  TeacherLevelModel({
    this.id,
    this.name,
  });

  factory TeacherLevelModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherLevelModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TeacherLevelModelToJson(this);
}

@JsonSerializable()
class TeacherBoardModel {
  final int? id;
  final String? name;

  TeacherBoardModel({
    this.id,
    this.name,
  });

  factory TeacherBoardModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherBoardModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TeacherBoardModelToJson(this);
}

@JsonSerializable()
class TeacherSystemModel {
  final int? id;
  final String? name;

  TeacherSystemModel({
    this.id,
    this.name,
  });

  factory TeacherSystemModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherSystemModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$TeacherSystemModelToJson(this);
}

