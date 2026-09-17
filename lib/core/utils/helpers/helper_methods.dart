import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:igenius/core/constants/app_constants.dart';
import 'package:igenius/core/utils/helpers/toast_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Features/Courses/presentation/views/pages/image_view_screen.dart';
import '../../../Features/Courses/presentation/views/pages/pdf_review_screen.dart';
import '../../../app.dart';
import '../../localization/strings_manager.dart';
import '../../services/localization_service.dart';
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
      initialEntryMode: DatePickerEntryMode.calendarOnly,
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

  static logout() async {
    await SecureStorageService.clear();
    currentUser = null;
    AppNavaigation.goToLogin();
  }

  static Future<int> getAndroidSdkInt() async {
    final info = await Process.run('getprop', ['ro.build.version.sdk']);
    return int.tryParse(info.stdout.toString().trim()) ?? 33;
  }

  static Future<bool> downloadFile({
    required String url,
    required String fileName,
    required BuildContext context,
    void Function(double progress)? onProgress,
  }) async {
    try {
      Directory? baseDir;

      if (Platform.isAndroid) {
        final sdkInt = await getAndroidSdkInt();

        if (sdkInt <= 32) {
          final status = await Permission.storage.request();

          if (!status.isGranted) {
            print('Storage permission denied');
            return false;
          }
        }

        baseDir = Directory('/storage/emulated/0/Download/IGENIUS');
      } else if (Platform.isIOS) {
        final appDir = await getApplicationDocumentsDirectory();
        baseDir = Directory('${appDir.path}/IGENIUS');
      }

      if (!await baseDir!.exists()) {
        await baseDir.create(recursive: true);
      }

      // Get extension from URL
      final uri = Uri.parse(url);
      final path = uri.path;

      final extension = path.contains('.') ? path.split('.').last : '';

      // Build original file name
      final originalFileName =
          extension.isNotEmpty ? '$fileName.$extension' : fileName;

      // Find available file name
      String finalFileName = originalFileName;
      int counter = 1;

      while (await File('${baseDir.path}/$finalFileName').exists()) {
        finalFileName =
            extension.isNotEmpty
                ? '${fileName}_$counter.$extension'
                : '${fileName}_$counter';

        counter++;
      }

      final finalPath = '${baseDir.path}/$finalFileName';

      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/$finalFileName';

      final tempFile = File(tempPath);

      if (await tempFile.exists()) {
        await tempFile.delete();
      }

      await Dio().download(
        url,
        tempPath,
        deleteOnError: true,
        onReceiveProgress: (received, total) {
          if (total != -1 && onProgress != null) {
            onProgress(received / total);
          }
        },
      );

      await File(tempPath).copy(finalPath);

      if (await File(tempPath).exists()) {
        await File(tempPath).delete();
      }

      // Success Toast
      ToastHelper.showSuccess('File downloaded successfully');

      return true;
    } catch (e) {
      ToastHelper.showError('Failed to download file $e');
      print('downloadFile error: $e');
      return false;
    }
  }

  static Future<void> requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.photos.isDenied) {
        await Permission.photos.request();
      }

      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }
    }
  }

 static String getLanguage(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    return languageCode;
  }

static  Future<DateTimeRange?> pickDateRange(
    BuildContext context,
    DateTime today,
    DateTimeRange? selectedRange,
    VoidCallback? onReset, // هتستدعي لما نضغط Reset
  ) async {
    DateTimeRange? picked = selectedRange;

    String languageCode = getLanguage( context);
    final result = await showDateRangePicker(
      context: context,
      firstDate: today.subtract(const Duration(days: 365)),
      lastDate: today.add(const Duration(days: 365)),
      initialDateRange: selectedRange,
      locale: Locale(
        languageCode == 'ar' ? "ar" : 'en',
        languageCode == 'ar' ? "SA" : 'US',
      ),
      builder: (context, child) {
        return Column(
          children: [
            Expanded(child: child!),
            // زر Reset
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.clear),
                label: Text(strings(context).resetFilter),
                onPressed: () {
                  picked = null; // عمل Reset
                  if (onReset != null) onReset();
                  Navigator.of(context).pop(null); // ارجع null
                },
              ),
            ),
          ],
        );
      },
    );
    return result;
  }


    // ======== File Preview / View ========

  static bool isImageFile(String? nameOrUrl) {
    if (nameOrUrl == null || nameOrUrl.isEmpty) return false;
    final cleanPath = nameOrUrl.split('?').first;
    final ext =
        cleanPath.contains('.') ? cleanPath.split('.').last.toLowerCase() : '';
    const imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
    return imageExtensions.contains(ext);
  }

  static bool isPdfFile(String? nameOrUrl) {
    if (nameOrUrl == null || nameOrUrl.isEmpty) return false;
    final cleanPath = nameOrUrl.split('?').first;
    final ext =
        cleanPath.contains('.') ? cleanPath.split('.').last.toLowerCase() : '';
    return ext == 'pdf';
  }

  /// بيفتح صفحة عرض مستقلة على حسب امتداد الملف:
  /// صورة -> صفحة Full Screen، PDF -> صفحة PDF Viewer،
  /// أي نوع تاني -> فتح خارجي بالفيوير الافتراضي في الجهاز.
  static Future<void> pushFileViewer({
    required BuildContext context,
    required String? url,
    required String fileName,
  }) async {
    if (url == null || url.isEmpty) {
      ToastHelper.showWarning("No file available to preview");
      return;
    }

    if (isImageFile(url) || isImageFile(fileName)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ImagePreviewScreen(imageUrl: url, title: fileName),
        ),
      );
      return;
    }

    if (isPdfFile(url) || isPdfFile(fileName)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => PdfPreviewScreen(pdfUrl: url, title: fileName),
        ),
      );
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null || !await canLaunchUrl(uri)) {
      ToastHelper.showError("Couldn't open file");
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static Future<void> downloadFileSafely({
    required BuildContext context,
    required String? url,
    required String fileName,
  }) async {
    if (url == null || url.isEmpty) {
      ToastHelper.showWarning("No file available to download");
      return;
    }
    await downloadFile(url: url, fileName: fileName, context: context);
  }

  bool canEnroll(dynamic courseData) {
  // المستخدم مش مسجل دخول
  if (currentUser == null) {
    return false;
  }

  // الكورس مملوك بالفعل
  if (courseData.isOwned == true) {
    return false;
  }

  // الكورس خاص وعدد المنضمين 1
  if (courseData.isPrivate == true && courseData.enrollmentsCount == 1) {
    return false;
  }

  // الكورس وصل للحد الأقصى للطلاب
  if (courseData.maxStudents != null &&
      courseData.enrollmentsCount != null &&
      courseData.maxStudents ==courseData.enrollmentsCount) {
    return false;
  }

  return true;
}
}
