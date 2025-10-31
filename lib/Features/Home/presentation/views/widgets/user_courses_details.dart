import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';

class UserCoursesDetails extends StatelessWidget {
  UserCoursesDetails({Key? key}) : super(key: key);
  List data = [
    {
      "title": "Courses",
      "value": "8",
      "color": Colors.blue,
      "image": AppImages.courses,
    },
    {
      "title": "Completed",
      "value": "45",
      "color": Colors.green,
      "image": AppImages.privacy,
    },
    {
      "title": "This Week",
      "value": "12h",
      "color": Colors.orange,
      "image": AppImages.time,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...data.map((e) {
          return dataBuild(e["title"], e["value"], e["image"], e["color"]);
        }),
      ],
    );
  }

  Widget dataBuild(String title, String value, String image, Color color) {
    return Container(
      width: 100.w,
      height: 120.h,
      child: Card(
        color: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.only(bottom: 16),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: color,
                  child: Image.asset(image, color: Colors.white, height: 25.h),
                ),
              ),

              6.verticalSpace,
              Text(value, style: AppsStyles.s16Bold),
              Text(title, style: AppsStyles.s10Regular),
            ],
          ),
        ),
      ),
    );
  }
}
