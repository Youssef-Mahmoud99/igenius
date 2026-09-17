import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Courses/presentation/cubits/lessons/mark_attendance_cubit.dart';
import 'package:igenius/Features/Courses/presentation/views/widgets/course_material.dart';
import 'package:igenius/core/resources/assets_manager.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/constants/app_routes.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/app_navigtion.dart';
import '../../../../../core/utils/helpers/helper_methods.dart';
import '../../../../../core/utils/helpers/toast_helper.dart';
import '../../../../../core/widgets/base_gradient.dart';
import '../../../data/models/course_details.dart';
import '../../cubits/lessons/lesson_content_cubit.dart';
import '../widgets/meeting_button.dart';

class LessonViewScreen extends StatefulWidget {
  final int lessonId;
  final String unitTitle;
  final bool isOwned;
  const LessonViewScreen({
    Key? key,
    required this.lessonId,
    required this.unitTitle,
    required this.isOwned,
  }) : super(key: key);
  @override
  _LessonViewScreenState createState() => _LessonViewScreenState();
}

class _LessonViewScreenState extends State<LessonViewScreen> {
  @override
  void initState() {
    context.read<LessonContentCubit>().getLessonContent(widget.lessonId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonContentCubit, BaseCubitState>(
      builder: (context, state) {
        if (state is ErrorState) {
          return Center(child: AppText(text: state.message));
        }
        if (state is SuccessState) {
          final response = state.data as BaseResponse<LessonModel>;
          final lesson = response.data ?? null;
          if (lesson == null) {
            return const Center(child: Text('No details available'));
          }
          return Scaffold(
            appBar: CustomAppBar(
              centerTitle: false,
              titleChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.unitTitle,
                    style: AppsStyles.s12Regular.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  Text(
                    lesson.title ?? '',
                    style: AppsStyles.s14Bold.copyWith(color: Colors.black),
                  ),
                ],
              ),
              showBack: true,
            ),
            body: SafeArea(
              child: BaseGradient(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            lesson.meetingUrl != null
                                ? MeetingButton(
                                  meetingUrl: lesson.meetingUrl ?? "",
                                )
                                : GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    AppNavaigation.pushToPageWithParams(
                                      AppRoutes.videoPlayerScreen,
                                      {
                                        'videoUrl': lesson.videoUrl,
                                        "onProgressThresholdReached": () {
                                          context
                                              .read<MarkAttendanceCubit>()
                                              .markAttendance(widget.lessonId);
                                        },
                                      },
                                    );
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          AppColors.buttonGradient1,
                                          AppColors.buttonGradient2,
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 50,
                                    ),
                                    width: double.infinity,
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.grey.withOpacity(0.4),
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 4,
                                      ),

                                      shape: CircleBorder(),
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.play_arrow_rounded,
                                          color: AppColors.primary,
                                          size: 48.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Description',
                                    style: AppsStyles.s14Bold,
                                  ),
                                  5.verticalSpace,
                                  AppText(
                                    text:
                                        lesson.description ??
                                        'No description available',
                                    style: AppsStyles.s12Regular.copyWith(
                                      color: AppColors.grey,
                                    ),
                                    maxLines: 20,
                                  ),

                                  10.verticalSpace,

                                  (lesson.files?.isNotEmpty ?? false)
                                      ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppText(
                                            text: 'Materials',
                                            style: AppsStyles.s14Bold,
                                          ),
                                          10.verticalSpace,

                                          ...lesson.files!.map((e) {
                                            final isSecure =
                                                e.accessType == 'secure';

                                            print(e.accessType);
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 10,
                                              ),
                                              child: CourseMaterial(
                                                isSecure: isSecure,
                                                title: e.name ?? '',
                                                subTitle: e.size ?? '',
                                                backgroundColor: AppColors
                                                    .primary
                                                    .withOpacity(0.1),
                                                iconColor: AppColors.primary,
                                                leadingImage:
                                                    AppImages.assignment,
                                                onView: () {

                                                  if (widget.isOwned) {
                                                  HelperMethods.pushFileViewer(
                                                    context: context,
                                                    url: e.url,
                                                    fileName: e.name ?? '',
                                                  );

                                                  }
                                                  else{
                                                    ToastHelper.showWarning("You can view this file only after purchasing the lesson");
                                                  }
                                                },
                                                // لو الملف secure منديش زرار تحميل خالص
                                                onDownload:
                                                    isSecure
                                                        ? null
                                                        : () {
                                                          if (widget.isOwned) {
                                                          HelperMethods
                                                              .downloadFileSafely(
                                                            context: context,
                                                            url: e.url,
                                                            fileName: e.name ?? '',
                                                          );
                                                          }
                                                          else{
                                                            ToastHelper.showWarning("You can download this file only after purchasing the lesson");
                                                          }
                                                        }
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                      )
                                      : SizedBox.shrink(),
                                  // Text('Lesson Slides', style: AppsStyles.s12Bold),
                                  // 5.verticalSpace,
                                  // CourseMaterial(
                                  //   title: 'Number Systems Slides.pdf',
                                  //   subTitle: 'PDF • 2.4 MB',
                                  //   backgroundColor: Color(0xffF0FDF4),
                                  //   iconColor: AppColors.red,
                                  //   leadingImage: AppImages.assignment,
                                  //   trailingIcon: Icons.file_download_outlined,
                                  // ),
                                  // 10.verticalSpace,
                                  // Text(
                                  //   'Practice Worksheets',
                                  //   style: AppsStyles.s12Bold,
                                  // ),
                                  // 5.verticalSpace,
                                  // CourseMaterial(
                                  //   title: 'Worksheet 1.docx',
                                  //   subTitle: 'DOCX • 856 KB',
                                  //   backgroundColor: AppColors.blue.withOpacity(0.1),
                                  //   iconColor: AppColors.blue,
                                  //   leadingImage: AppImages.assignment,
                                  //   trailingIcon: Icons.file_download_outlined,
                                  // ),
                                  // 10.verticalSpace,
                                  // CourseMaterial(
                                  //   title: 'Worksheet 2.docx',
                                  //   subTitle: 'DOCX • 856 KB',
                                  //   backgroundColor: AppColors.blue.withOpacity(0.1),
                                  //   iconColor: AppColors.blue,
                                  //   leadingImage: AppImages.assignment,
                                  //   trailingIcon: Icons.file_download_outlined,
                                  // ),

                                  // 10.verticalSpace,
                                  // Text('Answer Keys', style: AppsStyles.s12Bold),
                                  // 5.verticalSpace,
                                  // CourseMaterial(
                                  //   title: 'Answer Key.pdf',
                                  //   subTitle: 'PDF • 1.2 MB',
                                  //   backgroundColor: AppColors.green.withOpacity(0.1),
                                  //   iconColor: AppColors.green,
                                  //   leadingIcon: Icons.check_circle_outline_rounded,
                                  //   trailingIcon: Icons.file_download_outlined,
                                  // ),
                                  // 10.verticalSpace,
                                  // Text(
                                  //   'Additional Resources',
                                  //   style: AppsStyles.s12Bold,
                                  // ),
                                  // 5.verticalSpace,
                                  // CourseMaterial(
                                  //   title: 'Study Guide.pdf',
                                  //   subTitle: 'PDF • 3.2 MB',
                                  //   backgroundColor: Colors.purple.withOpacity(0.1),
                                  //   iconColor: Colors.purple,
                                  //   leadingImage: AppImages.assignment,
                                  //   trailingIcon: Icons.file_download_outlined,
                                  // ),
                                ],
                              ),
                            ),

                            30.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
