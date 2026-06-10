import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import '../../../../../app.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/base_gradient.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../../../../../injection/service_locator.dart';
import '../../cubits/password_cubit.dart';

class ForgetPasswordScreen extends BaseStatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  @override
  Widget buildBody(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return BaseGradient(
       
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
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
                        text: 'We will send you your password',
                        style: AppsStyles.s24Bold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      AppText(
                        text: 'Check your email',
                        style: AppsStyles.s16Regular.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                      50.verticalSpace,

                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: 'Email Address',
                              style: AppsStyles.s12Bold,
                            ),
                            5.verticalSpace,

                            CustomTextField(
                              prefix: Icon(
                                FontAwesomeIcons.at,
                                color: AppColors.grey,
                                size: 15,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  email = value;
                                });
                              },
                              hint: 'your.email@example.com',
                              inputType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                } else if (!value.contains("@")) {
                                  return 'Invalid email address';
                                }
                                return null;
                              },
                            ),
                            10.verticalSpace,
                            GradientButton(
                              height: 50.h,
                              text: 'Send  ',
                              onTap: () {
                                final cubit = sl<PasswordCubit>();
                                if (_formKey.currentState!.validate()) {
                                passwordParams = passwordParams?.copyWith(email: email);
                                  cubit.forgetPassword(email!);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
