import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/primary_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/gradient_button.dart';

void showEnrollToCourseBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => const EnrollToCourseBottomSheet(),
  );
}

class EnrollToCourseBottomSheet extends StatelessWidget {
  const EnrollToCourseBottomSheet({Key? key}) : super(key: key);

  final List<String> courseEnrollBenefits = const [
    'Lifetime access to all course materials',
    'Certificate of completion',
    'Access to live sessions & recordings',
    'Direct support from instructor',
  ];

  final List<Map<String, dynamic>> courseDetails = const [
    {'data': '48 Lessons', 'icon': Icons.menu_book},
    {'data': '24 Weeks', 'icon': Icons.access_time_rounded},
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
                    AppText(
                      text: 'Advanced Mathematics',
                      style: AppsStyles.s12Bold,
                    ),
                    5.verticalSpace,
                    10.horizontalSpace,
                    Row(
                      children: [
                        ...courseDetails.map(
                          (item) =>
                              courseDetailsDisplay(item['icon'], item['data']),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            moneyDisplay(
              AppColors.greyDarker,
              AppColors.greyDarker,
              'Course Price',
              "\$299",
            ),
            5.verticalSpace,
            moneyDisplay(
              AppColors.green,
              AppColors.green,
              'Limited Time Discount',
              "-\$100",
            ),
            5.verticalSpace,
            const Divider(color: Colors.grey, height: 1, thickness: 1),
            10.verticalSpace,
            moneyDisplay(
              AppColors.black,
              AppColors.primary,
              'Total',
              "\$299",
              textStyle: AppsStyles.s14Bold,
            ),
            10.verticalSpace,
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: AppColors.borderGrey.withOpacity(0.5),
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                        text: 'What\'s Included:',
                        style: AppsStyles.s12Bold),
                    10.verticalSpace,
                    ...courseEnrollBenefits.map(
                      (item) => Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check,
                                color: Colors.green, size: 20),
                            5.horizontalSpace,
                            Expanded(
                              child: Text(item,
                                  style: AppsStyles.s12Regular),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            GradientButton(
              height: 40.h,
              text: 'Complete Enrollment',
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
              onPressed: () {
                AppNavaigation.pop();
              },
              text: 'Cancel',
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
        Text("Enroll in Course", style: AppsStyles.s16Bold),
        IconButton(
          onPressed: () {
            AppNavaigation.pop();
          },
          icon: Icon(Icons.close, size: 20.r),
        ),
      ],
    );
  }

  Widget courseDetailsDisplay(IconData icon, String data) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.greyDarker, size: 15.r),
          5.horizontalSpace,
          Text(
            data,
            style: AppsStyles.s12Regular
                .copyWith(color: AppColors.greyDarker),
          ),
        ],
      ),
    );
  }

  Widget moneyDisplay(
    Color titleColor,
    Color dataColor,
    String title,
    String data, {
    TextStyle? textStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textStyle?.copyWith(color: titleColor) ??
              AppsStyles.s12Regular.copyWith(color: titleColor),
        ),
        5.horizontalSpace,
        Text(
          data,
          style: textStyle?.copyWith(color: dataColor) ??
              AppsStyles.s12Regular.copyWith(color: dataColor),
        ),
      ],
    );
  }
}
