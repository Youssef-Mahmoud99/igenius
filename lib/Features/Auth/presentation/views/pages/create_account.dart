import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Auth/presentation/views/widgets/personal_info.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/base/base_stateful.dart';
import '../../../../../core/widgets/base_gradient.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../core/widgets/fake_appbar.dart';
import '../../../../../core/widgets/gradient_button.dart';
import '../widgets/another_auth.dart';
import '../widgets/parent_info.dart';
import '../widgets/previous_next_buttons.dart';
import '../widgets/progress.dart';
import '../widgets/set_password.dart';

class CreateAccountScreen extends BaseStatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState
    extends BaseStatefulWidgetState<CreateAccountScreen> {
  int currentStep = 1;
  GlobalKey<FormState> personalKey = GlobalKey<FormState>();
  GlobalKey<FormState> parentKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  Widget chooseWhichBody() {
    if (currentStep == 1) {
      return PersonalInfo(formKey: personalKey, currentStep: currentStep);
    } else if (currentStep == 2) {
      return ParentInfo(formKey: parentKey, currentStep: currentStep);
    } else {
      return SetPassword(formKey: passwordKey, currentStep: currentStep);
    }
  }

  String currentHeadline() {
    if (currentStep == 1) {
      return 'Personal Information';
    } else if (currentStep == 2) {
      return 'Parent Information';
    } else {
      return 'Set Your Password';
    }
  }

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
                FakeAppbar(),
                30.vSizedBox,
                StepsProgress(currentStep: currentStep),
                20.verticalSpace,
                Align(
                  alignment: Alignment.center,
                  child: AppText(
                    text: currentHeadline(),
                    style: AppsStyles.s20Bold.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
                20.verticalSpace,
                chooseWhichBody(),
                20.verticalSpace,
                currentStep == 1
                    ? GradientButton(
                      height: 50.h,
                      text: 'Continue',
                      onTap: () {
                        if (personalKey.currentState!.validate()) {
                          setState(() {
                            currentStep++;
                          });
                        }
                      },
                    )
                    : PreviousNextButtons(
                      formKey: passwordKey,
                      currentStep: currentStep,
                      onBack: () {
                        setState(() {
                          currentStep--;
                        });
                      },
                      onContinue: () {
                        if (parentKey.currentState!.validate()) {
                          setState(() {
                            currentStep++;
                          });
                          ;
                        }
                      },
                    ),
                10.verticalSpace,
                AnotherAuth(
                  text: 'Already have an account?',
                  anotherAuthName: 'Login',
                  onPressed: () {
                    AppNavaigation.goToLogin();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
