import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/widgets/gradient_button.dart';
import 'package:igenius/core/widgets/primary_button.dart';

import '../../../../../core/utils/helpers/app_navigtion.dart';

class PreviousNextButtons extends StatefulWidget {
  const PreviousNextButtons({
    Key? key,
    required this.onBack,
    required this.currentStep,
    required this.onContinue, required this.formKey,
  }) : super(key: key);

  final VoidCallback onBack;
  final VoidCallback onContinue;
  final int currentStep;
  final GlobalKey<FormState> formKey;

  @override
  State<PreviousNextButtons> createState() => _PreviousNextButtonsState();
}

class _PreviousNextButtonsState extends State<PreviousNextButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Appbutton(
            height: 60,
            borderRadius: 16,
            needBorder: true,
            textColor: AppColors.primary,
            color: AppColors.white,
            text: "Back",
            onPressed: widget.onBack,
          ),
        ),
        20.horizontalSpace,
        Expanded(
          child: GradientButton(
            height: 60,
            text: widget.currentStep < 3 ? "Continue" : "Create Account",
            onTap: widget.currentStep < 3 ? widget.onContinue : () {
              if (widget.formKey.currentState!.validate()){
                            AppNavaigation.goToLogin();

              }

            },
          ),
        ),
      ],
    );
  }
}
