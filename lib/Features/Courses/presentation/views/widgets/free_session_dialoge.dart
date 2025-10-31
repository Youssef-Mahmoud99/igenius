import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/primary_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/gradient_button.dart';

void showFreeSessionBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const FreeSessionBottomSheet(),
  );
}

class FreeSessionBottomSheet extends StatelessWidget {
  const FreeSessionBottomSheet({Key? key}) : super(key: key);

  final List<String> freeSessionDetails = const [
    'Interact with the instructor in real-time',
    'Ask questions and get instant answers',
    'Experience our teaching style before enrolling',
    '100% free, no credit card required',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            titleandClose(),
            10.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: const Color(0xffFDF2F8),
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    liveView(),
                    10.verticalSpace,
                    AppText(
                      text: 'Introduction to Number Systems',
                      style: AppsStyles.s12Bold,
                    ),
                    5.verticalSpace,
                    AppText(
                      text:
                          'Join Dr. Robert Williams for a free introductory session covering the basics of number systems.',
                      style:
                          AppsStyles.s10Regular.copyWith(color: AppColors.grey),
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
                    const Icon(Icons.check, color: Colors.green, size: 20),
                    5.horizontalSpace,
                    Expanded(
                        child: Text(item, style: AppsStyles.s12Regular)),
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            GradientButton(
              gradientColors: const [Color(0xFFEF4444), Color(0xFFEC4899)],
              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  5.horizontalSpace,
                  Text(
                    'Request Free Live Session',
                    style: AppsStyles.s12Bold
                        .copyWith(color: AppColors.white),
                  ),
                  10.horizontalSpace,
                  Icon(
                    Icons.play_circle_outline_sharp,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                ],
              ),
              onTap: () {
                AppNavaigation.pop();
              },
            ),
            10.verticalSpace,
            Appbutton(
              height: 40.h,
              borderRadius: 12,
              borderColor: AppColors.grey,
              needBorder: true,
              color: AppColors.white,
              textColor: AppColors.black,
              onPressed: () {
                AppNavaigation.pop();
              },
              text: 'Maybe Later',
            ),
          ],
        ),
      ),
    );
  }

  Widget titleandClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Free Live Session", style: AppsStyles.s14Bold),
        IconButton(
          onPressed: () {
            AppNavaigation.pop();
          },
          icon: Icon(Icons.close, size: 20.r),
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
          decoration: const BoxDecoration(
            color: AppColors.red,
            shape: BoxShape.circle,
          ),
        ),
        5.horizontalSpace,
        Text(
          'Live Session',
          style: AppsStyles.s12Bold.copyWith(color: AppColors.red),
        ),
      ],
    );
  }
}
