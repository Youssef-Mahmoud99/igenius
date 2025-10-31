import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/styles_manager.dart';
import '../../../../core/theme/app_colors.dart';

class CustomCheckTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final Widget? trailing;

  const CustomCheckTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      dense: true,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: AppColors.primary,
      value: value,
      title: Row(
        children: [
          Text(title, style: AppsStyles.s12Regular),
          if (trailing != null) ...[5.horizontalSpace, trailing!],
        ],
      ),
      onChanged: onChanged,
    );
  }
}