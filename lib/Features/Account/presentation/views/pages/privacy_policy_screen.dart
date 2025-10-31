import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_appBar.dart';

class PrivacyPolicyScreen extends BaseStatelessWidget {
  const PrivacyPolicyScreen({super.key});
  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: BaseGradient(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last updated: October 2025',
                  style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
                ),
                SizedBox(height: 20.h),
                Text(
                  '1. Information Collection',
                  style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
                ),
                SizedBox(height: 8.h),
                Text(
                  'We collect personal information that you provide when you register, use our services, or communicate with us. This may include your name, email, and usage data.',
                  style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
                ),
                SizedBox(height: 20.h),
                Text(
                  '2. Use of Information',
                  style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
                ),
                SizedBox(height: 8.h),
                Text(
                  'We use collected data to improve our services, personalize user experience, and communicate important updates or offers.',
                  style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
                ),
                SizedBox(height: 20.h),
                Text(
                  '3. Data Protection',
                  style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Your data is securely stored and not shared with any third party without your consent, except as required by law.',
                  style: AppsStyles.s12Regular.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'For any privacy-related inquiries, please contact us through the Help & Support page.',
                  style: AppsStyles.s12Regular.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return CustomAppBar(title: 'Privacy Policy', showBack: true);
  }
}
