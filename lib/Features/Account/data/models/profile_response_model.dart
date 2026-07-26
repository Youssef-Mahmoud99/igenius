import 'package:json_annotation/json_annotation.dart';
import 'package:igenius/Features/Auth/data/models/user_model.dart';

part 'profile_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileResponseModel {
  final int id;
  final UserModel user;
  final String phone;
  final String whatsapp;
  final String? telegram;

  @JsonKey(name: 'parent_email')
  final String parentEmail;

  @JsonKey(name: 'parent_phone')
  final String parentPhone;

  @JsonKey(name: 'parent_whatsapp')
  final String parentWhatsapp;

  @JsonKey(name: 'parent_telegram')
  final String? parentTelegram;

  final int grade;
  final String school;
  final String country;
  final String city;

  @JsonKey(name: 'birth_date')
  final String birthDate;

  ProfileResponseModel({
    required this.id,
    required this.user,
    required this.phone,
    required this.whatsapp,
    this.telegram,
    required this.parentEmail,
    required this.parentPhone,
    required this.parentWhatsapp,
    this.parentTelegram,
    required this.grade,
    required this.school,
    required this.country,
    required this.city,
    required this.birthDate,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseModelToJson(this);
}