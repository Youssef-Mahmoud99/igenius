import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_drop_down.dart';

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
  final List<String> popularCategories = [
    'Most Popular',
    'Highest Rated',
    'Most Recent',
    'Most Viewed',
  ];

  String? selectedCategory = 'Most Popular';
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
                  style: AppsStyles.s14Bold.copyWith(color: AppColors.black),
                ),
                TextSpan(
                  text:
                      '${widget.type == 'courses' ? 'Courses' : 'Teachers'} found',
                  style: AppsStyles.s14Regular.copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),

          Container(
            width: 170.w,

            child: CustomSmallDropdown(
              items: popularCategories,
              onChanged: (value) {
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
