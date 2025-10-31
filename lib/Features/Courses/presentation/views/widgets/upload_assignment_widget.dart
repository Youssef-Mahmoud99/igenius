import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/helper_methods.dart';
import '../../../../../core/widgets/app_dotted_border.dart';
import '../../../../../core/widgets/custom_text.dart';

class UploadAssignmentWidget extends StatelessWidget {
  const UploadAssignmentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDottedBorder(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              IconButton(
                onPressed: () async {
                  final file = await HelperMethods.pickAssignmentFile(context);
                  if (file != null) {
                    print("Picked file path: ${file.path}");
                  }
                },
                icon: ImageIcon(
                  AssetImage(AppImages.upload),
                  color: AppColors.grey,
                  size: 30.r,
                ),
              ),
              AppText(text: 'Upload your answer', style: AppsStyles.s14Regular),
              5.verticalSpace,
              AppText(
                text: 'Click to browse or drag and drop',
                style: AppsStyles.s10Regular.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
