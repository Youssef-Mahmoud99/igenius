import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../../core/base/models/error_model.dart';
import '../models/auth_model.dart';
import '../models/auth_response_model.dart';
import '../network/auth_api.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthApi authApi;

  AuthRepoImpl(this.authApi);

  @override
  Future<Either<ErrorModel, BaseResponse<AuthResponseModel>>> register(AuthModel params) async {
    try {
      final response = await authApi.register(params);

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
  Future<Either<ErrorModel, BaseResponse<AuthResponseModel>>> login(AuthModel params) async {
    try {
      final response = await authApi.login(params);
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
  Future<Either<ErrorModel, BaseResponse<AuthResponseModel>>> Logout() async {
    try {
      final response = await authApi.logout();
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