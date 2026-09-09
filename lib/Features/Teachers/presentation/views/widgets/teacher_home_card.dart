import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../Home/presentation/views/widgets/rating_view.dart';
import '../../../data/models/teacher_model.dart';

class PopularTeacherCard extends StatelessWidget {
  const PopularTeacherCard({
    Key? key,
    required this.teacher,
  }) : super(key: key);

  final TeacherModel teacher;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
                              AppNavaigation.pushToPageWithParams(
                        AppRoutes.teacherProfile,
                        {'teacherId': teacher.id},
                      );

      },
      child: Container(
        width: 150.w,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                
                Container(
                  width: 64.r,
                  height: 64.r,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                    image: (teacher.image != null && teacher.image!.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(teacher.image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: (teacher.image == null || teacher.image!.isEmpty)
                      ? Text(
                          (teacher.name?.isNotEmpty == true)
                              ? teacher.name!.substring(0, 1)
                              : '',
                          style: AppsStyles.s16Bold.copyWith(color: Colors.white),
                        )
                      : null,
                ),
                Positioned(
                  bottom: -1,
                  right: -2,
                  child: Icon(Icons.verified, color: AppColors.blue, size: 16.r),
                ),
              ],
            ),
            8.verticalSpace,
            Text(
              teacher.name ?? '',
              style: AppsStyles.s14Bold,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              teacher.description ?? '',
              style: AppsStyles.s12Regular,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
      
            // if ((teacher.school ?? '').isNotEmpty) ...[
            //   2.verticalSpace,
            //   Text(
            //     teacher.school!,
            //     style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
            //     textAlign: TextAlign.center,
            //     maxLines: 1,
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ],
            6.verticalSpace,
            Center(
              child: RatingView(
                rating: teacher.averageRating?.toDouble() ?? 0,
                students: teacher.ratedStudentsCount?.toString() ?? '0',
                width: 90,
              ),
            ),
            // 6.verticalSpace,
          ],
        ),
      ),
    );
  }
}