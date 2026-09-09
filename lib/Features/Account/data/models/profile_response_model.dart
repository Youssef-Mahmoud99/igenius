import 'package:json_annotation/json_annotation.dart';
import 'package:igenius/Features/Auth/data/models/user_model.dart';

part 'profile_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileResponseModel {
  final int? id;

  final UserModel? user;

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

  final ProfileStatsModel? stats;

  ProfileResponseModel({
    this.id,
    this.user,
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
    this.stats,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProfileResponseModelToJson(this);
}

@JsonSerializable()
class ProfileStatsModel {
  @JsonKey(name: 'total_enrolled_courses')
  final int? totalEnrolledCourses;

  @JsonKey(name: 'total_completed_lessons')
  final int? totalCompletedLessons;

  @JsonKey(name: 'total_completed_assignments')
  final int? totalCompletedAssignments;

  @JsonKey(name: 'total_completed_exams')
  final int? totalCompletedExams;

  ProfileStatsModel({
    this.totalEnrolledCourses,
    this.totalCompletedLessons,
    this.totalCompletedAssignments,
    this.totalCompletedExams,
  });

  factory ProfileStatsModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileStatsModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProfileStatsModelToJson(this);
}