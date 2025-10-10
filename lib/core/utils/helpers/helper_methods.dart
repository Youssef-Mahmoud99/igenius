import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_colors.dart';

class HelperMethods {
  HelperMethods._();

  // ======== Date & Time ========
  static Future<String?> selectDate(BuildContext context, String? currentDateStr) async {
    DateTime now = DateTime.now();
    DateTime initialDate = currentDateStr != null && currentDateStr.isNotEmpty
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

  static Future<String?> selectTime(BuildContext context, String? currentTimeStr) async {
    TimeOfDay initialTime;
    if (currentTimeStr != null && currentTimeStr.isNotEmpty) {
      final parts = currentTimeStr.split(":");
      if (parts.length == 2) {
        initialTime = TimeOfDay(hour: int.tryParse(parts[0]) ?? 12, minute: int.tryParse(parts[1]) ?? 0);
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

  // ======== File Picker ========
  static Future<File?> pickFile({List<String>? allowedExtensions}) async {
    final result = await FilePicker.platform.pickFiles(
      type: allowedExtensions != null ? FileType.custom : FileType.any,
      allowedExtensions: allowedExtensions,
    );
    if (result != null && result.files.single.path != null) return File(result.files.single.path!);
    return null;
  }

  // ======== Share ========
  static Future<void> shareText(String text) async {
    await Share.share(text);
  }

  // ======== URL Launcher ========
  static Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
