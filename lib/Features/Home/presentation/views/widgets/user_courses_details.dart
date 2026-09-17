import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../Account/data/models/profile_response_model.dart';
import '../../../../Account/presentation/cubits/profile/profile_cubit.dart';
import 'stats_shimmer.dart';

class UserCoursesDetails extends StatelessWidget {
  const UserCoursesDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, BaseCubitState>(
      builder: (context, state) {
        // 1) لسه بيحمل
        if (state is LoadingState) {
          return const UserCoursesDetailsShimmer();
        }

        // 2) error - نعرض أصفار بدل ما نكسر الشاشة
        if (state is ErrorState) {
          return _buildRow(
            totalCourses: 0,
            totalLessons: 0,
            totalAssignments: 0,
            totalExams: 0,
          );
        }

        // 3) نجح
        if (state is SuccessState) {
          // ⚠️ حماية من أي فشل cast غير متوقع
          try {
            final response = state.data as BaseResponse<ProfileResponseModel>;
            final stats = response.data?.stats;

            return _buildRow(
              totalCourses: stats?.totalEnrolledCourses ?? 0,
              totalLessons: stats?.totalCompletedLessons ?? 0,
              totalAssignments: stats?.totalCompletedAssignments ?? 0,
              totalExams: stats?.totalCompletedExams ?? 0,
            );
          } catch (_) {
            return _buildRow(
              totalCourses: 0,
              totalLessons: 0,
              totalAssignments: 0,
              totalExams: 0,
            );
          }
        }

        // 4) Initial state
        return const UserCoursesDetailsShimmer();
      },
    );
  }

  Widget _buildRow({
    required int totalCourses,
    required int totalLessons,
    required int totalAssignments,
    required int totalExams,
  }) {
    final List<Map<String, dynamic>> data = [
      {
        "title": "Courses",
        "value": totalCourses.toString(),
        "color": Colors.blue,
        "image": AppImages.courses,
      },
      {
        "title": "Lessons",
        "value": totalLessons.toString(),
        "color": Colors.green,
        "image": AppImages.privacy,
      },
      {
        "title": "Assignments",
        "value": totalAssignments.toString(),
        "color": Colors.orange,
        "image": AppImages.time,
      },
      {
        "title": "Exams",
        "value": totalExams.toString(),
        "color": Colors.purple,
        "image": AppImages.courses,
      },
    ];

    return SizedBox(
      height: 110.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        separatorBuilder: (_, __) => 10.horizontalSpace,
        itemBuilder: (context, index) {
          final e = data[index];
          return dataBuild(
            e["title"] as String,
            e["value"] as String,
            e["image"] as String,
            e["color"] as Color,
          );
        },
      ),
    );
  }

  Widget dataBuild(String title, String value, String image, Color color) {
    return Container(
      width: 100.w,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: color,
              child: Image.asset(
                image,
                color: Colors.white,
                height: 25.h,
                errorBuilder: (context, error, stackTrace) {
                  // ⚠️ لو الأيقونة مش موجودة في assets، يظهر أيقونة بديلة بدل ما يكسر
                  return Icon(Icons.image_not_supported,
                      color: Colors.white, size: 20.h);
                },
              ),
            ),
          ),
          6.verticalSpace,
          Text(
            value,
            style: AppsStyles.s16Bold,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            title,
            style: AppsStyles.s10Regular,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}