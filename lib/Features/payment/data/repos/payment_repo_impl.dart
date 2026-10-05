import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/base/models/base_response.dart';
import '../../../../core/base/models/error_model.dart';
import '../models/buy_course_params.dart';
import '../models/buy_lesson_params.dart';
import '../models/installment_model.dart';
import '../models/installment_params.dart';
import '../models/pay_installment_params.dart';
import '../models/payment_model.dart';
import '../models/payment_response.dart';
import '../network/payment_api.dart';
import 'payment_repo.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentApi paymentApi;

  PaymentRepoImpl(this.paymentApi);

  @override
  Future<Either<ErrorModel, BaseResponse<PaymentModel>>> getPayments() async {
    try {
      final response = await paymentApi.getPayments();
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(
        ErrorModel(
          success: false,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse<InstallmentRequestModel>>>
      myInstallmentRequests() async {
    try {
      final response = await paymentApi.myInstallmentRequests();
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(
        ErrorModel(
          success: false,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse>> requestInstallment(
      InstallmentParams params) async {
    try {
      final response = await paymentApi.requestInstallment(params);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(
        ErrorModel(
          success: false,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse<PaymentResponseModel>>> buyCourse(
      BuyCourseParams params ) async {
    try {
      final response = await paymentApi.buyCourse(params.id.toString() , params);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(
        ErrorModel(
          success: false,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse>> buyLesson(
      BuylessonParams params ) async {
    try {
      final response = await paymentApi.buyLesson(params.id.toString() , params);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(
        ErrorModel(
          success: false,
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse>> buyInstallment(
      PayInstallmentParams params) async {
    try {
      final response = await paymentApi.buyInstallment(params.id.toString() , params);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(
        ErrorModel(
          success: false,
          message: e.toString(),
        ),
      );
    }
  }
}