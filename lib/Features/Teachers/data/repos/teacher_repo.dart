import 'package:dartz/dartz.dart';
import 'package:igenius/Features/Account/data/models/profile_response_model.dart';
import 'package:igenius/core/base/models/error_model.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/teacher_details_model.dart';
import '../models/teacher_model.dart';
import '../models/teachers_body.dart';

abstract class TeacherRepo {
  Future<Either<ErrorModel, BaseResponse<List<TeacherModel>>>> getTeachers(TeachersBody body);

  Future<Either<ErrorModel, BaseResponse<TeacherDetailsModel>>> getTeacherDetails(String id);
}