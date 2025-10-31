import 'package:flutter/material.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/course_card.dart';
import 'package:igenius/core/widgets/custom_gridview.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../data/models/courses_model.dart';

class CoursesView extends StatelessWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CustomGridViewBuilder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return CourseCard(
            liveIndex: index,
            course: CoursesModel(
              tag: "Most Popular",
              tagIcon: "🔥",
              title: "Advanced Mathematics",
              subtitle: "243",
              category: "Cambridge",
              categoryColor: Colors.black,
              categoryBackgroundColor: Colors.white,
              rating: 4.9,
              price: "\$299",
              gradientColors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
              image: AppImages.calculator,
            ),
          );
        },

        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.62,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
