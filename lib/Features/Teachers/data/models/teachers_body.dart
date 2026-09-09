import 'package:json_annotation/json_annotation.dart';

part 'teachers_body.g.dart';

@JsonSerializable(includeIfNull: false)
class TeachersBody {
  final int page;

  @JsonKey(name: 'per_page')
  final int perPage;

  final String? search;
  @JsonKey(name: 'subject_id')
  final int? subjectId;

  final String? sort;

  TeachersBody({
    required this.page,
    required this.perPage,
    this.search,
    this.subjectId,
    this.sort,
  });

  factory TeachersBody.fromJson(Map<String, dynamic> json) =>
      _$TeachersBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TeachersBodyToJson(this);

  TeachersBody copyWith({
    int? page,
    int? perPage,
    String? search,
    int? subjectId,
    String? sort,
  }) {
    return TeachersBody(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      search: search ?? this.search,
      subjectId: subjectId ?? this.subjectId,
      sort: sort ?? this.sort,
    );
  }
}

