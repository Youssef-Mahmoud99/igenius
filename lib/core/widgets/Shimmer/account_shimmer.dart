import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/widgets/base_gradient.dart';

/// شكل الـ Skeleton بتاع صفحة الـ Account وقت ما الـ profile
/// لسه بيتحمّل. بيحاكي نفس تخطيط الصفحة الحقيقية (هيدر + كروت).
class AccountShimmer extends StatelessWidget {
  const AccountShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BaseGradient(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------- Header block ----------
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20.0),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100.w,
                              height: 14.h,
                              color: Colors.white,
                            ),
                            10.verticalSpace,
                            Row(
                              children: [
                                Container(
                                  width: 60.r,
                                  height: 60.r,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                20.horizontalSpace,
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120.w,
                                      height: 14.h,
                                      color: Colors.white,
                                    ),
                                    8.verticalSpace,
                                    Container(
                                      width: 160.w,
                                      height: 12.h,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ---------- Tiles list ----------
                      Padding(
                        padding: const EdgeInsets.all(20.0).copyWith(
                          bottom: 0,
                        ),
                        child: Column(
                          children: List.generate(
                            7,
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                height: 70.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ---------- Settings card ----------
                      Padding(
                        padding: const EdgeInsets.all(20.0).copyWith(top: 0),
                        child: Container(
                          height: 180.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}