import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'student_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StudentModel {
  final int id;
  final String? phone;
  final String? whatsapp;
  final String? telegram;
  @JsonKey(name: 'parent_email')
  final String? parentEmail;
  @JsonKey(name: 'parent_phone')
  final String? parentPhone;
  @JsonKey(name: 'parent_whatsapp')
  final String? parentWhatsapp;
  @JsonKey(name: 'parent_telegram')
  final String? parentTelegram;
  final int? grade;
  final String? school;
  final String? country;
  final String? city;
  @JsonKey(name: 'birth_date')
  final String? birthDate;

    StudentModel({
    required this.id,
     this.phone,
     this.whatsapp,
    this.telegram,
     this.parentEmail,
     this.parentPhone,
     this.parentWhatsapp,
    this.parentTelegram,
     this.grade,
     this.school,
     this.country,
     this.city,
     this.birthDate,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) =>
      _$StudentModelFromJson(json);

  Map<String, dynamic> toJson() => _$StudentModelToJson(this);
}