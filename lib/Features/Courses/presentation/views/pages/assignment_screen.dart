import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/Features/Home/presentation/views/widgets/material_details.dart';
import 'package:igenius/core/widgets/app_dotted_border.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_listtile.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/helper_methods.dart';
import '../../../../../core/widgets/base_gradient.dart';
import '../widgets/course_material.dart';
import '../widgets/upload_assignment_widget.dart';

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
            style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
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
      child: BaseGradient(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                limitTimeandInstructions(),
                10.verticalSpace,

                Text('Assignment Materials', style: AppsStyles.s16Bold),
                10.verticalSpace,
                Text(
                  'Exercise 1: Natural Numbers',
                  style: AppsStyles.s14Regular,
                ),
                5.verticalSpace,
                CourseMaterial(
                  title: 'Exercise_1.pdf',
                  subTitle: 'PDF • 2.4 MB',
                  backgroundColor: Color(0xffF0FDF4),
                  iconColor: AppColors.red,
                  leadingImage: AppImages.assignment,
                  trailingIcon: Icons.file_download_outlined,
                ),
                10.verticalSpace,
                UploadAssignmentWidget(),
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

                Text('Exercise 3: Integers', style: AppsStyles.s12Regular),
                5.verticalSpace,
                CourseMaterial(
                  title: 'Exercise_3.pdf',
                  subTitle: 'PDF • 2.4 MB',
                  backgroundColor: Color(0xffF0FDF4),
                  iconColor: AppColors.red,
                  leadingImage: AppImages.assignment,
                  trailingIcon: Icons.file_download_outlined,
                ),
                10.verticalSpace,
                CourseMaterial(
                  title: 'My_Answer_3.pdf',
                  subTitle: 'DOCX • 856 KB',
                  backgroundColor: AppColors.blue.withOpacity(0.1),
                  iconColor: AppColors.blue,
                  leadingImage: AppImages.assignment,
                  trailingIcon: Icons.file_download_outlined,
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
                            style: AppsStyles.s12Bold,
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
                Text('Exercise 4: Real Numbers', style: AppsStyles.s14Regular),
                5.verticalSpace,
                CourseMaterial(
                  title: 'Exercise_4.pdf',
                  subTitle: 'PDF • 2.4 MB',
                  backgroundColor: Color(0xffF0FDF4),
                  iconColor: AppColors.red,
                  leadingImage: AppImages.assignment,
                  trailingIcon: Icons.file_download_outlined,
                ),
                10.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffBBF7D0).withOpacity(0.85),

                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.green),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CourseMaterial(
                          title: 'My_Answer_4.pdf',
                          subTitle: 'Submitted on Oct 18, 2025',
                          backgroundColor: Color(0xffDCFCE7),
                          iconColor: AppColors.green,
                          leadingImage: AppImages.assignment,
                          trailingIcon: Icons.visibility,
                          needBorder: false,
                        ),
                        10.verticalSpace,
                        yourGrade(),
                        10.verticalSpace,
                        CourseMaterial(
                          tileColor: Colors.white,
                          title: 'Teacher_Comments.pdf',
                          subTitle: 'Feedback from Dr. Williams',
                          backgroundColor: Color(0xffDCFCE7),
                          iconColor: AppColors.green,
                          leadingIcon: Icons.message,
                          trailingIcon: Icons.file_download_outlined,
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
                      style: AppsStyles.s12Regular.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),

                30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget limitTimeandInstructions() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.access_time_rounded, color: AppColors.red, size: 15.r),
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
        5.verticalSpace,
        AppText(
          style: AppsStyles.s12Regular,
          text:
              'Complete the following exercises on number systems. Download the assignment files, solve the problems, and upload your answers.',
        ),
      ],
    );
  }

  Widget yourGrade() {
    return CustomListTile(
      padding: EdgeInsets.symmetric(horizontal: 10),
      borderRadius: BorderRadius.circular(8),
      backgroundColor: Colors.white,
      leading: Text('Your Grade: ', style: AppsStyles.s12Bold),
      trailing: Text(
        '85/100',
        style: AppsStyles.s18Bold.copyWith(color: AppColors.green),
      ),
    );
  }
}
