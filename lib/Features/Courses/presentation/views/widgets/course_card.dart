import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../Home/presentation/views/widgets/material_details.dart';
import '../../../data/models/courses_model.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({Key? key, required this.course}) : super(key: key);
  final CourseModel course;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavaigation.pushToPageWithParams(
          AppRoutes.courseDetails,
          {'courseId': course.id, 'isBought': course.isOwned},
        );
      },
      child: Container(
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
            Stack(
              children: [
                Container(
                  width: double.infinity, // ياخد العرض كله
                  height: 120.h,
                  decoration:
                      course.image != null
                          ? BoxDecoration(
                            image:
                                course.image != null
                                    ? DecorationImage(
                                      image: NetworkImage(course.image ?? ''),
                                      fit: BoxFit.fill,
                                    )
                                    : null,
                            color: AppColors.primary,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          )
                          : BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [AppColors.primary, AppColors.secondary],
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                  child:
                      course.image != null
                          ? SizedBox.shrink()
                          : Center(
                            child: Icon(
                              Icons.menu_book,
                              size: 45.sp,
                              color: Colors.white,
                            ),
                          ),
                ),
                Positioned(
                  top: 10.h,
                  left: 12,
                  child: MaterialDetails(
                    style: AppsStyles.s10Bold,
                    color: Colors.white,
                    backgroundColor: Colors.grey,
                    name: course.level?.name ?? "لللل",
                  ),
                ),
                course.hasInstallmentPlan == true
                    ? Positioned(child: installmentPlan(), top: 10.h, right: 6)
                    : const SizedBox.shrink(),
              ],
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
                    AppText(
                      text: course.subject?.name ?? "",
                      style: AppsStyles.s10Bold.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    2.verticalSpace,
                    AppText(text: course.title ?? "", style: AppsStyles.s12Bold),
                    5.verticalSpace,
                    nameTag(Icons.person, course.teacher?.name ?? ""),
                    Spacer(),
                    Row(
                      children:
                          course.totalLessons == 0
                              ? [
                                nameTag(
                                  Icons.access_time,
                                  (course.durationWeeks?.toString() ?? "") + "w",
                                ),
                              ]
                              : [
                                nameTag(
                                  Icons.videocam_outlined,
                                  (course.totalLessons?.toString() ?? "") +
                                      " Lessons",
                                ),
                                5.horizontalSpace,
                                nameTag(
                                  Icons.access_time,
                                  (course.durationWeeks?.toString() ?? "") + "w",
                                ),
                              ],
                    ),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        price(),
                     GestureDetector(
                          onTap: () {
                            AppNavaigation.pushToPageWithParams(
                              AppRoutes.courseDetails,
                              {'courseId': course.id, 'isBought': course.isOwned},
                            );
                          },
                          child:
                          course.isOwned == true ? _continueButton() :
                           ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Container(

                                                                                            color: Color(0xff53A1D2),

                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
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

  Widget installmentPlan() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        color: Colors.green,
        child: AppText(
          text: 'Installments',
          style: AppsStyles.s10Bold.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  Widget price() {
    return course.priceAfterDiscount != null
        ? RichText(
          text: TextSpan(
            text: '\$',
            style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
            children: [
              TextSpan(
                text: course.priceAfterDiscount.toString(),
                style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
              ),
              TextSpan(
                text: "\n" + course.price.toString(),
                style: AppsStyles.s12Bold.copyWith(
                  color: AppColors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        )
        : AppText(
          text: '\$' + course.price.toString(),
          style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
        );
  }

  Widget nameTag(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 15),
        5.horizontalSpace,
        SizedBox(
          width: 100.w,
          child: AppText(
            text: text,
            style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
          ),
        ),
      ],
    );
  }

  Widget _continueButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.buttonGradient1,
              AppColors.buttonGradient2,
            ],
          ),
          color: Color(0xff53A1D2),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
           "Continue",
            style: AppsStyles.s12Bold.copyWith(
              color: AppColors.white,
              height: 1.25,
            ),
          ),
        ),
      ),
    );
  }
}
