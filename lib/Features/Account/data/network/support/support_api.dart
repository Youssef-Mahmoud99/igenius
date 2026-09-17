import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/api/endpoints.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../models/support/support_model.dart';

part 'support_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class SupportApi {
  factory SupportApi(Dio dio, {String baseUrl}) = _SupportApi;

  @GET(EndPoints.support)
  Future<BaseResponse<List<SupportTicketModel>>> getSupportTickets({
    @Query('per_page') int perPage = 20,
  });

  @FormUrlEncoded()
  @POST(EndPoints.support)
  Future<BaseResponse> createSupportTicket(
    @Field('message') String message,
  );
}