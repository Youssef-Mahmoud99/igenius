import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class SignInWithGoogle extends StatelessWidget {
  const SignInWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sentiment_satisfied_alt,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    8.horizontalSpace,
                    Text(
                      "Soon",
                      style: AppsStyles.s14Bold.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
        );
      },
      child: Card(
        shadowColor: Colors.grey.withOpacity(0.3),
        margin: EdgeInsets.only(bottom: 16),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FontAwesomeIcons.google, color: AppColors.primary, size: 30),
              10.horizontalSpace,
              Text("Sign in with Google", style: AppsStyles.s14Regular),
            ],
          ),
        ),
      ),
    );
  }
}
