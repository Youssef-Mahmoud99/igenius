import 'package:json_annotation/json_annotation.dart';

part 'courses_body.g.dart';

@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class CoursesBody {
  @JsonKey(name: 'search')
  final String? search;

  @JsonKey(name: 'page')
  final int? page;

  @JsonKey(name: 'system_id')
  final int? systemId;

  @JsonKey(name: 'board_id')
  final int? boardId;

  @JsonKey(name: 'level_id')
  final int? levelId;

  @JsonKey(name: 'subject_id')
  final int? subjectId;

  @JsonKey(name: 'teacher_id')
  final int? teacherId;

  @JsonKey(name: 'has_installment_plan')
  final int? hasInstallmentPlan;

  @JsonKey(name: 'max_students')
  final int? maxStudents;

  @JsonKey(name: 'per_page')
  final int? perPage;

  @JsonKey(name: 'is_private')
  final int? isPrivate;


  @JsonKey(name: 'sort')
  final String? sort;

  const CoursesBody({
    this.search,
    this.systemId,
    this.boardId,
    this.levelId,
    this.subjectId,
    this.teacherId,
    this.hasInstallmentPlan,
    this.perPage,
        this.page,
        this.maxStudents,
        this.isPrivate,
        this.sort,
  });

  factory CoursesBody.fromJson(Map<String, dynamic> json) =>
      _$CoursesBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CoursesBodyToJson(this);

  CoursesBody copyWith({
    String? search,
    int? systemId,
    int? boardId,
    int? levelId,
    int? subjectId,
    int? teacherId,
    int? hasInstallmentPlan,
    int? perPage,
    int? page,
    int? isPrivate,
    String? sort,
    int? maxStudents,
    
  }) {
    return CoursesBody(
      search: search ?? this.search,
      systemId: systemId ?? this.systemId,
      boardId: boardId ?? this.boardId,
      levelId: levelId ?? this.levelId,
      subjectId: subjectId ?? this.subjectId,
      teacherId: teacherId ?? this.teacherId,
      hasInstallmentPlan:
          hasInstallmentPlan ?? this.hasInstallmentPlan,
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      isPrivate: isPrivate ?? this.isPrivate,
      sort: sort ?? this.sort,
      maxStudents: maxStudents ?? this.maxStudents,
    );
  }
}