import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/primary_button.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../Home/presentation/views/widgets/material_details.dart';
import '../../../../Home/presentation/views/widgets/rating_view.dart';
import 'view_profile.dart';

class TeacherTile extends StatelessWidget {
  const TeacherTile({
    Key? key,
    required this.isGuest,
    required this.colors,
    required this.shortcut,
    required this.name,
    required this.materials,
    required this.rating,
    required this.students,
    this.inHome = true,
  }) : super(key: key);
  final bool isGuest;
  final List<Color> colors;
  final String shortcut;
  final String name;
  final List materials;
  final double rating;
  final String students;
  final bool? inHome;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circle with gradient
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
          ),
          child: Text(
            shortcut,
            style: AppsStyles.s16Bold.copyWith(color: Colors.white),
          ),
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
                      name,
                      style: AppsStyles.s14Bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  6.horizontalSpace,
                  Icon(Icons.verified, color: AppColors.blue, size: 16.r),
                ],
              ),
              6.verticalSpace,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    materials.map<Widget>((material) {
                      return MaterialDetails(
                        name: material["name"],
                        color: material["color"],
                        backgroundColor: material["titleColor"],
                      );
                    }).toList(),
              ),
              5.verticalSpace,
              Row(
                children: [
                  RatingView(
                    rating: rating,
                    students: students,
                    width: isGuest ? 100 : 70,
                  ),
                  isGuest ? SizedBox.shrink() : ViewProfile(),
                ],
              ),
              10.verticalSpace,
              inHome == false
                  ? Appbutton(
                    color: AppColors.secondary,
                    height: 30.h,
                    borderRadius: 12,
                    text: 'View Profile',
                    onPressed: () {
                      // AppNavaigation.push(AppRoutes.teacherProfile);
                    },
                  )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
  }
}
