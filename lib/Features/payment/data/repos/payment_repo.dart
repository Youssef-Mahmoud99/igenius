import 'package:dartz/dartz.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../../core/base/models/error_model.dart';
import '../models/buy_course_params.dart';
import '../models/buy_lesson_params.dart';
import '../models/installment_model.dart';
import '../models/installment_params.dart';
import '../models/pay_installment_params.dart';
import '../models/payment_model.dart';
import '../models/payment_response.dart';

abstract class PaymentRepo {
  Future<Either<ErrorModel, BaseResponse<PaymentModel>>> getPayments();

  Future<Either<ErrorModel, BaseResponse<InstallmentRequestModel>>>
      myInstallmentRequests();

  Future<Either<ErrorModel, BaseResponse>> requestInstallment(
      InstallmentParams params);

  Future<Either<ErrorModel, BaseResponse<PaymentResponseModel>>> buyCourse(
      BuyCourseParams params );

  Future<Either<ErrorModel, BaseResponse>> buyLesson(
      BuylessonParams params);

  Future<Either<ErrorModel, BaseResponse>> buyInstallment(
      PayInstallmentParams params );
}