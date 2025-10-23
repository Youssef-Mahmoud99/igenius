import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/gradient_button.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import 'teacher_info_card.dart';

class TeacherProfileScreen extends BaseStatelessWidget {
  const TeacherProfileScreen({Key? key}) : super(key: key);
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: false,
      title: 'Teacher Profile',
      showBack: true,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            TeacherInfoCard(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientButton(
                    text: 'Contact Teacher',
                    onTap: () {},
                    height: 50,
                  ),
                  20.verticalSpace,
                  aboutCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              style: AppsStyles.s16Bold.copyWith(color: AppColors.black),
            ),
            10.verticalSpace,
            AppText(
              text:
                  'Dr. Robert Williams is a highly experienced educator with over 15 years of teaching IGCSE Mathematics and Physics. He holds a PhD in Mathematics from Cambridge University and has helped over 1,000 students achieve outstanding results in their IGCSE examinations.',
              color: AppColors.black,
            ),
            10.verticalSpace,
            AppText(
              text:
                  "His teaching approach focuses on building strong foundational concepts while makingcomplex topics accessible and engaging. Dr.Williams is known for his ability to identify individual learning needs and providepersonalized guidance to each student.",
              color: AppColors.black,
            ),
            10.verticalSpace,
            AppText(
              text:
                  "He has developed innovative teaching methods that combine traditional instructionwith modern technology, ensuring studentsare well-prepared for both their exams andreal-world applications of mathematical andphysical concepts.",
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
