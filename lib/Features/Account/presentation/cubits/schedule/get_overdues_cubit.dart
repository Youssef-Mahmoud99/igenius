import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/schedule/overdue_model.dart';
import '../../../data/repos/schedule/schedule_repo.dart';

class GetOverduesCubit extends BaseCubit<BaseResponse<OverdueModel>> {
  final ScheduleRepo repo;

   GetOverduesCubit(this.repo);


  Future<void> getOverdues() async {
    await execute(
      params: null,
      useCase: (_) => repo.getOverdues(),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

  }

}