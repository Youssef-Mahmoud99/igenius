import 'package:json_annotation/json_annotation.dart';

part 'password_params.g.dart';

@JsonSerializable(explicitToJson: true)
class PasswordParams {
  final String? email;
  final String? code;
  final String? password;

  @JsonKey(name: 'password_confirmation')
  final String? passwordConfirmation;

  PasswordParams({
    this.email,
    this.code,
    this.password,
    this.passwordConfirmation,
  });

  PasswordParams copyWith({
    String? email,
    String? code,
    String? password,
    String? passwordConfirmation,
  }) {
    return PasswordParams(
      email: email ?? this.email,
      code: code ?? this.code,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }

  factory PasswordParams.fromJson(Map<String, dynamic> json) =>
      _$PasswordParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordParamsToJson(this);
}