import 'package:flutter/material.dart';
import 'package:igenius/core/theme/app_colors.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? height;
  final String? fontFamily;
  final TextStyle? style;

  const AppText({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.height,
    this.fontFamily,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines ?? 4,
      overflow: overflow ?? TextOverflow.ellipsis,
      style:
          style ??
          TextStyle(
            fontSize: fontSize ?? 14,
            color: color ?? AppColors.primary,
            fontWeight: fontWeight ?? FontWeight.normal,
            decoration: decoration,
            height: height,
            fontFamily: fontFamily,
          ),
    );
  }
}
