import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppsStyles {
  static const String fontFamily = 'Roboto'; // غيرها حسب المشروع

  /// Generate TextStyle dynamically
  static TextStyle text({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color ?? AppColors.black,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Quick predefined sizes
  static TextStyle get s10Light => text(size: 10, weight: FontWeight.w300);
  static TextStyle get s10Regular => text(size: 10, weight: FontWeight.w400);
  static TextStyle get s10Medium => text(size: 10, weight: FontWeight.w500);
  static TextStyle get s10SemiBold => text(size: 10, weight: FontWeight.w600);
  static TextStyle get s10Bold => text(size: 10, weight: FontWeight.w700);
  static TextStyle get s10ExtraBold => text(size: 10, weight: FontWeight.w800);

  static TextStyle get s12Light => text(size: 12, weight: FontWeight.w300);
  static TextStyle get s12Regular => text(size: 12, weight: FontWeight.w400);
  static TextStyle get s12Medium => text(size: 12, weight: FontWeight.w500);
  static TextStyle get s12SemiBold => text(size: 12, weight: FontWeight.w600);
  static TextStyle get s12Bold => text(size: 12, weight: FontWeight.w700);
  static TextStyle get s12ExtraBold => text(size: 12, weight: FontWeight.w800);

  static TextStyle get s14Light => text(size: 14, weight: FontWeight.w300);
  static TextStyle get s14Regular => text(size: 14, weight: FontWeight.w400);
  static TextStyle get s14Medium => text(size: 14, weight: FontWeight.w500);
  static TextStyle get s14SemiBold => text(size: 14, weight: FontWeight.w600);
  static TextStyle get s14Bold => text(size: 14, weight: FontWeight.w700);
  static TextStyle get s14ExtraBold => text(size: 14, weight: FontWeight.w800);

  static TextStyle get s16Light => text(size: 16, weight: FontWeight.w300);
  static TextStyle get s16Regular => text(size: 16, weight: FontWeight.w400);
  static TextStyle get s16Medium => text(size: 16, weight: FontWeight.w500);
  static TextStyle get s16SemiBold => text(size: 16, weight: FontWeight.w600);
  static TextStyle get s16Bold => text(size: 16, weight: FontWeight.w700);
  static TextStyle get s16ExtraBold => text(size: 16, weight: FontWeight.w800);

  static TextStyle get s18Light => text(size: 18, weight: FontWeight.w300);
  static TextStyle get s18Regular => text(size: 18, weight: FontWeight.w400);
  static TextStyle get s18Medium => text(size: 18, weight: FontWeight.w500);
  static TextStyle get s18SemiBold => text(size: 18, weight: FontWeight.w600);
  static TextStyle get s18Bold => text(size: 18, weight: FontWeight.w700);
  static TextStyle get s18ExtraBold => text(size: 18, weight: FontWeight.w800);

  static TextStyle get s20Light => text(size: 20, weight: FontWeight.w300);
  static TextStyle get s20Regular => text(size: 20, weight: FontWeight.w400);
  static TextStyle get s20Medium => text(size: 20, weight: FontWeight.w500);
  static TextStyle get s20SemiBold => text(size: 20, weight: FontWeight.w600);
  static TextStyle get s20Bold => text(size: 20, weight: FontWeight.w700);
  static TextStyle get s20ExtraBold => text(size: 20, weight: FontWeight.w800);

  static TextStyle get s24Light => text(size: 24, weight: FontWeight.w300);
  static TextStyle get s24Regular => text(size: 24, weight: FontWeight.w400);
  static TextStyle get s24Medium => text(size: 24, weight: FontWeight.w500);
  static TextStyle get s24SemiBold => text(size: 24, weight: FontWeight.w600);
  static TextStyle get s24Bold => text(size: 24, weight: FontWeight.w700);
  static TextStyle get s24ExtraBold => text(size: 24, weight: FontWeight.w800);

  static TextStyle get s28Light => text(size: 28, weight: FontWeight.w300);
  static TextStyle get s28Regular => text(size: 28, weight: FontWeight.w400);
  static TextStyle get s28Medium => text(size: 28, weight: FontWeight.w500);
  static TextStyle get s28SemiBold => text(size: 28, weight: FontWeight.w600);
  static TextStyle get s28Bold => text(size: 28, weight: FontWeight.w700);
  static TextStyle get s28ExtraBold => text(size: 28, weight: FontWeight.w800);

  static TextStyle get s32Light => text(size: 32, weight: FontWeight.w300);
  static TextStyle get s32Regular => text(size: 32, weight: FontWeight.w400);
  static TextStyle get s32Medium => text(size: 32, weight: FontWeight.w500);
  static TextStyle get s32SemiBold => text(size: 32, weight: FontWeight.w600);
  static TextStyle get s32Bold => text(size: 32, weight: FontWeight.w700);
  static TextStyle get s32ExtraBold => text(size: 32, weight: FontWeight.w800);
}
