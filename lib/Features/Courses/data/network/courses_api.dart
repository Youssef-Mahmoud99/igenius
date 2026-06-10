import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/api_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/course_details.dart';
import '../models/courses_body.dart';
import '../models/courses_model.dart';

part 'courses_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class CoursesApi {
  factory CoursesApi(Dio dio, {String baseUrl}) = _CoursesApi;


  @GET(AppUrls.courses)
  Future<BaseResponse<List<CourseModel>>> getCourses(@Queries() CoursesBody body,);

  @GET(AppUrls.courses + "/{id}")
  Future<BaseResponse<CourseDetails>> getCourseDetails(@Path("id") String id);
}