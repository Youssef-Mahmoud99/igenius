import 'package:flutter/material.dart';
import '../../../data/models/course_details.dart';
import 'lesson_view.dart';
import 'unti_tile.dart';

class CourseContent extends StatelessWidget {
  const CourseContent({Key? key, required this.courseDetails}) : super(key: key);
  final CourseDetails courseDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children:  courseDetails.units?.map((unit) => UntiTile(
        lessons: unit.lessons?.map((lesson) => LessonView(
          title: lesson.title ?? '',
          duration: lesson.durationMinutes?.toString() ?? '',
          isPreview: lesson.isPreview ?? false,
          isLocked: lesson.isBuyable ?? false,
          isQuiz: lesson.isPreview ?? false,
        )).toList() ?? [],
        title: unit.title ?? '',
        subtitle: unit.description ?? '',
      )).toList() ?? [],
    );
  }
}
