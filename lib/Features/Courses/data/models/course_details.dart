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

  @JsonKey(name: 'is_owned')
  final bool? isOwned;


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
    this.isOwned,
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

@JsonSerializable(genericArgumentFactories: true)
class LessonModel {
  final int? id;
  final String? title;
  final String? description;

  @JsonKey(name: 'video_url')
  final String? videoUrl;

  @JsonKey(name: 'external_link')
  final String? externalLink;

  final String? materials;

  @JsonKey(name: 'duration_minutes')
  final int? durationMinutes;

  final int? order;

  @JsonKey(name: 'is_preview')
  final bool? isPreview;

  @JsonKey(name: 'is_buyable')
  final bool? isBuyable;

  final int? price;

  @JsonKey(name: 'is_live')
  final bool? isLive;

  @JsonKey(name: 'meeting_url')
  final String? meetingUrl;

  @JsonKey(name: 'meeting_date')
  final String? meetingDate;

  @JsonKey(name: 'view_date')
  final String? viewDate;

  @JsonKey(name: 'deadline_date')
  final String? deadlineDate;

  final List<FileModel>? files;

  final dynamic attendance;

  const LessonModel({
    this.id,
    this.title,
    this.description,
    this.videoUrl,
    this.externalLink,
    this.materials,
    this.durationMinutes,
    this.order,
    this.isPreview,
    this.isBuyable,
    this.price,
    this.isLive,
    this.meetingUrl,
    this.meetingDate,
    this.viewDate,
    this.deadlineDate,
    this.files,
    this.attendance,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);
}



@JsonSerializable(genericArgumentFactories: true)
class AssignmentModel {
  final int? id;
  final String? title;
  final String? description;

  @JsonKey(name: 'total_marks')
  final int? totalMarks;

  @JsonKey(name: 'max_attempts')
  final int? maxAttempts;

  @JsonKey(name: 'attempts_used')
  final int? attemptsUsed;

  @JsonKey(name: 'can_submit')
  final bool? canSubmit;

  final int? order;

  @JsonKey(name: 'view_date')
  final String? viewDate;

  @JsonKey(name: 'due_date')
  final String? dueDate;

  @JsonKey(name: 'deadline_date')
  final String? deadlineDate;

  final List<FileModel>? files;

  const AssignmentModel({
    this.id,
    this.title,
    this.description,
    this.totalMarks,
    this.maxAttempts,
    this.attemptsUsed,
    this.canSubmit,
    this.order,
    this.viewDate,
    this.dueDate,
    this.deadlineDate,
    this.files,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssignmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AssignmentModelToJson(this);
}


@JsonSerializable(genericArgumentFactories: true)
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

  @JsonKey(name: 'attempts_used')
  final int? attemptsUsed;

  @JsonKey(name: 'can_submit')
  final bool? canSubmit;

  final int? order;

  @JsonKey(name: 'view_date')
  final String? viewDate;

  @JsonKey(name: 'due_date')
  final String? dueDate;

  @JsonKey(name: 'deadline_date')
  final String? deadlineDate;

  @JsonKey(name: 'file_url')
  final String? fileUrl;

  @JsonKey(name: 'file_name')
  final String? fileName;

  @JsonKey(name: 'file_size')
  final int? fileSize;

  const ExamModel({
    this.id,
    this.title,
    this.description,
    this.durationMinutes,
    this.totalMarks,
    this.maxAttempts,
    this.attemptsUsed,
    this.canSubmit,
    this.order,
    this.viewDate,
    this.dueDate,
    this.deadlineDate,
    this.fileUrl,
    this.fileName,
    this.fileSize,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamModelToJson(this);
}



@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class FileModel {
  final int? id;
  final String? name;
  final String? url;
  final String? size;

  const FileModel({
    this.id,
    this.name,
     this.url,
     this.size,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}