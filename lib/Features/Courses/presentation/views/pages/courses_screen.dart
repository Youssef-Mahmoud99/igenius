import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/course_type.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/courses_view.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text_field.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../Notifications/presentation/views/widgets/custom_type_shimmer.dart';
import '../../../../filters/presentation/cubits/filter_data_cubit.dart';
import '../../../../filters/presentation/widgets/filter_shimmer_section.dart';
import '../../cubits/courses/courses_cubit.dart';
import '../widgets/search_result_length_and_type.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  search(String value) {
    final cubit = context.read<CoursesCubit>();
    cubit.updateBody(cubit.body.copyWith(search: value));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<CoursesCubit>().loadMoreCourses();
    }
  }

  @override
  void initState() {
    searchController.text = context.read<CoursesCubit>().body.search ?? '';
    context.read<CoursesCubit>().getCourses(); // أول تحميل
    context.read<FilterDataCubit>().getAllFilters();
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
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
          controller: _scrollController, // <-- هنا الأساس
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
                      BlocBuilder<FilterDataCubit, BaseCubitState>(
                        builder: (context, state) {
                          final filterCubit = context.read<FilterDataCubit>();
                          final coursesCubit = context.watch<CoursesCubit>();

                          if (filterCubit.isSubjectsLoading) {
                            return const CustomTypeShimmer(
                               
                            ); // أو أي شيمر أفقي لو عندك واحد مخصص
                          }

                          final items = <CourseTypeItem>[
                            const CourseTypeItem(id: null, name: 'All Courses'),
                            ...filterCubit.subjects.map(
                              (s) =>
                                  CourseTypeItem(id: s.id, name: s.name ?? ''),
                            ),
                          ];

                          return CourseType(
                            courseTypes: items,
                            selectedId: coursesCubit.body.subjectId,
                            onTypeSelected: (id) {
                              context.read<CoursesCubit>().applyFilters(
                                subjectId: id,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,
                SearchResultLengthAndType(
                  type: 'courses',
                  resultsLength: context.watch<CoursesCubit>().totalCourses,
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
