import 'package:flutter/material.dart';

import '../../../../core/resources/styles_manager.dart';
import '../../../../core/theme/app_colors.dart';

class CustomRadioTile<T> extends StatelessWidget {
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const CustomRadioTile({
    Key? key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      dense: true,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      contentPadding: EdgeInsets.zero,
      activeColor: AppColors.primary,
      value: value,
      groupValue: groupValue,
      title: Text(title, style: AppsStyles.s12Regular),
      onChanged: onChanged,
    );
  }
}
