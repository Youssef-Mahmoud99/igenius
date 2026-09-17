import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/core/base/models/error_model.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../models/support/support_model.dart';
import '../../network/support/support_api.dart';
import 'support_repo.dart';

class SupportRepoImpl implements SupportRepo {
  final SupportApi api;

  SupportRepoImpl(this.api);

  @override
  Future<Either<ErrorModel, BaseResponse<List<SupportTicketModel>>>> getSupportTickets({
    int perPage = 20,
  }) async {
    try {
      final response = await api.getSupportTickets(perPage: perPage);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse>> createSupportTicket(
    String message,
  ) async {
    try {
      final response = await api.createSupportTicket(message);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }
}