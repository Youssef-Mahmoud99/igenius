import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          color: AppColors.secondary,
          width: 100.w,
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              'View Profile',
              style: AppsStyles.s12Bold.copyWith(
                color: AppColors.white,
                height: 1.25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
