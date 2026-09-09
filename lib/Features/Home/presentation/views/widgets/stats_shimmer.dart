import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/theme/app_colors.dart';

class UserCoursesDetailsShimmer extends StatelessWidget {
  const UserCoursesDetailsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        separatorBuilder: (_, __) => 10.horizontalSpace,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: AppColors.borderGrey,
            highlightColor: Colors.white,
            child: Container(
              width: 100.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 45.r,
                      height: 45.r,
                      color: Colors.white,
                    ),
                  ),
                  10.verticalSpace,
                  Container(width: 30.w, height: 14.h, color: Colors.white),
                  6.verticalSpace,
                  Container(width: 45.w, height: 10.h, color: Colors.white),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}