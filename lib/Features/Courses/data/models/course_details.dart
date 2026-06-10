import 'package:json_annotation/json_annotation.dart';
import 'teacher.dart';

part 'course_details.g.dart';

@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class CourseDetails {
  final int? id;
  final String? title;
  final String? description;
  final String? image;
  final int? price;

  @JsonKey(name: 'price_after_discount')
  final int? priceAfterDiscount;

  @JsonKey(name: 'effective_price')
  final int? effectivePrice;

  @JsonKey(name: 'has_discount')
  final bool? hasDiscount;

  @JsonKey(name: 'has_installment_plan')
  final bool? hasInstallmentPlan;

  @JsonKey(name: 'duration_weeks')
  final int? durationWeeks;

  @JsonKey(name: 'total_lessons')
  final int? totalLessons;

  @JsonKey(name: 'is_external_course')
  final bool? isExternalCourse;

  @JsonKey(name: 'course_platform')
  final dynamic coursePlatform;

  final Teacher? teacher;
  final Teacher? subject;
  final Teacher? level;
  final Teacher? board;
  final Teacher? system;
  final List<UnitModel>? units;

  const CourseDetails({
    this.id,
    this.title,
    this.description,
    this.image,
    this.price,
    this.priceAfterDiscount,
    this.effectivePrice,
    this.hasDiscount,
    this.hasInstallmentPlan,
    this.durationWeeks,
    this.totalLessons,
    this.isExternalCourse,
    this.coursePlatform,
    this.teacher,
    this.subject,
    this.level,
    this.board,
    this.system,
    this.units,
  });

  factory CourseDetails.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailsToJson(this);
}


@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class UnitModel {
  final int? id;
  final String? title;
  final String? description;
  final int? order;

  final List<LessonModel>? lessons;
  final List<ExamModel>? exams;
  final List<AssignmentModel>? assignments;

  const UnitModel({
    this.id,
    this.title,
    this.description,
    this.order,
    this.lessons,
    this.exams,
    this.assignments,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);

  Map<String, dynamic> toJson() => _$UnitModelToJson(this);
}

@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class LessonModel {
  final int? id;
  final String? title;
  final String? description;

  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;

  final int? order;

  @JsonKey(name: 'is_preview')
  final bool? isPreview;

  @JsonKey(name: 'is_buyable')
  final bool? isBuyable;

  final int? price;

  @JsonKey(name: 'view_date')
  final String? viewDate;

  @JsonKey(name: 'deadline_date')
  final String? deadlineDate;

  const LessonModel({
    this.id,
    this.title,
    this.description,
    this.durationMinutes,
    this.order,
    this.isPreview,
    this.isBuyable,
    this.price,
    this.viewDate,
    this.deadlineDate,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}

@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class ExamModel {
  final int? id;
  final String? title;
  final String? description;

  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;

  @JsonKey(name: 'total_marks')
  final int? totalMarks;

  @JsonKey(name: 'max_attempts')
  final int? maxAttempts;

  final int? order;

  @JsonKey(name: 'view_date')
  final String? viewDate;

  @JsonKey(name: 'due_date')
  final String? dueDate;

  @JsonKey(name: 'deadline_date')
  final String? deadlineDate;

  const ExamModel({
    this.id,
    this.title,
    this.description,
    this.durationMinutes,
    this.totalMarks,
    this.maxAttempts,
    this.order,
    this.viewDate,
    this.dueDate,
    this.deadlineDate,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamModelToJson(this);
}


@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class AssignmentModel {
  final int? id;
  final String? title;
  final String? description;

  @JsonKey(name: 'total_marks')
  final int? totalMarks;

  @JsonKey(name: 'max_attempts')
  final int? maxAttempts;

  final int? order;

  @JsonKey(name: 'view_date')
  final String? viewDate;

  @JsonKey(name: 'due_date')
  final String? dueDate;

  @JsonKey(name: 'deadline_date')
  final String? deadlineDate;

  const AssignmentModel({
    this.id,
    this.title,
    this.description,
    this.totalMarks,
    this.maxAttempts,
    this.order,
    this.viewDate,
    this.dueDate,
    this.deadlineDate,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentModelToJson(this);
}