import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Account/presentation/views/widgets/settings_item.dart';
import 'package:igenius/core/constants/app_routes.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/base_gradient.dart';

class GuestAccountScreen extends BaseStatelessWidget {
  const GuestAccountScreen({Key? key}) : super(key: key);

  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: BaseGradient(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.buttonGradient1,
                            AppColors.buttonGradient2,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(20.0),
                      width: double.infinity,
                      child: _joinUsHeader(context),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.4),
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 4,
                        ),
                        child: Column(
                          children: [
                            SettingsItem(
                              title: 'Privacy Policy',
                              icon: Icons.description_outlined,
                              route: AppRoutes.privacyPolicyScreen,
                            ),
                            Divider(color: Colors.grey),
                            SettingsItem(
                              title: 'About Us',
                              icon: Icons.info_outline,
                              route: AppRoutes.aboutUsScreen,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _joinUsHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Icon(
                Icons.person_outline_rounded,
                color: Colors.white,
                size: 32.r,
              ),
            ),
            20.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join Us Now',
                    style: AppsStyles.s18Bold.copyWith(color: Colors.white),
                  ),
                  5.verticalSpace,
                  Text(
                    'Sign in to access your courses, track your progress and more',
                    style: AppsStyles.s12Regular.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        20.verticalSpace,
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => AppNavaigation.goToLogin(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: Text(
              'Login',
              style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}