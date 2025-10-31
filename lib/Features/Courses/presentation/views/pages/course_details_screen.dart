import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/core/constants/app_routes.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_listtile.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/gradient_button.dart';
import 'package:igenius/core/widgets/primary_button.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/helper_methods.dart';
import '../../../../../core/widgets/dialogs/custom_dialoge.dart';
import '../widgets/course_content.dart';
import '../widgets/enroll_to_course_dialoge.dart';
import '../widgets/free_session_dialoge.dart';

class CourseDetailsScreen extends BaseStatelessWidget {
  CourseDetailsScreen({Key? key}) : super(key: key);
  List<Map<String, dynamic>> courseDetails = [
    {
      'title': 'Lessons',
      'data': '48',
      'icon': Icons.menu_book,
      "color": Colors.blue,
      'bacgroundColor': Color(0xffFDF2F8),
    },
    {
      'title': 'Duration',
      'data': '24 Weeks',
      'icon': Icons.access_time_rounded,
      "color": Colors.red[900],
      'bacgroundColor': Color(0xffFDF2F8),
    },
    {
      'title': 'Certificate',
      'data': 'Yes',
      'icon': Icons.verified_outlined,
      "color": Colors.green,
      'bacgroundColor': Color(0xffFDF2F8),
    },
  ];

  List<String> whatWillYouLearn = [
    'Master all IGCSE Mathematics topics with confidence',
    'Solve complex problems using proven techniques',
    'Practice with real exam-style questions',
    'Receive personalized feedback from expert teachers',
  ];
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: false,
      title: 'Course Details',
      showBack: true,
      actions: [
        IconButton(
          onPressed: () {
            HelperMethods.shareText('Share this course details');
          },
          icon: Icon(Icons.share, color: AppColors.black, size: 20.r),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
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
                          text: 'Advanced Mathematics',
                          style: AppsStyles.s24Bold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        10.verticalSpace,
                        AppText(
                          textAlign: TextAlign.center,
                          text: 'IGCSE Completed Course',
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
                        courseStatistics(),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ...courseDetails.map(
                              (item) => detailsCard(
                                item['icon'],
                                item['title'],
                                item['data'],
                                item["color"],
                                item['bacgroundColor'],
                              ),
                            ),
                          ],
                        ),
                        10.verticalSpace,
                        teacherTile(),
                        10.verticalSpace,
                        GradientButton(
                          gradientColors: [
                            Color(0xFFEF4444),
                            Color(0xFFEC4899),
                          ],
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
                            showFreeSessionBottomSheet(context);
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
                          text:
                              'Master IGCSE Mathematics with ourcomprehensive course covering all essential topics.From algebra and geometry to calculus and statistics, gain the skills and confidence needed to excel in your exams.',
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
                        CourseContent(),
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

          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                priceandDiscount(),
                10.horizontalSpace,
                Expanded(
                  child: GradientButton(
                    text: 'Enroll Now',
                    onTap: () {
                      showEnrollToCourseBottomSheet(context);
                    },
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget teacherTile() {
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
          title: Text("Dr. Robert Williams", style: AppsStyles.s12Bold),
          subtitle: Text(
            "Mathematics Expert • 15+ years",
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
                AppNavaigation.push(AppRoutes.teacherProfile);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget courseStatistics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rating(),
        10.horizontalSpace,
        details("1.247 Students", Icons.groups_sharp),
      ],
    );
  }

  Widget rating() {
    return Row(
      children: [
        Icon(Icons.star, color: Color(0xFFFBBF24), size: 18),
        5.horizontalSpace,
        Text("4.9", style: AppsStyles.s12Regular),
        5.horizontalSpace,
        Text(
          "(234 reviews)",
          style: AppsStyles.s10Regular.copyWith(color: AppColors.grey),
        ),
      ],
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

  Widget priceandDiscount() {
    return Column(
      children: [
        Text(
          '\$299',
          style: AppsStyles.s12Regular.copyWith(
            color: AppColors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        Text(
          '\$199',
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
