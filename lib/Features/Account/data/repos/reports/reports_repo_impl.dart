import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/core/utils/helpers/helper_methods.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../../core/base/models/base_response.dart';
import '../../models/reports/report_params.dart';
import '../../models/reports/report_response_model.dart';
import '../../network/reports/reports_api.dart';
import 'reports_repo.dart';

class ReportsRepoImpl implements ReportsRepo {
  final ReportsApi api;

  ReportsRepoImpl(this.api);

  @override
  Future<Either<ErrorModel, String>> downloadReport(
      DownloadReportParams params) async {
    try {
      final response = await api.downloadReport(
        courseId: params.courseId,
        type: params.type,
        from: params.from != null ? _formatDate(params.from!) : '',
        to: params.to != null ? _formatDate(params.to!) : '',
      );

      final baseDir = await _getAppReportsDirectory();
      if (baseDir == null) {
        return Left(ErrorModel(
          success: false,
          message: 'تم رفض إذن الوصول للتخزين',
        ));
      }

      final fileName =
          'report_${params.type}_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final savePath = '${baseDir.path}/$fileName';

      final file = File(savePath);
      await file.writeAsBytes(response.data);

      return Right(savePath);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }

  /// نفس منطق ال downloadFile القديمة: IGENIUS/Reports
  Future<Directory?> _getAppReportsDirectory() async {
    Directory? baseDir;

    if (Platform.isAndroid) {
      final sdkInt = await HelperMethods.getAndroidSdkInt();

      if (sdkInt <= 32) {
        final status = await Permission.storage.request();
        if (!status.isGranted) return null;
      }

      baseDir = Directory('/storage/emulated/0/Download/IGENIUS/Reports');
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      baseDir = Directory('${appDir.path}/IGENIUS/Reports');
    }

    if (!await baseDir.exists()) {
      await baseDir.create(recursive: true);
    }

    return baseDir;
  }


  String _formatDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}