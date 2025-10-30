import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/Features/Home/presentation/views/widgets/material_details.dart';
import 'package:igenius/core/widgets/app_dotted_border.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_listtile.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/helper_methods.dart';
import '../../../../../core/widgets/base_gradient.dart';

class AssignmentScreen extends BaseStatelessWidget {
  AssignmentScreen({Key? key}) : super(key: key);
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
            'Assignment 1',
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseGradient(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: limitTimeandInstructions(),
              ),
            ),

            10.verticalSpace,
            BaseGradient(
              width: double.infinity,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Assignment Materials', style: AppsStyles.s16Bold),
                    10.verticalSpace,
                    Text(
                      'Exercise 1: Natural Numbers',
                      style: AppsStyles.s14Regular,
                    ),
                    5.verticalSpace,
                    cardDisplay(
                      materialDisplay(
                        FontAwesomeIcons.file,
                        Icons.download,
                        'Exercise_1.pdf',
                        'PDF • 2.4 MB',
                        Color(0xffF0FDF4),
                        AppColors.red,
                      ),
                    ),
                    10.verticalSpace,
                    uploadWidget(context),
                    10.verticalSpace,
                    MaterialDetails(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      color: Color(0xffFEF9C3),
                      backgroundColor: Color(0xff92400E),
                      name: 'Not Submitted',
                    ),
                    10.verticalSpace,

                    Text('Exercise 3: Integers', style: AppsStyles.s14Regular),
                    5.verticalSpace,
                    cardDisplay(
                      materialDisplay(
                        FontAwesomeIcons.file,
                        Icons.download,
                        'Exercise_3.pdf',
                        'PDF • 2.4 MB',
                        Color(0xffF0FDF4),
                        AppColors.red,
                      ),
                    ),
                    5.verticalSpace,
                    cardDisplay(
                      materialDisplay(
                        FontAwesomeIcons.fileWord,
                        Icons.download,
                        'My_Answer_3.pdf',
                        'DOCX • 856 KB',
                        AppColors.blue.withOpacity(0.1),
                        AppColors.blue,
                      ),
                    ),
                    10.verticalSpace,
                    AppDottedBorder(
                      child: GestureDetector(
                        behavior:
                            HitTestBehavior.opaque, // ← تلتقط الضغط في أي مكان
                        onTap: () async {
                          final file = await HelperMethods.pickAssignmentFile(
                            context,
                          );
                          if (file != null) {
                            print("Picked file path: ${file.path}");
                          }
                        },
                        child: Container(
                          width:
                              double
                                  .infinity, // ← ده اللي بيخلي المساحة كلها clickable
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.refresh,
                                color: AppColors.grey,
                                size: 20,
                              ),
                              10.horizontalSpace,
                              AppText(
                                text: 'Re-upload Answer',
                                style: AppsStyles.s14Bold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    10.verticalSpace,
                    MaterialDetails(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      color: Color(0xffDCFCE7),
                      backgroundColor: Color(0xff1E40AF),
                      name: 'Under Review',
                    ),
                    10.verticalSpace,
                    Text(
                      'Exercise 4: Real Numbers',
                      style: AppsStyles.s14Regular,
                    ),
                    5.verticalSpace,
                    cardDisplay(
                      materialDisplay(
                        FontAwesomeIcons.file,
                        Icons.download,
                        'Exercise_4.pdf',
                        'PDF • 2.4 MB',
                        Color(0xffF0FDF4),
                        AppColors.red,
                      ),
                    ),
                    10.verticalSpace,
                    cardDisplay(
                      color: Color(0xffBBF7D0).withOpacity(0.85),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            materialDisplay(
                              FontAwesomeIcons.file,
                              Icons.visibility,
                              'My_Answer_4.pdf',
                              'Submitted on Oct 18, 2025',
                              Color(0xffDCFCE7),
                              AppColors.green,
                            ),
                            10.verticalSpace,
                            cardDisplay(
                              color: Colors.white,
                              materialDisplay(
                                Icons.message,
                                Icons.download,
                                'Teacher_Comments.pdf',
                                'Feedback from Dr. Williams',
                                Color(0xffDCFCE7),
                                AppColors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    10.verticalSpace,
                    Row(
                      children: [
                        MaterialDetails(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          color: Color(0xffDCFCE7),
                          backgroundColor: AppColors.green,
                          name: 'Graded',
                        ),
                        10.horizontalSpace,
                        AppText(
                          text: 'Graded on Oct 21, 2025',
                          style: AppsStyles.s14Regular.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            30.verticalSpace,
          ],
        ),
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
    return CustomListTile2(
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
    );
  }

  Widget cardDisplay(Widget child, {Color? color}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey, width: 0.5),
        color: color,
      ),
      child: Padding(padding: const EdgeInsets.all(5.0), child: child),
    );
  }

  Widget limitTimeandInstructions() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.access_time_rounded, color: AppColors.red, size: 15),
            5.horizontalSpace,
            Text(
              'Due: Oct 25, 2025',
              style: AppsStyles.s14Regular.copyWith(color: AppColors.red),
            ),

            Spacer(),
            MaterialDetails(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              color: Color(0xffFEF9C3),
              backgroundColor: Color(0xff854D0E),
              name: '2 Days Left',
            ),
          ],
        ),
        AppText(
          style: AppsStyles.s14Regular,
          text:
              'Complete the following exercises on number systems. Download the assignment files, solve the problems, and upload your answers.',
        ),
      ],
    );
  }

  Widget uploadWidget(BuildContext context) {
    return AppDottedBorder(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              IconButton(
                onPressed: () async {
                  final file = await HelperMethods.pickAssignmentFile(context);
                  if (file != null) {
                    // TODO: ارفع الملف أو خزّنه في الكيوبيت بتاعك
                    print("Picked file path: ${file.path}");
                  }
                },
                icon: Icon(FontAwesomeIcons.fileUpload, color: AppColors.grey),
              ),
              AppText(text: 'Upload your answer', style: AppsStyles.s16Bold),
              5.verticalSpace,
              AppText(
                text: 'Click to browse or drag and drop',
                style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
