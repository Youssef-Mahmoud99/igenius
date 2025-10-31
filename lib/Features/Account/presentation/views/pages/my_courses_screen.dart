import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/widgets/primary_button.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../Courses/presentation/views/widgets/course_type.dart';

class MyCoursesScreen extends BaseStatelessWidget {
  MyCoursesScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> courses = [
    {
      'title': 'Advanced Mathematics',
      'status': 'Active',
      'statusColor': Color(0xFF4CAF50),
      'progress': 0.65,
      'progressText': '65%',
      'lessons': 24,
      'duration': '12 weeks',
      'color': Color(0xFF5B7FFF),
      'icon': Icons.calculate_outlined,
      'buttonText': 'Continue Learning',
      'buttonColor': Color(0xFF5B7FFF),
    },
    {
      'title': 'Physics Fundamentals',
      'status': 'Active',
      'statusColor': Color(0xFF4CAF50),
      'progress': 0.42,
      'progressText': '42%',
      'lessons': 18,
      'duration': '10 weeks',
      'color': Color(0xFF5B7FFF),
      'icon': Icons.bolt,
      'buttonText': 'Continue Learning',
      'buttonColor': Color(0xFF5B7FFF),
    },
    {
      'title': 'Organic Chemistry',
      'status': 'Inactive',
      'statusColor': Color(0xFFFF5722),
      'progress': 0.0,
      'progressText': '0%',
      'lessons': 20,
      'duration': '8 weeks',
      'color': Color(0xFF26A69A),
      'icon': Icons.science_outlined,
      'buttonText': 'Update Progress',
      'buttonColor': Color(0xFFFF9800),
    },
    {
      'title': 'Cell Biology',
      'status': 'Completed',
      'statusColor': Color(0xFF4CAF50),
      'progress': 1.0,
      'progressText': '100%',
      'lessons': 16,
      'duration': '6 weeks',
      'color': Color(0xFF26A69A),
      'icon': Icons.biotech_outlined,
      'buttonText': 'View Certificate',
      'buttonColor': Color(0xFF4CAF50),
    },
    {
      'title': 'English Literature',
      'status': 'Active',
      'statusColor': Color(0xFF4CAF50),
      'progress': 0.80,
      'progressText': '80%',
      'lessons': 22,
      'duration': '14 weeks',
      'color': Color(0xFF8E6BA8),
      'icon': Icons.menu_book_outlined,
      'buttonText': 'Continue Learning',
      'buttonColor': Color(0xFF5B7FFF),
    },
  ];
  final List<String> courseTypes = [
    'All Courses',
    'Active',
    'Completed',
    'Tracking',
  ];
  String selectedTab = 'All Courses';

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return CustomAppBar(
      showBack: true,
      centerTitle: false,
      titleChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Courses',
            style: AppsStyles.s14Bold.copyWith(color: Colors.black),
          ),
          Text(
            '5 Active • 2 Completed',
            style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, color: Colors.grey, size: 20.r),
        ),
      ],
    );
  }

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
                CourseType(courseTypes: courseTypes, onTypeSelected: (type) {}),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return _buildCourseCard(courses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Card(
      elevation: 4,
      shadowColor: Colors.grey.withOpacity(0.2),
      margin: EdgeInsets.only(bottom: 16.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Column(
        children: [
          // Header with icon
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: course['color'],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Icon(course['icon'], size: 60.sp, color: Colors.white),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(course['title'], style: AppsStyles.s14Bold),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: course['statusColor'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        course['status'],
                        style: AppsStyles.s12Bold.copyWith(
                          color: course['statusColor'],
                        ),
                      ),
                    ),
                  ],
                ),

                12.verticalSpace,

                // Progress bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: course['progress'],
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            course['color'],
                          ),
                          minHeight: 8.h,
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Text(course['progressText'], style: AppsStyles.s14Bold),
                  ],
                ),

                12.verticalSpace,

                // Course info
                Row(
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      size: 18.sp,
                      color: Colors.grey.shade600,
                    ),
                    6.horizontalSpace,
                    Text(
                      '${course['lessons']} Lessons',
                      style: AppsStyles.s12Regular.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    16.horizontalSpace,
                    Icon(
                      Icons.access_time,
                      size: 20.r,
                      color: Colors.grey.shade600,
                    ),
                    6.horizontalSpace,
                    Text(
                      course['duration'],
                      style: AppsStyles.s12Regular.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                16.verticalSpace,

                // Action button
                Appbutton(
                  height: 40.h,
                  borderRadius: 12,
                  text: course['buttonText'],
                  color: course['buttonColor'],
                  onPressed: () {
                    AppNavaigation.push(AppRoutes.courseDetails);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
