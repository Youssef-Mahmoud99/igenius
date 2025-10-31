import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/gradient_button.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';

class ReadyToStart extends StatelessWidget {
  ReadyToStart({Key? key}) : super(key: key);
  List<Map<String, dynamic>> data = [
    {"title": "Students", "value": "1000+"},
    {"title": "Teachers", "value": "50+"},
    {"title": "Success Rate", "value": "98%"},
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFCE7F3), Color(0xFFEFF6FF)],
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        child: Column(
          children: [
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(AppImages.lock, height: 40.h),
              ),
            ),
            10.verticalSpace,
            AppText(text: 'Ready to Start?', style: AppsStyles.s20Bold),
            AppText(
              textAlign: TextAlign.center,
              text: 'Join thousands of students achieving their IGCSE goals',
              style: AppsStyles.s14Light,
            ),

            20.verticalSpace,
            GradientButton(
              height: 50.h,
              text: "Create Free Account",
              onTap: () {
                AppNavaigation.push(AppRoutes.register);
              },
            ),
            10.verticalSpace,
            AppText(
              textAlign: TextAlign.center,
              text: 'No credit card required • Start learning today',
              style: AppsStyles.s10Regular.copyWith(color: AppColors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget titleandValue(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          text: value,
          style: AppsStyles.s20Bold.copyWith(color: AppColors.white),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: AppText(
            textAlign: TextAlign.center,
            text: title,
            style: AppsStyles.s14Regular.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}
