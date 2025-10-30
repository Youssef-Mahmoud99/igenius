import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_listtile.dart';
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
            style: AppsStyles.s12Light.copyWith(color: AppColors.grey),
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

                  BaseGradient(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Description', style: AppsStyles.s16Bold),
                          5.verticalSpace,
                          AppText(
                            text:
                                'Welcome to the first lesson on Number Systems! In this comprehensive introduction, we\'ll explore the fundamental concepts that form the foundation of mathematics. You will learn about different types of numbers including natural numbers, whole numbers, integers, rational numbers, and irrational numbers. We\'ll also cover how to identify and classify different number types and understand their real-world applications.',
                            style: AppsStyles.s14Regular.copyWith(
                              color: AppColors.grey,
                            ),
                            maxLines: 20,
                          ),
                        ],
                      ),
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
                        Text('Materials', style: AppsStyles.s16Bold),
                        10.verticalSpace,
                        Text('Lesson Slides', style: AppsStyles.s14Regular),
                        5.verticalSpace,
                        materialDisplay(
                          FontAwesomeIcons.file,
                          Icons.download,
                          'Number Systems Slides.pdf',
                          'PDF • 2.4 MB',
                          Color(0xffF0FDF4),
                          AppColors.red,
                        ),
                        10.verticalSpace,
                        Text(
                          'Practice Worksheets',
                          style: AppsStyles.s14Regular,
                        ),
                        5.verticalSpace,
                        materialDisplay(
                          FontAwesomeIcons.fileWord,
                          Icons.download,
                          'Worksheet 1.docx',
                          'DOCX • 856 KB',
                          AppColors.blue.withOpacity(0.1),
                          AppColors.blue,
                        ),
                        5.verticalSpace,
                        materialDisplay(
                          FontAwesomeIcons.fileWord,
                          Icons.download,
                          'Worksheet 2.docx',
                          'DOCX • 856 KB',
                          AppColors.blue.withOpacity(0.1),
                          AppColors.blue,
                        ),

                        10.verticalSpace,
                        Text('Answer Keys', style: AppsStyles.s14Regular),
                        5.verticalSpace,
                        materialDisplay(
                          Icons.check_circle_outline_rounded,
                          Icons.download,
                          'Answer Key.pdf',
                          'PDF • 1.2 MB',
                          AppColors.green.withOpacity(0.1),
                          AppColors.green,
                        ),
                        10.verticalSpace,
                        Text(
                          'Additional Resources',
                          style: AppsStyles.s14Regular,
                        ),
                        5.verticalSpace,
                        materialDisplay(
                          FontAwesomeIcons.file,
                          Icons.download,
                          'Study Guide.pdf',
                          'PDF • 3.2 MB',
                          Colors.purple.withOpacity(0.1),
                          Colors.purple,
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
    );
  }

  Widget materialDisplay(
    IconData leadingIcon,
    IconData trailingIcon,
    String title,
    String subTitle,
    Color backgroundColor,
    Color iconColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CustomListTile2(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: backgroundColor,

              padding: EdgeInsets.all(10),
              child: Icon(leadingIcon, color: iconColor),
            ),
          ),
          title: Text(title, style: AppsStyles.s14Bold),
          subtitle: Text(subTitle, style: AppsStyles.s12Light),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: backgroundColor,
              padding: EdgeInsets.all(10),
              child: Icon(trailingIcon, color: iconColor),
            ),
          ),
        ),
      ),
    );
  }
}
