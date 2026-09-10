import 'package:flutter/foundation.dart';
import '../../../../../core/base/cubit/base_cubit.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../data/models/notifications_model.dart';
import '../../data/repos/notifications_repo.dart';

enum NotificationsFilter { all, unread, read }

class GetNotificationsCubit
    extends BaseCubit<BaseResponse<List<NotificationModel>>> {
  final NotificationsRepo repo;

  GetNotificationsCubit(this.repo);

  static const int _perPage = 20;

  int _page = 1;
  NotificationsFilter filter = NotificationsFilter.all;

  final List<NotificationModel> allNotifications = [];

  bool hasMore = true;
  bool isLoadingMore = false;

  // ⬅️ العداد بقى معتمد على ValueNotifier، مش field عادي بس
  final ValueNotifier<int> unreadCountNotifier = ValueNotifier<int>(0);
  int get unreadCount => unreadCountNotifier.value;

  int _requestId = 0;

  Future<void> getNotifications({bool isRefresh = false}) async {
    final int currentRequestId = ++_requestId;

    if (isRefresh || _page == 1) {
      _page = 1;
      allNotifications.clear();
      hasMore = true;
    }

    final int unreadOnly = filter == NotificationsFilter.unread ? 1 : 0;

    await execute(
      params: null,
      useCase: (_) => repo.getNotifications(
        unreadOnly: unreadOnly,
        perPage: _perPage,
        page: _page,
      ),
      requestMethod: 'GET',
      errorMessageExtractor: (failure) => failure.allErrorMessages,
      successMessageExtractor: (response) => response.message,
    );

    if (currentRequestId != _requestId) return;

    final currentState = state;
    if (currentState is SuccessState<BaseResponse<List<NotificationModel>>>) {
      final response = currentState.data;
      final fetched = response.data ?? [];

      hasMore = fetched.length == _perPage;

      var newNotifications = fetched;

      if (filter == NotificationsFilter.read) {
        newNotifications =
            newNotifications.where((n) => n.isRead == true).toList();
      }

      allNotifications.addAll(newNotifications);

      // ⬅️ ده اللي بيضمن الـ rebuild فعليًا
      unreadCountNotifier.value = _recalculateUnreadLocally();
    }
  }

  int _recalculateUnreadLocally() {
    return allNotifications.where((n) => n.isRead == false).length;
  }

  Future<void> loadMoreNotifications() async {
    if (isLoadingMore || !hasMore) return;
    isLoadingMore = true;
    _page += 1;
    await getNotifications();
    isLoadingMore = false;
  }

  void changeFilter(NotificationsFilter newFilter) {
    if (filter == newFilter) return;
    filter = newFilter;
    getNotifications(isRefresh: true);
  }

  void markAllAsReadLocally() {
    for (var i = 0; i < allNotifications.length; i++) {
      allNotifications[i] =
          allNotifications[i].copyWith(isRead: true) as NotificationModel;
    }
    unreadCountNotifier.value = 0; // ⬅️ بدل الـ emit اليدوي القديم
  }

  @override
  Future<void> close() {
    unreadCountNotifier.dispose();
    return super.close();
  }
}