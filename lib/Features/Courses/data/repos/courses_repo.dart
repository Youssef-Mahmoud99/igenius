import 'package:dartz/dartz.dart';
import 'package:igenius/Features/Courses/data/models/courses_model.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../core/base/models/base_response.dart';
import '../models/course_details.dart';
import '../models/courses_body.dart';

abstract class CoursesRepo {
  Future<Either<ErrorModel, BaseResponse <List<CourseModel>>>> getCourses(CoursesBody params);
  Future<Either<ErrorModel, BaseResponse <CourseDetails>>> getCourseDetails(String id);
}