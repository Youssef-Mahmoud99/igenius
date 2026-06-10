import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/api_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/auth_model.dart';
import '../models/auth_response_model.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST(AppUrls.register)
  Future<BaseResponse<AuthResponseModel>> register(@Body() AuthModel body);

  @POST(AppUrls.login)
  Future<BaseResponse<AuthResponseModel>> login(@Body() AuthModel body);

  @POST(AppUrls.logout)
  Future<BaseResponse<AuthResponseModel>> logout();
}