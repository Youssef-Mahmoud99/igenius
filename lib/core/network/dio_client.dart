import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/cache_interceptor.dart';
import 'interceptors/logger_interceptor.dart';


class DioClient {
  final Dio dio;

  DioClient._(this.dio, );

  static Future<DioClient> create() async {

    final dio = Dio(
       
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    dio.interceptors.addAll([ 
      
      GetStorageCacheInterceptor(),
      AuthInterceptor(),
      AppLoggerInterceptor(),
    ]);
   

    return DioClient._(dio);
  }

  Dio get instance => dio;
}
