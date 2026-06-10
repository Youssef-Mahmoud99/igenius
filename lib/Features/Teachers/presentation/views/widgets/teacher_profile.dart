import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/helpers/helper_methods.dart';
import 'package:igenius/core/utils/url_launcher_utils.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/gradient_button.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../Courses/data/models/teacher.dart';
import '../../../../Courses/presentation/cubits/courses_by_teacher_cubit.dart';
import '../../../../Home/presentation/views/widgets/popular_courses.dart';
import 'teacher_info_card.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({ Key? key, required this.teacher }) : super(key: key);
  final Teacher teacher;
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
    List<Map<String, dynamic>> qualifiacations = [
    {
      'certificate': 'PhD in Mathematics',
      'university': 'Cambridge University',
      "color": Colors.lightBlue.withOpacity(0.7),
      'bacgroundColor': Colors.lightBlueAccent.withOpacity(0.3),
    },
    {
      'certificate': 'PhD in Mathematics',
      'university': 'Cambridge University',
      "color": Colors.purple.withOpacity(0.7),
      'bacgroundColor': Colors.purpleAccent.withOpacity(0.3),
    },
    {
      'certificate': 'PhD in Mathematics',
      'university': 'Cambridge University',
      "color": Colors.green.withOpacity(0.7),
      'bacgroundColor': Colors.greenAccent.withOpacity(0.3),
    },
  ];

  Widget aboutCard() {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.4),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: 'About',
              style: AppsStyles.s14Bold.copyWith(color: AppColors.black),
            ),
            10.verticalSpace,
            AppText(
              text:
                  'Dr. Robert Williams is a highly experienced educator with over 15 years of teaching IGCSE Mathematics and Physics. He holds a PhD in Mathematics from Cambridge University and has helped over 1,000 students achieve outstanding results in their IGCSE examinations.',
              color: AppColors.black,
              style: AppsStyles.s12Regular,
            ),
            10.verticalSpace,
            AppText(
              text:
                  "His teaching approach focuses on building strong foundational concepts while making complex topics accessible and engaging. Dr. Williams is known for his ability to identify individual learning needs and provide personalized guidance to each student.",
              color: AppColors.black,
              style: AppsStyles.s12Regular,
            ),
            10.verticalSpace,
            AppText(
              text:
                  "He has developed innovative teaching methods that combine traditional instruction with modern technology, ensuring students are well-prepared for both their exams and real-world applications of mathematical and physical concepts.",
              color: AppColors.black,
              style: AppsStyles.s12Regular,
            ),
          ],
        ),
      ),
    );
  }

  Widget qualificationTile(
    String certificate,
    String university,
    Color color,
    Color backgroundColor,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: backgroundColor,
          padding: EdgeInsets.all(15),
          child: Icon(Icons.verified, color: color, size: 20.r),
        ),
      ),
      title: Text(certificate, style: AppsStyles.s14Bold),
      subtitle: Text(
        university,
        style: AppsStyles.s14Regular.copyWith(color: AppColors.grey),
      ),
    );
  }
@override
  void initState() {
    context.read<CoursesByTeacherCubit>().getCourseByTeacher(widget.teacher.id ?? 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
      centerTitle: false,
      title: 'Teacher Profile',
      showBack: true,
      actions: [
        IconButton(
          onPressed: () {
            HelperMethods.shareText('Share this teacher profile');
          },
          icon: const Icon(Icons.share, color: Colors.black),
        ),
      ],
    ),
      body: SafeArea(
      child: BaseGradient(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TeacherInfoCard( teacher: widget.teacher),
              Padding(
                padding: const EdgeInsets.all(20.0).copyWith(top: 0),
                child: Column(
                  children: [
                    // 20.verticalSpace,
                    // GradientButton(
                    //   text: 'Contact Teacher',
                    //   onTap: () {
                    //     UrlLauncherUtils.openWhatsApp('+201234567890');
                    //   },
                    //   height: 40.h,
                    // ),
                    20.verticalSpace,
                    aboutCard(),
                    Card(
                      elevation: 10,
                      shadowColor: Colors.grey.withOpacity(0.4),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Qualifications', style: AppsStyles.s14Bold),
                            ...qualifiacations.map(
                              (qualification) => qualificationTile(
                                qualification['certificate'],
                                qualification['university'],
                                qualification['color'],
                                qualification['bacgroundColor'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Courses by ${widget.teacher.name}',
                  style: AppsStyles.s14Bold,
                ),
              ),

              PopularCourses(
                isGuest: true,
                scrollDirection: Axis.vertical,
                inHome: false,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
