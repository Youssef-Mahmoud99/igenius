import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/utils/helpers/helper_methods.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class ChooseImageBottomSheet extends StatelessWidget {
  const ChooseImageBottomSheet({super.key});

  static Future<String?> show(BuildContext context) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => const ChooseImageBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5.h,
            width: 50.w,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text('Select Image Source', style: AppsStyles.s18Bold),
          SizedBox(height: 20.h),
          _buildOption(
            context,
            icon: Icons.photo_camera_rounded,
            title: 'Camera',
            value: 'camera',
          ),
          SizedBox(height: 12.h),
          _buildOption(
            context,
            icon: Icons.photo_library_rounded,
            title: 'Gallery',
            value: 'gallery',
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return InkWell(
      onTap: () async {
        File? pickedImage = await HelperMethods.pickImage(
          fromCamera: value == 'camera',
        );
        Navigator.pop(context, pickedImage?.path);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            SizedBox(width: 14.w),
            Text(title, style: AppsStyles.s16Medium),
          ],
        ),
      ),
    );
  }
}
