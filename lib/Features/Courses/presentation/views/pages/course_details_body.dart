import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../app.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../../core/widgets/custom_listtile.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../data/models/course_details.dart';
import '../widgets/course_content.dart';
import '../widgets/enroll_to_course_dialoge.dart';
import '../widgets/free_session_dialoge.dart';

class CourseDetailsBody extends StatelessWidget {
  CourseDetailsBody({
    Key? key,
    required this.courseDetails,
    required this.isBought,
  }) : super(key: key);
  final CourseDetails courseDetails;
  final bool isBought;

  List<Map<String, dynamic>> courseOtherDetails = [
    {
      'title': 'Lessons',
      'icon': Icons.menu_book,
      "color": Colors.blue,
      'bacgroundColor': Color(0xffFDF2F8),
    },
    {
      'title': 'Duration',
      'icon': Icons.access_time_rounded,
      "color": Colors.red[900],
      'bacgroundColor': Color(0xffFDF2F8),
    },
  ];

  List<String> whatWillYouLearn = [
    'Master all IGCSE Mathematics topics with confidence',

    'Solve complex problems using proven techniques',

    'Practice with real exam-style questions',

    'Receive personalized feedback from expert teachers',
  ];
  String getCourseStatistics(CourseDetails courseDetails, int index) {
    if (index == 0) {
      return courseDetails.totalLessons?.toString() ?? '';
    }
    if (index == 1) {
      return courseDetails.durationWeeks?.toString() ?? '' + ' weeks';
    } else {
      return courseDetails.hasInstallmentPlan == true ? 'Yes' : 'No';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,

                      end: Alignment.bottomRight,

                      colors: [
                        AppColors.buttonGradient1,

                        AppColors.buttonGradient2,
                      ],
                    ),
                  ),

                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,

