import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/data/models/courses_model.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/cached_network_image.dart';
import '../../../../../core/widgets/primary_button.dart';
import '../../../../Home/presentation/views/widgets/material_details.dart';

class HomeCourseCard extends StatelessWidget {
  const HomeCourseCard({Key? key, required this.course, required this.inHome})
    : super(key: key);
  final CourseModel course;
  final bool inHome;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 110.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [ AppColors.primary, AppColors.secondary],
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          course.subject?.name ?? "",
                          style: AppsStyles.s12Regular,
                        ),
                        // 5.horizontalSpace,
                        // Text(course.system?.name ?? "", style: AppsStyles.s10Bold),
                      ],
                    ),
                  ),
                ),
                Center(child: CustomCachedNetworkImage(
                  imageUrl: course.image ?? "",
                  width: 80.w,
                  height: 80.h,
                )),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialDetails(
                    color: AppColors.tertiary,
                    backgroundColor: AppColors.white,
                    name: course.teacher?.name ?? "",
                  ),
                  5.verticalSpace,
                  Text(course.title ?? "", style: AppsStyles.s14Bold),
                  5.verticalSpace,
                  Text(
                    course.description ?? "",
                    style: AppsStyles.s12Regular.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  Spacer(),
                  inHome ? SizedBox.shrink() : statistics(),
                  inHome
                      ? ratingandPrice()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          price(),
                          Appbutton(
                            height: 30.h,
                            width: 80.w,
                            color: AppColors.secondary,
                            borderRadius: 12,
                            text: 'View Course',
                            onPressed: () {
                              AppNavaigation.pushToPageWithParams(AppRoutes.courseDetails,  {
                                'courseId': course.id,
                              });
                            },
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

  Widget ratingandPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [rating(), price()],
    );
  }

  Widget rating() {
    return Row(
      children: [
        Icon(Icons.star, color: Color(0xFFFBBF24), size: 16.r),
        const SizedBox(width: 4),
        Text('5.0', style: AppsStyles.s14Bold),
      ],
    );
  }

  Widget price() {
    return Text(
      course.price.toString() ,
      style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
    );
  }

  Widget statistics() {
    return Row(
      children: [
        rating(),
        10.horizontalSpace,
        details("847 Students", Icons.group_sharp),
        10.horizontalSpace,
        details('24 Weeks', Icons.access_time_outlined),
      ],
    );
  }

  Widget details(String data, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.grey, size: 15),
        5.horizontalSpace,
        Text(
          data,
          style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }
}
