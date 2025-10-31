import 'package:flutter/material.dart';
import 'lesson_view.dart';
import 'unti_tile.dart';

class CourseContent extends StatelessWidget {
  const CourseContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UntiTile(
          title: "Unit 1: Number Systems",
          subtitle: "6 lessons • 2 assignments • 1 exam",
          lessons: [
            LessonView(
              title: "Introduction to Number Systems",
              duration: "15 min • Video",
              isPreview: true,
              isLocked: false,
            ),
            LessonView(
              title: "Integers and Rational Numbers",
              duration: "20 min • Video",
              isLocked: true,
            ),
            LessonView(
              title: "Real Numbers and Operations",
              duration: "25 min • Video",
              isLocked: true,
            ),
            LessonView(
              title: "Number Systems Quiz",
              duration: "Due: Oct 25, 2025",
              isLocked: false,
              isQuiz: true,
            ),
          ],
        ),
        UntiTile(
          lessons: [],
          title: "Unit 2: Algebra Fundamentals",
          subtitle: "8 lessons • 3 assignments • 1 exam",
        ),
        UntiTile(
          lessons: [],
          title: "Unit 3: Geometry & Shapes",
          subtitle: "7 lessons • 2 assignments • 1 exam",
        ),
      ],
    );
  }
}
