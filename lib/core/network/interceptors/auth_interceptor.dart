import 'package:dio/dio.dart';
import 'package:igenius/core/constants/app_keys.dart';
import '../../../injection/service_locator.dart';
import '../../services/secure_storage_service.dart';
import '../../utils/helpers/helper_methods.dart';
import '../network_info.dart';

class AuthInterceptor extends Interceptor {
  final NetworkInfo networkInfo = sl<NetworkInfo>();

@override
void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
  final token = await SecureStorageService.read(AppKeys.token);
  
  print('token: $token'); // شوف بيطبع ايه
  
  options.headers["Authorization"] = "Bearer $token"; // حطها من غير if
  
  print('headers: ${options.headers}'); // شوف الهيدر اتحط
  
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
    // لو 401 يعني الـ token انتهى — امسحه وودي للـ login
    if (err.response?.statusCode == 401) {
      HelperMethods.logout();
    }
    return handler.next(err);
  }
}