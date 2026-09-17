import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/theme/app_colors.dart';

class StepsProgress extends StatefulWidget {
  const StepsProgress({Key? key, required this.currentStep}) : super(key: key);
  final int currentStep;
  @override
  _StepsProgressState createState() => _StepsProgressState();
}

class _StepsProgressState extends State<StepsProgress> {
  @override
  Widget build(BuildContext context) {
    int stepsCount = 3;
    return SizedBox(
      height: 50.h,
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(stepsCount * 2 - 1, (i) {
            if (i.isEven) {
              int index = i ~/ 2;
              return step(index);
            } else {
              return divider();
            }
          }),
        ),
      ),
    );
  }

  Widget step(int index) {
    return Container(
      height: 35.h,
      width: 35.h,
      decoration: BoxDecoration(
        border:
            widget.currentStep - 1 < index
                ? Border.all(color: AppColors.borderGrey, width: 2)
                : widget.currentStep - 1 > index
                ? Border.all(color: AppColors.primary, width: 2)
                : null,
        shape: BoxShape.circle,
        color:
            widget.currentStep - 1 == index
                ? AppColors.primary
                : widget.currentStep - 1 > index
                ? AppColors.green
                : Colors.transparent,
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              "${index + 1}",
              style: AppsStyles.s14Bold.copyWith(
                color:
                    widget.currentStep - 1 == index ||
                            widget.currentStep - 1 > index
                        ? Colors.white
                        : Color(0xff9CA3AF),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(height: 2.h, width: 50.w, color: AppColors.borderGrey),
    );
  }
}