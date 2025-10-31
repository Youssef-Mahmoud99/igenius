import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/widgets/custom_listtile.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.leadingIcon,
    required this.iconColor,
    required this.colors,
    required this.route,
    this.isNotifications,
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String leadingIcon;
  final Color iconColor;
  final List<Color> colors;
  final String route;
  final bool? isNotifications;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,

      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.4),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomListTile(
          onTap: () {
            AppNavaigation.push(route);
          },
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
            child:
                isNotifications == true
                    ? Badge(
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      label: Text('5'),
                      child: ImageIcon(
                        AssetImage(leadingIcon),
                        color: iconColor,
                        size: 20.r,
                      ),
                    )
                    : ImageIcon(
                      AssetImage(leadingIcon),
                      color: iconColor,
                      size: 20.r,
                    ),
          ),
          title: Text(title, style: AppsStyles.s14Bold),
          subtitle: Text(subTitle, style: AppsStyles.s12Light),
          trailing: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 20.r,
            ),
          ),
        ),
      ),
    );
  }
}
