import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/course_card.dart';
import 'package:igenius/core/widgets/custom_gridview.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../cubits/courses/courses_cubit.dart';


class CoursesView extends StatelessWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, BaseCubitState>(
      builder: (context, state) {
        final cubit = context.read<CoursesCubit>();
        final courses = cubit.allCourses;

        if (state is LoadingState && courses.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorState && courses.isEmpty) {
          return Center(child: Text(state.message ?? 'Something went wrong'));
        }
        if (courses.isEmpty) {
          return const Center(child: Text('No courses available'));
        }

        return Column(
          children: [
            CustomGridViewBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: courses.length,
              itemBuilder: (context, index) => CourseCard(course: courses[index]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.5,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
            if (cubit.isLoadingMore)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}