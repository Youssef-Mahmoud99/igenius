import 'dart:convert';
import 'package:dio/dio.dart';
import '../../services/get_storage_service.dart';

class GetStorageCacheInterceptor extends Interceptor {
  final Duration cacheDuration;

  GetStorageCacheInterceptor({this.cacheDuration = const Duration(hours: 1)});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.method.toUpperCase() == 'GET' &&
        response.statusCode == 200) {
      final key = response.requestOptions.uri.toString();
      final cacheData = jsonEncode({
        'timestamp': DateTime.now().toIso8601String(),
        'response': response.data,
      });
      GetStorageService.write(key, cacheData);
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;

    if (options.method.toUpperCase() == 'GET') {
      final key = options.uri.toString();
      final cached = await GetStorageService.read(key);

      if (cached != null) {
        final data = jsonDecode(cached);
        final timestamp = DateTime.parse(data['timestamp']);
        final isExpired = DateTime.now().difference(timestamp) > cacheDuration;

        if (!isExpired) {
          return handler.resolve(
            Response(
              requestOptions: options,
              data: data['response'],
              statusCode: 200,
            ),
          );
        }
      }
    }
    return handler.next(err);
  }
}
