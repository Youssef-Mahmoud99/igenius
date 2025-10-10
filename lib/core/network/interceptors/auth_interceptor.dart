import 'package:dio/dio.dart';
import 'package:igenius/core/constants/app_keys.dart';
import '../../../injection/service_locator.dart';
import '../../services/secure_storage_service.dart';
import '../network_info.dart';

class AuthInterceptor extends Interceptor {
   final NetworkInfo networkInfo  = sl<NetworkInfo>();
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final requiresToken = options.extra["requiresToken"] == true;

    if (requiresToken) {
      final token = await SecureStorageService.read(AppKeys.token);
      if (token != null && token.isNotEmpty) {
        options.headers["Authorization"] = "Bearer $token";
      }
    }

    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: "No Internet Connection",
          type: DioExceptionType.unknown,
        ),
      );
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        final newToken = await SecureStorageService.read(AppKeys.token);
        err.requestOptions.headers["Authorization"] = "Bearer $newToken";
        final retryResponse = await Dio().fetch(err.requestOptions);
        return handler.resolve(retryResponse);
      }
    }
    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await SecureStorageService.read(AppKeys.token);
    if (refreshToken == null) return false;

    try {
      final dio = Dio();
      final response = await dio.post(
        'https://example.com/api/refresh',
        data: {"refresh_token": refreshToken},
      );
      final newToken = response.data["access_token"];
      await SecureStorageService.write(AppKeys.token, newToken);
      return true;
    } catch (_) {
      return false;
    }
  }
}
