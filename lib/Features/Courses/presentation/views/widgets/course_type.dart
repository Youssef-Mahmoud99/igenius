import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class CourseType extends StatefulWidget {
  CourseType({Key? key, required this.courseTypes, this.onTypeSelected})
    : super(key: key);
  final List<String> courseTypes;
  final void Function(String?)? onTypeSelected;
  @override
  State<CourseType> createState() => _CourseTypeState();
}

class _CourseTypeState extends State<CourseType> {
  String? selectedType;
  @override
  void initState() {
    selectedType = widget.courseTypes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return courseType('${widget.courseTypes[index]}', index);
        },
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemCount: widget.courseTypes.length,
      ),
    );
  }

  Widget courseType(String type, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
        });
        widget.onTypeSelected?.call(type);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 5, bottom: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:
              selectedType == type ? AppColors.primary : AppColors.borderGrey,
        ),
        child: Center(
          child: Text(
            type,
            style: AppsStyles.s14SemiBold.copyWith(
              height: 1,
              color: selectedType != type ? AppColors.black : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
