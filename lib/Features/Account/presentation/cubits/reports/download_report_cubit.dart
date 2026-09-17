import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../data/models/reports/report_params.dart';
import '../../../data/repos/reports/reports_repo.dart';
class DownloadReportCubit extends BaseCubit<String> {
  final ReportsRepo repo;

  DownloadReportCubit(this.repo);

  Future<void> downloadReport({
    int? courseId,
    String type = 'full',
    DateTime? from,
    DateTime? to,
  }) async {
    await execute<DownloadReportParams>(
      useCase: repo.downloadReport,
      params: DownloadReportParams(
        courseId: courseId,
        type: type,
        from: from,
        to: to,
      ),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
    );
  }
}