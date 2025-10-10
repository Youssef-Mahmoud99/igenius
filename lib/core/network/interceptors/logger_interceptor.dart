import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppLoggerInterceptor extends PrettyDioLogger {
  AppLoggerInterceptor()
      : super(
          requestBody: true,
          requestHeader: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
          maxWidth: 90,
        );
}
