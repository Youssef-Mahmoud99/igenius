import 'dart:io';
import 'package:dio/dio.dart';

import '../../injection/service_locator.dart';
import '../services/localization_service.dart';


class ErrorHandler {
  static String getErrorMessage(dynamic error) {
        final strings = sl<LocalizationService>().strings;

    if (error is DioException) {
      final res = error.response;

      if (res != null && res.data is Map<String, dynamic>) {
        final data = res.data as Map<String, dynamic>;
        return data['message'] ?? data['error'] ?? strings?.serverError;
      }

      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.sendTimeout:
          return strings?.timeout ?? 'Timeout';
        case DioExceptionType.badResponse:
          return strings?.badResponse ?? 'Bad response';
        case DioExceptionType.cancel:
          return strings?.cancelled ?? 'Cancelled';
        case DioExceptionType.connectionError:
          return strings?.noInternet ?? 'No internet'; // 👈 رسالة واضحة
        default:
          return strings?.unexpectedError ?? 'Unexpected error';
      }
    }
    if (error is SocketException) {
      return  strings?.noInternet ?? 'No internet';
    }

    return    strings?.unknownError ?? 'Unknown error';
  }
}
