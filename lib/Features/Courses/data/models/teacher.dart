import 'package:json_annotation/json_annotation.dart';

part 'teacher.g.dart';

@JsonSerializable(genericArgumentFactories: true) // شيل ignoreUnannotated
class Teacher {
  final int? id;
  final String? name;
  final String? description;

  const Teacher({
    this.id,
    this.name,
    this.description,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherToJson(this);

  Teacher copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return Teacher(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}