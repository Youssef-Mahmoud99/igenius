import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/Features/Courses/presentation/cubits/courses/courses_cubit.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/widgets/custom_text.dart';
import '../../../../../injection/service_locator.dart';
import '../../../data/models/course_details.dart';
import '../../cubits/courses/course_details_cubit.dart';
import 'course_details_body.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({Key? key, required this.isBought}) : super(key: key);
  final bool isBought;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseDetailsCubit, BaseCubitState>(
      builder: (context, state) {
        if (state is ErrorState) {
          return Center(child: AppText(text: state.message));
        }
        if (state is SuccessState) {
          final response = state.data as BaseResponse<CourseDetails>;
          final courseDetails = response.data ?? null;
          if (courseDetails == null) {
            return const Center(child: Text('No details available'));
          }
          return CourseDetailsBody(
            courseDetails: courseDetails,
            isBought: isBought,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
