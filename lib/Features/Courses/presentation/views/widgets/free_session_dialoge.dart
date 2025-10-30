import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/primary_button.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_listtile.dart';
import '../../../../../core/widgets/gradient_button.dart';

class FreeSessionDialoge extends StatelessWidget {
  FreeSessionDialoge({Key? key}) : super(key: key);
  List<String> freeSessionDetails = [
    'Interact with the instructor in real-time',
    'Ask questions and get instant answers',
    'Experience our teaching style before enrolling',
    '100% free, no credit card required',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        titleandClose(),
        10.verticalSpace,
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Color(0xffFDF2F8),
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                liveView(),
                10.verticalSpace,
                AppText(
                  text: 'Introduction to Number Systems',
                  style: AppsStyles.s14Bold,
                ),
                5.verticalSpace,
                AppText(
                  text:
                      'Join Dr. Robert Williams for a free introductory session covering the basics of number systems.',
                  style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
        ),
        10.verticalSpace,
        ...freeSessionDetails.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Icon(Icons.check, color: Colors.green, size: 20),
                5.horizontalSpace,
                Expanded(child: Text(item, style: AppsStyles.s12Regular)),
              ],
            ),
          ),
        ),
        10.verticalSpace,
        GradientButton(
          gradientColors: [Color(0xFFEF4444), Color(0xFFEC4899)],
          height: 40.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10.w,
                height: 10.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              5.horizontalSpace,
              Text(
                'Request Free Live Session',
                style: AppsStyles.s14Bold.copyWith(color: AppColors.white),
              ),
              10.horizontalSpace,
              Icon(Icons.play_circle_outline_sharp, color: AppColors.white),
            ],
          ),
          onTap: () {},
        ),
        10.verticalSpace,
        Appbutton(
          height: 40.h,
          borderRadius: 12,
          borderColor: AppColors.grey,
          needBorder: true,
          color: AppColors.white,
          textColor: AppColors.black,
          onPressed: () {},
          text: 'Maybe Later',
        ),
      ],
    );
  }

  Widget titleandClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Free Live Session", style: AppsStyles.s16Bold),
        IconButton(
          onPressed: () {
            AppNavaigation.pop();
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Widget liveView() {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(
            color: AppColors.red,
            shape: BoxShape.circle,
          ),
        ),
        5.horizontalSpace,
        Text(
          'Live Session',
          style: AppsStyles.s14Bold.copyWith(color: AppColors.red),
        ),
      ],
    );
  }
}
