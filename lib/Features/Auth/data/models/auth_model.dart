import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthModel {
  final String? name;
  final String? email;
  final String? password;

  @JsonKey(name: 'password_confirmation')
  final String? passwordConfirmation;

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

  final String? grade;
  final String? school;
  final String? country;
  final String? city;

  @JsonKey(name: 'birth_date')
  final String? birthDate;

  AuthModel({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
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

  AuthModel copyWith({
    String? name,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? phone,
    String? whatsapp,
    String? telegram,
    String? parentEmail,
    String? parentPhone,
    String? parentWhatsapp,
    String? parentTelegram,
    String? grade,
    String? school,
    String? country,
    String? city,
    String? birthDate,
  }) { 
    return AuthModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      telegram: telegram ?? this.telegram,
      parentEmail: parentEmail ?? this.parentEmail,
      parentPhone: parentPhone ?? this.parentPhone,
      parentWhatsapp: parentWhatsapp ?? this.parentWhatsapp,
      parentTelegram: parentTelegram ?? this.parentTelegram,
      grade: grade ?? this.grade,
      school: school ?? this.school,
      country: country ?? this.country,
      city: city ?? this.city,
      birthDate: birthDate ?? this.birthDate,
    );
  } 

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}