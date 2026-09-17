import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/api/endpoints.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../models/reports/report_response_model.dart';
part 'reports_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class ReportsApi {
  factory ReportsApi(Dio dio, {String baseUrl}) = _ReportsApi;

  @GET(EndPoints.reportsDownload)
  @DioResponseType(ResponseType.bytes)
  Future<HttpResponse<List<int>>> downloadReport({
    @Query('course_id') int? courseId,
    @Query('type') String type = 'full',
    @Query('from') String from = '',
    @Query('to') String to = '',
  });
}