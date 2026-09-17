import 'package:dartz/dartz.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../../core/base/models/base_response.dart';
import '../../models/schedule/overdue_model.dart';
import '../../models/schedule/upcoming_model.dart';

abstract class ScheduleRepo {
  Future<Either<ErrorModel, BaseResponse<UpcomingModel>>> getUpcomings();
  Future<Either<ErrorModel, BaseResponse<OverdueModel>>> getOverdues();
}
