import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/schedule/upcoming_model.dart';
import '../../../data/repos/schedule/schedule_repo.dart';

class GetUpcomingsCubit extends BaseCubit<BaseResponse<UpcomingModel>> {
  final ScheduleRepo repo;

      GetUpcomingsCubit(this.repo);


  Future<void> getUpcomings() async {
    await execute(
      params: null,
      useCase: (_) => repo.getUpcomings(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

  }

}