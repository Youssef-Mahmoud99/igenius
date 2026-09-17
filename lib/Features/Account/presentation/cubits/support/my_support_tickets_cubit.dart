import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../data/models/support/support_model.dart';
import '../../../data/repos/support/support_repo.dart';

class MySupportTicketsCubit extends BaseCubit<BaseResponse<List<SupportTicketModel>>> {
  final SupportRepo repo;

  MySupportTicketsCubit(this.repo);


  Future<void> getSupportTickets({int perPage = 20}) async {
    await execute(
      params: null,
      useCase: (_) => repo.getSupportTickets(perPage: perPage),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

  }

}