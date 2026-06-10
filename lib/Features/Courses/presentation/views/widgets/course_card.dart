import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../Home/presentation/views/widgets/material_details.dart';
import '../../../data/models/courses_model.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({Key? key, required this.course, required this.liveIndex})
    : super(key: key);
  final CourseModel course;
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
            height: 120.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors:   [ AppColors.primary, AppColors.secondary],
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
                    style: AppsStyles.s12Bold,
                    color:  Colors.white,
                    backgroundColor:  Colors.grey,
                    name: course.subject?.name ?? "لللل",
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
                  Text(course.title ?? "", style: AppsStyles.s14Bold.copyWith(color: AppColors.primary)),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.star, color: AppColors.orange, size: 20.r),
                      Text('5.0', style: AppsStyles.s14Bold),
                      20.horizontalSpace,
                      SizedBox(
                        width: 80,
                        child: Text(
                          "200 Students",
                          style: AppsStyles.s10Regular,
                        ),
                      ),
                    ],
                  ),
                  5.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.price.toString(),
                        style: AppsStyles.s14Bold.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          AppNavaigation.pushToPageWithParams(AppRoutes.courseDetails,  {
                            'courseId': course.id,
                          });
                        },
                        child: ClipRRect(
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
                                style: AppsStyles.s12Bold.copyWith(
                                  color: AppColors.white,
                                  height: 1.25,
                                ),
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
              style: AppsStyles.s12Bold.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
