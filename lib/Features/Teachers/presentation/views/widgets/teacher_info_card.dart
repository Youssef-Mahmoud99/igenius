import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/courses_view.dart';
import 'package:igenius/Features/Home/presentation/views/widgets/material_details.dart';
import 'package:igenius/Features/Teachers/data/models/teacher_details_model.dart';
import 'package:igenius/Features/Teachers/data/models/teacher_model.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../Courses/data/models/teacher.dart';

class TeacherInfoCard extends StatelessWidget {
  final TeacherDetailsModel teacher;
  TeacherInfoCard({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.buttonGradient1, AppColors.buttonGradient2],
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      width: double.infinity,
      child: Column(
        children: [
          teacher.image != null
              ? Container(
                  width: 120.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(teacher.image!),
                      fit: BoxFit.cover,
                      
                    ),
                  ),
                ):
          Card(
            shape: CircleBorder(),
            color: Colors.white.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                'DR',
                style: AppsStyles.s24Bold.copyWith(color: AppColors.white),
              ),
            ),
          ),
          10.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: teacher.name?.toUpperCase() ?? '',
                style: AppsStyles.s24Bold.copyWith(color: AppColors.white),
              ),
              6.horizontalSpace,
              Icon(Icons.verified, color: AppColors.white, size: 18),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: AppText(
              textAlign: TextAlign.center,
              text:  teacher.description ?? '',
              style: AppsStyles.s12Regular.copyWith(color: AppColors.greyLight),
            ),
          ),
          10.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...teacher.certificates?.map((item) {
                return titleandValue(
                  item.certificate ?? '',
                  item.university ?? '',
                  teacher.certificates?.indexOf(item) ?? 0,
                );
              }).toList() ?? [],
            ],
          ),
          20.verticalSpace,
          Wrap(
            children: [
              ...teacher.levels?.map((course) {
                return Padding(
                  padding:  8.rPadding,
                  child: MaterialDetails(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    color: AppColors.white.withOpacity(0.2),
                    backgroundColor: AppColors.white,
                    name: course.name ?? '',
                  ),
                );
              }).toList() ?? [],
            ],
          ),
        ],
      ),
    );
  }

  Widget titleandValue(String title, String value, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              text: value,
              style: AppsStyles.s20Bold.copyWith(color: AppColors.white),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: AppText(
                textAlign: TextAlign.center,
                text: title,
                style: AppsStyles.s12Regular.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
        20.horizontalSpace,
        index != 2
            ? Container(height: 50, width: 2, color: AppColors.grey)
            : SizedBox.shrink(),
      ],
    );
  }
}
