// core/utils/loading_helper.dart
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingHelper {
  EasyLoadingHelper._();

  static void config() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.blue
      ..backgroundColor = Colors.black.withOpacity(0.7)
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.5)
      ..maskType = EasyLoadingMaskType.black
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  static void show({String? message}) {
    EasyLoading.show(status: message ?? 'Loading...');
  }

  static void dismiss() => EasyLoading.dismiss();

  static void showSuccess(String message) => EasyLoading.showSuccess(message);
  static void showLoading() => EasyLoading.show(status: 'Loading...');

  static void showError(String message) => EasyLoading.showError(message);

  static void showInfo(String message) => EasyLoading.showInfo(message);

  static void showProgress(double progress, {String? status}) =>
      EasyLoading.showProgress(progress, status: status);
}
