import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/data/models/course_details.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import 'package:igenius/core/widgets/primary_button.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../../core/widgets/gradient_button.dart';

void showFreeSessionBottomSheet(
  BuildContext context,
  CourseDetails courseDetails,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => FreeSessionDialoge(courseDetails: courseDetails),
  );
}

class FreeSessionDialoge extends StatefulWidget {
  const FreeSessionDialoge({Key? key, required this.courseDetails})
    : super(key: key);
  final CourseDetails courseDetails;

  @override
  _FreeSessionDialogeState createState() => _FreeSessionDialogeState();
}

class _FreeSessionDialogeState extends State<FreeSessionDialoge> {
  TextEditingController sessionData = TextEditingController();
  @override
  void dispose() {
    sessionData.dispose();
    super.dispose();
  }

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
                      text: widget.courseDetails.title ?? '',
                      style: AppsStyles.s12Bold,
                    ),
                    5.verticalSpace,
                    AppText(
                      text:
                          widget.courseDetails.description ??
                          'No description available',
                      style: AppsStyles.s10Regular.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            10.verticalSpace,
            CustomTextField(
              controller: sessionData,
              inputType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!value.contains("@")) {
                  return 'Invalid email address';
                }
                return null;
              },
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
                  AppText(
                    text: 'Request Free Live Session',
                    style: AppsStyles.s12Bold.copyWith(color: AppColors.white),
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
