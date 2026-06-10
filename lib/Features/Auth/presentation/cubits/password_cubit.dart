import 'package:igenius/Features/Auth/data/repos/password_repo.dart';
import 'package:igenius/core/utils/helpers/toast_helper.dart';

import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/cubit/base_state.dart';
import '../../../../core/base/models/base_response.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../core/utils/helpers/helper_methods.dart';
import '../../data/models/password_params.dart';

class PasswordCubit extends BaseCubit<BaseResponse> {
  final PasswordRepo repo;

  PasswordCubit(this.repo);

  Future<void> forgetPassword(String email) async {
    await execute(
      useCase: repo.forgetPassword,
      params: email,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
    if (state is SuccessState<BaseResponse>) {
      AppNavaigation.push(AppRoutes.otpScreen);
    }
  }

  Future<void> verifyOtp(PasswordParams params) async {
    await execute(
      useCase: repo.verifyOtp,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
    if (state is SuccessState<BaseResponse>) {
      AppNavaigation.goToPage(AppRoutes.createNewPassword);
    }
  }

  Future<void> resetPassword(PasswordParams params) async {
    await execute(
      useCase: repo.resetPassword,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
    if (state is SuccessState<BaseResponse>) {
      AppNavaigation.goToLogin();
    }
  }
}
