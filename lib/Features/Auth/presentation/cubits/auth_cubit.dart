import '../../../../app.dart';
import '../../../../core/base/cubit/base_cubit.dart';
import '../../../../core/base/cubit/base_state.dart';
import '../../../../core/base/models/base_response.dart';
import '../../../../core/constants/app_keys.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../core/utils/helpers/helper_methods.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/auth_response_model.dart';
import '../../data/repos/auth_repo.dart';

class AuthCubit extends BaseCubit<BaseResponse<AuthResponseModel>> {
  final AuthRepo repo;

  AuthCubit(this.repo);

  Future<void> login(AuthModel params) async {
    await execute(
      useCase: repo.login,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

    if (state is SuccessState<BaseResponse<AuthResponseModel>>) {
      final data =
          (state as SuccessState<BaseResponse<AuthResponseModel>>).data;
      await SecureStorageService.write(AppKeys.token, data.data?.token ?? '');
      currentUser = data.data?.user;
      currentStudent = data.data?.student;
      AppNavaigation.goToHome(isGuest: false);
    }
  }

  Future<void> register(AuthModel params) async {
    await execute(
      useCase: repo.register,
      params: params,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
    if (state is SuccessState<BaseResponse<AuthResponseModel>>) {
      final data =
          (state as SuccessState<BaseResponse<AuthResponseModel>>).data;
      await SecureStorageService.write(AppKeys.token, data.data?.token ?? '');
      currentUser = data.data?.user;
      // currentStudent = data.data?.student;
      AppNavaigation.goToHome(isGuest: false);
    }
  }

  Future<void> logout() async {
    await execute(
      useCase: (_) => repo.Logout(),
      params: null,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
    if (state is SuccessState<BaseResponse<AuthResponseModel>>) {
      await HelperMethods.logout();
    }
  }
}
