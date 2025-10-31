import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/course_type.dart';
import 'package:igenius/Features/Teachers/presentation/views/widgets/teachers_view.dart';
import 'package:igenius/core/theme/app_colors.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text_field.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/widgets/base/base_stateless.dart';
import '../../../../Courses/presentation/views/widgets/search_result_length_and_type.dart';

class TeachersScreen extends BaseStatelessWidget {
  TeachersScreen({Key? key}) : super(key: key);
  String searchText = '';

  final List<String> courseTypes = [
    'All',
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
  ];

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: false,
      title: 'Our Teachers',
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GestureDetector(
            onTap: () => AppNavaigation.pushToPageWithParams(AppRoutes.filtersScreen , {"isCourses": false}),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              padding: const EdgeInsets.all(5.0),
              child: const Icon(Icons.filter_alt_outlined, size: 30),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return BaseGradient(
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
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                          },
                          fillColor: AppColors.borderGrey,
                          hint: 'Search teachers...',
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
                    type: 'teachers',
                    onChanged: (value) {},
                  ),
                  10.verticalSpace,

                  TeachersView(isGuest: true, inHome: false),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
