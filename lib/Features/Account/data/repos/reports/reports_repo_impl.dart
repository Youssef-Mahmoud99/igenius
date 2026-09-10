import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../../core/api/endpoints.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../models/reports/report_response_model.dart';
import '../../network/reports_api.dart';
import 'reports_repo.dart';

class ReportsRepoImpl implements ReportsRepo {
  final ReportsApi api;
  final Dio dio;

  ReportsRepoImpl(this.api, this.dio);

  @override
  Future<Either<ErrorModel, BaseResponse<ReportsResponseModel>>> getReports({
    int? courseId,
  }) async {
    try {
      final response = await api.getReports(courseId: courseId);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, String>> downloadReport() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final savePath =
          '${dir.path}/report_${DateTime.now().millisecondsSinceEpoch}.pdf';

      await dio.download(
        '${AppConstants.baseUrl}${EndPoints.reportsDownload}',
        savePath,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      return Right(savePath);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }
}