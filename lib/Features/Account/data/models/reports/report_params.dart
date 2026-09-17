import 'package:dartz/dartz.dart';
import '../../../../../core/base/models/error_model.dart';
import '../../models/reports/report_response_model.dart';

class DownloadReportParams {
  final int? courseId;
  final String type; // 'full' افتراضيًا
  final DateTime? from;
  final DateTime? to;

  DownloadReportParams({
    this.courseId,
    this.type = 'full',
    this.from,
    this.to,
  });
}

