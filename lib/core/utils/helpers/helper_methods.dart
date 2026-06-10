import 'dart:io';
import 'package:flutter/material.dart';
import 'package:igenius/core/utils/helpers/toast_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app.dart';
import '../../services/secure_storage_service.dart';
import '../../theme/app_colors.dart';
import 'app_navigtion.dart';

class HelperMethods {
  HelperMethods._();

  // ======== Date & Time ========
  static Future<String?> selectDate(
    BuildContext context,
    String? currentDateStr,
  ) async {
    DateTime now = DateTime.now();
    DateTime initialDate =
        currentDateStr != null && currentDateStr.isNotEmpty
            ? DateTime.tryParse(currentDateStr) ?? now
            : now;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1940, 1),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            hintColor: AppColors.grey,
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      return "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    }
    return currentDateStr;
  }

  static Future<String?> selectTime(
    BuildContext context,
    String? currentTimeStr,
  ) async {
    TimeOfDay initialTime;
    if (currentTimeStr != null && currentTimeStr.isNotEmpty) {
      final parts = currentTimeStr.split(":");
      if (parts.length == 2) {
        initialTime = TimeOfDay(
          hour: int.tryParse(parts[0]) ?? 12,
          minute: int.tryParse(parts[1]) ?? 0,
        );
      } else {
        initialTime = TimeOfDay.now();
      }
    } else {
      initialTime = TimeOfDay.now();
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      return "$hour:$minute";
    }
    return currentTimeStr;
  }

  // ======== Image Picker ========
  static Future<File?> pickImage({required bool fromCamera}) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 85,
    );
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }

 static Future<File?> pickAssignmentFile(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        final fileSizeInMB = (file.size / (1024 * 1024));

        if (fileSizeInMB > 5) {
          ToastHelper.showWarning("File size must be less than 5 MB");
          return null;
        }

        final fileExtension = file.extension?.toLowerCase();
        if (fileExtension != 'pdf' &&
            fileExtension != 'doc' &&
            fileExtension != 'docx') {
          ToastHelper.showError("Only PDF or Word files are allowed");
          return null;
        }

        return File(file.path!);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("File pick error: $e");
      ToastHelper.showError("Failed to pick file");
      return null;
    }
  }

  // ======== Share ========
  static Future<void> shareText(String text) async {
    await Share.share(text);
  }
  

 static logout()async{
  
   await SecureStorageService.clear();
   currentUser = null;
   currentStudent = null;   AppNavaigation.goToLogin();

 }
 
}
