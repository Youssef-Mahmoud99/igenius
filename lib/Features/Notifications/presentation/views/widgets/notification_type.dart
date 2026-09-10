import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class CustomType extends StatelessWidget {
  const CustomType({
    Key? key,
    required this.CustomTypes,
    required this.selectedType,
    this.onTypeSelected,
  }) : super(key: key);

  final List<String> CustomTypes;
  final String selectedType;
  final void Function(String?)? onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _buildType(CustomTypes[index]);
        },
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemCount: CustomTypes.length,
      ),
    );
  }

  Widget _buildType(String type) {
    final bool isSelected = selectedType == type;
    return GestureDetector(
      onTap: () => onTypeSelected?.call(type),
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? AppColors.primary : AppColors.borderGrey,
        ),
        child: Center(
          child: Text(
            type,
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