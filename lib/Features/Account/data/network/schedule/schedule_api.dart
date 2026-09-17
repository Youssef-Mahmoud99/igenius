import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/api/endpoints.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../models/schedule/overdue_model.dart';
import '../../models/schedule/upcoming_model.dart';
part 'schedule_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ScheduleApi {
  factory ScheduleApi(Dio dio, {String baseUrl}) = _ScheduleApi;

  @GET(EndPoints.overdues)
  Future<BaseResponse<OverdueModel>> getOverdues();
  @GET(EndPoints.upcomings)
  Future<BaseResponse<UpcomingModel>> getUpcomings();
}
