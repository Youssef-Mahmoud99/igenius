import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/course_card.dart';
import 'package:igenius/core/widgets/custom_gridview.dart';
import '../../../../Courses/data/models/courses_model.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../cubits/courses/courses_cubit.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({Key? key}) : super(key: key);

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesCubit, BaseCubitState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ErrorState) {
          return Center(child: Text(state.message ?? 'Something went wrong'));
        }

        if (state is SuccessState) {
          final response = state.data as BaseResponse<List<CourseModel>>;
          final courses = response.data ?? [];

          if (courses.isEmpty) {
            return const Center(child: Text('No courses available'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomGridViewBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CourseCard( course: courses[index]);
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.55,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}