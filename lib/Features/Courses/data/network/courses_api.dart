import 'dart:io';

import 'package:dio/dio.dart';
import 'package:igenius/Features/Courses/data/models/attempts_model.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/endpoints.dart';
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

  @GET(EndPoints.courses)
  Future<BaseResponse<List<CourseModel>>> getCourses(
    @Queries() CoursesBody body,
  );

  @GET(EndPoints.courses + "/{id}")
  Future<BaseResponse<CourseDetails>> getCourseDetails(@Path("id") String id);
  @GET(EndPoints.myCourses)
  Future<BaseResponse<List<MyCourseModel>>> getMyCourses(
    @Queries() CoursesBody body,
  );

  @GET(EndPoints.myCourses + "/{id}")
  Future<BaseResponse<MyCourseDetails>> getMyCourseDetails(
    @Path("id") String id,
  );
  @GET(EndPoints.getLessonContent + "/{id}")
  Future<BaseResponse<LessonModel>> getLessonContent(@Path("id") String id);

  @POST(EndPoints.getLessonContent + "/{id}/attend")
  Future<BaseResponse> markAttendance(@Path("id") String id);
  @GET(EndPoints.assignments)
  Future<BaseResponse<AssignmentModel>> getAssignments(
    @Queries() CoursesBody body,
  );

  @GET(EndPoints.assignments + "/{id}")
  Future<BaseResponse<AssignmentModel>> getAssignmentDetails(
    @Path("id") String id,
  );
  @GET(EndPoints.assignments + "/{id}/attempts")
  Future<BaseResponse<List<AttemptsModel>>> getAssignmentAttempts(
    @Path("id") String id,
  );
  @POST(EndPoints.assignments + "/{id}/submit")
  Future<BaseResponse> submitAssignment(
    @Path("id") String id,
    @Body() FormData data,
  );

  @GET(EndPoints.myExams)
  Future<BaseResponse<ExamModel>> getMyExams(@Queries() CoursesBody body);
  @GET(EndPoints.myExams + "/{id}")
  Future<BaseResponse<ExamModel>> getMyExamDetails(@Path("id") String id);
  @GET(EndPoints.myExams + "/{id}/attempts")
  Future<BaseResponse<List<AttemptsModel>>> getExamAttempts(@Path("id") String id);
  @POST(EndPoints.myExams + "/{id}/submit")
  Future<BaseResponse> submitExam(@Path("id") String id, @Body() FormData data);
}
