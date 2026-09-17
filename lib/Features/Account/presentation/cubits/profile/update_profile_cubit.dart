import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../Auth/data/models/auth_model.dart';
import '../../../data/repos/profile/profile_repo.dart';
import 'profile_cubit.dart';

class UpdateProfileCubit extends BaseCubit<BaseResponse> {
  final ProfileRepo repo;

  UpdateProfileCubit(this.repo);

  Future<void> updateProfile(AuthModel body, BuildContext context) async {
    await execute<AuthModel>(
      useCase: repo.updateProfile,
      params: body,
      requestMethod: 'POST',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );
    if (state is SuccessState<BaseResponse>) {
      AppNavaigation.pop();
      context.read<ProfileCubit>().getProfile();
    }
  }
}