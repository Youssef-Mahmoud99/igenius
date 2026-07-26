import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/course_type.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/courses_view.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/base/base_stateful.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text_field.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/widgets/base/base_stateless.dart';
import '../../../../../injection/service_locator.dart';
import '../../../data/models/courses_body.dart';
import '../../cubits/courses/courses_cubit.dart';
import '../widgets/search_result_length_and_type.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  TextEditingController searchController = TextEditingController();
  final List<String> courseTypes = [
    'All Courses',
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
  ];

  // @override
  // void initState() {
  //   context.read<CoursesCubit>().getCourses(CoursesBody(page: 1, perPage: 10));
  //   super.initState();
  // }

  search(String value) {
    final cubit = context.read<CoursesCubit>();
    cubit.body = cubit.body.copyWith(search: value); // copyWith مش setter
    cubit.updateBody(cubit.body);
    cubit.getCourses();
  }

  dispose() {
    searchController.dispose();
    super.dispose();
  }
@override
  void initState() {
    searchController.text = context.read<CoursesCubit>().body.search ?? '';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        title: 'Browse Courses',
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              onTap:
                  () => AppNavaigation.pushToPageWithParams(
                    AppRoutes.filtersScreen,
                    {"isCourses": true},
                  ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(AppImages.filter),
              ),
            ),
          ),
        ],
      ),
      body: BaseGradient(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: 10.rPadding,
                  color: AppColors.white,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: searchController,
                        suffix:
                            context
                                        .watch<CoursesCubit>()
                                        .body
                                        .search
                                        ?.isNotEmpty ==
                                    true
                                ? IconButton(
                                  onPressed: () {
                                      searchController.clear();
                                      search('');
                                  },
                                  icon: Icon(
                                    Icons.clear,
                                    color: AppColors.primary,
                                  ),
                                )
                                : null,
                        onChanged: (value) => search(value),
                        fillColor: AppColors.borderGrey,
                        hint: 'Search Courses...',
                        prefix: const Icon(
                          Icons.search,
                          color: AppColors.grey,
                          size: 20,
                        ),
                      ),
                      10.verticalSpace,
                      CourseType(
                        courseTypes: courseTypes,
                        onTypeSelected: (type) {},
                      ),
                    ],
                  ),
                ),

                10.verticalSpace,
                SearchResultLengthAndType(
                  type: 'courses',
                  resultsLength: 12,
                  onChanged: (value) {},
                ),
                10.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: CoursesView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
