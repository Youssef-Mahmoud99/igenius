import 'dart:developer';

import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../app.dart';
import '../../../../core/base/cubit/base_state.dart';
import '../../data/models/profile_response_model.dart';
import '../../data/repos/profile_repo.dart';

class ProfileCubit extends BaseCubit<BaseResponse<ProfileResponseModel>> {
  final ProfileRepo repo;

  ProfileCubit(this.repo);

  Future<void> getProfile() async {
    await execute(
      params: null,
      useCase: (_) => repo.getProfile(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
      
    );
        if (state is SuccessState<BaseResponse<ProfileResponseModel>>) {
        final data = (state as SuccessState<BaseResponse<ProfileResponseModel>>).data.data;
          currentUser = data;
    }

  }
}
