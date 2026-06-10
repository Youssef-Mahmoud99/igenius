import 'package:json_annotation/json_annotation.dart';

import 'student_model.dart';
import 'user_model.dart';

part 'auth_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResponseModel {
  final String token;
  final UserModel? user;
  final StudentModel? student;

  AuthResponseModel({
    required this.token,
     this.user,
     this.student,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);
}


