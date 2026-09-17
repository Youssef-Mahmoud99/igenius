import 'package:dartz/dartz.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../models/reports/report_params.dart';


abstract class ReportsRepo {

  Future<Either<ErrorModel, String>>  downloadReport(DownloadReportParams params);
}