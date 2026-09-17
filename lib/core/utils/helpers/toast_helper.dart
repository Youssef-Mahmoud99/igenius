// lib/core/helpers/toast_helper.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../theme/app_colors.dart';



class ToastHelper {
  static void showSuccess(String message) {
    _showToast(message, backgroundColor: AppColors.success);
  }

  static void showError(String message) {
    _showToast(message, backgroundColor: AppColors.error);
  }

  static void showWarning(String message) {
    _showToast(message, backgroundColor: AppColors.warning,color: Colors.black );
  }

  static void showInfo(String message) {
    _showToast(message, backgroundColor: AppColors.primary);
  }

  static void _showToast(
    String message, {
    required Color backgroundColor,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Toast toastLength = Toast.LENGTH_SHORT,
    Color? color,
  }) {
    Fluttertoast.showToast(

      msg: message,
      gravity: gravity,
      toastLength: toastLength,
      backgroundColor: backgroundColor,
      textColor: color?? Colors.white,
      fontSize: 16.0,
    );
  }
}
