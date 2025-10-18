import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool dense;
  final bool enabled;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const CustomListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.margin = EdgeInsets.zero,
    this.dense = false,
    this.enabled = true,
    this.backgroundColor,
    this.height,
    this.width,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: borderRadius,
      ),
      child: ListTile(
        contentPadding: padding,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
        onTap: enabled ? onTap : null,
        dense: dense,
        enabled: enabled,
        tileColor:
            Colors.transparent, // نخليها شفاف علشان Container يتحكم في اللون
        shape: null,
      ),
    );
  }
}

class CustomListTile2 extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool dense;
  final bool enabled;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final bool? wantCenter;

  const CustomListTile2({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.margin = EdgeInsets.zero,
    this.dense = false,
    this.enabled = true,
    this.backgroundColor,
    this.height,
    this.width,
    this.borderRadius,
    this.wantCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      child: Container(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: borderRadius,
        ),
        child: Row(
          crossAxisAlignment:
              wantCenter == true
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,

          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 12)],
            if (title != null)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:
                      subtitle != null
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                  children: [
                    title!,
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      subtitle!,
                    ],
                  ],
                ),
              ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              Center(child: trailing!),
            ],
          ],
        ),
      ),
    );
  }
}
