import 'package:flutter/material.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_text_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../Courses/presentation/views/widgets/course_type.dart';
import '../../../data/models/notifications_model.dart';
import '../widgets/nofification_card.dart';

class NotificationsScreen extends BaseStatelessWidget {
  NotificationsScreen({super.key});
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Assignment Due Soon',
      'message':
          'Your Number Systems Assignment is due in 2 days. Make sure to submit before Oct 25, 2025.',
      'subject': 'Advanced Mathematics',
      'time': '2 hours ago',
      'color': Colors.redAccent,
    },
    {
      'title': 'New Lesson Available',
      'message':
          'A new lesson "Quadratic Equations" has been added to your course.',
      'subject': 'Advanced Mathematics',
      'time': '5 hours ago',
      'color': Colors.blueAccent,
    },
    {
      'title': 'Exam Reminder',
      'message':
          'Unit 2 exam is scheduled for tomorrow at 10:00 AM. Good luck!',
      'subject': 'Mathematics',
      'time': '1 day ago',
      'color': Colors.orangeAccent,
    },
    {
      'title': 'Assignment Graded',
      'message':
          'Your Exercise 4 has been graded. You scored 85/100. Great job!',
      'subject': 'Artificial Intelligence',
      'time': '2 days ago',
      'color': Colors.green,
    },
    {
      'title': 'Overdue Assignment',
      'message':
          'You have missed the deadline for Practice Worksheet 2. Please contact your instructor.',
      'subject': 'Chemistry',
      'time': '3 days ago',
      'color': Colors.redAccent,
    },
  ];

  final List<String> notificationTypes = [
    'All',
    'Warnings',
    'Sessions',
    'Grades',
  ];
  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: 10.rPadding,
            color: AppColors.white,
            child: Column(
              children: [
                notificationFakeAppBar(),
                CourseType(
                  courseTypes: notificationTypes,
                  onTypeSelected: (type) {},
                ),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return NofificationCard(
                    notification: NotificationsModel(
                      color: notifications[index]['color'],
                      title: notifications[index]['title'],
                      message: notifications[index]['message'],
                      subject: notifications[index]['subject'],
                      time: notifications[index]['time'],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationFakeAppBar() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        onPressed: () {
          AppNavaigation.pop();
        },
        icon: Icon(Icons.arrow_back_ios),
        color: Colors.grey,
      ),
      title: Text('Notifications', style: AppsStyles.s16Bold),
      subtitle: Text(
        '5 unread',
        style: AppsStyles.s12Regular.copyWith(color: Colors.grey),
      ),
      trailing: CustomTextButton(
        fontWeight: FontWeight.bold,
        text: 'Mark all as read',
        color: AppColors.primary,
        onPressed: () {},
      ),
    );
  }
}
