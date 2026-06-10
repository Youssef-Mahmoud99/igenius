import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'core/constants/app_keys.dart';
import 'core/services/secure_storage_service.dart';
import 'core/utils/helpers/app_navigtion.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
    WhichPage();
  }

  Future<void> _getAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = info.version;
    });
  }
WhichPage()async {
  String? userToken =await SecureStorageService.read(AppKeys.token);
    Future.delayed(const Duration(seconds: 5), () {
      if (userToken != null) {
        AppNavaigation.goToHome(isGuest: false);
      } else {
        AppNavaigation.goToLogin();
      }
    });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🎨 الخلفية بدوائر متدرجة
          Positioned(top: -100, right: -100, child: pinkball()),
          Positioned(child: pinkball(radius: 170)),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 2.7,
            child: Image.asset(AppImages.logo2, height: 120.h),
          ),
          Positioned(
            bottom: -120,
            left: -100,
            child: Container(
              width: 250.w,
              height: 250.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFE4F7E6), // أخضر فاتح
                    Color(0xFFFAD1E5), // وردي أغمق شوية
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Positioned(left: 0, bottom: 100.h, right: 0, child: loadingPart()),
          Positioned(
            left: 0,
            top: 120.h,
            right: 0,
            child: Image.asset(AppImages.newLogo, height: 140.h),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [Spacer(), versionAndCopyRights()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pinkball({double? radius}) {
    return Container(
      width: radius ?? 250.w,
      height: radius ?? 250.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFE5EE), // وردي فاتح
            Color(0xFFFADBE9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget versionAndCopyRights() {
    return Column(
      children: [
        Text(
          'Version ${_appVersion.isEmpty ? "..." : _appVersion}',
          style: const TextStyle(fontSize: 12, color: Colors.black45),
        ),
        const SizedBox(height: 4),

        const Text(
          '© 2025 iGenius. All rights reserved.',
          style: TextStyle(fontSize: 11, color: Colors.black38),
        ),
      ],
    );
  }

  Widget loadingPart() {
    return Column(
      children: [
        30.verticalSpace,
        Container(
          child: const CircularProgressIndicator(
            strokeWidth: 3,
            color: AppColors.primary,
          ),
        ),

        20.verticalSpace,
        Text(
          'Loading your learning experience...',
          style: AppsStyles.s16Bold.copyWith(color: Colors.black45),
        ),

        40.verticalSpace,
        const Text(
          '"Learn Smarter, Achieve Higher"',
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black45),
        ),
      ],
    );
  }
}
