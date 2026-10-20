import 'package:flutter/material.dart';
import '../../../data/models/course_details.dart';
import 'lesson_view.dart';
import 'unti_tile.dart';

class CourseContent extends StatelessWidget {
  const CourseContent({Key? key, required this.courseDetails})
      : super(key: key);
  final CourseDetails courseDetails;

  @override
  Widget build(BuildContext context) {
    final courseOwned = courseDetails.isOwned ?? false;

    return Column(
      children: courseDetails.units?.map((unit) {
        
            final List<LessonView> items = [];

            // Lessons
            items.addAll((unit.lessons ?? []).map((lesson) {
              final lessonOwned = lesson.isOwned ?? false;
              final preview = lesson.isPreview ?? false;
debugPrint('LESSON ${lesson.id} owned=$lessonOwned preview=$preview price=${lesson.price} courseOwned=$courseOwned');
              return LessonView(
                id: lesson.id ?? 0,
                type: LessonType.lesson,
                title: lesson.title ?? '',
                unitTitle: unit.title ?? '',
                duration: lesson.durationMinutes?.toString() ?? '',
                isPreview: preview,
                isOwned: courseOwned,
                isLessonOwned: lessonOwned,
                price: lesson.price,
                // مقفول لو الكورس مش مشترى والدرس مش مشترى ومش preview
                isLocked: !courseOwned && !lessonOwned && !preview,
              );
            }));

            // Assignments
            items.addAll((unit.assignments ?? []).map((assignment) =>
                LessonView(
                  id: assignment.id ?? 0,
                  type: LessonType.quiz,
                  title: assignment.title ?? '',
                  unitTitle: unit.title ?? '',
                  isOwned: courseOwned,
                  isPreview: false,
                  isLocked: !courseOwned,
                )));

            // Exams
            items.addAll((unit.exams ?? []).map((exam) => LessonView(
                  id: exam.id ?? 0,
                  type: LessonType.exam,
                  title: exam.title ?? '',
                  unitTitle: unit.title ?? '',
                  duration: exam.durationMinutes?.toString() ?? '',
                  isOwned: courseOwned,
                  isPreview: false,
                  isLocked: !courseOwned,
                )));

            return UntiTile(
              title: unit.title ?? '',
              subtitle: unit.description ?? '',
              children: items,
            );
          }).toList() ??
          [],
    );
  }
}