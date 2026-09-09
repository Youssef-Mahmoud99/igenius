import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/widgets/custom_listtile.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../app.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';


class ContinueLearningCard extends StatelessWidget {
  const ContinueLearningCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            AppNavaigation.push(
              AppRoutes.myCoursesScreen,
            );

          },
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.buttonGradient1, AppColors.buttonGradient2],
              ),
            ),
          
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomListTile(
                    title: AppText(
                      text: "Continue Learning",
                      style: AppsStyles.s20Bold.copyWith(color: AppColors.white),
                    ),
                    subtitle: AppText(
                      text: "You're doing great! Keep it up 🎉",
                      style: AppsStyles.s12Light.copyWith(color: AppColors.white),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Image.asset(AppImages.courses),
                    ),
                  ),
                  5.verticalSpace,
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       AppText(
                  //         text: "Overall Progress",
                  //         style: AppsStyles.s12Regular.copyWith(
                  //           color: AppColors.white.withOpacity(0.9),
                  //         ),
                  //       ),
                  //       AppText(
                  //         text: "68%",
                  //         style: AppsStyles.s12Bold.copyWith(
                  //           color: AppColors.white,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // 8.verticalSpace,
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 20,
                  //   ).copyWith(bottom: 10),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(8),
                  //     child: LinearProgressIndicator(
                  //       value: 0.68, // 68%
                  //       minHeight: 6,
                  //       backgroundColor: Colors.white.withOpacity(0.3),
                  //       valueColor: const AlwaysStoppedAnimation<Color>(
                  //         AppColors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  8.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
