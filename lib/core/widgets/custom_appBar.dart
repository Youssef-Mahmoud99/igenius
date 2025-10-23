import 'package:flutter/material.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';

import '../resources/styles_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? titleColor;
  final double elevation;
  final PreferredSizeWidget? bottom;
  final void Function()? onBack;
  final bool? centerTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.actions,
    this.backgroundColor,
    this.titleColor,
    this.elevation = 0,
    this.bottom,
    this.onBack,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppsStyles.s20Bold.copyWith(color: titleColor ?? Colors.black),
      ),
      centerTitle: centerTitle ?? true,
      leading:
          showBack == true
              ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                onPressed: onBack ?? () => AppNavaigation.pop(),
              )
              : null,
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
