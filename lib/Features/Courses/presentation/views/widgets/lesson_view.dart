import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/Features/payment/presentation/cubits/buy_lesson_cubit.dart';
import 'package:igenius/app.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';

import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../payment/data/models/buy_lesson_params.dart';
import 'preview_button.dart';

class LessonView extends StatelessWidget {
  final String title;
  final String? unitTitle;
  final String? duration;
  final bool isLocked;
  final bool isPreview;
  final LessonType type;
  final int id;
  final bool isOwned; // الكورس مشترى
  final bool isLessonOwned; // الدرس نفسه مشترى
  final num? price; // لو > 0 الدرس متاح للشراء

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
    this.isLessonOwned = false,
    this.price,
  });

  /// عنده صلاحية (الكورس كله أو الدرس لوحده مشترى)
  bool get _hasAccess => isOwned || isLessonOwned;

  /// الدرس مقفول فعلاً (مش مشترى ومش preview)
  bool get _isReallyLocked => isLocked && !_hasAccess && !isPreview;

  /// يظهر زرار preview
  bool get _showPreview =>
      type == LessonType.lesson && isPreview && !_hasAccess;

  /// يظهر زرار Buy: درس، ليه سعر حقيقي، ومش مملوك
  bool get _showBuy =>
      type == LessonType.lesson &&
      !_hasAccess &&
      price != null &&
      price! > 0;

  /// الباهت يتطبق على الأيقونة والعنوان بس
  double get _contentOpacity => isLocked && !_hasAccess ? 0.6 : 1;

  void _openLesson() {
    AppNavaigation.pushToPageWithParams(
      AppRoutes.lessonViewScreen,
      {
        'lessonId': id,
        'unitTitle': unitTitle,
        'isOwned': _hasAccess,
      },
    );
  }

  void _onTap() {
    if (_isReallyLocked && !_showBuy) return;

    switch (type) {
      case LessonType.quiz:
        if (currentUser != null) {
          if (isOwned) {
            AppNavaigation.pushToPageWithParams(
              AppRoutes.assignmentViewScreen,
              {'id': id, 'unitTitle': unitTitle, 'isExam': false},
            );
          } else {
            ToastHelper.showWarning(
              "You can access this assignment only after purchasing it",
            );
          }
        } else {
          ToastHelper.showWarning("Please login to access this assignment");
        }
        break;

      case LessonType.exam:
        if (currentUser != null) {
          if (isOwned) {
            AppNavaigation.pushToPageWithParams(
              AppRoutes.assignmentViewScreen,
              {'id': id, 'unitTitle': unitTitle, 'isExam': true},
            );
          } else {
            ToastHelper.showWarning(
              "You can access this exam only after purchasing it",
            );
          }
        } else {
          ToastHelper.showWarning("Please login to access this exam");
        }
        break;

      case LessonType.lesson:
        if (currentUser != null) {
          if (isPreview || _hasAccess) {
            _openLesson();
          } else {
            ToastHelper.showWarning(
              "You can access this lesson only after purchasing it",
            );
          }
        } else {
          ToastHelper.showWarning("Please login to access this lesson");
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xfff8f8f8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // ---------- الأيقونة (باهتة لو مقفول) ----------
            Opacity(
              opacity: _contentOpacity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 40.w,
                  color: _iconBgColor(),
                  padding: const EdgeInsets.all(10),
                  child: _buildIcon(),
                ),
              ),
            ),

            10.horizontalSpace,

            // ---------- العنوان (باهت لو مقفول) ----------
            Expanded(
              child: Opacity(
                opacity: _contentOpacity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: title, style: AppsStyles.s12Bold),
                    if (type == LessonType.lesson &&
                        (duration?.isNotEmpty ?? false)) ...[
                      5.verticalSpace,
                      AppText(
                        text: "${duration}m",
                        style: AppsStyles.s10Regular.copyWith(
                          color: AppColors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // ---------- الأزرار (برّا الـ Opacity => لونها كامل) ----------
            if (_showPreview || _showBuy)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_showPreview)
                    PreviewButton(
                      onPressed: () {
                        if (currentUser != null) {
                          _openLesson();
                        } else {
                          ToastHelper.showWarning(
                            "Please login to access this lesson",
                          );
                        }
                      },
                    ),

                  if (_showPreview && _showBuy) 6.verticalSpace,

                  if (_showBuy)
                    PreviewButton(
                      text: 'Buy Lesson',
                      onPressed: () {
                        context.read<BuyLessonCubit>().buyLesson(
                              BuylessonParams(
                                method: "paymob_card",
                                id: id,
                              ),
                            );
                      },
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _buildIcon() {
    final locked = isLocked && !_hasAccess;
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
          locked ? Icons.lock_outline : Icons.play_circle_outlined,
          color: locked ? Colors.grey : Colors.blueAccent,
        );
    }
  }

  Color _iconBgColor() {
    final locked = isLocked && !_hasAccess;
    switch (type) {
      case LessonType.exam:
        return const Color(0xffFEE2E2);

      case LessonType.quiz:
        return Colors.amberAccent.withOpacity(0.2);

      case LessonType.lesson:
        return locked ? const Color(0xffE5E7EB) : const Color(0xffBFDBFE);
    }
  }
}

enum LessonType { lesson, quiz, exam }