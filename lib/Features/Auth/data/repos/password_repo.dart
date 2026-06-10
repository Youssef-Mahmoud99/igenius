import 'package:dartz/dartz.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../../core/base/models/error_model.dart';
import '../models/password_params.dart';

abstract class PasswordRepo {
  Future<Either<ErrorModel, BaseResponse>> forgetPassword(String email);
  Future<Either<ErrorModel, BaseResponse>> verifyOtp(PasswordParams params);
  Future<Either<ErrorModel, BaseResponse>> resetPassword(PasswordParams params);
}