import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({Key? key, required this.title, required this.viewallTitle})
    : super(key: key);
  final String title;
  final String viewallTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppsStyles.s20Bold),
          Row(
            children: [
              Text(
                viewallTitle,
                style: AppsStyles.s16Bold.copyWith(color: AppColors.blue),
              ),
              5.horizontalSpace,
              Icon(Icons.arrow_forward, color: AppColors.blue, size: 10),
            ],
          ),
        ],
      ),
    );
  }
}
