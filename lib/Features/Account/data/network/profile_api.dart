import 'package:dio/dio.dart';
import 'package:igenius/Features/Account/data/models/profile_response_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../../../Auth/data/models/auth_model.dart';

part 'profile_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String baseUrl}) = _ProfileApi;

  @GET(EndPoints.profile)
  Future<BaseResponse<ProfileResponseModel>> getProfile();

  @PUT(EndPoints.profile)
  Future<BaseResponse> updateProfile(@Body() AuthModel body);
}
