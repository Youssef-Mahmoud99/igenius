import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:igenius/Features/Home/presentation/views/widgets/material_details.dart';
import 'package:igenius/core/widgets/custom_appBar.dart';
import 'package:igenius/core/widgets/custom_text.dart';

import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/helpers/helper_methods.dart';
import '../../../../../core/widgets/base_gradient.dart';
import '../../../../../injection/service_locator.dart';
import '../../../data/models/attempts_model.dart';
import '../../../data/models/course_details.dart';
import '../../cubits/assignments/assignment_attemps_cubit.dart';
import '../../cubits/assignments/assignment_details_cubit.dart';
import '../../cubits/assignments/submit_assinment.dart';
import '../../cubits/exams/exam_attemps_cubit.dart';
import '../../cubits/exams/exam_details_cubit.dart';
import '../../cubits/exams/submit_exam.dart';
import '../widgets/course_material.dart';
import '../widgets/upload_assignment_widget.dart';

/// تمثيل موحّد لملف، يشتغل سواء جاي من AssignmentModel (List<FileModel>)
/// أو من ExamModel (file_url / file_name / file_size مفردين).
class _FileInfo {
  final String name;
  final String? size;
  final String? url;

  const _FileInfo({required this.name, this.size, this.url});
}

/// تمثيل موحّد لتفاصيل assignment أو exam، عشان الصفحة تتعامل مع
/// شكل بيانات واحد بدل ما تفرّق بين الموديلين في كل سطر.
class _TaskDetails {
  final String? title;
  final String? description;
  final String? viewDate;
  final String? dueDate;
  final String? deadlineDate;
  final int? totalMarks;
  final int? maxAttempts;
  final int? attemptsUsed;
  final bool? canSubmit;
  final int? durationMinutes; // null في حالة Assignment
  final List<_FileInfo> files;

  const _TaskDetails({
    this.title,
    this.description,
    this.viewDate,
    this.dueDate,
    this.deadlineDate,
    this.totalMarks,
    this.maxAttempts,
    this.attemptsUsed,
    this.canSubmit,
    this.durationMinutes,
    this.files = const [],
  });

  factory _TaskDetails.fromAssignment(AssignmentModel a) {
    return _TaskDetails(
      title: a.title,
      description: a.description,
      viewDate: a.viewDate,
      dueDate: a.dueDate,
      deadlineDate: a.deadlineDate,
      totalMarks: a.totalMarks,
      maxAttempts: a.maxAttempts,
      attemptsUsed: a.attemptsUsed,
      canSubmit: a.canSubmit,
      files:
          (a.files ?? [])
              .map(
                (f) => _FileInfo(name: f.name ?? '', size: f.size, url: f.url),
              )
              .toList(),
    );
  }

  factory _TaskDetails.fromExam(ExamModel e) {
    final List<_FileInfo> files = [];
    if (e.fileName != null) {
      files.add(
        _FileInfo(
          name: e.fileName!,
          size: e.fileSize != null ? '${e.fileSize} KB' : null,
          url: e.fileUrl,
        ),
      );
    }
    return _TaskDetails(
      title: e.title,
      description: e.description,
      viewDate: e.viewDate,
      dueDate: e.dueDate,
      deadlineDate: e.deadlineDate,
      totalMarks: e.totalMarks,
      maxAttempts: e.maxAttempts,
      attemptsUsed: e.attemptsUsed,
      canSubmit: e.canSubmit,
      durationMinutes: e.durationMinutes,
      files: files,
    );
  }
}

/// تمثيل موحّد لملف جوه attempt واحد، بيفرّق بين رابط التحميل (original)
/// ورابط المعاينة (النسخة اللي عليها تعليقات المدرّس لو موجودة).
class _AttemptFile {
  final String name;
  final String? size;
  final String? downloadUrl;
  final String? viewUrl;

  const _AttemptFile({
    required this.name,
    this.size,
    this.downloadUrl,
    this.viewUrl,
  });
}

/// تمثيل موحّد لمحاولة واحدة (Attempt)، سواء جاية من AttemptsModel
/// (assignment attempts) أو من ExamModel (exam attempts).
class _AttemptView {
  final List<_AttemptFile> files;

