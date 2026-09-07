import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class CourseType extends StatelessWidget {
  const CourseType({
    Key? key,
    required this.courseTypes,
    required this.selectedId,
    this.onTypeSelected,
  }) : super(key: key);

  final List<CourseTypeItem> courseTypes;
  final int? selectedId; // الـ id المختار حاليًا (null = All Courses)
  final void Function(int?)? onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = courseTypes[index];
          return _courseTypeChip(item);
        },
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemCount: courseTypes.length,
      ),
    );
  }

  Widget _courseTypeChip(CourseTypeItem item) {
    final bool isSelected = selectedId == item.id;

    return GestureDetector(
      onTap: () => onTypeSelected?.call(item.id),
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? AppColors.primary : AppColors.borderGrey,
        ),
        child: Center(
          child: Text(
            item.name,
            style: AppsStyles.s12SemiBold.copyWith(
              height: 1,
              color: isSelected ? AppColors.white : AppColors.black,
            ),
          ),
        ),
      ),
    );
  }
}

// course_type_item.dart
class CourseTypeItem {
  final int? id; // null = "All Courses"
  final String name;

  const CourseTypeItem({required this.id, required this.name});
}