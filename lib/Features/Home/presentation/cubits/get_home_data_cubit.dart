import 'dart:developer';
import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../data/models/home_data_model.dart';
import '../../data/repos/home_repo.dart';

class GetHomeDataCubit extends BaseCubit<BaseResponse<HomeDataModel>> {
  final HomeRepo repo;

  GetHomeDataCubit(this.repo);

  Future<void> getHomeData() async {
    await execute(
      params: null,
      useCase: (_) => repo.getHomeData(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
      
    );
  }
}
