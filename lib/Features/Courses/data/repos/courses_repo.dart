import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:igenius/Features/Account/data/models/my_course_model.dart';
import 'package:igenius/Features/Courses/data/models/courses_model.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../Account/data/models/my_course_details_model.dart';
import '../../presentation/cubits/assignments/submit_assinment.dart';
import '../../presentation/cubits/exams/submit_exam.dart';
import '../models/course_details.dart';
import '../models/courses_body.dart';

abstract class CoursesRepo {
  Future<Either<ErrorModel, BaseResponse<List<CourseModel>>>> getCourses(
    CoursesBody params,
  );

  Future<Either<ErrorModel, BaseResponse<CourseDetails>>> getCourseDetails(
    String id,
  );

  Future<Either<ErrorModel, BaseResponse<List<MyCourseModel>>>> getMyCourses(
    CoursesBody params,
  );

  Future<Either<ErrorModel, BaseResponse<MyCourseDetails>>> getMyCourseDetails(
    String id,
  );

  Future<Either<ErrorModel, BaseResponse<LessonModel>>> getLessonContent(
    String id,
  );

  Future<Either<ErrorModel, BaseResponse>> markAttendance(
    String id,
  );

  Future<Either<ErrorModel, BaseResponse<AssignmentModel>>> getAssignments( CoursesBody body);

  Future<Either<ErrorModel, BaseResponse<AssignmentModel>>> getAssignmentDetails(
    String id,
  );

  Future<Either<ErrorModel, BaseResponse<List<AssignmentModel>>>> getAssignmentAttempts(
    String id,
  );

  Future<Either<ErrorModel, BaseResponse>> submitAssignment(
    SubmitAssignmentParams params,
  );

  Future<Either<ErrorModel, BaseResponse<ExamModel>>> getMyExams( CoursesBody body);

  Future<Either<ErrorModel, BaseResponse<ExamModel>>> getMyExamDetails(
    String id,
  );

  Future<Either<ErrorModel, BaseResponse<List<ExamModel>>>> getExamAttempts(
    String id,
  );

  Future<Either<ErrorModel, BaseResponse>> submitExam(
     SubmitExamParams params,
  );
}