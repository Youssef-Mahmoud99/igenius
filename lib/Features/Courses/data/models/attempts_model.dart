import 'package:json_annotation/json_annotation.dart';

part 'attempts_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class AttemptsModel {
  final int? id;
  final int? attemptNumber;

  @JsonKey(name: 'submitted_at')
  final String? submittedAt;

  final String? status;

  final int? score;

  @JsonKey(name: 'total_marks')
  final int? totalMarks;

  final List<FileModel>? files;

  const AttemptsModel({
    this.id,
    this.attemptNumber,
    this.submittedAt,
    this.status,
    this.score,
    this.totalMarks,
    this.files,
  });

  factory AttemptsModel.fromJson(Map<String, dynamic> json) =>
      _$AttemptsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttemptsModelToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class FileModel {
  final int? id;
  final String? name;

  @JsonKey(name: 'file_url')
  final String? fileUrl;

  @JsonKey(name: 'file_with_comments_url')
  final String? fileWithCommentsUrl;

  const FileModel({
    this.id,
    this.name,
    this.fileUrl,
    this.fileWithCommentsUrl,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}