import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/url_launcher_utils.dart';
import '../../../../../core/widgets/custom_appBar.dart';
import '../widgets/contact_us_form.dart';

class HelpAndSupportScreen extends BaseStatelessWidget {
  const HelpAndSupportScreen({super.key});
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
                  'We’re here to help!',
                  style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
                ),
                SizedBox(height: 10.h),
                Text(
                  'If you’re facing any issues or have questions about our app, please reach out to us through one of the methods below:',
                  style: AppsStyles.s12Regular.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 20.h),
                _buildTile(
                  icon: Icons.email_rounded,
                  title: 'Email Support',
                  subtitle: 'support@igenius.com',
                  onTap:
                      () => UrlLauncherUtils.sendEmail(
                        email: "support@igenius.com",
                      ),
                ),
                SizedBox(height: 12.h),

                // _buildTile(
                //   icon: Icons.chat_bubble_outline_rounded,
                //   title: 'Live Chat',
                //   subtitle: 'Chat with our support team instantly.',
                //   onTap: () {},
                // ),
                // SizedBox(height: 12.h),
                // _buildTile(
                //   icon: Icons.description_outlined,
                //   title: 'FAQs',
                //   subtitle: 'Find quick answers to common questions.',
                //   onTap: () {},
                // ),
                 Text(
                  'Contact Us',
                  style: AppsStyles.s14Bold,
                ),
                SizedBox(height: 8.h),
                ContactUsForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return CustomAppBar(title: 'Help & Support', showBack: true);
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 20.r),
            20.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppsStyles.s14Medium),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: AppsStyles.s12Regular.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
