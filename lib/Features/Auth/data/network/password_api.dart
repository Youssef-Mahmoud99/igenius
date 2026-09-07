import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/auth_model.dart';
import '../models/auth_response_model.dart';
import '../models/password_params.dart';

part 'password_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class PasswordApi {
  factory PasswordApi(Dio dio, {String baseUrl}) = _PasswordApi;

  @POST(EndPoints.forgetPassword)
  Future<BaseResponse> forgetPassword(@Field('email') String email);

  @POST(EndPoints.verifyOtp)
  Future<BaseResponse> verifyOtp(@Body() PasswordParams body);

  @POST(EndPoints.resetPassword)
  Future<BaseResponse> resetPassword(@Body() PasswordParams body);
}
