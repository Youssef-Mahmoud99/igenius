import 'package:flutter/material.dart';
import 'package:igenius/Features/Home/presentation/views/widgets/material_details.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/widgets/custom_listtile.dart';

import '../../../../../core/theme/app_colors.dart';

class UpcomingDeadlines extends StatelessWidget {
  UpcomingDeadlines({Key? key}) : super(key: key);
  List data = [
    {
      "day": "24",
      "month": "Dec",
      "colors": [Color(0xffEF4444), Color(0xffF97316)],
      "title": "Mathematics Assignment 3",
      "subtitle": "Due in 2 days",
      "status": "Urgent",
      "statusColor": Color(0xffB91C1C),
      "statusBackgorundColor": Color(0xffFEE2E2),
    },
    {
      "day": "28",
      "month": "Dec",
      "colors": [Color(0xff3B82F6), Color(0xffA855F7)],
      "title": "Physics Unit Test",
      "subtitle": "Due in 6 days",
      "status": "Soon",
      "statusColor": Color(0xffA16207),
      "statusBackgorundColor": Color(0xffFEF9C3),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ...data.map((e) {
            return Card(
              color: Colors.white,
              elevation: 6,
              shadowColor: Colors.grey.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: EdgeInsets.only(bottom: 16),
              child: CustomListTile2(
                wantCenter: true,
                leading: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: e["colors"],
                    ),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: e["day"],
                          style: AppsStyles.s28Bold.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        TextSpan(text: "\n"),
                        TextSpan(
                          text: e["month"],
                          style: AppsStyles.s16Regular.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                title: SizedBox(
                  width: 130,
                  child: Text(e["title"], style: AppsStyles.s16Bold),
                ),
                subtitle: Text(e["subtitle"], style: AppsStyles.s14Regular),
                trailing: MaterialDetails(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 2,
                  ),
                  color: e['statusBackgorundColor'],
                  backgroundColor: e['statusColor'],
                  name: e["status"],
                ),
                onTap: () {},
              ),
            );
          }),
        ],
      ),
    );
  }
}
