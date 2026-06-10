import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';
@JsonSerializable(explicitToJson: true)
class ErrorModel {
  final bool? success;
  final String? message;
  final Map<String, List<String>>? errors;

  ErrorModel({this.success, this.message, this.errors});

  // 👇 مش هنستخدم الـ generated code للـ errors عشان فيه مشكلة casting
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<String>>? errors;
    if (json['errors'] != null) {
      errors = (json['errors'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).map((e) => e.toString()).toList(),
        ),
      );
    }

    return ErrorModel(
      success: json['success'],
      message: json['message'],
      errors: errors,
    );
  }

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);

  String get firstErrorMessage {
    if (errors == null || errors!.isEmpty) {
      return message ?? 'Unknown error';
    }
    final firstKey = errors!.keys.first;
    return errors![firstKey]?.first ?? message ?? 'Unknown error';
  }

  String get allErrorMessages {
  if (errors == null || errors!.isEmpty) {
    return message ?? 'Unknown error';
  }
  return errors!.values
      .expand((list) => list)
      .join('\n');
}
}
