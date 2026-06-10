import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/check_box.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class SetPassword extends StatefulWidget {
  SetPassword({Key? key, required this.currentStep, required this.formKey})
    : super(key: key);
  final int currentStep;
  final GlobalKey<FormState> formKey;

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: 'Password', style: AppsStyles.s12Bold),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              registerParams = registerParams?.copyWith(password: value);
              log("password: ${registerParams?.password}");
            },
            hint: 'Create a strong password',
            inputType: TextInputType.text,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              // if (value.length < 8) {
              //   return 'Password must be at least 8 characters long';
              // }
              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return 'Password must contain at least one uppercase letter';
              }
              if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return 'Password must contain at least one special character';
              }

              return null;
            },
          ),
          10.verticalSpace,
          AppText(text: 'Confirm Password', style: AppsStyles.s12Bold),
          5.verticalSpace,
          CustomTextField(
            onChanged: (value) {
              registerParams = registerParams?.copyWith(passwordConfirmation: value);
              log("confirm password: ${registerParams?.passwordConfirmation}");
            },
            hint: 'Re-enter your password',
            inputType: TextInputType.text,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }
              if (value != registerParams?.password) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),

          20.verticalSpace,
          CustomCheckboxTile(
            titleWidget: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'I agree to the ',
                    style: AppsStyles.s16Regular.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: AppsStyles.s16Regular.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                  TextSpan(
                    text: ' and',
                    style: AppsStyles.s16Regular.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  TextSpan(
                    text: ' Privacy Policy',
                    style: AppsStyles.s16Regular.copyWith(
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
            ),
            value: termsAgreed,
             onChanged: (value) {
              setState(() {
                termsAgreed = value!;
              });
            },
          ),
        ],
      ),
    );
  }
}
