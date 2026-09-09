import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_drop_down.dart';
import '../../../data/models/teachers_body.dart';
import '../../cubits/get_teachers_cubit.dart';

class TeachersResultLengthAndType extends StatefulWidget {
  const TeachersResultLengthAndType({
    Key? key,
    this.onChanged,
    this.resultsLength,
  }) : super(key: key);

  final Function(String?)? onChanged;
  final int? resultsLength;

  @override
  State<TeachersResultLengthAndType> createState() =>
      _TeachersResultLengthAndTypeState();
}

class _TeachersResultLengthAndTypeState
    extends State<TeachersResultLengthAndType> {
  final Map<String, String> popularTeachersCategories = {
    'Highest Rating': 'rating',
    'Most Courses': 'courses',
  };

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${widget.resultsLength ?? 12} ',
                  style: AppsStyles.s12Bold.copyWith(color: AppColors.black),
                ),
                TextSpan(
                  text: 'Teachers found',
                  style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: 200.w,
            child: CustomSmallDropdown(
              items: popularTeachersCategories.keys.toList(),
              onChanged: (value) {
                final cubit = context.read<GetTeachersCubit>();
                final oldBody = cubit.body;

                final TeachersBody newBody = oldBody.copyWith(
                  page: 1,
                  sort: popularTeachersCategories[value],
                );

                cubit.updateBody(newBody);
                setState(() => selectedCategory = value);
              },
              value: selectedCategory,
              height: 38,
              hint: 'Sort',
            ),
          ),
        ],
      ),
    );
  }
}