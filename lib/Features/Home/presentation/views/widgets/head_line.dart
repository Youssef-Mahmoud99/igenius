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
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
                    Center(child: Image.asset(AppImages.logo, scale: 2)),
          isGuest
              ? CustomTextButton(
                text: 'Login',
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
                onPressed: () {
                  AppNavaigation.push(AppRoutes.login);
                },
              )
              : Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () {
                      AppNavaigation.push(AppRoutes.notificationsScreen);
                    },
                    icon: ImageIcon(
                      AssetImage(AppImages.notifications),
                      size: 30.r,
                    ),
                  ),
                  Positioned(
                    top: 2.h,
                    right: 5.w,
                    child:
                    ValueListenableBuilder<int>(
                  valueListenable:
                      context.read<GetNotificationsCubit>().unreadCountNotifier,
                  builder: (context, count, _) => 
                    
                   Container(
                    padding: const EdgeInsets.all(3.0),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: count > 0 ? Text(
                         style: TextStyle(fontSize: 10.sp, color: Colors.white, fontWeight: FontWeight.bold),
                        count.toString()) : null,
                    ) 
                ),
                     
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
