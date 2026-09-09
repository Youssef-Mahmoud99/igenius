import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../app.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../Home/data/models/home_data_model.dart';
import '../../../../Home/presentation/cubits/get_home_data_cubit.dart';
import 'teacher_home_card.dart';

class PopularTeachersSection extends StatelessWidget {
  const PopularTeachersSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataCubit, BaseCubitState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return SizedBox(
            height: 210.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ErrorState) {
          return SizedBox(
            height: 100.h,
            child: Center(child: Text(state.message ?? 'Something went wrong')),
          );
        }

        if (state is SuccessState) {
          final response = state.data as BaseResponse<HomeDataModel>;
          final teachers = response.data?.popularTeachers ?? [];

          if (teachers.isEmpty) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: 180.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: teachers.length,
              separatorBuilder: (_, __) => 12.horizontalSpace,
              itemBuilder: (context, index) {
                return PopularTeacherCard(
                  teacher: teachers[index],
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
