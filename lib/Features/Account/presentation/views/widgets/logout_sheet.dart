import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/primary_button.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => const LogoutBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5.h,
            width: 50.w,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            'Logout',
            style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: 12.h),
          Text(
            'Are you sure you want to log out?',
            textAlign: TextAlign.center,
            style: AppsStyles.s12Regular.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: Appbutton(
                  color: Colors.white,
                  needBorder: true,
                  borderRadius: 12,
                  borderColor: AppColors.primary,
                  text: 'Cancel',
                  textColor: AppColors.primary,
                  onPressed: () {
                    AppNavaigation.pop();
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Appbutton(
                  borderRadius: 12,
                  text: 'Logout',
                  onPressed: () {
                    AppNavaigation.goToLogin();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
