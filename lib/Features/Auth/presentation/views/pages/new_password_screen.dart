import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/core/utils/helpers/toast_helper.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import '../../../../../app.dart';
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

class NewPasswordScreen extends BaseStatelessWidget {
  NewPasswordScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? password;
  String? confirmPassword;
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
                    Center(child: Image.asset(AppImages.logo, scale: 1.5)),
                      AppText(
                        text: 'Enter your new password',
                        style: AppsStyles.s24Bold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),

                      50.verticalSpace,

                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: 'Password',
                              style: AppsStyles.s12Bold,
                            ),
                            5.verticalSpace,

                            CustomTextField(
                              prefix: Icon(
                                FontAwesomeIcons.lock,
                                color: AppColors.grey,
                                size: 15,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              hint: 'Enter your password',
                              inputType: TextInputType.text,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                            ),
                            AppText(
                              text: 'Confirm Password',
                              style: AppsStyles.s12Bold,
                            ),
                            5.verticalSpace,

                            CustomTextField(
                              prefix: Icon(
                                FontAwesomeIcons.lock,
                                color: AppColors.grey,
                                size: 15,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  confirmPassword = value;
                                });
                              },
                              hint: 'Confirm your password',
                              inputType: TextInputType.text,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                if (value != password) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),

                            10.verticalSpace,
                            GradientButton(
                              height: 50.h,
                              text: 'Submit',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  final cubit = sl<PasswordCubit>();
                                  passwordParams = passwordParams?.copyWith(password: password, passwordConfirmation: confirmPassword);
                                  cubit.resetPassword(passwordParams!);
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
