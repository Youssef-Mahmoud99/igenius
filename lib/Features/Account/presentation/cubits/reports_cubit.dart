// import '../../../../../core/base/cubit/base_cubit.dart';
// import '../../../../../core/base/cubit/base_state.dart';
// import '../../../../../core/base/models/base_response.dart';
// import '../../data/models/reports_response_model.dart';
// import '../../data/repos/reports_repo.dart';

// class ReportsCubit extends BaseCubit<BaseResponse<ReportsResponseModel>> {
//   final ReportsRepo repo;

//   ReportsCubit(this.repo);

//   ReportsResponseModel? reportsData;

//   Future<void> getReports({int? courseId}) async {
//     await execute(
//       params: null,
//       useCase: (_) => repo.getReports(courseId: courseId),
//       requestMethod: 'GET',
//       errorMessageExtractor: (failure) => failure.allErrorMessages,
//       successMessageExtractor: (response) => response.message,
//     );

//     if (state is SuccessState<BaseResponse<ReportsResponseModel>>) {
//       reportsData =
//           (state as SuccessState<BaseResponse<ReportsResponseModel>>)
//               .data
//               .data;
//     }
//   }

//   Future<void> downloadReport() async {
//     final result = await repo.downloadReport();
//     result.fold(
//       (error) => emitError(error.allErrorMessages),
//       (path) => emitDownloadSuccess(path),
//     );
//   }
// }