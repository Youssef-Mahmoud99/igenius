import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../Home/presentation/views/widgets/material_details.dart';
import '../../../../Home/presentation/views/widgets/rating_view.dart';
import '../../../data/models/courses_model.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({Key? key, required this.course, required this.liveIndex})
    : super(key: key);
  final CoursesModel course;
  final int liveIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity, // ياخد العرض كله
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: course.gradientColors ?? [],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 12,
                  left: 12,
                  child: MaterialDetails(
                    style: AppsStyles.s14Bold,
                    color: course.categoryBackgroundColor ?? Colors.white,
                    backgroundColor: course.categoryColor ?? Colors.grey,
                    name: course.category ?? "",
                  ),
                ),
                liveIndex % 2 == 0
                    ? Positioned(child: liveWidget(), top: 12, right: 6)
                    : const SizedBox.shrink(),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(course.title ?? "", style: AppsStyles.s16Bold),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.star, color: AppColors.orange, size: 20),
                      Text(course.rating.toString(), style: AppsStyles.s14Bold),
                      20.horizontalSpace,
                      SizedBox(
                        width: 80,
                        child: Text(
                          "${course.subtitle} Students",
                          style: AppsStyles.s12Light,
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.price ?? "",
                        style: AppsStyles.s18Bold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          color: Color(0xff53A1D2),
                          width: 65.w,
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'Enroll',
                              style: AppsStyles.s14Bold.copyWith(
                                color: AppColors.white,
                                height: 1.25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget liveWidget() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        color: Colors.red,
        child: Row(
          children: [
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            4.horizontalSpace,
            Text(
              textAlign: TextAlign.center,
              'Live',
              style: AppsStyles.s16Bold.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
