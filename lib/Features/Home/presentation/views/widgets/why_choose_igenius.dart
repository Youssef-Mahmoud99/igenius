import 'package:flutter/material.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/widgets/custom_listtile.dart';

class WhyChooseIgenius extends StatelessWidget {
  WhyChooseIgenius({Key? key}) : super(key: key);
  List data = [
    {
      "title": "All IGCSE Subjects",
      "subtitle":
          "Complete courses for Math, Physics,Chemistry, Biology, and more",
      "color": Colors.blue,
      "image": AppImages.courses,
    },
    {
      "title": "Expert Teachers",
      "subtitle":
          "Learn from certified IGCSE instructors with years of experience",
      "color": Colors.green,
      "image": AppImages.privacy,
    },
    {
      "title": "Track Progress",
      "subtitle":
          "Monitor performance with detailed analytics for students and parents",
      "color": Colors.purple,
      "image": AppImages.chart,
    },
    {
      "title": "Learn Anytime",
      "subtitle":
          "Access live sessions and recorded lessons 24/7 at your own pace",
      "color": Colors.orange,
      "image": AppImages.time,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    color: e["color"],
                    child: Image.asset(
                      e["image"],
                      color: Colors.white,
                      height: 30,
                    ),
                  ),
                ),
                title: Text(e["title"], style: AppsStyles.s16Bold),
                subtitle: Text(e["subtitle"], style: AppsStyles.s14Light),
                onTap: () {},
              ),
            );
          }),
        ],
      ),
    );
  }
}
