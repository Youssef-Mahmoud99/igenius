import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../localization/strings_manager.dart';

class CustomDialogHelper {
  CustomDialogHelper._();

  static Future<void> showAlert({
    required BuildContext context,
    String? title,
    required String message,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoDialog(
        context: context,
        builder:
            (_) => CupertinoAlertDialog(
              title: Text(title ?? ''),
              content: Text(message),
              actions: [
                CupertinoDialogAction(
                  child: Text(strings(context).ok),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
    } else {
      return showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text(title ?? ''),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(strings(context).ok),
                ),
              ],
            ),
      );
    }
  }

  /// Confirmation (Yes / No)
  static Future<bool> showConfirmation({
    required BuildContext context,
    String? title,
    required String message,
    String? confirmText,
    String? cancelText,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoDialog<bool>(
        context: context,
        builder:
            (_) => CupertinoAlertDialog(
              title: Text(title ?? ''),
              content: Text(message),
              actions: [
                CupertinoDialogAction(
                  child: Text(cancelText ?? strings(context).cancel),
                  onPressed: () => Navigator.of(context).pop(false),
                ),
                CupertinoDialogAction(
                  child: Text(confirmText ?? strings(context).ok),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ),
      ).then((value) => value ?? false);
    } else {
      return showDialog<bool>(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text(title ?? ''),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(cancelText ?? strings(context).cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(confirmText ?? strings(context).ok),
                ),
              ],
            ),
      ).then((value) => value ?? false);
    }
  }

  /// Success / Error / Info
  static Future<void> showCustom({
    required BuildContext context,
    required String message,
    String? title,
    Color? titleColor,
    Color? contentColor,
    bool? isError = false,
  }) async {
    await showAlert(
      context: context,
      title:
          title ??
          (isError == true ? strings(context).unknownError : "success"),
      message: message,
    );
  }

  static Future<T?> showCustomBaseDialog<T>({
    required BuildContext context,
    Widget? title,
    required Widget body,
    List<Widget>? actions,
    bool barrierDismissible = true,
    EdgeInsetsGeometry? contentPadding,
    AlignmentGeometry alignment = Alignment.center,
  }) async {
    if (Platform.isIOS) {
      return showCupertinoDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (_) {
          return CupertinoAlertDialog(
            title: title,
            content: Padding(
              padding: contentPadding ?? const EdgeInsets.only(top: 8.0),
              child: body,
            ),

            actions: actions ??
                [
                 
                ],
          );
        },
      );
    } else {
      return showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (_) {
          return AlertDialog(
            alignment: alignment,
            title: title,
            contentPadding: contentPadding ?? const EdgeInsets.all(16),
            content: body,
            actions: actions ??
                [
                
                ],
          );
        },
      );
    }
  }
}
