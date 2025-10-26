import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/Features/Notifications/data/models/notifications_model.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';

class NofificationCard extends StatelessWidget {
  NofificationCard({super.key, required this.notification});
  final NotificationsModel notification;
  IconData chooseWhichIcon(String notificationType) {
    if (notificationType == "Assignment Due Soon") {
      return Icons.warning_amber_rounded;
    } else if (notificationType == "New Lesson Available") {
      return FontAwesomeIcons.video;
    } else if (notificationType == "Exam Reminder") {
      return Icons.fact_check_rounded;
    } else if (notificationType == "Assignment Graded") {
      return Icons.check_circle_outline_sharp;
    } else if (notificationType == "Overdue Assignment") {
      return Icons.info_outline_rounded;
    } else {
      return FontAwesomeIcons.video;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border(left: BorderSide(color: notification.color, width: 4.w)),
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
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: notification.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              chooseWhichIcon(notification.title),
              color: notification.color,
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
                    Text(notification.title, style: AppsStyles.s14Bold),
                    const Spacer(),
                    Icon(Icons.circle, color: notification.color, size: 10),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  notification.message,
                  style: AppsStyles.s12Regular.copyWith(color: Colors.black87),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notification.subject,
                      style: AppsStyles.s12Regular.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                    Text(
                      notification.time,
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
    );
  }
}
