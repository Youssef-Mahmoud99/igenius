import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/primary_button.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../Home/presentation/views/widgets/rating_view.dart';
import '../../../data/models/teacher_model.dart';

class TeacherTile extends StatelessWidget {
  const TeacherTile({
    Key? key,
    required this.isGuest,
    this.inHome = true,
    required this.teacher,
  }) : super(key: key);
  final bool isGuest;
  final bool? inHome;
  final TeacherModel teacher;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circle with gradient
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
        12.horizontalSpace,
        // Info column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      teacher.name ?? '',
                      style: AppsStyles.s14Bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  6.horizontalSpace,
                  Icon(Icons.verified, color: AppColors.blue, size: 16.r),
                ],
              ),
              6.verticalSpace,
              Text(
                      teacher.description ?? '',
                      maxLines: 2,
                      style: AppsStyles.s12Regular,
                      overflow: TextOverflow.ellipsis,
                    ),
              // Wrap(
              //   spacing: 8,
              //   runSpacing: 8,
              //   children:
              //       teacher.?.map<Widget>((material) {
              //         return MaterialDetails(
              //           name: material["name"],
              //           color: material["color"],
              //           backgroundColor: material["titleColor"],
              //         );
              //       }).toList(),
              // ),
              5.verticalSpace,
              Row(
                children: [
                  RatingView(
                    rating: teacher.averageRating?.toDouble() ?? 0,
                    students: teacher.ratedStudentsCount.toString() ?? "",
                    width:  70,
                  ),
                ],
              ),
              10.verticalSpace,
             Appbutton(
                    color: AppColors.secondary,
                    height: 30.h,
                    borderRadius: 12,
                    text: 'View Profile',
                    onPressed: () {
                      AppNavaigation.pushToPageWithParams(
                        AppRoutes.teacherProfile,
                        {'teacherId': teacher.id},
                      );
                    },
                  )
            ],
          ),
        ),
      ],
    );
  }
}
