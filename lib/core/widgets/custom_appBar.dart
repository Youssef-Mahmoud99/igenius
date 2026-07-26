import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';

import '../resources/styles_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final void Function()? onBack;
  final bool? centerTitle;
  final Widget? titleChild;
  final Widget? leading;

  const CustomAppBar({
    super.key,
    this.title,
    this.showBack = true,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 0,
    this.bottom,
    this.onBack,
    this.centerTitle,
    this.titleChild,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          titleChild ??
          Text(
            title ?? "",
            style: AppsStyles.s16Bold.copyWith(
              color: titleColor ?? Colors.black,
            ),
          ),
      centerTitle: centerTitle ?? true,
      leading:
          showBack == true
              ? IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20.r,
                ),
                onPressed: onBack ?? () => AppNavaigation.pop(),
              )
              : leading,
      actions: actions ?? [],
      backgroundColor: backgroundColor ?? Colors.white,
      elevation: elevation,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));
}
