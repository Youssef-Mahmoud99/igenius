import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import 'image_bottom_sheet.dart';

class ChangeImage extends StatefulWidget {
  const ChangeImage({Key? key, this.onImagePicked}) : super(key: key);
  final void Function(String?)? onImagePicked;
  @override
  _ChangeImageState createState() => _ChangeImageState();
}

class _ChangeImageState extends State<ChangeImage> {
  String? selectedSource;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          selectedSource == null ? defaultDisplay() : selectedImageView(),
          CustomTextButton(
            text: 'Change Photo',
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: AppColors.primary,
            onPressed: () async {
              final result = await ChooseImageBottomSheet.show(context);
              if (result != null) {
                setState(() => selectedSource = result);
                widget.onImagePicked?.call(result);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget defaultDisplay() {
    final double size = 100.w;

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.buttonGradient1, AppColors.buttonGradient2],
        ),
      ),
      child: Center(
        child: Text(
          'JD',
          style: AppsStyles.s28Bold.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget selectedImageView() {
    final double size = 100.w;

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(4), // ده المسافة بين الصورة والبوردر
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.buttonGradient1, AppColors.buttonGradient2],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        clipBehavior: Clip.antiAlias,
        child: ClipOval(
          child: Image.file(
            File(selectedSource!),
            fit: BoxFit.cover,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }
}