  const _AttemptView({this.files = const []});

  factory _AttemptView.fromExam(ExamModel e) {
    final List<_AttemptFile> files = [];
    if (e.fileName != null) {
      files.add(
        _AttemptFile(
          name: e.fileName!,
          size: e.fileSize != null ? '${e.fileSize} KB' : null,
          downloadUrl: e.fileUrl,
          viewUrl: e.fileUrl,
        ),
      );
    }
    return _AttemptView(files: files);
  }

  factory _AttemptView.fromAssignmentAttempt(AttemptsModel a) {
    final files =
        (a.files ?? [])
            .map(
              (f) => _AttemptFile(
                name: f.name ?? '',
                downloadUrl: f.fileUrl,
                viewUrl: f.fileWithCommentsUrl ?? f.fileUrl,
              ),
            )
            .toList();
    return _AttemptView(files: files);
  }
}

class AssignmentScreen extends StatefulWidget {
  final int id;
  final String unitTitle;
  final bool isExam;

  const AssignmentScreen({
    Key? key,
    required this.id,
    required this.unitTitle,
    this.isExam = false,
  }) : super(key: key);

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  /// الملف اللي المستخدم اختاره لسه ومش اتعمله submit، بنعرضه في مكانه
  /// عشان يقدر يراجعه أو يمسحه قبل الإرسال الفعلي.
  File? _pickedFile;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
          widget.isExam
              ? [
                BlocProvider(
                  create:
                      (_) =>
                          sl<MyExamDetailsCubit>()..getMyExamDetails(widget.id),
                ),
                BlocProvider(
                  create:
                      (_) =>
                          sl<ExamAttemptsCubit>()..getExamAttempts(widget.id),
                ),
                BlocProvider(create: (_) => sl<SubmitExamCubit>()),
              ]
              : [
                BlocProvider(
                  create:
                      (_) =>
                          sl<AssignmentDetailsCubit>()
                            ..getAssignmentDetails(widget.id),
                ),
                BlocProvider(
                  create:
                      (_) =>
                          sl<AssignmentAttemptsCubit>()
                            ..getAssignmentAttempts(widget.id),
                ),
                BlocProvider(create: (_) => sl<SubmitAssignmentCubit>()),
              ],
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: BaseGradient(child: _buildDetailsBuilder(context)),
        ),
      ),
    );
  }

  // ---------------- DETAILS (Exam أو Assignment) ----------------

  Widget _buildDetailsBuilder(BuildContext context) {
    if (widget.isExam) {
      return BlocBuilder<MyExamDetailsCubit, BaseCubitState>(
        builder:
            (context, state) => _renderDetailsState(
              context,
              state,
              (response) =>
                  (response as BaseResponse<ExamModel>).data == null
                      ? null
                      : _TaskDetails.fromExam(response.data!),
            ),
      );
    }
    return BlocBuilder<AssignmentDetailsCubit, BaseCubitState>(
      builder:
          (context, state) => _renderDetailsState(
            context,
            state,
            (response) =>
                (response as BaseResponse<AssignmentModel>).data == null
                    ? null
                    : _TaskDetails.fromAssignment(response.data!),
          ),
    );
  }
  Widget _renderDetailsState(
    BuildContext context,
    BaseCubitState state,
    _TaskDetails? Function(dynamic response) extractor,
  ) {
    if (state is ErrorState) {
      return Center(child: AppText(text: state.message));
    }
    if (state is SuccessState) {
      final details = extractor(state.data);
      if (details == null) {
        return const Center(child: Text('No details available'));
      }
      return _buildBody(context, details);
    }
    return const Center(child: CircularProgressIndicator());
  }
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: false,
      titleChild: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.unitTitle,
            style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
          ),
          widget.isExam
              ? BlocBuilder<MyExamDetailsCubit, BaseCubitState>(
                builder: (context, state) => _appBarTitle(state, isExam: true),
              )
              : BlocBuilder<AssignmentDetailsCubit, BaseCubitState>(
                builder: (context, state) => _appBarTitle(state, isExam: false),
              ),
        ],
      ),
      showBack: true,
    );
  }

  Widget _appBarTitle(BaseCubitState state, {required bool isExam}) {
    String title = isExam ? 'Exam' : 'Assignment';
    if (state is SuccessState) {
      if (isExam) {
        final response = state.data as BaseResponse<ExamModel>;
        title = response.data?.title ?? title;
      } else {
        final response = state.data as BaseResponse<AssignmentModel>;
        title = response.data?.title ?? title;
      }
    }
    return Text(title, style: AppsStyles.s14Bold.copyWith(color: Colors.black));
  }

  // ---------------- DEADLINE HELPERS ----------------

  /// يحسب نهاية يوم الـ deadline (23:59:59) لأن السيرفر بيرجّع تاريخ بدون
  /// وقت، فلازم اليوم كله يبقى مسموح فيه التسليم لحد آخره.
  DateTime? _endOfDeadlineDay(String? deadlineDate) {
    if (deadlineDate == null || deadlineDate.isEmpty) return null;
    final parsed = DateTime.tryParse(deadlineDate);
    if (parsed == null) return null;
    return DateTime(parsed.year, parsed.month, parsed.day, 23, 59, 59);
  }

  bool _isDeadlinePassed(String? deadlineDate) {
    final end = _endOfDeadlineDay(deadlineDate);
    if (end == null) return false;
    return DateTime.now().isAfter(end);
  }

  int _daysLeft(String? deadlineDate) {
    final end = _endOfDeadlineDay(deadlineDate);
    if (end == null) return 0;
    final diff = end.difference(DateTime.now());
    if (diff.isNegative) return 0;
    // +1 يوم تقريبي لأن نهاية اليوم نفسه لسه بيعتبر "يوم متاح"
    return diff.inHours <= 24 ? 1 : (diff.inHours / 24).ceil();
  }

  bool _attemptsExhausted(_TaskDetails details) {
    if (details.maxAttempts == null) return false;
    final used = details.attemptsUsed ?? 0;
    return used >= details.maxAttempts!;
  }

  // ---------------- BODY ----------------

  Widget _buildBody(BuildContext context, _TaskDetails details) {
    final deadlinePassed = _isDeadlinePassed(details.deadlineDate);
    final attemptsExhausted = _attemptsExhausted(details);
    final canSubmit =
        (details.canSubmit ?? true) && !deadlinePassed && !attemptsExhausted;

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _limitTimeAndInstructions(details, deadlinePassed),
            10.verticalSpace,

            if (details.maxAttempts != null) ...[
              _attemptsCounter(details),
              10.verticalSpace,
            ],

            Text(
              widget.isExam ? 'Exam Materials' : 'Assignment Materials',
              style: AppsStyles.s16Bold,
            ),
            10.verticalSpace,

            if (details.files.isNotEmpty)
              ...details.files.map(
                (file) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CourseMaterial(
                    title: file.name,
                    subTitle: file.size ?? '',
                    backgroundColor: const Color(0xffF0FDF4),
                    iconColor: AppColors.red,
                    leadingImage: AppImages.assignment,
                    onDownload: () => HelperMethods.downloadFileSafely(
                      context: context,
                      url: file.url,
                      fileName: file.name,
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.isExam
                      ? 'No materials available for this exam'
                      : 'No materials available for this assignment',
                ),
              ),

            10.verticalSpace,

            if (canSubmit) ...[
              if (_pickedFile != null)
                _buildPickedFilePreview(context)
              else
                UploadAssignmentWidget(
                  onFilePicked: () async {
                    final file = await HelperMethods.pickAssignmentFile(
                      context,
                    );
                    if (file != null) {
                      setState(() => _pickedFile = file);
                    }
                  },
                ),
              10.verticalSpace,
            ] else
              _buildBlockedBanner(deadlinePassed, attemptsExhausted),

            10.verticalSpace,
            _buildSubmitStatusListener(context),

            20.verticalSpace,
            Text('Your Attempts', style: AppsStyles.s16Bold),
            10.verticalSpace,
            _buildAttemptsSection(context),

            30.verticalSpace,
          ],
        ),
      ),
    );
  }

  // ---------------- PICKED FILE PREVIEW (قبل الـ Submit الفعلي) ----------------

  Widget _buildPickedFilePreview(BuildContext context) {
    final file = _pickedFile!;
    final fileName = file.path.split('/').last;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.insert_drive_file_outlined,
                color: AppColors.primary,
                size: 20.r,
              ),
              8.horizontalSpace,
              Expanded(
                child: AppText(
                  text: fileName,
                  style: AppsStyles.s12Bold,
                  maxLines: 2,
                ),
              ),
              8.horizontalSpace,
              GestureDetector(
                onTap: () => setState(() => _pickedFile = null),
                child: Icon(
                  Icons.close_rounded,
                  color: AppColors.red,
                  size: 20.r,
                ),
              ),
            ],
          ),
          10.verticalSpace,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _pickedFile = null),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Remove',
                    style: AppsStyles.s12Bold.copyWith(color: AppColors.red),
                  ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _onFilePicked(context, file),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: AppsStyles.s12Bold.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onFilePicked(BuildContext context, File file) {
    if (widget.isExam) {
      context.read<SubmitExamCubit>().submitExam(
        SubmitExamParams(examId: widget.id.toString(), file: file),
      );
    } else {
      context.read<SubmitAssignmentCubit>().submitAssignment(
        SubmitAssignmentParams(assignmentId: widget.id.toString(), file: file),
      );
    }
  }

  Widget _attemptsCounter(_TaskDetails details) {
    final used = details.attemptsUsed ?? 0;
    final max = details.maxAttempts ?? 0;
    return Row(
      children: [
        Icon(
          Icons.replay_circle_filled_outlined,
          color: AppColors.grey,
          size: 15.r,
        ),
        5.horizontalSpace,
        AppText(
          text: 'Attempts: $used / $max',
          style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
        ),
      ],
    );
  }

  Widget _buildBlockedBanner(bool deadlinePassed, bool attemptsExhausted) {
    String message;
    if (deadlinePassed) {
      message =
          widget.isExam
              ? 'The deadline for this exam has passed. You can no longer submit your answer.'
              : 'The deadline for this assignment has passed. You can no longer submit your answer.';
    } else if (attemptsExhausted) {
      message = 'You have used all your available attempts.';
    } else {
      message = 'Submission is currently not available.';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.red),
      ),
      child: Row(
        children: [
          Icon(Icons.lock_outline, color: AppColors.red, size: 18.r),
          10.horizontalSpace,
          Expanded(
            child: AppText(
              text: message,
              style: AppsStyles.s12Regular.copyWith(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitStatusListener(BuildContext context) {
    if (widget.isExam) {
      return BlocConsumer<SubmitExamCubit, BaseCubitState>(
        listener: (context, state) => _handleSubmitListener(context, state),
        builder: (context, state) => _submitStatusBuilder(state),
      );
    }
    return BlocConsumer<SubmitAssignmentCubit, BaseCubitState>(
      listener: (context, state) => _handleSubmitListener(context, state),
      builder: (context, state) => _submitStatusBuilder(state),
    );
  }

  void _handleSubmitListener(BuildContext context, BaseCubitState state) {
    if (state is SuccessState) {
      // الإرسال نجح: نمسح الملف المختار محليًا ونرجّع الصفحة لوضعها الطبيعي.
      setState(() => _pickedFile = null);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isExam
                ? 'Exam submitted successfully'
                : 'Assignment submitted successfully',
          ),
        ),
      );
      if (widget.isExam) {
        context.read<ExamAttemptsCubit>().getExamAttempts(widget.id);
        context.read<MyExamDetailsCubit>().getMyExamDetails(widget.id);
      } else {
        context.read<AssignmentAttemptsCubit>().getAssignmentAttempts(
          widget.id,
        );
        context.read<AssignmentDetailsCubit>().getAssignmentDetails(widget.id);
      }
    }
    if (state is ErrorState) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.message)));
    }
  }

  Widget _submitStatusBuilder(BaseCubitState state) {
    if (state is LoadingState) {
      return const Center(child: CircularProgressIndicator());
    }
    return const SizedBox.shrink();
  }

  // ---------------- ATTEMPTS SECTION ----------------

  Widget _buildAttemptsSection(BuildContext context) {
    if (widget.isExam) {
      return BlocBuilder<ExamAttemptsCubit, BaseCubitState>(
        builder: (context, state) {
          return _renderAttemptsState(state, (response) {
            final r = response as BaseResponse<List<ExamModel>>;
            return r.data?.map(_AttemptView.fromExam).toList() ?? [];
          });
        },
      );
    }

    return BlocBuilder<AssignmentAttemptsCubit, BaseCubitState>(
      builder: (context, state) {
        return _renderAttemptsState(state, (response) {
          final r = response as BaseResponse<List<AttemptsModel>>;
          return r.data?.map(_AttemptView.fromAssignmentAttempt).toList() ??
              [];
        });
      },
    );
  }

  Widget _renderAttemptsState(
    BaseCubitState state,
    List<_AttemptView> Function(dynamic response) extractor,
  ) {
    if (state is ErrorState) {
      return AppText(
        text: state.message,
        style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
      );
    }

    if (state is LoadingState) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is SuccessState) {
      final attempts = extractor(state.data);

      if (attempts.isEmpty) {
        return const AppText(text: 'No attempts submitted yet');
      }

      return Column(
        children: attempts.map((attempt) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xffBBF7D0).withOpacity(0.85),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.green),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (attempt.files.isNotEmpty)
                      ...attempt.files.map(
                        (file) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CourseMaterial(
                            title: file.name,
                            subTitle: file.size ?? '',
                            backgroundColor: const Color(0xffDCFCE7),
                            iconColor: AppColors.green,
                            leadingImage: AppImages.assignment,
                            needBorder: false,
                            onView: () => HelperMethods.pushFileViewer(
                              context: context,
                              url: file.viewUrl,
                              fileName: file.name,
                            ),
                            onDownload: () => HelperMethods.downloadFileSafely(
                              context: context,
                              url: file.downloadUrl,
                              fileName: file.name,
                            ),
                          ),
                        ),
                      )
                    else
                      const AppText(text: 'Submitted, awaiting review'),

                    10.verticalSpace,

                    MaterialDetails(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      color: const Color(0xffDCFCE7),
                      backgroundColor: const Color(0xff1E40AF),
                      name: 'Under Review',
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      );
    }

    return const SizedBox.shrink();
  }

  // ---------------- HEADER (deadline + instructions) ----------------

  Widget _limitTimeAndInstructions(_TaskDetails details, bool deadlinePassed) {
    final daysLeft = _daysLeft(details.deadlineDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              color: deadlinePassed ? AppColors.grey : AppColors.red,
              size: 15.r,
            ),
            5.horizontalSpace,
            Text(
              details.deadlineDate != null
                  ? 'Due: ${details.deadlineDate}'
                  : 'No due date',
              style: AppsStyles.s14Regular.copyWith(
                color: deadlinePassed ? AppColors.grey : AppColors.red,
              ),
            ),
            const Spacer(),
            if (details.deadlineDate != null)
              MaterialDetails(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                color:
                    deadlinePassed
                        ? const Color(0xffFEE2E2)
                        : const Color(0xffFEF9C3),
                backgroundColor:
                    deadlinePassed ? AppColors.red : const Color(0xff854D0E),
                name:
                    deadlinePassed ? 'Deadline Passed' : '$daysLeft Days Left',
              ),
          ],
        ),
        5.verticalSpace,
        if (widget.isExam && details.durationMinutes != null) ...[
          Row(
            children: [
              Icon(Icons.timer_outlined, color: AppColors.grey, size: 14.r),
              5.horizontalSpace,
              AppText(
                text: 'Duration: ${details.durationMinutes} minutes',
                style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          5.verticalSpace,
        ],
        if (details.totalMarks != null) ...[
          Row(
            children: [
              Icon(
                Icons.star_border_rounded,
                color: AppColors.grey,
                size: 14.r,
              ),
              5.horizontalSpace,
              AppText(
                text: 'Total Marks: ${details.totalMarks}',
                style: AppsStyles.s12Regular.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          5.verticalSpace,
        ],
        AppText(style: AppsStyles.s12Regular, text: details.description ?? ''),
      ],
    );
  }
}