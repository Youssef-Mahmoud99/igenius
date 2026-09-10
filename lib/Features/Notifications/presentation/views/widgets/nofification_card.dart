import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/Features/Notifications/data/models/notifications_model.dart';
import 'package:igenius/Features/Notifications/presentation/cubits/delete_notification_cubit.dart';
import 'package:igenius/core/base/cubit/base_state.dart';
import 'package:igenius/core/base/models/base_response.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../cubits/mark_as_read_cubit.dart';
import '../../cubits/notifications_cubit.dart';

class NofificationCard extends StatelessWidget {
  NofificationCard({super.key, required this.notification});
  final NotificationModel notification;

  IconData chooseWhichIcon(NotificationModel notification) {
    if (notification.assignmentId != null) {
      return Icons.warning_amber_rounded;
    } else if (notification.lessonId != null) {
      return FontAwesomeIcons.video;
    } else if (notification.examId != null) {
      return Icons.fact_check_rounded;
    } else {
      return Icons.info_outline_rounded;
    }
  }

  // دايلوج تأكيد الحذف
  Future<bool> _confirmDeleteDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Confirm deletion'),
            content: const Text(
              'Are you sure you want to delete this notification?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MarkNotificationAsReadCubit, BaseCubitState>(
          listener: (context, state) {
            if (state is SuccessState<BaseResponse>) {
              context.read<GetNotificationsCubit>().getNotifications();
              ToastHelper.showSuccess('Notification marked as read');
            } else if (state is ErrorState) {}
          },
        ),

        BlocListener<DeleteNotificationCubit, BaseCubitState>(
          listener: (context, state) {
            if (state is SuccessState<BaseResponse>) {
              context.read<GetNotificationsCubit>().getNotifications();
              ToastHelper.showSuccess('Notification deleted');
            } else if (state is ErrorState) {}
          },
        ),
      ],
      child: Dismissible(
        key: ValueKey(notification.id),
        direction: DismissDirection.endToStart,
        // مفيش خلفية حمراء، بس الـ confirmDismiss لسه شغال
        background: const SizedBox.shrink(),
        confirmDismiss: (direction) async {
          final confirmed = await _confirmDeleteDialog(context);
          if (!confirmed) return false;

          final deleteCubit = context.read<DeleteNotificationCubit>();
          await deleteCubit.deleteNotification(notification.id!, context);
          return true;
        },
        child: GestureDetector(
          onTap: () {
            // if (notification.examId != null) {
            //   AppNavaigation.pushToPageWithParams(AppRoutes.assignmentViewScreen, extra: notification.examId);
            // }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEA),
              borderRadius: BorderRadius.circular(12.r),
              border: Border(
                left: BorderSide(
                  color:
                      notification.isRead
                          ? Colors.transparent
                          : AppColors.buttonGradient2,
                  width: 4,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.buttonGradient1.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    chooseWhichIcon(notification),
                    color: AppColors.buttonGradient1,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title ?? "",
                              style: AppsStyles.s12Bold,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (!notification.isRead)
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {
                                context
                                    .read<MarkNotificationAsReadCubit>()
                                    .markAsRead(notification.id!, context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.check_circle_outline,
                                  color: AppColors.blue,
                                  size: 18,
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        notification.body ?? "",
                        // overflow: TextOverflow.ellipsis,
                        style: AppsStyles.s12Regular.copyWith(
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notification.status ?? "",
                            style: AppsStyles.s12Regular.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                          Text(
                            notification.createdAt ?? "",
                            style: AppsStyles.s12Regular.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
