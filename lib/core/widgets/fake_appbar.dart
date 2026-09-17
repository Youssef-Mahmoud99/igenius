import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/assets_manager.dart';

class FakeAppbar extends StatelessWidget {
  const FakeAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTextTabBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 40.h,
              width: 40.h,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.center,
                child: const Icon(Icons.arrow_back_ios, size: 20),
              ),
            ),
          ),

          Image.asset(AppImages.logo),
        ],
      ),
    );
  }
}
