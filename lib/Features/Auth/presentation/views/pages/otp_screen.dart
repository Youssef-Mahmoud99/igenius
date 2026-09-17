import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/constants/app_routes.dart';
import 'package:pinput/pinput.dart';

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

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? otpCode;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return BaseGradient(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Center(child: Image.asset(AppImages.logo, scale: 1.5)),
                      AppText(
                        text: 'Enter the code we just sent you',
                        style: AppsStyles.s20Bold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),

                      50.verticalSpace,

                      Center(
                        child: Pinput(
                          defaultPinTheme: PinTheme(
                            width: 50.w,
                            height: 50.h,
                            textStyle: AppsStyles.s16Bold.copyWith(
                              color: AppColors.primary,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: AppColors.secondary),
                            ),
                          ),
                          onCompleted: (pin) {
                            setState(() {
                              otpCode = pin;
                              isLoading = true;
                            });
                            print('Completed: $pin');
                            final cubit = sl<PasswordCubit>();
                            if (_formKey.currentState!.validate()) {
                              passwordParams = passwordParams?.copyWith(
                                code: otpCode,
                              );
                              cubit.verifyOtp(passwordParams!);
                            }
                          },
                          length: 6,
                          autofocus: true,
                        ),
                      ),

                      30.verticalSpace,
                      GradientButton(
                        isLoading: isLoading,
                        height: 40.h,
                        text: 'Check Otp',
                        onTap: () {
                          final cubit = sl<PasswordCubit>();
                          if (_formKey.currentState!.validate()) {
                            passwordParams = passwordParams?.copyWith(
                              code: otpCode,
                            );
                            cubit.verifyOtp(passwordParams!);
                          }
                        },
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
