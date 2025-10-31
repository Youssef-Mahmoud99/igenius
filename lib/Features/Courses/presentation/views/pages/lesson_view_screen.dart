import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/course_material.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/base_gradient.dart';

class LessonViewScreen extends BaseStatelessWidget {
  LessonViewScreen({Key? key}) : super(key: key);
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
      titleChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unit 1: Number Systems',
            style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
          ),
          Text(
            'Introduction to Number Systems',
            style: AppsStyles.s14Bold.copyWith(color: Colors.black),
          ),
        ],
      ),
      showBack: true,
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: BaseGradient(
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
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.4),
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 4,
                        ),

                        shape: CircleBorder(),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: AppColors.primary,
                            size: 48.r,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Description', style: AppsStyles.s14Bold),
                          5.verticalSpace,
                          AppText(
                            text:
                                'Welcome to the first lesson on Number Systems! In this comprehensive introduction, we\'ll explore the fundamental concepts that form the foundation of mathematics. You will learn about different types of numbers including natural numbers, whole numbers, integers, rational numbers, and irrational numbers. We\'ll also cover how to identify and classify different number types and understand their real-world applications.',
                            style: AppsStyles.s12Regular.copyWith(
                              color: AppColors.grey,
                            ),
                            maxLines: 20,
                          ),

                          10.verticalSpace,
                          Text('Materials', style: AppsStyles.s14Bold),
                          10.verticalSpace,
                          Text('Lesson Slides', style: AppsStyles.s12Bold),
                          5.verticalSpace,
                          CourseMaterial(
                            title: 'Number Systems Slides.pdf',
                            subTitle: 'PDF • 2.4 MB',
                            backgroundColor: Color(0xffF0FDF4),
                            iconColor: AppColors.red,
                            leadingImage: AppImages.assignment,
                            trailingIcon: Icons.file_download_outlined,
                          ),
                          10.verticalSpace,
                          Text(
                            'Practice Worksheets',
                            style: AppsStyles.s12Bold,
                          ),
                          5.verticalSpace,
                          CourseMaterial(
                            title: 'Worksheet 1.docx',
                            subTitle: 'DOCX • 856 KB',
                            backgroundColor: AppColors.blue.withOpacity(0.1),
                            iconColor: AppColors.blue,
                            leadingImage: AppImages.assignment,
                            trailingIcon: Icons.file_download_outlined,
                          ),
                          10.verticalSpace,
                          CourseMaterial(
                            title: 'Worksheet 2.docx',
                            subTitle: 'DOCX • 856 KB',
                            backgroundColor: AppColors.blue.withOpacity(0.1),
                            iconColor: AppColors.blue,
                            leadingImage: AppImages.assignment,
                            trailingIcon: Icons.file_download_outlined,
                          ),

                          10.verticalSpace,
                          Text('Answer Keys', style: AppsStyles.s12Bold),
                          5.verticalSpace,
                          CourseMaterial(
                            title: 'Answer Key.pdf',
                            subTitle: 'PDF • 1.2 MB',
                            backgroundColor: AppColors.green.withOpacity(0.1),
                            iconColor: AppColors.green,
                            leadingIcon: Icons.check_circle_outline_rounded,
                            trailingIcon: Icons.file_download_outlined,
                          ),
                          10.verticalSpace,
                          Text(
                            'Additional Resources',
                            style: AppsStyles.s12Bold,
                          ),
                          5.verticalSpace,
                          CourseMaterial(
                            title: 'Study Guide.pdf',
                            subTitle: 'PDF • 3.2 MB',
                            backgroundColor: Colors.purple.withOpacity(0.1),
                            iconColor: Colors.purple,
                            leadingImage: AppImages.assignment,
                            trailingIcon: Icons.file_download_outlined,
                          ),
                        ],
                      ),
                    ),

                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
