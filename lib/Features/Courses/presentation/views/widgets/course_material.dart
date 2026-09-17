import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_listtile.dart';

class CourseMaterial extends StatelessWidget {
  const CourseMaterial({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.backgroundColor,
    required this.iconColor,
    this.leadingIcon,
    this.leadingImage,
    this.onView,
    this.onDownload,
    this.tileColor,
    this.isSecure = false,

    this.needBorder = true,
  }) : super(key: key);

  final String title;
  final String subTitle;
  final Color backgroundColor;
  final Color iconColor;
  final IconData? leadingIcon;
  final String? leadingImage;
  final bool?  isSecure;

  /// بيتنده لما المستخدم يدوس على أيقونة المعاينة (العين).
  final VoidCallback? onView;

  /// بيتنده لما المستخدم يدوس على أيقونة التحميل.
  final VoidCallback? onDownload;

  final Color? tileColor;
  final bool needBorder;

  Widget _actionButton({required VoidCallback? onTap, required IconData icon}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: backgroundColor,
          padding: EdgeInsets.all(10),
          child: Icon(icon, color: iconColor, size: 20.r),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: tileColor,
        border: needBorder == true ? Border.all(color: AppColors.grey) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: CustomListTile(
          padding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: backgroundColor,
              padding: EdgeInsets.all(10),
              child:
                  leadingImage != null
                      ? ImageIcon(
                        AssetImage(leadingImage!),
                        size: 25.r,
                        color: iconColor,
                      )
                      : Icon(leadingIcon, color: iconColor, size: 20.r),
            ),
          ),
          title: Text(title, style: AppsStyles.s12Bold),
          subtitle: Text(subTitle, style: AppsStyles.s10Regular),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (onView != null) ...[
                _actionButton(onTap: onView, icon: Icons.visibility_outlined),
                8.horizontalSpace,
              ],
              if (onDownload != null && isSecure == false)
                _actionButton(
                  onTap: onDownload,
                  icon: Icons.file_download_outlined,
                ),
            ],
          ),
        ),
      ),
    );
  }
}