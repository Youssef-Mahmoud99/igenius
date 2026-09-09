import 'dart:developer';

import 'package:igenius/Features/Home/data/models/about_model.dart';

import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../app.dart';
import '../../../../core/base/cubit/base_state.dart';
import '../../data/repos/home_repo.dart';

class GetAboutCubit extends BaseCubit<BaseResponse<AboutDataModel>> {
  final HomeRepo repo;

  GetAboutCubit(this.repo);

  Future<void> getAbout() async {
    await execute(
      params: null,
      useCase: (_) => repo.getAboutInfo(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
      
    );
  }
}
