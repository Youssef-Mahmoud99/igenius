import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/courses_view.dart';
import 'package:igenius/Features/Home/presentation/views/widgets/material_details.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class TeacherInfoCard extends StatelessWidget {
  TeacherInfoCard({Key? key}) : super(key: key);
  List<Map<String, dynamic>> data = [
    {"title": "Rating", "value": "★ 4.9"},
    {"title": "Students", "value": "1,234"},
    {"title": "Reviews", "value": "243"},
  ];

  List<String> materialNames = ["Mathematics", "Physics"];
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
                text: 'Dr. Robert Williams',
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
              text: 'Mathematics & Physics Expert',
              style: AppsStyles.s12Regular.copyWith(color: AppColors.greyLight),
            ),
          ),
          10.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...data.map((item) {
                return titleandValue(
                  item["title"],
                  item["value"],
                  data.indexOf(item),
                );
              }).toList(),
            ],
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...materialNames.map((material) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: MaterialDetails(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    color: AppColors.white.withOpacity(0.2),
                    backgroundColor: AppColors.white,
                    name: material,
                  ),
                );
              }).toList(),
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
