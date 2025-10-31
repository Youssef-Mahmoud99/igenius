import 'package:flutter/material.dart';
import 'package:igenius/core/theme/app_colors.dart';
import '../resources/styles_manager.dart';

class Appbutton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final bool enabled;
  final bool needBorder;
  final double? borderRadius;
  final Color? borderColor;
  final TextStyle? textStyle;

  const Appbutton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 50,
    this.color,
    this.textColor,
    this.enabled = true,
    this.needBorder = false,
    this.borderRadius,
    this.borderColor,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDisabled = isLoading || !enabled;

    final Color effectiveBackgroundColor =
        isDisabled
            ? AppColors.greyLight
            : (color ?? Theme.of(context).primaryColor);

    final Color effectiveTextColor =
        isDisabled ? AppColors.grey : (textColor ?? Colors.white);

    return Opacity(
      opacity: isDisabled ? 0.8 : 1,
      child: MaterialButton(
        onPressed: isDisabled ? null : onPressed,
        color: effectiveBackgroundColor,
        disabledColor: effectiveBackgroundColor,
        height: height,
        minWidth: width ?? double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 40),
          side:
              needBorder == true
                  ? BorderSide(
                    color: borderColor ?? AppColors.primary,
                    width: 2,
                  )
                  : BorderSide.none,
        ),
        child:
            isLoading
                ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 2,
                  ),
                )
                : Text(
                  text,
                  style:
                      textStyle ??
                      AppsStyles.s14Bold.copyWith(color: effectiveTextColor),
                ),
      ),
    );
  }
}
