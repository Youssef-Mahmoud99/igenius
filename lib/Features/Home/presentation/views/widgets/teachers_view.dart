import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import 'material_details.dart';

class TeachersView extends StatelessWidget {
  TeachersView({Key? key, required this.isGuest}) : super(key: key);
  final bool isGuest;

  List data = [
    {
      "shortcut": "DR",
      "colors": [AppColors.buttonGradient1, AppColors.buttonGradient2],
      "name": "Dr. Robert Williams",
      "materials": [
        {
          "name": "Mathematics",
          "color": Color(0xffDCFCE7),
          "titleColor": Color(0xff1D4ED8),
        },
        {
          "name": "Physics",
          "color": Color(0xffFCE7F3),
          "titleColor": Color(0xff7E22CE),
        },
      ],
      "rating": 4.9,
      "students": "1,234",
    },
    {
      "shortcut": "SJ",
      "colors": [Color(0xffA855F7), Color(0xffEC4899)],
      "name": "Dr. Sarah Johnson",
      "materials": [
        {
          "name": "Chemistry",
          "color": Color(0xffDCFCE7),
          "titleColor": Color(0xff15803D),
        },
        {
          "name": "Biology",
          "color": Color(0xffCCFBF1),
          "titleColor": Color(0xff0F766E),
        },
      ],
      "rating": 4.9,
      "students": "987",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0).copyWith(bottom: 0),
      child: Column(
        children: List.generate(data.length, (index) {
          final teacher = data[index];
          return Card(
            color: Colors.white,
            elevation: 6,
            shadowColor: Colors.grey.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: courseDetailsTile(
                teacher["colors"],
                teacher["shortcut"],
                teacher["name"],
                teacher["materials"],
                teacher["rating"],
                teacher["students"],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget courseDetailsTile(
    List<Color> colors,
    String shortcut,
    String name,
    List materials,
    double rating,
    String students,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circle with gradient
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: colors,
            ),
          ),
          child: Text(
            shortcut,
            style: AppsStyles.s20Bold.copyWith(color: Colors.white),
          ),
        ),
        12.horizontalSpace,
        // Info column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: AppsStyles.s18Bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  6.horizontalSpace,
                  Icon(Icons.verified, color: AppColors.blue, size: 18),
                ],
              ),
              6.verticalSpace,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    materials.map<Widget>((material) {
                      return MaterialDetails(
                        name: material["name"],
                        color: material["color"],
                        backgroundColor: material["titleColor"],
                      );
                    }).toList(),
              ),
              5.verticalSpace,
              Row(children: [ratingView(rating, students)]),
            ],
          ),
        ),
      ],
    );
  }

  Widget ratingView(double rating, String students) {
    return Row(
      children: [
        Icon(Icons.star, color: AppColors.orange, size: 20),
        5.horizontalSpace,
        Text(rating.toString(), style: AppsStyles.s14Bold),
        20.horizontalSpace,
        SizedBox(
          width: isGuest ? 100 : 70,
          child: Text("$students Students", style: AppsStyles.s14Light),
        ),
        isGuest
            ? SizedBox.shrink()
            : ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                color: Color(0xff53A1D2),
                width: 100.w,
                child: Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    'View Profile',
                    style: AppsStyles.s16Bold.copyWith(
                      color: AppColors.white,
                      height: 1.25,
                    ),
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
