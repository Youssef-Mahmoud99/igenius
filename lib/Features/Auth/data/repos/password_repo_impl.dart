import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/Features/Auth/data/repos/password_repo.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../../core/base/models/error_model.dart';
import '../models/auth_model.dart';
import '../models/auth_response_model.dart';
import '../models/password_params.dart';
import '../network/auth_api.dart';
import '../network/password_api.dart';
import 'auth_repo.dart';

class PasswordRepoImpl implements PasswordRepo {
  final PasswordApi authApi;

  PasswordRepoImpl(this.authApi);

  @override
  Future<Either<ErrorModel, BaseResponse>> forgetPassword(String email) async {
    try {
      final response = await authApi.forgetPassword(email);
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
  Future<Either<ErrorModel, BaseResponse>> verifyOtp(PasswordParams params) async {
    try {
      final response = await authApi.verifyOtp(params);
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
  Future<Either<ErrorModel, BaseResponse>> resetPassword(PasswordParams params) async {
    try {
      final response = await authApi.resetPassword(params);
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