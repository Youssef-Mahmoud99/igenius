import 'package:dartz/dartz.dart';
import 'package:igenius/core/base/models/error_model.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/notifications_model.dart';

abstract class NotificationsRepo {
  Future<Either<ErrorModel, BaseResponse<List<NotificationModel>>>> getNotifications({
    int unreadOnly = 0,
    int perPage = 20,
    int page = 1,
  });

  Future<Either<ErrorModel, BaseResponse>> markAsRead(int id);

  Future<Either<ErrorModel, BaseResponse>> deleteNotification(int id);
}