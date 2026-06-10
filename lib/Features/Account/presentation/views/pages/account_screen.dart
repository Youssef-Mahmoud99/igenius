import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Account/presentation/views/widgets/account_tile.dart';
import 'package:igenius/Features/Account/presentation/views/widgets/settings_item.dart';
import 'package:igenius/core/constants/app_routes.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import '../../../../../app.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/base_gradient.dart';

class AccountScreen extends BaseStatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  List<Map<String, dynamic>> courseDetails = [
    {
      'title': 'My Profile',
      'data': 'View and edit your personal information',
      'icon': AppImages.editprofile,
      "color": Colors.blue,
      'colors': [Color(0xFFDCFCE7), Color(0xFFBFDBFE)],
      'route': AppRoutes.editProfileScreen,
    },
    {
      'title': 'My Courses',
      'data': 'Access your enrolled courses and progress',
      'icon': AppImages.mycourses,
      "color": Colors.purple,
      'colors': [Color(0xFFFEFCE8), Color(0xFFFFEDD5)],
      'route': AppRoutes.myCoursesScreen,
    },
    {
      'title': 'Notification Center',
      'data': 'View your alerts and updates',
      'icon': AppImages.notifications,
      "color": Color(0xffEA580C),
      'colors': [Color(0xFFFFEDD5), Color(0xFFFED7AA)],
      'isNotifications': true,
      'route': AppRoutes.notificationsScreen,
    },
    {
      'title': 'About Us',
      'data': 'Learn more about iGenius platform',
      'icon': AppImages.aboutus,
      "color": Color(0xffDB2777),
      'colors': [Color(0xFFFEFCE8), Color(0xFFFBCFE8)],
      'route': AppRoutes.aboutUsScreen,
    },
  ];
  List<String> userInfo = [
    currentUser?.name ?? 'John Doe',
    currentUser?.email ?? 'johndoe@gmail.com',
    'Student • Joined Sep 2025',
  ];
  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: BaseGradient(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.buttonGradient1,
                            AppColors.buttonGradient2,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(20.0),

                      width: double.infinity,
                      child: accountDetails(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0).copyWith(bottom: 0),
                      child: Column(
                        children: [
                          ...courseDetails.map(
                            (item) => AccountTile(
                              title: item['title'],
                              subTitle: item['data'],
                              leadingIcon: item['icon'],
                              iconColor: item['color'],
                              colors: item['colors'],
                              route: item['route'],
                              isNotifications: item['isNotifications'],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0).copyWith(top: 0),
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.4),
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 4,
                        ),
                        child: Column(
                          children: [
                            SettingsItem(
                              title: 'Help & Support',
                              icon: Icons.help_outline,
                              route: AppRoutes.helpAndSupportScreen,
                            ),
                            Divider(color: Colors.grey),
                            SettingsItem(
                              title: 'Privacy Policy',
                              icon: Icons.description_outlined,
                              route: AppRoutes.privacyPolicyScreen,
                            ),
                            Divider(color: Colors.grey),
                            SettingsItem(
                              title: 'Logout',
                              icon: Icons.logout,
                              index: 3,
                              
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget accountDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "My Account",
              style: AppsStyles.s16Bold.copyWith(color: Colors.white),
            ),
            // Spacer(),
            // Icon(Icons.settings, color: Colors.white, size: 20.r),
          ],
        ),
        10.verticalSpace,
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2),
              ),
              child: Text(
                "JD",
                style: AppsStyles.s18Bold.copyWith(color: Colors.white),
              ),
            ),
            20.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...userInfo
                    .map(
                      (item) => Text(
                        item,
                        style:
                            userInfo.indexOf(item) == 0
                                ? AppsStyles.s14Bold.copyWith(
                                  color: Colors.white,
                                )
                                : AppsStyles.s12Regular.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
