import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/app.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../../core/widgets/custom_text.dart';
import 'preview_button.dart';

class LessonView extends StatelessWidget {
  final String title;
  final String? unitTitle;
  final String? duration;
  final bool isLocked;
  final bool isPreview;
  final LessonType type;
  final int id;
  final bool isOwned;

  const LessonView({
    super.key,
    required this.title,
    this.unitTitle,
    this.duration,
    this.isLocked = false,
    this.isPreview = false,
    this.type = LessonType.lesson,
    required this.id,
    required this.isOwned,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLocked ? 0.6 : 1,
      child: GestureDetector(
        onTap: () {
          if (isLocked) return;

          switch (type) {
            case LessonType.quiz:
              if (currentUser != null  ){
                if (isOwned) {
                  AppNavaigation.pushToPageWithParams(AppRoutes.assignmentViewScreen, {
                    'id': id,
                    'unitTitle': unitTitle,
                    'isExam': false,
                  });
                }
                else{
                  print( "user Name: ${currentUser?.user?.name}");
                  ToastHelper.showWarning("You can access this assignment only after purchasing it");
                }
              }
              else{
                ToastHelper.showWarning("Please login to access this  assignment");
              }
              break;

            case LessonType.exam:
              if (currentUser != null  ){
                if (isOwned) {
                  AppNavaigation.pushToPageWithParams(AppRoutes.assignmentViewScreen, {
                    'id': id,
                    'unitTitle': unitTitle,
                    'isExam': true,
                  });
                }
                else{
                  ToastHelper.showWarning("You can access this exam only after purchasing it");
                }
              }
              else{
                ToastHelper.showWarning("Please login to access this exam");
              }
              break;

            case LessonType.lesson:
            if (currentUser != null  ){
              if ( isPreview || isOwned) {
              AppNavaigation.pushToPageWithParams(AppRoutes.lessonViewScreen, {
                'lessonId': id,
                'unitTitle': unitTitle,
                'isOwned': isOwned,
              });

              }
              else{
                ToastHelper.showWarning("You can access this lesson only after purchasing it");
              }

            }
            else{
              ToastHelper.showWarning("Please login to access this lesson");
            }
              break;
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xfff8f8f8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 40.w,
                  color: _iconBgColor(),
                  padding: const EdgeInsets.all(10),
                  child: _buildIcon(),
                ),
              ),

              10.horizontalSpace,

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: title, style: AppsStyles.s12Bold),
                    5.verticalSpace,
                    type == LessonType.lesson
                        ? Row(
                          children: [
                            AppText(
                              text: duration! + "m",
                              style: AppsStyles.s10Regular.copyWith(
                                color: AppColors.grey,
                              ),
                            ),
                          ],
                        )
                        : SizedBox.shrink(),
                  ],
                ),
              ),

              if (isPreview) PreviewButton(onPressed: () {}),

              if (isLocked) PreviewButton(onPressed: () {}, text: 'Buy'),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _buildIcon() {
    switch (type) {
      case LessonType.exam:
        return Icon(
          size: 20.r,
          FontAwesomeIcons.calendar,
          color: Colors.redAccent,
        );

      case LessonType.quiz:
        return ImageIcon(AssetImage(AppImages.answer), color: Colors.amber);

      case LessonType.lesson:
        return Icon(
          isLocked ? Icons.lock_outline : Icons.play_circle_outlined,
          color: isLocked ? Colors.grey : Colors.blueAccent,
        );
    }
  }

  Color _iconBgColor() {
    switch (type) {
      case LessonType.exam:
        return const Color(0xffFEE2E2); // light red

      case LessonType.quiz:
        return Colors.amberAccent.withOpacity(0.2); // gray

      case LessonType.lesson:
        return isLocked
            ? const Color(0xffE5E7EB)
            : const Color(0xffBFDBFE); // blue
    }
  }
}

// ---------------- ENUM ----------------

enum LessonType {
  lesson,
  quiz, // assignment
  exam,
}
