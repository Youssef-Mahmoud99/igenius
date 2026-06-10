import 'package:dartz/dartz.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../core/base/models/base_response.dart';
import '../models/auth_model.dart';
import '../models/auth_response_model.dart';

abstract class AuthRepo {
  Future<Either<ErrorModel, BaseResponse <AuthResponseModel>>> register(AuthModel params);
  Future<Either<ErrorModel, BaseResponse <AuthResponseModel>>> login(AuthModel params);
  Future<Either<ErrorModel, BaseResponse <AuthResponseModel>>> Logout();
}
