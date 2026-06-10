import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/cubits/courses_by_teacher_cubit.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/home_course_card.dart';
import '../../../../Courses/data/models/courses_body.dart';
import '../../../../Courses/data/models/courses_model.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../Courses/presentation/cubits/courses_cubit.dart';
import '../../../../Courses/presentation/cubits/home_courses_cubit.dart';

class PopularCourses extends StatefulWidget {
  final bool isGuest;
  final Axis scrollDirection;
  final bool inHome;
  final CoursesBody? params; // optional — home يعدي null أو default params

  const PopularCourses({
    Key? key,
    this.isGuest = false,
    this.inHome = true,
    this.scrollDirection = Axis.horizontal,
    this.params,
  }) : super(key: key);

  @override
  State<PopularCourses> createState() => _PopularCoursesState();
}

class _PopularCoursesState extends State<PopularCourses> {
  @override
  Widget build(BuildContext context) {
    return widget.scrollDirection == Axis.horizontal
        ? BlocBuilder<HomeCoursesCubit, BaseCubitState>(
          builder: (context, state) {
            // Loading
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error
            if (state is ErrorState) {
              return Center(
                child: Text(state.message ?? 'Something went wrong'),
              );
            }

            // Success
            if (state is SuccessState) {
              final response = state.data as BaseResponse<List<CourseModel>>;
              final courses = response.data ?? [];

              if (courses.isEmpty) {
                return const Center(child: Text('No courses available'));
              }

              return ListView.separated(
                physics:
                    widget.scrollDirection == Axis.vertical
                        ? const NeverScrollableScrollPhysics()
                        : const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: widget.scrollDirection,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                itemCount: courses.length,
                separatorBuilder:
                    (_, __) =>
                        widget.scrollDirection == Axis.horizontal
                            ? 15.horizontalSpace
                            : 15.verticalSpace,
                itemBuilder: (context, index) {
                  final course = courses[index];
                  return SizedBox(
                    width: 200.w,
                    height: 250.h,
                    child: HomeCourseCard(
                      course: course,
                      inHome: widget.inHome,
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        )
        : BlocBuilder<CoursesByTeacherCubit, BaseCubitState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error
            if (state is ErrorState) {
              return Center(
                child: Text(state.message ?? 'Something went wrong'),
              );
            }

            // Success
            if (state is SuccessState) {
              final response = state.data as BaseResponse<List<CourseModel>>;
              final courses = response.data ?? [];

              if (courses.isEmpty) {
                return const Center(child: Text('No courses available'));
              }
            return ListView.separated(
              physics:
                  widget.scrollDirection == Axis.vertical
                      ? const NeverScrollableScrollPhysics()
                      : const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: widget.scrollDirection,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: courses.length,
              separatorBuilder:
                  (_, __) =>
                      widget.scrollDirection == Axis.horizontal
                          ? 15.horizontalSpace
                          : 15.verticalSpace,
              itemBuilder: (context, index) {
                final course = courses[index];
                return SizedBox(
                  height: 290.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: HomeCourseCard(
                      course: course,
                      inHome: widget.inHome,
                    ),
                  ),
                );
              },
            );
       
            }
            else {
              return const SizedBox.shrink();
            }
          },
        );
  }
}
