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
      children: courseDetails.units?.map((unit) {
        final List<LessonView> items = [];

        // Lessons
        items.addAll((unit.lessons ?? []).map((lesson) => LessonView(
          id: lesson.id ?? 0,
          type: LessonType.lesson,
              title: lesson.title ?? '',
              unitTitle: unit.title ?? '',
              duration: lesson.durationMinutes?.toString() ?? '',
              isPreview: lesson.isPreview ?? false,
              isLocked: (lesson.isBuyable ?? false),
            )));

        // Assignments
        items.addAll((unit.assignments ?? []).map((assignment) => LessonView(
          id: assignment.id ?? 0,
          unitTitle: unit.title ?? '',
              title: assignment.title ?? '',
              isPreview: false,
              isLocked: false,
              type: LessonType.quiz,
            )));

        // Exams
        items.addAll((unit.exams ?? []).map((exam) => LessonView(
          id: exam.id ?? 0,
          unitTitle: unit.title ?? '',
              title: exam.title ?? '',
              duration: exam.durationMinutes?.toString() ?? '',
              isPreview: false,
              isLocked: false,
              type: LessonType.exam,
            )));

        return UntiTile(
          title: unit.title ?? '',
          subtitle: unit.description ?? '',
          children: items,
        );
      }).toList() ?? [],
    );
  }
}