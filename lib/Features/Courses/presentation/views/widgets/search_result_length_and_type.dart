import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_drop_down.dart';
import '../../../data/models/courses_body.dart';
import '../../cubits/courses/courses_cubit.dart';

class SearchResultLengthAndType extends StatefulWidget {
  const SearchResultLengthAndType({
    Key? key,
    required this.type,
    this.onChanged,
    this.resultsLength,
  }) : super(key: key);
  final String type;
  final Function(String?)? onChanged;
  final int? resultsLength;

  @override
  State<SearchResultLengthAndType> createState() =>
      _SearchResultLengthAndTypeState();
}

class _SearchResultLengthAndTypeState extends State<SearchResultLengthAndType> {
  final Map<String, String> popularCategories = {
    'Latest': 'latest',
    'Most Popular': 'popular',
    'Price Ascending': 'price_asc',
    'Price Descending': 'price_desc',
    'Is Private': 'is_private',
    'Has Installment Plan': 'has_installment_plan',
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
                  text:
                      '${widget.type == 'courses' ? 'Courses' : 'Teachers'} found',
                  style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),

          Container(
            width: 200.w,

            child: CustomSmallDropdown(
              items: popularCategories.keys.toList(),
              onChanged: (value) {
                final cubit = context.read<CoursesCubit>();
                final oldBody = cubit.body;

                CoursesBody newBody = CoursesBody(
                  page: 1,
                  perPage: oldBody.perPage,
                  search: oldBody.search, // خلي البحث زي ما هو
                  // كل باقي الفلاتر بتتصفر هنا تلقائيًا (null) لأننا مش بنمررهم
                );

                if (popularCategories[value] == "is_private") {
                  newBody = newBody.copyWith(isPrivate: 1);
                } else if (popularCategories[value] == "has_installment_plan") {
                  newBody = newBody.copyWith(hasInstallmentPlan: 1);
                } else {
                  newBody = newBody.copyWith(sort: popularCategories[value]);
                }

                cubit.updateBody(newBody);
                setState(() => selectedCategory = value);
              },
              value: selectedCategory,
              height: 38,
              hint: 'Select Category',
            ),
          ),
        ],
      ),
    );
  }
}
