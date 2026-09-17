import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/gradient_button.dart';
import 'package:igenius/core/widgets/primary_button.dart';

import '../../../../core/base/cubit/base_state.dart';
import '../../../../core/widgets/custom_text.dart';
import '../../../Courses/presentation/cubits/courses/courses_cubit.dart';
import '../cubits/filter_data_cubit.dart';
import '../widgets/filter_checkbox.dart';
import '../widgets/filter_radio.dart';
import '../widgets/filter_shimmer_section.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key, this.isCourses = true}) : super(key: key);

  final bool isCourses;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  int? selectedSubjectId;
  int? selectedLevelId;
  int? selectedBoardId;
  int? selectedSystemId;

  // String selectedSession = "All Sessions";
  // String selectedRating = "All Ratings";

  // final sessions = ["All Sessions", "Live Sessions", "Recorded Sessions"];
  // final ratings = ["All Ratings", "4.0+ ⭐", "4.5+ ⭐", "4.8+ ⭐"];

  @override
  void initState() {
    context.read<FilterDataCubit>().getAllFilters();


    final coursesBody = context.read<CoursesCubit>().body;
    print("selectedSubjectId = ${coursesBody.subjectId}");
    selectedSubjectId = coursesBody.subjectId;
    selectedLevelId = coursesBody.levelId;
    selectedBoardId = coursesBody.boardId;
    selectedSystemId = coursesBody.systemId;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBack: false,
        titleChild: AppText(text: "Filters", style: AppsStyles.s18Bold),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => AppNavaigation.pop(),
          ),
        ],
      ),
      body: Stack(
        children: [
          BaseGradient(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: BlocBuilder<FilterDataCubit, BaseCubitState>(
                  builder: (context, state) {
                    final cubit = context.read<FilterDataCubit>();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildDynamicFilters(cubit),
                        // _sectionTitle("Session Type"),
                        // ...sessions.map(
                        //   (type) => CustomRadioTile(
                        //     title: type,
                        //     value: type,
                        //     groupValue: selectedSession,
                        //     onChanged: (value) =>
                        //         setState(() => selectedSession = value!),
                        //   ),
                        // ),
                        // _sectionTitle("Minimum Rating"),
                        // ...ratings.map(
                        //   (rating) => CustomRadioTile(
                        //     title: rating,
                        //     value: rating,
                        //     groupValue: selectedRating,
                        //     onChanged: (value) =>
                        //         setState(() => selectedRating = value!),
                        //   ),
                        // ),
                        20.verticalSpace,
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Appbutton(
                needBorder: true,
                color: Colors.white,
                textColor: AppColors.primary,
                height: 40.h,
                borderRadius: 16,
                text: 'Clear All',
                onPressed: _clearAll,
              ),
            ),
            15.horizontalSpace,
            Expanded(
              child: GradientButton(
                height: 40.h,
                text: 'Apply Filters',
                onTap: _applyFilters,
              ),
            ),
          ],
        ),
      ),
    );
  }

List<Widget> _buildDynamicFilters(FilterDataCubit cubit) {
  return [
    _sectionTitle("Subject"),
    if (cubit.isSubjectsLoading)
      const FilterShimmerSection(itemCount: 5)
    else
      ...cubit.subjects.map(
        (subject) => CustomRadioTile(
          title: subject.name ?? "",
          value: subject.id,
          groupValue: selectedSubjectId,
          onChanged: (value) => setState(() => selectedSubjectId = value),
        ),
      ),
    _sectionTitle("Level"),
    if (cubit.isLevelsLoading)
      const FilterShimmerSection(itemCount: 3)
    else
      ...cubit.levels.map(
        (level) => CustomRadioTile(
          title: level.name ?? "",
          value: level.id,
          groupValue: selectedLevelId,
          onChanged: (value) => setState(() => selectedLevelId = value),
        ),
      ),
    _sectionTitle("Course Provider"),
    if (cubit.isBoardsLoading)
      const FilterShimmerSection(itemCount: 3)
    else
      ...cubit.boards.map(
        (board) => CustomRadioTile(
          title: board.name ?? "",
          value: board.id,
          groupValue: selectedBoardId,
          onChanged: (value) => setState(() => selectedBoardId = value),
        ),
      ),
    _sectionTitle("Educational System"),
    if (cubit.isSystemsLoading)
      const FilterShimmerSection(itemCount: 3)
    else
      ...cubit.systems.map(
        (system) => CustomRadioTile(
          title: system.name ?? "",
          value: system.id,
          groupValue: selectedSystemId,
          onChanged: (value) => setState(() => selectedSystemId = value),
        ),
      ),
  ];
}

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
      child: Text(title, style: AppsStyles.s14Bold),
    );
  }

  void _clearAll() {
    setState(() {
      selectedSubjectId = null;
      selectedLevelId = null;
      selectedBoardId = null;
      selectedSystemId = null;
      // selectedSession = "All Sessions";
      // selectedRating = "All Ratings";
    });

    // بينادي الـ Cubit مباشرة عشان يمسح الفلاتر ويجيب الكورسات تاني
    context.read<CoursesCubit>().resetFilters();

    AppNavaigation.pop();
  }

  void _applyFilters() {
    // بينادي الـ Cubit مباشرة بالقيم المختارة
    context.read<CoursesCubit>().applyFilters(
          subjectId: selectedSubjectId,
          levelId: selectedLevelId,
          boardId: selectedBoardId,
          systemId: selectedSystemId,
        );

    AppNavaigation.pop();
  }
}