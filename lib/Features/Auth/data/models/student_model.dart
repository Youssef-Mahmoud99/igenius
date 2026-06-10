import 'package:json_annotation/json_annotation.dart';

part 'student_model.g.dart';
@JsonSerializable(explicitToJson: true)
class StudentModel {
  final int id;
  final String phone;
  final String grade;
  final String school;
  final String country;
  final String city;

  StudentModel({
    required this.id,
    required this.phone,
    required this.grade,
    required this.school,
    required this.country,
    required this.city,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}