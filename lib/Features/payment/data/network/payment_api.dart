import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/buy_course_params.dart';
import '../models/buy_lesson_params.dart';
import '../models/installment_params.dart';
import '../models/pay_installment_params.dart';
import '../models/payment_model.dart';
import '../models/installment_model.dart';

part 'payment_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class PaymentApi {
  factory PaymentApi(Dio dio, {String baseUrl}) = _PaymentApi;

  @GET(EndPoints.getPayments)
  Future<BaseResponse<PaymentModel>> getPayments();

  @GET(EndPoints.getInstallments)
  Future<BaseResponse<InstallmentRequestModel>> myInstallmentRequests();

  @POST(EndPoints.getInstallments)
  Future<BaseResponse> requestInstallment(@Body() InstallmentParams body);

  @POST(EndPoints.buyCourse + '/{id}')
  Future<BaseResponse> buyCourse(
    @Path('id') String method,
    @Body() BuyCourseParams body,
  );

  @POST(EndPoints.buyLesson + '/{id}')
  Future<BaseResponse> buyLesson(
    @Path('id') String id,
    @Body() BuylessonParams body,
  );

  @POST(EndPoints.buyInstallment + '/{id}')
  Future<BaseResponse> buyInstallment(
    @Path('id') String id,
    @Body() PayInstallmentParams body,
  );
}
