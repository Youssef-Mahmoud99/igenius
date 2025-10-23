import 'package:flutter/material.dart';
import 'package:igenius/Features/Teachers/presentation/views/widgets/teacher_tile.dart';
import '../../../../../core/theme/app_colors.dart';

class TeachersView extends StatelessWidget {
  TeachersView({Key? key, required this.isGuest, required this.inHome})
    : super(key: key);
  final bool isGuest;
  final bool inHome;

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
    final displayData = inHome ? data : [...data, ...data];

    return Padding(
      padding: const EdgeInsets.all(20.0).copyWith(bottom: 0),
      child: Column(
        children: List.generate(displayData.length, (index) {
          final teacher = displayData[index];
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
              child: TeacherTile(
                colors: teacher["colors"],
                shortcut: teacher["shortcut"],
                name: teacher["name"],
                materials: teacher["materials"],
                rating: teacher["rating"],
                students: teacher["students"],
                isGuest: isGuest,
                inHome: inHome,
              ),
            ),
          );
        }),
      ),
    );
  }
}
