
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/Features/Account/data/models/schedule/upcoming_model.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../../core/base/models/base_response.dart';
import '../../models/schedule/overdue_model.dart';
import '../../network/schedule/schedule_api.dart';
import 'schedule_repo.dart';

class ScheduleRepoImpl implements ScheduleRepo {
  final ScheduleApi api;

  ScheduleRepoImpl(this.api,);

  @override
  Future<Either<ErrorModel, BaseResponse<UpcomingModel>>> getUpcomings({
    int? courseId,
  }) async {
    try {
      final response = await api.getUpcomings();
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }
  @override
  Future<Either<ErrorModel, BaseResponse<OverdueModel>>> getOverdues({
    int? courseId,
  }) async {
    try {
      final response = await api.getOverdues();
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }

}