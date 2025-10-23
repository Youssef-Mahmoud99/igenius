import 'package:flutter/material.dart';
import 'package:igenius/core/theme/app_colors.dart';

import '../resources/styles_manager.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    Key? key,
    required this.text,
    this.onTap,
    this.isLoading,
    this.height,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String text;
  final bool? isLoading;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 70,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.buttonGradient1, AppColors.buttonGradient2],
          ),
          color: isLoading == true ? Colors.white : null,
        ),
        child:
            isLoading == true
                ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
                : Text(
                  text,
                  style: AppsStyles.s18Bold.copyWith(color: Colors.white),
                ),
      ),
    );
  }
}
