import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../Courses/data/models/courses_model.dart';
import 'teacher_course_card.dart';

class CoursesRowSection extends StatelessWidget {
  const CoursesRowSection({
    Key? key,
    required this.courses,
    this.title,
    this.onCourseTap,
  }) : super(key: key);

  final List<CourseModel> courses;
  final String? title;
  final void Function(CourseModel course)? onCourseTap;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          itemCount: courses.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            thickness: 0.6,
            indent: 60.w,
          ),
          itemBuilder: (context, index) {
            final course = courses[index];
            return CourseRowCard(
              course: course,
              onTap: () => onCourseTap?.call(course),
            );
          },
        ),
      ],
    );
  }
}