import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:igenius/core/theme/app_colors.dart';

class AppDottedBorder extends StatelessWidget {
  const AppDottedBorder({
    Key? key,
    required this.child,
    this.radius,
    this.color,
  }) : super(key: key);
  final Widget child;
  final double? radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        borderPadding: EdgeInsets.zero,
        radius: Radius.circular(radius ?? 12),
        dashPattern: const [4, 4],
        color: color ?? AppColors.grey,
        strokeWidth: 2,
        padding: EdgeInsets.zero,
      ),
      child: child,
    );
  }
}
