import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/core/constants/app_routes.dart';
import 'package:igenius/core/widgets/custom_text_button.dart';
import 'package:igenius/core/widgets/gradient_button.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../injection/service_locator.dart';
import '../../../data/models/auth_model.dart';
import '../../cubits/auth_cubit.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
  if (kDebugMode) {
     email = 'yossef10@student.com';
     password = '12345678';
  }
    return StatefulBuilder(
      builder: (context, setState) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(text: 'Email Address', style: AppsStyles.s12Bold),
              5.verticalSpace,

              CustomTextField(
                initialValue: email,
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
              AppText(text: 'Password', style: AppsStyles.s12Bold),
              5.verticalSpace,

              CustomTextField(
                initialValue: password,
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

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SizedBox(
                  //   width: 200,
                  //   child: CustomCheckboxTile(
                  //     title: 'Remember me',
                  //     value: rememberMe,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         rememberMe = value!;
                  //       });
                  //     },
                  //   ),
                  // ),
                  CustomTextButton(
                    text: "Forget password?",
                    color: AppColors.buttonGradient2,
                    onPressed: () {
                      AppNavaigation.push(AppRoutes.forgotPassword);
                    },
                  ),
                ],
              ),
              GradientButton(
                height: 50.h,
                text: 'Login to Account',
                onTap: () {
                  final cubit = sl<AuthCubit>();
                  if (_formKey.currentState!.validate()) {
                    cubit.login(AuthModel(
                      email: email!,
                      password: password!,
                    ));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
