import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';

class CustomCheckboxTile extends StatelessWidget {
  final String? title;
  final bool value;
  final ValueChanged<bool?>? onChanged;
  final Color activeColor;
  final Color checkColor;
  final Color tileColor;
  final Color borderColor; // اللون الجديد
  final double iconSize;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final Widget? titleWidget;

  const CustomCheckboxTile({
    Key? key,
    this.title,
    required this.value,
    this.onChanged,
    this.activeColor = AppColors.primary,
    this.checkColor = Colors.white,
    this.tileColor = Colors.white,
    this.borderColor = AppColors.primary, // افتراضي
    this.iconSize = 24.0,
    this.padding = const EdgeInsets.all(8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.titleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: activeColor,
          checkColor: checkColor,
          visualDensity: VisualDensity.compact,
        ),
        Expanded(
          child: titleWidget ?? Text(title ?? '', style: AppsStyles.s16Light),
        ),
      ],
    );
  }
}
