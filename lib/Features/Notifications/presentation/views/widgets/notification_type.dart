import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';

class CustomType extends StatefulWidget {
  CustomType({Key? key, required this.CustomTypes, this.onTypeSelected})
    : super(key: key);
  final List<String> CustomTypes;
  final void Function(String?)? onTypeSelected;
  @override
  State<CustomType> createState() => _CustomTypeState();
}

class _CustomTypeState extends State<CustomType> {
  String? selectedType;
  @override
  void initState() {
    selectedType = widget.CustomTypes[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CustomType('${widget.CustomTypes[index]}', index);
        },
        separatorBuilder: (context, index) => 10.horizontalSpace,
        itemCount: widget.CustomTypes.length,
      ),
    );
  }

  Widget CustomType(String type, int index) {
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
            style: AppsStyles.s12SemiBold.copyWith(
              height: 1,
              color: selectedType != type ? AppColors.black : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
