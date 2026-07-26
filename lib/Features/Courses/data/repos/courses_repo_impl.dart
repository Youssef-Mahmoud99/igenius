



import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/Features/Courses/data/models/course_details.dart';
import 'package:igenius/Features/Courses/presentation/cubits/assignments/submit_assinment.dart';
import 'package:igenius/Features/Courses/presentation/cubits/exams/submit_exam.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../../core/base/models/error_model.dart';
import '../../../Account/data/models/my_course_details_model.dart';
import '../../../Account/data/models/my_course_model.dart';
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

  @override
Future<Either<ErrorModel, BaseResponse<List<MyCourseModel>>>> getMyCourses(
    CoursesBody params) async {
  try {
    final response = await coursesApi.getMyCourses(params);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse<MyCourseDetails>>> getMyCourseDetails(
    String id) async {
  try {
    final response = await coursesApi.getMyCourseDetails(id);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse<LessonModel>>> getLessonContent(
    String id) async {
  try {
    final response = await coursesApi.getLessonContent(id);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse>> markAttendance(
    String id) async {
  try {
    final response = await coursesApi.markAttendance(id);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse<AssignmentModel>>> getAssignments( CoursesBody body) async {
  try {
    final response = await coursesApi.getAssignments( body);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse<AssignmentModel>>> getAssignmentDetails(
    String id) async {
  try {
    final response = await coursesApi.getAssignmentDetails(id);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse<List<AssignmentModel>>>> getAssignmentAttempts(
    String id) async {
  try {
    final response = await coursesApi.getAssignmentAttempts(id);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse>> submitAssignment(
    SubmitAssignmentParams params) async {
  try {
final formData = FormData.fromMap({
  'file': [
    await MultipartFile.fromFile(
      params. file.path,
      filename:  params.file.path.split('/').last,
    ),
  ],
});

    final response = await coursesApi.submitAssignment(
      params.assignmentId,
      formData,
    );
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse<ExamModel>>> getMyExams( CoursesBody body) async {
  try {
    final response = await coursesApi.getMyExams( body);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse<ExamModel>>> getMyExamDetails(
    String id) async {
  try {
    final response = await coursesApi.getMyExamDetails(id);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

@override
Future<Either<ErrorModel, BaseResponse<List<ExamModel>>>> getExamAttempts(
    String id) async {
  try {
    final response = await coursesApi.getExamAttempts(id);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(
      ErrorModel(
        success: false,
        message: e.toString(),
      ),
    );
  }
}
@override
Future<Either<ErrorModel, BaseResponse>> submitExam( SubmitExamParams params) async {
  try {
final formData = FormData.fromMap({
  'file': [
    await MultipartFile.fromFile(
      params. file.path,
      filename:  params.file.path.split('/').last,
    ),
  ],
});

    final response = await coursesApi.submitExam (
      params.examId,
      formData,
    );
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorModel.fromJson(e.response?.data ?? {}));
  } catch (e) {
    return Left(ErrorModel(success: false, message: e.toString()));
  }
}

}