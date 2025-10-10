import 'package:flutter/material.dart';

class CustomModalBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    bool isDismissible = false,
    bool enableDrag = true,
    bool useSafeArea = true,
    double? height,
    BorderRadius? borderRadius,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      useSafeArea: useSafeArea,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: height,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: borderRadius ??
                const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: child,
        );
      },
    );
  }
}
