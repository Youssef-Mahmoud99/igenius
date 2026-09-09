import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../Courses/data/models/courses_model.dart';

class CourseRowCard extends StatelessWidget {
  const CourseRowCard({
    Key? key,
    required this.course,
    this.onTap,
  }) : super(key: key);

  final CourseModel course;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // صورة الكورس
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: (course.image != null && course.image!.isNotEmpty)
                    ? Image.network(
                        course.image!,
                        width: 48.w,
                        height: 48.w,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _placeholderImage(),
                      )
                    : _placeholderImage(),
              ),
              12.horizontalSpace,
        
              // العنوان + subject · level
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      course.title ?? '',
                      style: AppsStyles.s14Bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    4.verticalSpace,
                    Text(
                      [
                        if ((course.subject?.name ?? '').isNotEmpty)
                          course.subject!.name!,
                        if ((course.level?.name ?? '').isNotEmpty)
                          course.level!.name!,
                      ].join(' · '),
                      style: AppsStyles.s12Regular.copyWith(
                        color: AppColors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
        
              8.horizontalSpace,
        
              // السعر + السهم
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${course.effectivePrice ?? course.price ?? 0}',
                    style: AppsStyles.s14Bold.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      width: 48.w,
      height: 48.w,
      color: AppColors.borderGrey,
      child: Icon(Icons.menu_book_outlined, color: AppColors.grey, size: 22),
    );
  }
}


