import 'package:dartz/dartz.dart';
import 'package:igenius/Features/Account/data/models/profile_response_model.dart';
import 'package:igenius/core/base/models/error_model.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../Auth/data/models/auth_model.dart';

abstract class ProfileRepo {
  Future<Either<ErrorModel, BaseResponse<ProfileResponseModel>>> getProfile();

  Future<Either<ErrorModel, BaseResponse>> updateProfile(AuthModel body);
}