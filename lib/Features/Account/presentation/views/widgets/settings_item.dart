import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import 'logout_sheet.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.index,
    this.route,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final int? index;
  final String? route;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (index == 3) {
            LogoutBottomSheet.show(context);
          } else {
            AppNavaigation.push(route ?? "");
          }
        },
        child: Row(
          children: [
            Icon(
              icon,
              color: index == 3 ? Colors.red : Colors.black,
              size: 20.r,
            ),
            20.horizontalSpace,
            Text(
              title,
              style: AppsStyles.s12Bold.copyWith(
                color: index == 3 ? Colors.red : Colors.black,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: index == 3 ? Colors.red : Colors.grey,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
