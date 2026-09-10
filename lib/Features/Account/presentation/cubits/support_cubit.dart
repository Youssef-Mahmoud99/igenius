// import '../../../../../core/base/cubit/base_cubit.dart';
// import '../../../../../core/base/cubit/base_state.dart';
// import '../../../../../core/base/models/base_response.dart';
// import '../../data/models/support/support_model.dart';
// import '../../data/repos/support/support_repo.dart';

// class SupportCubit extends BaseCubit<BaseResponse<SupportListModel>> {
//   final SupportRepo repo;

//   SupportCubit(this.repo);

//   SupportListModel? ticketsData;

//   Future<void> getSupportTickets({int perPage = 20}) async {
//     await execute(
//       params: null,
//       useCase: (_) => repo.getSupportTickets(perPage: perPage),
//       requestMethod: 'GET',
//       errorMessageExtractor: (failure) => failure.allErrorMessages,
//       successMessageExtractor: (response) => response.message,
//     );

//     if (state is SuccessState<BaseResponse<SupportListModel>>) {
//       ticketsData =
//           (state as SuccessState<BaseResponse<SupportListModel>>).data.data;
//     }
//   }

//   Future<void> createSupportTicket(String message) async {
//     final result = await repo.createSupportTicket(message);
//     result.fold(
//       (error) => emitError(error.allErrorMessages),
//       (response) => getSupportTickets(), // refresh list after create
//     );
//   }
// }