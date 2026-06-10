import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/api_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/auth_model.dart';
import '../models/auth_response_model.dart';
import '../models/password_params.dart';

part 'password_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class PasswordApi {
  factory PasswordApi(Dio dio, {String baseUrl}) = _PasswordApi;

  @POST(AppUrls.forgetPassword)
  Future<BaseResponse> forgetPassword(@Field('email') String email);

  @POST(AppUrls.verifyOtp)
  Future<BaseResponse> verifyOtp(@Body() PasswordParams body);

  @POST(AppUrls.resetPassword)
  Future<BaseResponse> resetPassword(@Body() PasswordParams body);

}