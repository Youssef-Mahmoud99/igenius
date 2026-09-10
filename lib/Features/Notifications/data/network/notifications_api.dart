import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/api/endpoints.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/base/models/base_response.dart';
import '../models/notifications_model.dart';

part 'notifications_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class NotificationsApi {
  factory NotificationsApi(Dio dio, {String baseUrl}) = _NotificationsApi;

  @GET(EndPoints.notifications)
  Future<BaseResponse<List<NotificationModel>>> getNotifications({
    @Query('unread_only') int unreadOnly = 0,
    @Query('per_page') int perPage = 20,
    @Query('page') int page = 1,
  });

  @PATCH(EndPoints.notificationReadPath)
  Future<BaseResponse> markAsRead(@Path('id') int id);

  @DELETE(EndPoints.notificationDeletePath)
  Future<BaseResponse> deleteNotification(@Path('id') int id);
}