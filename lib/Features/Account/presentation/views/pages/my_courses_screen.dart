import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/widgets/primary_button.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../../../../Courses/presentation/cubits/my_courses/my_courses_cubit.dart';
import '../../../../Courses/presentation/views/widgets/course_type.dart';
import '../../../../Courses/data/models/courses_body.dart';
import '../../../../Courses/data/models/courses_model.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../Notifications/presentation/views/widgets/notification_type.dart';
import '../../../data/models/my_course_model.dart';

class MyCoursesScreen extends StatefulWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  State<MyCoursesScreen> createState() => _MyCoursesScreenState();
}

class _MyCoursesScreenState extends State<MyCoursesScreen> {
  final List<String> courseTypes = [
    'All Courses',
    'Active',
    'Completed',
    'Tracking',
  ];
  String selectedTab = 'All Courses';

  @override
  void initState() {
    super.initState();
    context.read<MyCoursesCubit>().getMyCourses(CoursesBody(
      perPage:  10,
      page: 1
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: 10.rPadding,
              color: AppColors.white,
              child: Column(
                children: [
                  CustomType(
                    selectedType: "All Courses",
                    CustomTypes:  courseTypes,
                    onTypeSelected: (type) {
                      setState(() => selectedTab = type!);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<MyCoursesCubit, BaseCubitState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ErrorState) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: Text(
                          state.message ?? 'حدث خطأ ما',
                          textAlign: TextAlign.center,
                          style: AppsStyles.s14Bold.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    );
                  }

                  if (state is SuccessState) {
                    final courses =
                        (state.data?.data ?? <MyCourseModel>[])
                            as List<MyCourseModel>;

                    if (courses.isEmpty) {
                      return _buildEmptyState();
                    }

                    return ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return _buildCourseCard(courses[index]);
                      },
                    );
                  }

                  // InitialState
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 80.sp,
              color: Colors.grey.shade400,
            ),
            16.verticalSpace,
            Text(
              "No courses available",
              style: AppsStyles.s14Bold.copyWith(color: Colors.grey.shade600),
            ),
            8.verticalSpace,
            Text(
              'The courses you are enrolled in will appear here',
              textAlign: TextAlign.center,
              style: AppsStyles.s12Regular.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(MyCourseModel course) {
    final color = _statusColor(
      course.isCompleted ?? false ? 'Completed' : 'Active',
    );
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
            image: course.course?.image != null ? DecorationImage(
              image: NetworkImage(course.course?.image ?? ''),
              fit: BoxFit.cover,
            ) : null,
              color: AppColors.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: course.course?.image != null ? null : Center(
              child: Icon(Icons.menu_book, size: 45.sp, color: Colors.white),
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
                      child: Text(
                        course.course?.title ?? '',
                        style: AppsStyles.s14Bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        course.isCompleted ?? false ? 'Completed' : 'Active',
                        style: AppsStyles.s12Bold.copyWith(color: color),
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
                          value: (course.progressPercentage ?? 0) / 100,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 8.h,
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Text(
                      '${course.progressPercentage ?? 0}%',
                      style: AppsStyles.s14Bold,
                    ),
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
                      '${course.course?.totalLessons ?? 0} Lessons',
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
                      course.course?.durationWeeks.toString() ?? "",
                      style: AppsStyles.s12Regular.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),

                16.verticalSpace,

                // Action button
                GradientButton(
                  height: 40.h,
                  text: 'Continue Learning',
                  onTap: () {
                    AppNavaigation.pushToPageWithParams(
                      AppRoutes.courseDetails,
                      {"courseId": course.course?.id, 
                        "isBought": true,
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'Completed':
        return Colors.orange;
      default:
        return AppColors.buttonGradient1;
    }
  }
}
