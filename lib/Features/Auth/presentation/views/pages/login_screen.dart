import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_text_button.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/base_gradient.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../widgets/another_auth.dart';
import '../widgets/login_form.dart';
import '../widgets/signin_with_google.dart';

class LoginScreen extends BaseStatelessWidget {

  @override
  Widget buildBody(BuildContext context) {
    return BaseGradient(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(AppImages.logo, scale: 3),
                    10.horizontalSpace,
                    Image.asset(AppImages.logo2, height: 50.h),
                  ],
                ),
                30.verticalSpace,
                AppText(
                  text: 'Welcome Back!',
                  style: AppsStyles.s32Bold.copyWith(color: AppColors.primary),
                ),
                AppText(
                  text: 'Sign in to continue learning',
                  style: AppsStyles.s20Regular.copyWith(color: AppColors.grey),
                ),
                50.verticalSpace,

                LoginForm(),
                20.verticalSpace,
                AnotherAuth(
                  text: 'Don\'t have an account?',
                  anotherAuthName: 'Sign up',
                  onPressed: () {
                    AppNavaigation.goToSignUp();
                  },
                ),
                SignInWithGoogle(),
                Align(
                  alignment: Alignment.center,
                  child: CustomTextButton(
                    text: 'Continue as guest',
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    onPressed: () {
                      AppNavaigation.goToHome(isGuest: true);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
