import 'package:dio/dio.dart';
import 'package:igenius/Features/Account/data/models/profile_response_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../../../Auth/data/models/auth_model.dart';
import '../../../Courses/data/models/courses_model.dart';
import '../models/about_model.dart';
import '../models/home_data_model.dart';

part 'home_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class HomeApi {
  factory HomeApi(Dio dio, {String baseUrl}) = _HomeApi;

  @GET(EndPoints.homeData)
  Future<BaseResponse<HomeDataModel>> getHomeData();
  @GET(EndPoints.about)
  Future<BaseResponse<AboutDataModel>> getAboutInfo();

}
