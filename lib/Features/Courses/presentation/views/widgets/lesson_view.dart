import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';

import '../../../../../core/constants/app_routes.dart';
import 'preview_button.dart';

class LessonView extends StatelessWidget {
  final String title;
  final String duration;
  final bool isLocked;
  final bool isPreview;
  final bool isQuiz;
  const LessonView({
    super.key,
    required this.title,
    required this.duration,
    this.isLocked = false,
    this.isPreview = false,
    this.isQuiz = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLocked ? 0.6 : 1,
      child: GestureDetector(
        onTap: () {
          if (isQuiz && !isLocked) {
            AppNavaigation.push(AppRoutes.assignmentViewScreen);
          } else if (!isQuiz && !isLocked) {
            AppNavaigation.push(AppRoutes.lessonViewScreen);
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
                  color:
                      isLocked || isQuiz
                          ? Color(0xffE5E7EB)
                          : Color(0xffBFDBFE),
                  padding: const EdgeInsets.all(10),
                  child:
                      isQuiz
                          ? ImageIcon(
                            AssetImage(AppImages.answer),
                            color: Colors.grey,
                          )
                          : Icon(
                            isLocked
                                ? Icons.lock_outline
                                : Icons.play_circle_outlined,

                            color: isLocked ? Colors.grey : Colors.blueAccent,
                            size: 20.r,
                          ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppsStyles.s12Bold),
                    5.verticalSpace,
                    Text(
                      duration,
                      style: AppsStyles.s10Regular.copyWith(
                        color: isQuiz ? Colors.redAccent : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              if (isPreview) PreviewButton(),
              if (isLocked)
                Icon(Icons.lock_outline, color: Colors.grey, size: 20.r),
            ],
          ),
        ),
      ),
    );
  }
}
