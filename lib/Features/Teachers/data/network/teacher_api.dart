import 'package:dio/dio.dart';
import 'package:igenius/Features/Account/data/models/profile_response_model.dart';
import 'package:igenius/Features/Teachers/data/models/teacher_details_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/teacher_model.dart';
import '../models/teachers_body.dart';

part 'teacher_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class TeacherApi {
  factory TeacherApi(Dio dio, {String baseUrl}) = _TeacherApi;

  @GET(EndPoints.teachers)
  Future<BaseResponse<List<TeacherModel>>> getTeachers(
        @Queries() TeachersBody body,

  );
  @GET(EndPoints.teachers + "/{id}")
  Future<BaseResponse<TeacherDetailsModel>> getTeacherDetails(@Path("id") String id);

}