                    vertical: 50,
                  ),

                  width: double.infinity,

                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.graduationCap,

                        color: AppColors.white,

                        size: 45.r,
                      ),

                      20.verticalSpace,

                      AppText(
                        text: courseDetails.subject?.name ?? '',

                        style: AppsStyles.s24Bold.copyWith(
                          color: AppColors.white,
                        ),
                      ),

                      10.verticalSpace,

                      AppText(
                        textAlign: TextAlign.center,

                        text: courseDetails.title ?? '',

                        style: AppsStyles.s14Regular.copyWith(
                          color: AppColors.greyLight,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(20.0),

                  width: double.infinity,

                  color: Colors.white,

                  child: Column(
                    children: [
                      // courseStatistics(),
                      10.verticalSpace,

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          ...courseOtherDetails.map(
                            (item) => detailsCard(
                              item['icon'],

                              item['title'],
                              getCourseStatistics(
                                courseDetails,
                                courseOtherDetails.indexOf(item),
                              ),

                              item['color'],

                              item['bacgroundColor'],
                            ),
                          ),
                        ],
                      ),

                      10.verticalSpace,

                      teacherTile(courseDetails),

                      10.verticalSpace,

                      GradientButton(
                        gradientColors: [Color(0xFFEF4444), Color(0xFFEC4899)],

                        height: 40.h,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Container(
                              width: 8.w,

                              height: 8.h,

                              decoration: BoxDecoration(
                                color: Colors.white,

                                shape: BoxShape.circle,
                              ),
                            ),

                            5.horizontalSpace,

                            Text(
                              'Join Free Live Session',

                              style: AppsStyles.s14Bold.copyWith(
                                color: AppColors.white,
                              ),
                            ),

                            10.horizontalSpace,

                            Icon(
                              Icons.play_circle_outline_sharp,

                              color: AppColors.white,

                              size: 20.r,
                            ),
                          ],
                        ),

                        onTap: () {
                          showFreeSessionBottomSheet(context, courseDetails);
                        },
                      ),
                    ],
                  ),
                ),

                10.verticalSpace,

                Container(
                  padding: const EdgeInsets.all(20.0),

                  width: double.infinity,

                  color: Colors.white,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('About This Course', style: AppsStyles.s14Bold),

                      5.verticalSpace,

                      AppText(
                        text: courseDetails.description ?? '',
                        style: AppsStyles.s12Regular.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                10.verticalSpace,

                Container(
                  padding: EdgeInsets.all(20),

                  width: double.infinity,

                  color: Colors.white,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Course Content', style: AppsStyles.s14Bold),

                      10.verticalSpace,

                      CourseContent(courseDetails: courseDetails),
                    ],
                  ),
                ),

                10.verticalSpace,

                Container(
                  width: double.infinity,

                  color: Colors.white,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,

                          vertical: 10,
                        ),

                        child: Text(
                          'What Will You Learn',

                          style: AppsStyles.s14Bold,
                        ),
                      ),

                      ...whatWillYouLearn.map(
                        (item) => CustomListTile2(
                          leading: Icon(
                            Icons.check_circle_outline,

                            color: Colors.green,

                            size: 20,
                          ),

                          title: Padding(
                            padding: const EdgeInsets.only(
                              left: 5.0,

                              right: 30.0,
                            ),

                            child: Text(item, style: AppsStyles.s12Regular),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                30.verticalSpace,
              ],
            ),
          ),
        ),

        !isBought
            ? Container(
              color: Colors.white,

              padding: EdgeInsets.all(20.0),

              child: Row(
                children: [
                  priceandDiscount(courseDetails),

                  10.horizontalSpace,

                  Expanded(
                    child: GradientButton(
                      text: 'Enroll Now',

                      onTap: () {
                        print(
                          "hasInstallments: ${courseDetails.hasInstallmentPlan}",
                        );
                        if (currentUser?.parentEmail != null) {
                          ToastHelper.showWarning(
                            "Please login to enroll in this course",
                          );

                          return;
                        }

                        showEnrollToCourseBottomSheet(context, courseDetails);
                      },

                      height: 50,
                    ),
                  ),
                ],
              ),
            )
            : SizedBox.shrink(),
      ],
    );
  }

  Widget teacherTile(CourseDetails courseDetails) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),

      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),

        color: AppColors.borderGrey.withOpacity(0.5),

        child: ListTile(
          contentPadding: EdgeInsets.zero,

          leading: Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              shape: BoxShape.circle,

              gradient: LinearGradient(
                begin: Alignment.topLeft,

                end: Alignment.bottomRight,

                colors: [AppColors.buttonGradient1, AppColors.buttonGradient2],
              ),
            ),

            child: Text(
              'DR',

              style: AppsStyles.s16Bold.copyWith(color: Colors.white),
            ),
          ),

          title: Text(
            courseDetails.teacher?.name ?? '',
            style: AppsStyles.s12Bold,
          ),

          subtitle: Text(
            courseDetails.teacher?.description ?? '',

            style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
          ),

          trailing: SizedBox(
            width: 60.w,

            height: 30.h,

            child: Appbutton(
              borderColor: AppColors.secondary,

              needBorder: true,

              color: AppColors.white,

              textStyle: AppsStyles.s12Bold.copyWith(
                color: AppColors.secondary,
              ),

              text: "View",

              onPressed: () {
                AppNavaigation.pushToPageWithParams(AppRoutes.teacherProfile, {
                  'teacherId': courseDetails.teacher?.id ?? 0,
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget details(String data, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.grey, size: 15.r),

        5.horizontalSpace,

        Text(
          data,

          style: AppsStyles.s10Regular.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }

  Widget priceandDiscount(CourseDetails courseDetails) {
    return Column(
      children:
          courseDetails.priceAfterDiscount == null
              ? [
                Text(
                  '\$${courseDetails.price}',

                  style: AppsStyles.s18Bold.copyWith(color: AppColors.primary),
                ),
              ]
              : [
                Text(
                  '\$${courseDetails.price}',

                  style: AppsStyles.s12Regular.copyWith(
                    color: AppColors.grey,

                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Text(
                  '\$${courseDetails.priceAfterDiscount}',

                  style: AppsStyles.s18Bold.copyWith(color: AppColors.primary),
                ),
              ],
    );
  }

  Widget detailsCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
    Color backgroundColor,
  ) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 90.w,
        height: 100.h,
        color: backgroundColor,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20.r),
            5.verticalSpace,
            Text(
              title,
              style: AppsStyles.s10Regular.copyWith(color: AppColors.grey),
            ),
            5.verticalSpace,
            Text(subtitle, style: AppsStyles.s16Bold),
          ],
        ),
      ),
    );
  }
}
