import 'package:dartz/dartz.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../../core/base/models/base_response.dart';
import '../../models/reports/report_response_model.dart';

abstract class ReportsRepo {
  Future<Either<ErrorModel, BaseResponse<ReportsResponseModel>>> getReports({
    int? courseId,
  });

  /// بيرجع مسار الملف بعد ما يتحفظ على الجهاز
  Future<Either<ErrorModel, String>> downloadReport();
}