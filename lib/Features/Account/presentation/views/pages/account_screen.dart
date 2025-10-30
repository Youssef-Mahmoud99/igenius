import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/core/widgets/base/base_stateless.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_listtile.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/base_gradient.dart';

class AccountScreen extends BaseStatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  List<Map<String, dynamic>> courseDetails = [
    {
      'title': 'Lessons',
      'data': '48',
      'icon': Icons.menu_book,
      "color": Colors.blue,
      'colors': [Color(0xFF8B5CF6), Color(0xFF6366F1)],
    },
    {
      'title': 'Duration',
      'data': '24 Weeks',
      'icon': Icons.access_time_rounded,
      "color": Colors.red[900],
      'colors': [Color(0xFF8B5CF6), Color(0xFF6366F1)],
    },
    {
      'title': 'Certificate',
      'data': 'Yes',
      'icon': Icons.verified_outlined,
      "color": Colors.green,
      'colors': [Color(0xFF8B5CF6), Color(0xFF6366F1)],
    },
  ];
  List<String> userInfo = [
    'John Doe',
    'johndoe@gmail.com',
    'Student • Joined Sep 2025',
  ];
  @override
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: BaseGradient(
        height: double.infinity,
        width: double.infinity,
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
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ...courseDetails.map(
                            (item) => accountScreenTile(
                              item['icon'],
                              item['title'],
                              item['data'],
                              item['color'],
                              item['colors'],
                            ),
                          ),
                        ],
                      ),
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget accountScreenTile(
    IconData leadingIcon,
    String title,
    String subTitle,
    Color iconColor,
    List<Color> colors,
  ) {
    return Card(
      color: Colors.white,

      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.4),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomListTile(
          padding: EdgeInsets.zero,
          leading: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
            ),
            child: Icon(leadingIcon, color: iconColor),
          ),
          title: Text(title, style: AppsStyles.s14Bold),
          subtitle: Text(subTitle, style: AppsStyles.s12Light),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ),
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
              style: AppsStyles.s18Bold.copyWith(color: Colors.white),
            ),
            Spacer(),
            Icon(Icons.settings, color: Colors.white, size: 20.r),
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
                style: AppsStyles.s20Bold.copyWith(color: Colors.white),
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
                                ? AppsStyles.s18Bold.copyWith(
                                  color: Colors.white,
                                )
                                : AppsStyles.s14Regular.copyWith(
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
