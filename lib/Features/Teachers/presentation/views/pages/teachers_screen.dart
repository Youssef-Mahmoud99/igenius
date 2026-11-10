import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/course_type.dart';
import 'package:igenius/Features/Teachers/presentation/views/widgets/teachers_view.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text_field.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../Notifications/presentation/views/widgets/custom_type_shimmer.dart';
import '../../../../filters/presentation/cubits/filter_data_cubit.dart';
import '../../cubits/get_teachers_cubit.dart';
import '../widgets/sort_teachers.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({Key? key}) : super(key: key);

  @override
  _TeachersScreenState createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  search(String value) {
    final cubit = context.read<GetTeachersCubit>();
    cubit.updateBody(cubit.body.copyWith(search: value));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<GetTeachersCubit>().loadMoreTeachers();
    }
  }

  @override
  void initState() {
    searchController.text = context.read<GetTeachersCubit>().body.search ?? '';
    context.read<GetTeachersCubit>().getTeachers();
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
        showBack: false,
        centerTitle: true,
        title: 'Our Teachers',
      ),
      body: BaseGradient(
        child: RefreshIndicator(
          onRefresh: () async {
            final cubit = context.read<GetTeachersCubit>();
            searchController.clear();
            cubit.refreshTeachers();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
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
                          suffix: context
                                      .watch<GetTeachersCubit>()
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
                          hint: 'Search teachers...',
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
                            final teachersCubit = context.watch<GetTeachersCubit>();
          
                            if (filterCubit.isSubjectsLoading) {
                              return const CustomTypeShimmer();
                            }
          
                            final items = <CourseTypeItem>[
                              const CourseTypeItem(id: null, name: 'All Teachers'),
                              ...filterCubit.subjects.map(
                                (s) => CourseTypeItem(id: s.id, name: s.name ?? ''),
                              ),
                            ];
          
                            return CourseType(
                              courseTypes: items,
                              selectedId: teachersCubit.body.subjectId,
                              onTypeSelected: (id) {
                                context.read<GetTeachersCubit>().applyFilters(
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
                  TeachersResultLengthAndType(
                    resultsLength: context.watch<GetTeachersCubit>().totalTeachers,
                    onChanged: (value) {},
                  ),
                  10.verticalSpace,
                   TeachersView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}