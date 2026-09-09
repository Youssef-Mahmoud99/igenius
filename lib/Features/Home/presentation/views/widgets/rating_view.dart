import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class RatingView extends StatelessWidget {
  const RatingView({
    Key? key,
    required this.rating,
    required this.students,
    this.width,
  }) : super(key: key);
  final double rating;
  final String students;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.star, color: AppColors.orange, size: 20.r),
        5.horizontalSpace,
        Text(rating.toString(), style: AppsStyles.s14Bold),
        // SizedBox(
        //   width: width ?? 100,
        //   child: Text("$students Students", style: AppsStyles.s12Light),
        // ),
      ],
    );
  }
}
