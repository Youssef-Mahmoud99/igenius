import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/constants/app_routes.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/custom_text_button.dart';
import '../../../../Notifications/presentation/cubits/notifications_cubit.dart';

class HeadLine extends StatelessWidget {
  const HeadLine({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.logo, height: 40.h, fit: BoxFit.contain),
          isGuest ? _buildLogin() : _buildNotificationIcon(context),
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return CustomTextButton(
      text: 'Login',
      color: AppColors.primary,
      fontWeight: FontWeight.w500,
      onPressed: () => AppNavaigation.push(AppRoutes.login),
    );
  }

  Widget _buildNotificationIcon(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => AppNavaigation.push(AppRoutes.notificationsScreen),
      child: SizedBox(
        width: 44.r,
        height: 44.r,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            ImageIcon(
              AssetImage(AppImages.notifications),
              size: 28.r,
              color: Colors.black87,
            ),
            Positioned(
              top: 4.r,
              right: 4.r,
              child: ValueListenableBuilder<int>(
                valueListenable:
                    context.read<GetNotificationsCubit>().unreadCountNotifier,
                builder: (context, count, _) {
                  if (count <= 0) return const SizedBox.shrink();

                  return Container(
                    constraints: BoxConstraints(
                      minWidth: 18.r,
                      minHeight: 18.r,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Text(
                      count > 99 ? '99+' : count.toString(),
                      style: TextStyle(
                        fontSize: 10.sp,
                        height: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}