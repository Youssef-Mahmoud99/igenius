



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/Features/Courses/data/models/course_details.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../../core/base/models/error_model.dart';
import '../models/courses_body.dart';
import '../models/courses_model.dart';
import '../network/courses_api.dart';
import 'courses_repo.dart';

class CoursesRepoImpl implements CoursesRepo {
  final CoursesApi coursesApi;

  CoursesRepoImpl(this.coursesApi);

  @override
  Future<Either<ErrorModel, BaseResponse<List<CourseModel>>>> getCourses(CoursesBody params) async {
    try {
      final response = await coursesApi.getCourses(params);

      return Right(response);

    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(
        success: false,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse<CourseDetails>>> getCourseDetails(String courseId) async {
    try {
      final response = await coursesApi.getCourseDetails(courseId);
      return Right( response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(
        success: false,
        message: e.toString(),
      ));
    }
  }

}