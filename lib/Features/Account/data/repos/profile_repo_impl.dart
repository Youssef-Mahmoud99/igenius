import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/Features/Account/data/models/profile_response_model.dart';
import 'package:igenius/Features/Account/data/network/profile_api.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../Auth/data/models/auth_model.dart';
import 'profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileApi api;

  ProfileRepoImpl(this.api);

  @override
  Future<Either<ErrorModel, BaseResponse<ProfileResponseModel>>> getProfile() async {
    try {
      final response = await api.getProfile();
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
  Future<Either<ErrorModel, BaseResponse>> updateProfile(AuthModel body) async {
    try {
      final response = await api.updateProfile(body);
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