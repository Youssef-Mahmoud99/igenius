import 'package:flutter/material.dart';

import 'custom_dialoge.dart';

class AppDialogs {
  AppDialogs._();

  static void showErrorDialog(BuildContext context, String message) {
    CustomDialogHelper.showAlert(context: context, message: message);
  }

  static void showSuccessDialog(BuildContext context, String message) {
    CustomDialogHelper.showConfirmation(context: context, message: message);
  }
}
