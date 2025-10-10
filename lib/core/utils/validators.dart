import '../../injection/service_locator.dart';
import '../services/localization_service.dart';

class Validators {
  static String? validateEmail(String? value) {
    final strings = sl<LocalizationService>().strings;

    if (value == null || value.trim().isEmpty) {
      return strings?.validationEmailRequired ?? 'Email required';
    }

    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return strings?.validationInvalidEmail ?? 'Invalid email';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    final strings = sl<LocalizationService>().strings;

    if (value == null || value.isEmpty) {
      return strings?.validationPasswordRequired ?? 'Password required';
    }

    if (value.length < 6) {
      return strings?.validationPasswordLength ?? 'Password too short';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    final strings = sl<LocalizationService>().strings;

    if (value == null || value.isEmpty) {
      return strings?.validationConfirmPasswordRequired ?? 'Confirm password required';
    }

    if (value != password) {
      return strings?.validationPasswordMismatch ?? 'Passwords do not match';
    }

    return null;
  }

  static String? validateName(String? value) {
    final strings = sl<LocalizationService>().strings;

    if (value == null || value.trim().isEmpty) {
      return strings?.validationNameRequired ?? 'Name required';
    }

    if (value.length < 2) {
      return strings?.validationNameLength ?? 'Name too short';
    }

    return null;
  }

  static String? validatePhone(String? value) {
    final strings = sl<LocalizationService>().strings;

    if (value == null || value.trim().isEmpty) {
      return strings?.validationPhoneRequired ?? 'Phone required';
    }

    final pattern = r'^01[0-2,5]{1}[0-9]{8}$';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(value.trim())) {
      return strings?.validationInvalidPhone ?? 'Invalid phone';
    }

    return null;
  }

  static String? validateNotEmpty(String? value, {String fieldName = "هذا الحقل"}) {
    final strings = sl<LocalizationService>().strings;

    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${strings?.validationRequired ?? 'required'}';
    }
    return null;
  }
}
