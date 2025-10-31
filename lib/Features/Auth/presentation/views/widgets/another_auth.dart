import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/custom_text_button.dart';

import '../../../../../core/resources/styles_manager.dart';

class AnotherAuth extends StatelessWidget {
  const AnotherAuth({
    Key? key,
    this.onPressed,
    required this.text,
    required this.anotherAuthName,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String text;
  final String anotherAuthName;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: text,
          style: AppsStyles.s14Regular.copyWith(color: AppColors.grey),
        ),
        CustomTextButton(
          text: anotherAuthName,
          color: AppColors.primary,
          onPressed: onPressed,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      ],
    );
  }
}
