import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/constants/app_routes.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/custom_text_button.dart';

class HeadLine extends StatelessWidget {
  const HeadLine({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset(AppImages.logo, scale: 3.5),
              10.horizontalSpace,
              Image.asset(AppImages.logo2, height: 40.h),
            ],
          ),
          isGuest
              ? CustomTextButton(
                text: 'Login',
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                onPressed: () {
                  AppNavaigation.push(AppRoutes.login);
                },
              )
              : Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                      AppNavaigation.push(AppRoutes.notificationsScreen);
                    },
                    icon: ImageIcon(
                      AssetImage(AppImages.notifications),
                      size: 30.r,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 8,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
