import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/Features/Home/presentation/cubits/get_home_data_cubit.dart';
import 'package:igenius/Features/Teachers/presentation/views/widgets/teacher_tile.dart';
import '../../../../../app.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../Home/data/models/home_data_model.dart';
import '../../cubits/get_teachers_cubit.dart';

class TeachersView extends StatelessWidget {
   TeachersView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetTeachersCubit, BaseCubitState>(
      builder: (context, state) {
        final cubit = context.read<GetTeachersCubit>();
        final teachers = cubit.allTeachers;

        return _buildContent(
          context: context,
          state: state,
          teachers: teachers,
          isLoadingMore: cubit.isLoadingMore,
        );
      },
    );
  }

  Widget _buildContent({
    required BuildContext context,
    required BaseCubitState state,
    required List teachers,
    required bool isLoadingMore,
  }) {
    // 1) أول تحميل ومفيش داتا خالص
    if (state is LoadingState && teachers.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 2) error وأول تحميل (مفيش داتا اتعرضت قبل كده)
    if (state is ErrorState && teachers.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                state.message ?? 'Something went wrong',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // 3) نجح لكن القائمة فاضية فعلاً (مفيش مدرسين)
    if (state is SuccessState && teachers.isEmpty) {
      return const Center(child: Text('No teachers available'));
    }

    // 4) عندنا داتا نعرضها (نجاح، أو تحميل صفحة إضافية، أو error مع داتا قديمة معروضة)
    if (teachers.isEmpty) {
      // حالة افتراضية (مثلاً initial state قبل أي نداء) - رجّع widget فاضي بأمان
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0).copyWith(bottom: 0),
      child: Column(
        children: [
          ...List.generate(teachers.length, (index) {
            final teacher = teachers[index];
            return Card(
              color: Colors.white,
              elevation: 6,
              shadowColor: Colors.grey.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TeacherTile(
                  isGuest: currentUser == null,
                  teacher: teacher,
                ),
              ),
            );
          }),

          // مؤشر تحميل صفحة إضافية (pagination) - بس للشاشة الكاملة
          if (isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),

          // error أثناء عرض داتا قديمة (مثلاً فشل تحميل صفحة جديدة)
          if (state is ErrorState && teachers.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                state.message ?? 'Something went wrong',
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}
