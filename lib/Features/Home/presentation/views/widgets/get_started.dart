import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/primary_button.dart';

class GetStarted extends StatelessWidget {
  GetStarted({Key? key}) : super(key: key);
  List<Map<String, dynamic>> data = [
    {"title": "Students", "value": "1000+"},
    {"title": "Teachers", "value": "50+"},
    {"title": "Success Rate", "value": "98%"},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.buttonGradient1, AppColors.buttonGradient2],
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            color: Colors.white.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(AppImages.courses, height: 60),
            ),
          ),
          10.verticalSpace,
          AppText(
            text: 'Master Your IGCSE',
            style: AppsStyles.s28Bold.copyWith(color: AppColors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: AppText(
              textAlign: TextAlign.center,
              text:
                  'Learn smarter, achieve higher with expert teachers and comprehensive courses',
              style: AppsStyles.s18Light.copyWith(color: AppColors.white),
            ),
          ),
          20.verticalSpace,
          Appbutton(
            height: 60,
            borderRadius: 16,
            text: "Get Started Free",
            onPressed: () {
              AppNavaigation.push(AppRoutes.login);
            },
            color: AppColors.white,
            textColor: AppColors.primary,
            isLoading: false,
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...data.map((e) {
                return titleandValue(e["title"], e["value"]);
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleandValue(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText(
          text: value,
          style: AppsStyles.s28Bold.copyWith(color: AppColors.white),
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
