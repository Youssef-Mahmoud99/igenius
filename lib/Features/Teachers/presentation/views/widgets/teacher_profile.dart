import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Teachers/presentation/cubits/get_teacher_details_cubit.dart';
import 'package:igenius/core/utils/helpers/helper_methods.dart';
import 'package:igenius/core/widgets/base_gradient.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../Home/presentation/views/widgets/popular_courses.dart';
import '../../../data/models/teacher_details_model.dart';
import '../../../data/models/teacher_model.dart';
import 'courses_section.dart';
import 'teacher_info_card.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key? key, required this.teacherId}) : super(key: key);
  final int teacherId;

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  @override
  void initState() {
    context.read<GetTeacherDetailsCubit>().getTeacherDetails(
      widget.teacherId,
    );
    super.initState();
  }

  Widget aboutCard(String description) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.4),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: 'About',
              style: AppsStyles.s14Bold.copyWith(color: AppColors.black),
            ),
            10.verticalSpace,
            AppText(
              text: description,
              color: AppColors.black,
              style: AppsStyles.s12Regular,
            ),
          ],
        ),
      ),
    );
  }

  Widget qualificationTile(
    String certificate,
    String university,
    Color color,
    Color backgroundColor,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: backgroundColor,
          padding: const EdgeInsets.all(15),
          child: Icon(Icons.verified, color: color, size: 20.r),
        ),
      ),
      title: Text(certificate, style: AppsStyles.s14Bold),
      subtitle: Text(
        university,
        style: AppsStyles.s14Regular.copyWith(color: AppColors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        title: 'Teacher Profile',
        showBack: true,
        actions: [
          IconButton(
            onPressed: () {
              HelperMethods.shareText('Share this teacher profile');
            },
            icon: const Icon(Icons.share, color: Colors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: BaseGradient(
          child: BlocBuilder<GetTeacherDetailsCubit, BaseCubitState>(
            builder: (context, state) {
              // 1) Loading
              if (state is LoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              // 2) Error
              if (state is ErrorState) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 40,
                        ),
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

              // 3) Success
              if (state is SuccessState) {
                final response =
                    state.data as BaseResponse<TeacherDetailsModel>;
                final details = response.data;

                if (details == null) {
                  return const Center(
                    child: Text('Teacher details not available'),
                  );
                }

                // ⚠️ عدّل أسامي الفيلدز دي تبقى مطابقة لـ TeacherDetailsModel الحقيقي عندك
                final String description = details.description ?? '';
                final qualifications = details.certificates ?? [];

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TeacherInfoCard(teacher: details),
                      Padding(
                        padding: const EdgeInsets.all(20.0).copyWith(top: 0),
                        child: Column(
                          children: [
                            20.verticalSpace,
                            aboutCard(description),
                            if (qualifications.isNotEmpty)
                              Card(
                                elevation: 10,
                                shadowColor: Colors.grey.withOpacity(0.4),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 4,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Qualifications',
                                        style: AppsStyles.s14Bold,
                                      ),

                                      ...qualifications.map(
                                        (qualification) => qualificationTile(
                                          // ⚠️ عدّل الأسامي دي حسب الموديل الحقيقي
                                          qualification.certificate ?? '',
                                          qualification.university ?? '',
                                          AppColors.primary,
                                          AppColors.borderGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      CoursesRowSection(
                        title: 'Courses by ${details.name}',
                        courses: details.courses ?? [],
                        onCourseTap: (course) {
                          AppNavaigation.pushToPageWithParams(
                            AppRoutes.courseDetails,
                            {'courseId': course.id, 'isBought': false},
                          );
                        },
                      ),
                      20.verticalSpace,
                    ],
                  ),
                );
              }

              // 4) Initial state
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
