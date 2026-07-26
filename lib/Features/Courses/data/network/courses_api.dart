import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/api_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../../../Account/data/models/my_course_details_model.dart';
import '../../../Account/data/models/my_course_model.dart';
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
  @GET(AppUrls.myCourses)
  Future<BaseResponse<List<MyCourseModel>>> getMyCourses(@Queries() CoursesBody body,);

  @GET(AppUrls.myCourses + "/{id}")
  Future<BaseResponse<MyCourseDetails>> getMyCourseDetails(@Path("id") String id);
  @GET(AppUrls.getLessonContent + "/{id}")
  Future<BaseResponse<LessonModel>> getLessonContent(@Path("id") String id);
  
  @POST(AppUrls.getLessonContent + "/{id}/attend")
  Future<BaseResponse> markAttendance(@Path("id") String id);
  @GET(AppUrls.assignments )
  Future<BaseResponse<AssignmentModel>> getAssignments(@Queries() CoursesBody body,);
  
  @GET(AppUrls.assignments + "/{id}")
  Future<BaseResponse<AssignmentModel>> getAssignmentDetails(@Path("id") String id);
  @GET(AppUrls.assignments + "/{id}/attempts")
  Future<BaseResponse<List<AssignmentModel>>> getAssignmentAttempts(@Path("id") String id);
  @POST(AppUrls.assignments + "/{id}/submit")
  Future<BaseResponse> submitAssignment(@Path("id") String id,   @Body() FormData data,
);

  @GET(AppUrls.myExams)
  Future<BaseResponse<ExamModel>> getMyExams(@Queries() CoursesBody body,);
  @GET(AppUrls.myExams + "/{id}")
  Future<BaseResponse<ExamModel>> getMyExamDetails(@Path("id") String id);
  @GET(AppUrls.myExams + "/{id}/attempts")
  Future<BaseResponse<List<ExamModel>>> getExamAttempts(@Path("id") String id);
  @POST(AppUrls.myExams + "/{id}/submit")
  Future<BaseResponse> submitExam(@Path("id") String id ,  @Body() FormData data,
);
  


  


}