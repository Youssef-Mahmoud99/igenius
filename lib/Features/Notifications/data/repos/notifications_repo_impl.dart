import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:igenius/core/base/models/error_model.dart';

import '../../../../core/base/models/base_response.dart';
import '../models/notifications_model.dart';
import '../network/notifications_api.dart';
import 'notifications_repo.dart';

class NotificationsRepoImpl implements NotificationsRepo {
  final NotificationsApi api;

  NotificationsRepoImpl(this.api);

  @override
  Future<Either<ErrorModel, BaseResponse<List<NotificationModel>>>> getNotifications({
    int unreadOnly = 0,
    int perPage = 20,
    int page = 1,
  }) async {
    try {
      final response = await api.getNotifications(
        unreadOnly: unreadOnly,
        perPage: perPage,
        page: page,
      );
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse>> markAsRead(int id) async {
    try {
      final response = await api.markAsRead(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, BaseResponse>> deleteNotification(int id) async {
    try {
      final response = await api.deleteNotification(id);
      return Right(response);
    } on DioException catch (e) {
      return Left(ErrorModel.fromJson(e.response?.data ?? {}));
    } catch (e) {
      return Left(ErrorModel(success: false, message: e.toString()));
    }
  }
}