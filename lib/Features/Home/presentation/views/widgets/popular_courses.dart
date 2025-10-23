import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/home_course_card.dart';

import '../../../../../core/resources/assets_manager.dart';
import '../../../../Courses/data/models/courses_model.dart';

class PopularCourses extends StatelessWidget {
  final bool isGuest;

  PopularCourses({Key? key, this.isGuest = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CoursesModel> courses = [
      CoursesModel(
        tag: "Most Popular",
        tagIcon: "🔥",
        title: "Advanced Mathematics",
        subtitle: "Master algebra, geometry, and calculus",
        category: "Mathematics",
        categoryColor: Color(0xFF1D4ED8),
        categoryBackgroundColor: Color(0xFFDCFCE7),
        rating: 4.9,
        price: "\$299",
        gradientColors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
        image: AppImages.calculator,
      ),
      CoursesModel(
        tag: "Trending",
        tagIcon: "📈",
        title: "Advanced Physics",
        subtitle: "Mechanics, thermodynamics",
        category: "Physics",
        categoryColor: Color(0xFF4338CA),
        categoryBackgroundColor: Color(0xFFFEE2E2),
        rating: 4.8,
        price: "\$249",
        gradientColors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
        image: AppImages.calculator,
      ),
      CoursesModel(
        tag: "New",
        tagIcon: "✨",
        title: "Organic Chemistry",
        subtitle: "Introduction to organic chemistry",
        category: "Chemistry",
        categoryColor: Color(0xFF15803D),
        categoryBackgroundColor: Color(0xFFDCFCE7),
        rating: 4.7,
        price: "\$199",
        gradientColors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
        image: AppImages.calculator,
      ),
    ];

    final filteredCourses =
        isGuest
            ? courses.take(2).toList()
            : courses.sublist(courses.length - 2); // آخر اتنين

    return SizedBox(
      height: 300.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: filteredCourses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final course = filteredCourses[index];
          return SizedBox(width: 260.w, child: HomeCourseCard(course: course));
        },
      ),
    );
  }
}
