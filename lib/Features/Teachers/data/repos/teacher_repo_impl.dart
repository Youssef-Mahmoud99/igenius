import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/Features/Account/data/models/profile_response_model.dart';
import 'package:igenius/Features/Account/data/network/profile_api.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../Auth/data/models/auth_model.dart';
import '../models/teacher_details_model.dart';
import '../models/teacher_model.dart';
import '../models/teachers_body.dart';
import '../network/teacher_api.dart';
import 'teacher_repo.dart';

class TeacherRepoImpl implements  TeacherRepo {
  final TeacherApi api;

  TeacherRepoImpl(this.api);

  @override
  Future<Either<ErrorModel, BaseResponse<List<TeacherModel>>>> getTeachers(
    TeachersBody body,
  ) async {
    try {
      final response = await api.getTeachers(body);
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
  Future<Either<ErrorModel, BaseResponse<TeacherDetailsModel>>> getTeacherDetails(String id) async {
    try {
      final response = await api.getTeacherDetails(id);
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
}